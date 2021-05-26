const suits = ['H','D','C','S'];
const ranks = ['2','3','4','5','6','7','8','9','10','K','J','Q','A'];

let deck = suits.flatMap((s)=> ranks.map((r)=> `${r}${s}`));

console.log(deck);

const shuffleCards = (deck: any, times=3) => {
    for(let i = 0; i < times; i++){
        for(let j=0; j< deck.length; j++){
            let r = Math.floor(Math.random() * (j + 1));
            let currentCard = deck[j];
            deck[j] = deck[r];
            deck[r] = currentCard;
         }
    }
    return deck;
}

deck = shuffleCards(deck);
console.log(deck);