import React from 'react'
import moment from 'moment/moment';
import PropTypes from 'prop-types';

export const Item = (props) => {
    const timeRange = props.data
    const startTime = moment(timeRange.attributes.start_time).utcOffset(0, false).format('HH:mm')
    const endTime = moment(timeRange.attributes.end_time).utcOffset(0, false).format('HH:mm')

    const disabled = props.data.attributes.booking_id !== null
    return (
        <button className={ btnClass(disabled, props.selected) }
                disabled={ disabled }
                onClick={ () => props.selectTime(timeRange.id) }>
            { startTime } - { endTime }
        </button>
    )
}

const btnClass = (disabled, selected) => {
    if (disabled) {
        return 'p-4 rounded-lg flex items-center justify-center bg-blue-300 shadow-lg'
    }
    if (selected) {
        return 'p-4 rounded-lg flex items-center justify-center bg-blue-800 shadow-lg'
    }
    return 'p-4 max-w-xs rounded-lg flex items-center justify-center bg-blue-500 shadow-lg hover:bg-blue-600'
}

Item.propTypes = {
    data: PropTypes.object.isRequired,
    selectTime: PropTypes.func.isRequired,
    selected: PropTypes.bool.isRequired,
};