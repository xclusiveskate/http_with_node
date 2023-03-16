import express from 'express'
import cors from 'cors'



const app = express()



app.use(cors())
app.use(express.json())
app.use(express.urlencoded({ extended: true }))


const PORT = process.env.PORT || 5000


let myData = [
    { 'name': 'important name', 'amount': 200000, id: 1 },
    { 'name': 'important name2', 'amount': 340000, id: 2 },
]



// GET TESTING
app.get('/', (req, res) => {
    res.send('Hello server responding...')
})



// GET
app.get('/v1/getdataurl', (req, res) => {
    try {

        res.status(200).json({ message: 'geting data...', data: myData })
    } catch (error) {
        res.status(500).json({ message: `oops, something went wrong` })
    }
})

// POST
app.post('/v1/postdataurl', (req, res) => {

    try {
        const sentData = req.body

        myData = [...myData, sentData]


        res.status(201).json({ message: 'data added successfully', latestData: myData })

    } catch (error) {
        res.status(500).json({ message: `oops, something went wrong` })
    }


})


// PUT
app.put('/v1/editingdataurl', (req, res) => {

    try {
        const sentData = req.body

        let findTheRecord = myData.find((data) => data.id === sentData.id)

        if (findTheRecord) {
            findTheRecord = sentData

            const newData = myData.map((element) => element.id === sentData.id ? findTheRecord : element)

            myData = newData

            res.status(201).json({ message: 'data changed successfully', latestData: myData })

        } else {
            res.status(404).json({ message: `oops, record with the id: ${sentData.id} not found` })
        }

    } catch (error) {
        res.status(500).json({ message: `oops, something went wrong` })
    }

})



// DELETE
// I sent the user id in the body object (req.body), but you can actually send the ID as parameter to this server
// to achieve this you can use  this url => /v1/deletedataurl/:id

// then you call it like this => /v1/deletedataurl/2
// whatever info you passed  here /v1/deletedataurl/... 
//    can be grab using req.param.id
app.delete('/v1/deletedataurl/', (req, res) => {

    try {

        // id  req.param.id
        // id  req.body.id


        // console.log(req.params)
        // console.log(req.body)


        // const sentData = req.params.id;
        const sentData = req.body
        console.log(sentData);


        // Number() is beign used to convert string to int because params is actually string

        let findTheRecord = myData.find((data) => data.id === Number(sentData.id))


        if (findTheRecord) {

            const newData = myData.filter((element) => element.id !== Number(sentData.id))

            myData = newData

            res.status(201).json({ message: 'data deleted successfully', latestData: myData })

        } else {
            res.status(404).json({ message: `oops, record with the id: ${sentData.id} not found` })
        }

    } catch (error) {
        res.status(500).json({ message: `oops, something went wrong` })
    }

})





app.listen(PORT, () => {
    console.log(`server is listening at port ${PORT}`)
})