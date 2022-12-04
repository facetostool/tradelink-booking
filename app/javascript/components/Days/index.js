import React from 'react';
import PropTypes from 'prop-types';

import { Item } from './item';

export const Days = (props) => {
    return (
        <div className='p-8 h-screen text-white text-sm font-bold font-mono'>
            <h1 className='font-bold text-lg text-center text-gray-900 my-4'> Select Day </h1>
            <div className='relative rounded-xl overflow-auto h-5/6'>
                <div className='flex flex-col mx-auto space-y-4 leading-6 max-w-xs'>
                    {props.days.map((day) => (
                        <Item key={day} data={day} activateDay={props.activateDay}></Item>
                    ))}
                </div>
            </div>
        </div>
    )
}

Days.propTypes = {
    days: PropTypes.arrayOf(Date).isRequired,
    activateDay: PropTypes.func.isRequired,
};
