export prof=~/work/cutlass/cutlass/build_profiler/tools/profiler

rm ww4w_splitk.gemm.csv
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
	  $prof/cutlass_profiler --op_class=tensorop --kernels=gemm --verification-enabled=false --split_k_slices=4 --m=$m --n=$n --k=$((4 * k)) --A=f16:row --B=f16:column --C=f32:column --cta_m=$((2 ** mm)) --cta_n=$((2 ** nn)) --cta_k=$((2 ** kk)) --inst_m=16 --inst_n=8 --inst_k=8 --accum=f32 --output=ww4w_splitk.csv --append=true
			fi
		      done
		  done
	      done
	  done
      done 
  done
