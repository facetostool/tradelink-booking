import React from 'react';
import ActionCable from 'actioncable';
import { useState, useEffect } from 'react';

import PropTypes from 'prop-types';

import { Item } from './item';
import { CreateBooking } from './createBooking';

import { indexTimeRanges } from '../../api/timeRanges';
import { createBooking } from '../../api/bookings';

export const TimeRanges = (props) => {
    const activeDay = props.activeDay

    const [selected, setSelected] = useState([]);
    const [timeRanges, setTimeRanges] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    const selectTime = (timeRangeID) => {
        if (selected.includes(timeRangeID)) {
            const array = [...selected];
            const index = array.indexOf(timeRangeID)
            array.splice(index, 1);
            return setSelected(array);
        }
        return setSelected([...selected, timeRangeID]);
    }

    useEffect(() => {
        const cable = ActionCable.createConsumer(`ws://${window.location.host}/cable`);
        const conn = cable.subscriptions.create(
            { channel: 'TimeRangesChannel' },
            { received: (message) => {
                    setTimeRanges((prev) => {
                        const updatedRanges = message.included;
                        return prev.map(tr => {
                            const updated = updatedRanges.find(element => element.id === tr.id)
                            if (updated) {
                                return updated;
                            }

                            return tr;
                        });
                    });
                }
            }
        );
        return () => {
            conn.unsubscribe()
        }
    }, []);

    const bookTimeRanges = (username, ranges) => {
        createBooking(username, ranges)
            .then((response) => {
                if (!response.ok) {
                    throw new Error(
                        `This is an HTTP error: The status is ${response.status}`
                    );
                }
                return response.json();
            }).then(() => {
                setSelected([])
                setError(null)
            }).catch((err) => {
                setError(err.message);
                setTimeRanges(null);
            })
    }

    useEffect(() => {
        if (!activeDay) {
            return
        }
        indexTimeRanges(activeDay)
            .then((response) => {
                if (!response.ok) {
                    throw new Error(
                        `This is an HTTP error: The status is ${response.status}`
                    );
                }
                return response.json();
            })
            .then((data) => {
                setTimeRanges(data.data)
                setError(null)
            })
            .catch((err) => {
                setError(err.message);
                setTimeRanges(null);
            })
            .finally(() => {
                setLoading(false);
            });
    }, [activeDay]);

    return (
        <>
            { !activeDay && (
                <h3 className='text-lg text-center text-gray-900'> Please select day </h3>
            )}
            { activeDay && loading && (
                <div>A moment please...</div>
            )}
            { error && (
                <div>{`There is a problem fetching the post data - ${error}`}</div>
            )}
            { timeRanges && !error && (
                <div className='p-8 h-screen text-white text-sm font-bold font-mono'>
                    <h1 className='font-bold text-lg text-center text-gray-900 my-4'> Select time </h1>
                    <div className='relative rounded-xl overflow-auto h-3/4'>
                        <div className='flex flex-col mx-auto space-y-4 leading-6 max-w-xs'>
                            {timeRanges.map((timeRange) => (
                                <Item key={timeRange.id} data={timeRange} selected={selected.includes(timeRange.id)} selectTime={selectTime}></Item>
                            ))}
                        </div>
                    </div>
                    <CreateBooking timeRanges={selected} bookHandler={bookTimeRanges}/>
                </div>
            )}
        </>
    )
}

TimeRanges.propTypes = {
    activeDay: PropTypes.instanceOf(Date).isRequired,
};
