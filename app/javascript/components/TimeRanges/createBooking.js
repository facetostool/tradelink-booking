import React from 'react'
import { useState } from 'react';
import PropTypes from 'prop-types';

export const CreateBooking = (props) => {
    const timeRangeIDs = props.timeRanges

    const [username, setUsername] = useState('');

    return (
        <div className='mt-10 flex flex-col mx-auto space-y-4 max-w-xs'>
            <input name='username'
                   placeholder='your username'
                   className='text-center text-black p-4 border border-blue-400 rounded-lg flex items-center justify-center shadow-lg max-w-xs'
                   onChange={ (e) => setUsername(e.target.value) } />
            <button className={ btnClass(timeRangeIDs, username) }
                    disabled={ isDisabled(timeRangeIDs, username) }
                    onClick={ () => props.bookHandler(username, timeRangeIDs) }>
                Book time
            </button>
        </div>
    )
}

const isDisabled = (timeRangeIDs, username) => {
    return timeRangeIDs.length === 0 || username.trim().length === 0
}

const btnClass = (timeRangeIDs, username) => {
    if (isDisabled(timeRangeIDs, username)) {
        return 'p-4 rounded-lg flex items-center justify-center bg-emerald-200 shadow-lg max-w-xs disabled:opacity-75'
    }
    return 'p-4 rounded-lg flex items-center justify-center bg-emerald-300 hover:bg-emerald-400 shadow-lg max-w-xs'
}

CreateBooking.propTypes = {
    timeRanges: PropTypes.arrayOf(PropTypes.object).isRequired,
    bookHandler: PropTypes.func.isRequired,
};
