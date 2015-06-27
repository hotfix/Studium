/* Makros zur Bitmanipulation */

#define SET_BITS 8

typedef char SET;

#define check(i)         ( (SET)(i) < SET_BITS )

#define emptyset         ( (SET) 0)

#define add(s,i)         ( (s) | singleset(i) )

#define singleset(i)     ( ((SET) 1) << (i) )

#define intersect(s1,s2) ( (s1) & (s2) )

#define my_union(s1,s2)     ( (s1) | (s2) )

#define exor(s1,s2)      ( (s1) ^ (s2) )

#define element(i,s)     ( singleset((i)) & (s))

#define first_n_elems(n) (SET)( (1<<(n))-1 )

#define forallelems(i,s)            \
       for ((i) = 0; (i)<SET_BITS; ++(i)) \
       if (element((i),(s)))

/*----------------------------------------*/

extern int cardinality (SET x);

/* extern int cardinality1 (SET x); */

extern void printset (SET s);
