const array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];


const shuffler = (array: any, times=3) => {
    for(let i = 0; i < times; i++){
        for(let j=0; j< array.length; j++){
            let r = Math.floor(Math.random() * (j + 1));
            let currentCard = array[j];
            array[j] = array[r];
            array[r] = currentCard;
         }
    }
    return array;
}

console.log(shuffler(array))