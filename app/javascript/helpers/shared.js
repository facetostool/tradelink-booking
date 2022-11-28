import moment from "moment/moment";

export const DaysUntilEndMonth = () => {
    const days = []
    const start = moment().toDate()
    const end = moment().endOf('month').toDate()
    let loop = new Date(start);
    while (loop < end) {
        days.push(new Date(loop))
        let newDate = loop.setDate(loop.getDate() + 1);
        loop = new Date(newDate);
    }

    return days
}

