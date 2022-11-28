import React from 'react';
import PropTypes from 'prop-types';

import { Item } from './item';

export const Days = (props) => {
    return (
        <div className='relative rounded-xl overflow-auto p-8'>
            <h1 className='font-bold text-lg text-center text-gray-900 my-4'> Select day </h1>
            <div className='flex flex-col mx-auto space-y-4 font-mono text-white text-sm font-bold leading-6 max-w-xs overflow-y-auto h-5/6'>
                {props.days.map((day) => (
                    <Item key={day} data={day} activateDay={props.activateDay}></Item>
                ))}
            </div>
        </div>
    )
}

Days.propTypes = {
    days: PropTypes.arrayOf(Date).isRequired,
    activateDay: PropTypes.func.isRequired,
};
