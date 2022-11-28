import React from 'react';
import { useState } from 'react';

import { Days } from '../Days';
import { DaysUntilEndMonth } from '../../helpers/shared';
import { TimeRanges } from '../TimeRanges';

export default function App() {
    const [days, setDays] = useState(
         DaysUntilEndMonth().map(day => {
            return {
                day: day,
                active: false,
            }
        })
    );
    const [activeDay, setActiveDay] = useState(null)

    function activateDay(day) {
        const nextDays = days.map(h => {
            if (h.day === day) {
                return {
                    ...h,
                    active: true,
                };
            }

            return {
                ...h,
                active: false,
            };
        });
        setDays(nextDays);
        setActiveDay(day);
    }

    return (
        <>
            <div className='min-h-screen flex'>
                <div className='flex-1 border-r-4 grid content-center'>
                    <Days days={days} activateDay={activateDay}/>
                </div>
                <div className='flex-1 grid content-center'>
                    <TimeRanges activeDay={activeDay}/>
                </div>
            </div>
        </>
    );
}