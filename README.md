# Universal-Opportunistic-Bits
This is a brief summary of what i have done. (My B.Tech project in college)

Opportunistic Bits - is a paired packet transmission technique that gives a significant improvement in spectral efficiency (I personally think it's a minor improvement, but who am i to judge.)
This was published in an IEEE paper - (https://ieeexplore.ieee.org/document/8540065).
Have a look at it for details.
It is much simpler than it looks like at first glance.
The crux of it is here: 
For a simple communications model, you have a stream of packets going from transmitter to reciever.
Assume the packets have same packet size 'N'.
NOW, designate some specific bits (can take any combination but must stick to it once chosen) as 'Opportunistic bits'(OB).
Again, for simplicity take the first 'K' bits as OB.
Make a sufficiently large storage of size M and fill it with the incoming stream of packets.

If two packets share a common OB, then transmit those packets together - packet pair.
In a packet pair instead of transmitting 2*N bits, we will transmit 2*N-K bits thus saving K bits per transmission.
Doing this saves bandwidth and blah blah blah.. you know the rest.
The exact mathematics are presented in the paper. There is a MARKOV CHAIN and all kinds of fancy stuff there.

The folders 1,2 do the simulations and mathematics of this model in MATLAB. Its all there for you to open.

The IEEE paper did not however think it to that important to do the delay analysis of this model.
phsssh... I know right.
So that was the 'novelty' of my project. 
To do a delay analysis of OB and to find any optimization to improve it.
Easier said than done.

Using basics of probablity (not that basic though...) I derived the probability density function for the time to remove a packet, and the average time delay caused my OB scheme.
My conclusion - this is a very bad choice for the gaming community.
They need 0ms latency.
Anyways the maths and codes for it are in folder 3

The two delay/latency related problems observed by me. 
Firstly - some packets stayed inside the storage for a long time - ameliorated that using the Threshold method
Secondly - reduced the average delay of packets using a new scheme - Universal Opportunistic Bits (UOB)

# Threshold-Method
A simple check on the time spent by packets in the storage does the job. Any packet stays for too long, it leave without a buddy(no packet pair, just simple transmission)
Folder 4 has the related content.

# Universal-Opportunistic-Bits
The storage is made diffently here. 
Earlier we performed our search for packet pair when the number of packets in the storage were M.
Now we perform our search whenever the number of packets in strorage is between (M2,M) M2 <= M.
Folder 5 has all the maths and sims of UOB - It is in Python 3. 

I'll add the pdf for the above stuff soon. It will have all kinds of pretty stuff like pictures and graphs.


