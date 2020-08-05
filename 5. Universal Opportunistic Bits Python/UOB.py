import random
import matplotlib.pyplot as plt
import math


# import scipy.io

def pp_prob(m=8, m2=1, N=16, range_upper=1000):
    # m = 8  # Storage
    # m2 = 8  # min no  of packets in storage for output
    # N = 16
    Nc = 0  # no of current packets
    if m2 <= 1:  # M2 canr be negative
        m2 = 1
    packets = list(range(1, m2))
    dob = list(range(1, m2))
    for k in range(m2, m + 1):
        packets.append(None)
        dob.append(None)
    sigmaAge = 0
    Nc = m2 - 1
    nosPP = 0
    nosOP = 0
    # Start the process to get a random stage;
    for x in range(1, 100):
        p_id = random.randint(1, N)
        packets[Nc] = p_id
        dob[Nc] = x
        # print('\n',packets,end=' ')
        Nc = Nc + 1
        if Nc >= m2:
            isPP = False
            # is pp there -----------------------------------
            for i in range(0, Nc):
                ele1 = packets[i]
                for j in range(i + 1, Nc):
                    ele2 = packets[j]
                    if ele2 == ele1:  # then pp found #packets[i] == packets[j]
                        # print("pp",end=' ')
                        isPP = True
                        nosPP += 1
                        packets.pop(j)
                        sigmaAge += (x - dob.pop(j))
                        packets.pop(i)
                        sigmaAge += (x - dob.pop(i))
                        Nc = Nc - 2
                        packets.append(None)
                        packets.append(None)
                        dob.append(None)
                        dob.append(None)
                        # removal of pp to be done later
                        break
                if isPP == True:
                    break

            # is number of packets == STORAGE SIZE ----------------------------
            if Nc == m:
                packets.pop(0)
                sigmaAge += (x - dob.pop(0))
                packets.append(None)
                dob.append(None)
                Nc = Nc - 1
                nosOP += 1
                # print("op",end=' ')
            else:
                pass
        else:
            pass
            # do nothing

    sigmaAge = 0
    nosOP = 0
    nosPP = 0

    # The Good Stuff
    for x in range(1, range_upper):
        p_id = random.randint(1, N)
        packets[Nc] = p_id
        dob[Nc] = x
        # print('\n',packets,end=' ')
        Nc = Nc + 1
        if Nc >= m2:
            isPP = False
            # is pp there -----------------------------------
            for i in range(0, Nc):
                ele1 = packets[i]
                for j in range(i + 1, Nc):
                    ele2 = packets[j]
                    if ele2 == ele1:  # then pp found #packets[i] == packets[j]
                        # print("pp",end=' ')
                        isPP = True
                        nosPP += 1
                        packets.pop(j)
                        sigmaAge += (x - dob.pop(j))
                        packets.pop(i)
                        sigmaAge += (x - dob.pop(i))
                        Nc = Nc - 2
                        packets.append(None)
                        packets.append(None)
                        dob.append(None)
                        dob.append(None)
                        # removal of pp to be done later
                        break
                if isPP == True:
                    break

            # is number of packets == STORAGE SIZE ----------------------------
            if Nc == m:
                packets.pop(0)
                sigmaAge += (x - dob.pop(0))
                packets.append(None)
                dob.append(None)
                Nc = Nc - 1
                nosOP += 1
                # print("op",end=' ')
            else:
                pass
        else:
            pass
            # do nothing
    z = nosOP + nosPP
    z2 = nosOP + nosPP * 2
    # print(z, ' ', nosPP / z)
    return [nosOP, nosPP, nosPP / z, sigmaAge, sigmaAge / z2]


# calculation of spectral efficiency

def spectral_calculator(ps, k=5, sze=24, snr=100):
    s1 = 2 * sze / (2 * sze - k)
    s2 = math.log2(1 + s1 * snr) / math.log2(1 + snr)
    s2 = s2 * s1
    return 1 - ps + s2 * ps


def grapher(K=5, graph_number=1, total_iteration=20000, sv=4, s='x'):  # sv is step size.
    N = 2 ** K
    y1 = []  # LAtency
    y2 = []  # PP prob
    x1 = []  # indexing
    S24 = []  # Spectral efficiency 1
    S48 = []  # Spectral efficiency 2
    S64 = []  # Spectral efficiency 3
    S160 = []  # Spectral efficiency 4
    SFac = []
    arr = []
    for i in range(3, N, sv):  # 1 32 5
        a = pp_prob(i, i, N, total_iteration)  # (m = upper,m2 = lower,N,nosIter)
        y1.append(a[4])  # latency
        y2.append(a[2])  # pp prob
        S24.append(spectral_calculator(a[2], K, 24, 100))
        S48.append(spectral_calculator(a[2], K, 48, 100))
        S64.append(spectral_calculator(a[2], K, 64, 100))
        S160.append(spectral_calculator(a[2], K, 160, 100))
        SFac.append((spectral_calculator(a[2], K, 48, 100)-1)/(spectral_calculator(a[2], K, 160, 100)-1))
        #
        x1.append(i)

    plt.subplot(2, 3, graph_number)
    xi = []
    n = N
    for idx in range(3, n, sv):
        # sume += x2 * (idx-1)/ n
        xi.append((idx - 1))

    #   plt.figure()
    #
    #plt.plot(x1, xi, label='P_s2 incase of m2 = 1')
    graph_number = graph_number + 1
    plt.plot(x1, y1, label='Delay: M2 = M (Maximized), K=%i' % K, marker='o')
    #plt.plot(x1, [y for y in y2], label='p_s: M2 = M, K=%i' % K, marker='d')
    plt.plot(x1, [(x - 1) * 0.95 for x in x1], label='tester by hand')
    arr.append(x1)
    arr.append(y1)
    arr.append(y2)
    plt.legend()
    print(x1)
    print(y1)
    print(y2)
    # Reset the vars
    y1x = y1
    y1 = []
    y2 = []
    x1 = []

    for i in range(3, N, sv):
        a = pp_prob(i, 1, N, total_iteration)
        y1.append(a[4])
        y2.append(a[2])
        x1.append(i)

    plt.plot(x1, y1, label='Delay: M2 = 1 (Minimized), K=%i' % K, marker='x')
    #plt.plot(x1, [y for y in y2], label='p_s: M2 = 1, K=%i' % K, marker='x')

    # hfont = {'fontname': 'Helvetica'}
    #plt.ylabel('DU-pair transmission probability')
    plt.ylabel('Delay')
    plt.xlabel('Storage Size (M)')
    arr.append(x1)
    arr.append(y1)
    arr.append(y2)
    plt.legend()
    print(x1)
    print(y1)
    print(y2)
    plt.title("Delay(new,old) vs Storage Size\nK=%i" % K)
    plt.grid()
    plt.subplot(2, 3, graph_number)
    graph_number = graph_number + 1
    plt.plot([y * 1 for y in y2], y1x, label='M2 = M')
    plt.plot([y * 1 for y in y2], y1, label='M2 = 1')
    plt.legend()
    plt.title("Latency vs p_s K=%i" % K)
    plt.grid()

    plt.subplot(2, 3, graph_number)
    graph_number = graph_number + 1
    plt.plot(x1, S48, label='N = 48')
    plt.plot(x1, S64, label='N = 64')
    plt.plot(x1, S160, label='N = 160')
    plt.legend()
    plt.title("Spectral Efficiency K=%i" % K)

    #plt.plot(x1, [(xx - 1) * 100 for xx in S48], label='SEG, N = 48, K = %i' % K, marker='x')
    #plt.plot(x1, [y for y in y2], label='p_s: M2 = 1, K=%i' % K, marker='o')
    #plt.plot(x1, y1, label='Delay: M2 = 1 (Minimized), K=%i' % K, marker='d')
    #plt.plot(x1, [(xx - 1) * 100 for xx in S160], label='SEG, N = 160, K = %i' % K, marker='o')
    #plt.plot(x1, [xx for xx in SFac], label='SFac, K = %i' % K, marker='d')
    plt.legend(prop={"size": 12})
    plt.grid()

    # print(y1x)
    # print(y1)
    # print(1-y1[0]/y1x[0])

    return 0


# scipy.io.savemat('arrdata.mat', mdict={'arr': arr})
# z = grapher(11, 1, 2000, 128)
# z = grapher(10, 1, 2000, 64)
# z = grapher(9, 1, 2000, 32)
# z = grapher(8, 1, 4000, 16)
# z = grapher(7, 1, 4000, 8)
z = grapher(6, 1, 4000, 4)
z = grapher(5, 4, 4000, 2)
# z = grapher(4, 1, 4000, 1)
plt.grid()
plt.savefig('foo1.pdf', bbox_inches='tight')
plt.show()
