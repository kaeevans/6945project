;;;; Map each chord difference to an integer that can bet digested by PS4 matchers

(define make-chord-difference-table make-equal-hash-table)

(define (chord-difference->int table chord-difference)
  (let ((val (hash-table/get table chord-difference #f)))
    (if val
	val
	(add-chord-difference->int table chord-difference))))

(define (add-chord-difference->int table chord-difference)
  (let ((l (hash-table/count table)))
    (hash-table/put! table chord-difference l)
    l))

(define (chord-differences->ints chord-differences)
  (let ((vec (make-vector (length chord-differences)))
	(table (make-chord-difference-table)))
    (let iter ((ind 0))
      (if (= ind (length chord-differences))
	  (vector->list vec)
	  (let ((chord-difference (list-ref chord-differences ind)))
	    (let ((val (chord-difference->int table chord-difference)))
	      (vector-set! vec
			   ind
			   (if val
			       val
			       (add-chord-difference->int table chord-difference)))
	      (iter (+ ind 1))))))))

(define (difference-profile->ints difference-profile)
  (chord-differences->ints (difference-profile-chord-differences difference-profile)))
				     
