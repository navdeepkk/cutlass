export prof=~/work/cutlass/cutlass/build_profiler/tools/profiler

rm 2www.gemm.csv
for mm in {5..8..1}
  do
    for nn in {5..8..1}
      do
	for kk in {5..6..1}
	  do
	    for m in {1024..10240..1024}
	      do
	        for n in {1024..10240..1024}
	          do
		    for k in {1024..10240..1024}
		      do
			if [ $m -eq $n ] && [ $n -eq $k ];
			then
	  $prof/cutlass_profiler --op_class=tensorop --kernels=gemm --verification-enabled=false --m=$(( 2 * m)) --n=$n --k=$k --A=f16:row --B=f16:column --C=f32:column --cta_m=$((2 ** mm)) --cta_n=$((2 ** nn)) --cta_k=$((2 ** kk)) --inst_m=16 --inst_n=8 --inst_k=8 --accum=f32 --output=2www.csv --append=true
			fi
		      done
		  done
	      done
	  done
      done 
  done
