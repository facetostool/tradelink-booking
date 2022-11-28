import React from 'react'
import PropTypes from 'prop-types';

export const Item = (props) => {
    const data = props.data

    return (
        <button className={btnClass(data.active)} onClick={() => props.activateDay(data.day)}>
            <div className='hello'>{data.day.toISOString().slice(0,10)}</div>
        </button>
    )
}

const btnClass = (active) => {
    if (active === true) {
        return 'p-4 rounded-lg flex items-center justify-center bg-indigo-800 shadow-lg'
    }
    return 'p-4 rounded-lg flex items-center justify-center bg-indigo-500 shadow-lg hover:bg-indigo-600'
}

Item.propTypes = {
    data: PropTypes.object.isRequired,
    activateDay: PropTypes.func.isRequired,
};
