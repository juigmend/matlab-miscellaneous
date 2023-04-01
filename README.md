# Matlab miscellaneous

Miscellaneous <a href="http://mathworks.com">Matlab</a> code.
It might also work in <a href="https://www.gnu.org/software/octave/">Octave</a>.

## Description 

<ul>

<br> 
<li>

mcrecovery vs. mcfillgaps:




<img src="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/raw/main/mcrecovery_vs_mcfillgaps/Full_P07_s4_allgaps.gif" width="133" height="100"/>

<img src="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/raw/main/mcrecovery_vs_mcfillgaps/Full_P07_s4_gapsfilled.gif" width="133" height="100"/>


<img src="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/raw/main/mcrecovery_vs_mcfillgaps/gaps_P07_s4.gif" width="133" height="100"/>

<img src="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/raw/main/mcrecovery_vs_mcfillgaps/mcfillgaps_P07_s4.gif" width="133" height="100"/>

<img src="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/raw/main/mcrecovery_vs_mcfillgaps/mcrecovery_P07_s4.gif" width="133" height="100"/>




<ul>

<li>
Mendoza Garay, J. I., Burger, B., & Luck, G. (2022). Exploring relations between Big Five personality traits and musical emotions embodied in spontaneous dance. Psychology of Music, OnlineFirst. https://doi.org/10.1177/03057356221135355
</li>
<li>
https://journals.sagepub.com/doi/full/10.1177/03057356221135355
</li>
<li>
http://urn.fi/URN:NBN:fi:jyu-202211295415
</li>
</ul>

</li>

<br>
<li>
<a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/mcspread.m">mcspread</a> 
 Computes "a movement feature representing bodily extension and contraction". See <a href="https://psychologyandmusicconference.files.wordpress.com/2022/10/ab_pam-ie-belgrade-2022.pdf?force_download=true">Touizrar, Mendoza & Thompson (2022)</a> in <a href="https://psychologyandmusicconference.wordpress.com/proceedings/">Second International Conference Psychology and Music, Belgrade, Serbia</a>. 

<ul> 
<li><a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/contraction_expansion_comparison.m">Comparison with other measures</a>. </li>
 
<li><a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/postural_contraction_expansion.pdf">Technical report</a>. </li>
 
<li>Example: <a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/whole_body_velocity.m"> speed of the whole body spread.</a> </li>
</ul>
</li>

<br>
<li><a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/novelty_2D_DEMO.m">Novelty 2D Demonstration</a> 
Shows the computation of a novelty score from a two-dimensional signal. </li>

<br>
<li><a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/diagonal_convolution_kernel_demo.m">Diagonal Convolution Kernel Demonstration</a> 
Convolves a kernel along the diagonal of a matrix, for example to obtain a novelty curve of a distance matrix. </li>

<br>
<li><a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/gaussian_tapered_checkerboard_kernel_2D_demo.m">Gaussian Tapered Checkerboard Kernel 2D Demonstration</a> 
Computes a Gaussian Tapered Checkerboard Kernel. </li>

<br>
<li><a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/find_peaks_DEMO.m">find_peaks_DEMO</a> </li>

<br>
<li><a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/mcwinxcorr.m">mcwinxcorr</a> 
Computes windowed cross correlation of two signals. Useful to measure drift between two measurements made with different devices. 
This function is compatible with the <a href="https://www.jyu.fi/hytk/fi/laitokset/mutku/en/research/materials/mocaptoolbox">Mocap Toolbox (open source, download for free)</a>.</li>

<br>
<li><a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/downsampling_data_demo.m">Downsampling Data Demonstration.</a> 
Downsample data with different methods and measure their computing time. 
<a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/accel_test_100Hz.txt">Download testing data here. </a></li>

<br>
<li><a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/projection_3D_to_2D_demo.m">Projection 3D to 2D Demonstration</a> 
Projects data in 3 dimensions to 2 dimensions, for example motion-captured position. </li>

<br>
<li><a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/nextbase36char.m">nextbase36char</a> 
Counts in base 36 (letters of the English alphabet, then digits from 0 to 9). </li>

<br>
<li><a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/nextbase26char.m">nextbase26char</a> 
Counts in base 26 (letters of the English alphabet).  </li>

<br>
<li><a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/avoid_nested_loops_DEMO.m">Avoid Nested Loops Demonstration</a> 
Shows an alternative to compute nested loops. It uses a while statement and dynamic indexing instead of 'for' loops. 
This makes it easy to resume the process if the program is halted.  </li>

<br>
<li><a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/waitbar_DEMO.m">Waitbar Demonstration</a> 
Shows how to make and format a wait bar in nested loops. </li>

<br>
<li><a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/change_filename_extensions.m">change_filename_extensions</a> </li>

<br>
<li><a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/maketimestamp.m">maketimestamp</a> 
Produces irrepeteable numbers based in system clock, with minimum interval of one second.</li>

<br>
<li><a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/AR_file_loader_v0.1.m">Audiofile Rating File Loader</a> 
Reads files produced by <a href="https://gitlab.jyu.fi/juigmend/matlab-miscellaneous/-/blob/main/Audiofile_Rating_v0.1.2.pd">Audiofile Rating</a> into a Matlab matrix.</li>

</ul>

## License
All software of my authorship in this page is published under the <a href="https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html">GNU General Purpose License version 2.</a>


