const suits = ['H','D','C','S'];
const ranks = ['2','3','4','5','6','7','8','9','10','K','J','Q','A'];

let deck = suits.flatMap((s)=> ranks.map((r)=> `${r}${s}`));
deck.push("JokerA", "JokerB");
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
}

shuffleCards(deck);

console.log(deck);

const pickCard = (deck: any, count = 1) => {
    var cards = [];
    for(let i = 0; i< count; i++){
        cards.push(deck.shift());
    }

    return cards;
}


console.log(pickCard(deck, 3));
console.log(deck);

