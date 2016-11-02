From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 00/25] mmc: mmc: Add Software Command Queuing
Date: Wed, 2 Nov 2016 12:09:02 +0200
Message-ID: <3128dca4-374c-02d3-dda6-645f46e64a23@intel.com>
References: <1477298260-5064-1-git-send-email-adrian.hunter@intel.com>
 <76a4ab7d-b4bb-0500-35af-c1a10b51af7c@codeaurora.org>
 <23591370-9dcc-49f8-fa80-ce2d60c7d082@intel.com>
 <4d64111f-7bdb-22ed-5a53-e23f6bfcb28b@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53881 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750964AbcKBKN7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Nov 2016 06:13:59 -0400
In-Reply-To: <4d64111f-7bdb-22ed-5a53-e23f6bfcb28b@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

On 02/11/16 11:30, Ritesh Harjani wrote:
> Hi Adrian,
> 
> Reply got delayed due to festive season holidays here.
> 
> On 10/28/2016 6:18 PM, Adrian Hunter wrote:
>> On 28/10/16 14:48, Ritesh Harjani wrote:
>>> Hi Adrian,
>>>
>>>
>>> Thanks for the re-base. I am trying to apply this patch series and validate.
>>> I am seeing some tuning related errors, it could be due to my setup/device.
>>> I will be working on this.
>>>
>>>
>>> Meanwhile below perf readout was showing some discrepancy (could be that I
>>> am missing something).
>>> In your last test both sequential and random read gives almost same
>>> throughput and even the percentage increase is similar(legacy v/s SW cmdq).
>>> Could be due to benchmark itself ?
>>
>> Normally sequential reading would result in large transfers due to
>> readahead.  But the test is using Direct-I/O (-I option) to prevent VFS
>> caching distorting the results.  So the sequential read case ends up being
>> more like a random read case anyway.
>>
>>>
>>> Do you think we should get some other benchmarks tested as well?
>>> (may be tio?)
>>>
>>>
>>> Also could you please also add some analysis on where we should expect to
>>> see the score improvement in SW CMDQ and where we may see some decrements
>>> due to SW CMDQ?
>>
>> I would expect random reads to be improved, but there is the overhead of the
>> extra cmdq commands, so a small decrease in performance would be expected
>> otherwise.
>>
>>> You did mention in original cover-letter that we mostly should see
>>> improvement in Random read scores, but below here we are seeing similar or
>>> higher improvement in sequential reads(4 threads). Which is a bit
>>> surprising.
>>
>> As explained above: the test is called "sequential" but the limited record
>> size combined with Direct I/O makes it more like random I/O especially when
>> it is mixed from multiple threads.
> In that case if we see sequential read v/s random read for single thread of
> SWCMDQ, both show the same data. Both SR and RR should not be same ideally no?

Yes, with these iozone tests, SR and RR seem the same.

> 
> 
>>
>>>
>>>
>>>
>>>
>>> On 10/24/2016 2:07 PM, Adrian Hunter wrote:
>>>> Hi
>>>>
>>>> Here is an updated version of the Software Command Queuing patches,
>>>> re-based on next, with patches 1-5 dropped because they have been applied,
>>>> and 2 fixes that have been rolled in (refer Changes in V5 below).
>>>>
>>>> Performance results:
>>>>
>>>> Results can vary from run to run, but here are some results showing 1, 2
>>>> or 4
>>>> processes with 4k and 32k record sizes.  They show up to 40% improvement in
>>>> read performance when there are multiple processes.
>>>>
>>>> iozone -s 8192k -r 4k -i 0 -i 1 -i 2 -i 8 -I -t 1 -F /mnt/mmc/iozone1.tmp
>>>>
>>>>     Children see throughput for  1 initial writers     =     27909.87
>>>> kB/sec     24204.14 kB/sec      -13.28 %
>>>>     Children see throughput for  1 rewriters     =     28839.28 kB/sec
>>>> 25531.92 kB/sec      -11.47 %
>>>>     Children see throughput for  1 readers         =     25889.65
>>>> kB/sec     24883.23 kB/sec       -3.89 %
>>>>     Children see throughput for 1 re-readers     =     25558.23 kB/sec
>>>> 24679.89 kB/sec       -3.44 %
>>>>     Children see throughput for 1 random readers     =     25571.48
>>>> kB/sec     24689.52 kB/sec       -3.45 %
>>>>     Children see throughput for 1 mixed workload     =     25758.59
>>>> kB/sec     24487.52 kB/sec       -4.93 %
>>>>     Children see throughput for 1 random writers     =     24787.51
>>>> kB/sec     19368.99 kB/sec      -21.86 %
>>>>
>>>> iozone -s 8192k -r 32k -i 0 -i 1 -i 2 -i 8 -I -t 1 -F /mnt/mmc/iozone1.tmp
>>>>
>>>>     Children see throughput for  1 initial writers     =     91344.61
>>>> kB/sec    102008.56 kB/sec       11.67 %
>>>>     Children see throughput for  1 rewriters     =     87932.36 kB/sec
>>>> 96630.44 kB/sec        9.89 %
>>>>     Children see throughput for  1 readers         =    134879.82
>>>> kB/sec    110292.79 kB/sec      -18.23 %
>>>>     Children see throughput for 1 re-readers     =    147632.13 kB/sec
>>>> 109053.33 kB/sec      -26.13 %
>>>>     Children see throughput for 1 random readers     =     93547.37
>>>> kB/sec    112225.50 kB/sec       19.97 %
>>>>     Children see throughput for 1 mixed workload     =     93560.04
>>>> kB/sec    110515.21 kB/sec       18.12 %
>>>>     Children see throughput for 1 random writers     =     92841.84
>>>> kB/sec     81153.81 kB/sec      -12.59 %
>>>>
>>>> iozone -s 8192k -r 4k -i 0 -i 1 -i 2 -i 8 -I -t 2 -F /mnt/mmc/iozone1.tmp
>>>> /mnt/mmc/iozone2.tmp
>>>>
>>>>     Children see throughput for  2 initial writers     =     31145.43
>>>> kB/sec     33771.25 kB/sec        8.43 %
>>>>     Children see throughput for  2 rewriters     =     30592.57 kB/sec
>>>> 35916.46 kB/sec       17.40 %
>>>>     Children see throughput for  2 readers         =     31669.83
>>>> kB/sec     37460.13 kB/sec       18.28 %
>>>>     Children see throughput for 2 re-readers     =     32079.94 kB/sec
>>>> 37373.33 kB/sec       16.50 %
>>>>     Children see throughput for 2 random readers     =     27731.19
>>>> kB/sec     37601.65 kB/sec       35.59 %
>>>>     Children see throughput for 2 mixed workload     =     13927.50
>>>> kB/sec     14617.06 kB/sec        4.95 %
>>>>     Children see throughput for 2 random writers     =     31250.00
>>>> kB/sec     33106.72 kB/sec        5.94 %
>>>>
>>>> iozone -s 8192k -r 32k -i 0 -i 1 -i 2 -i 8 -I -t 2 -F /mnt/mmc/iozone1.tmp
>>>> /mnt/mmc/iozone2.tmp
>>>>
>>>>     Children see throughput for  2 initial writers     =    123255.84
>>>> kB/sec    131252.22 kB/sec        6.49 %
>>>>     Children see throughput for  2 rewriters     =    115234.91 kB/sec
>>>> 107225.74 kB/sec       -6.95 %
>>>>     Children see throughput for  2 readers         =    128921.86
>>>> kB/sec    148562.71 kB/sec       15.23 %
>>>>     Children see throughput for 2 re-readers     =    127815.24 kB/sec
>>>> 149304.32 kB/sec       16.81 %
>>>>     Children see throughput for 2 random readers     =    125600.46
>>>> kB/sec    148406.56 kB/sec       18.16 %
>>>>     Children see throughput for 2 mixed workload     =     44006.94
>>>> kB/sec     50937.36 kB/sec       15.75 %
>>>>     Children see throughput for 2 random writers     =    120623.95
>>>> kB/sec    103969.05 kB/sec      -13.81 %
>>>>
>>>> iozone -s 8192k -r 4k -i 0 -i 1 -i 2 -i 8 -I -t 4 -F /mnt/mmc/iozone1.tmp
>>>> /mnt/mmc/iozone2.tmp /mnt/mmc/iozone3.tmp /mnt/mmc/iozone4.tmp
>>>>
>>>>     Children see throughput for  4 initial writers     =     24100.96
>>>> kB/sec     33336.58 kB/sec       38.32 %
>>>>     Children see throughput for  4 rewriters     =     31650.20 kB/sec
>>>> 33091.53 kB/sec        4.55 %
>>>>     Children see throughput for  4 readers         =     33276.92
>>>> kB/sec     41799.89 kB/sec       25.61 %
>>>>     Children see throughput for 4 re-readers     =     31786.96 kB/sec
>>>> 41501.74 kB/sec       30.56 %
>>>>     Children see throughput for 4 random readers     =     31991.65
>>>> kB/sec     40973.93 kB/sec       28.08 %
>>>>     Children see throughput for 4 mixed workload     =     15804.80
>>>> kB/sec     13581.32 kB/sec      -14.07 %
>>>>     Children see throughput for 4 random writers     =     31231.42
>>>> kB/sec     34537.03 kB/sec       10.58 %
>>>>
>>>> iozone -s 8192k -r 32k -i 0 -i 1 -i 2 -i 8 -I -t 4 -F /mnt/mmc/iozone1.tmp
>>>> /mnt/mmc/iozone2.tmp /mnt/mmc/iozone3.tmp /mnt/mmc/iozone4.tmp
>>>>
>>>>     Children see throughput for  4 initial writers     =    116567.42
>>>> kB/sec    119280.35 kB/sec        2.33 %
>>>>     Children see throughput for  4 rewriters     =    115010.96 kB/sec
>>>> 120864.34 kB/sec        5.09 %
>>>>     Children see throughput for  4 readers         =    130700.29
>>>> kB/sec    177834.21 kB/sec       36.06 %
>>> Do you think sequential read will increase more that of random read. It
>>> should mostly benefit in random reads right. Any idea why it's behaving
>>> differently here?
>>
>> Explained above.
>>
>>>
>>>
>>>>     Children see throughput for 4 re-readers     =    125392.58 kB/sec
>>>> 175975.28 kB/sec       40.34 %
>>>>     Children see throughput for 4 random readers     =    132194.57
>>>> kB/sec    176630.46 kB/sec       33.61 %
>>>>     Children see throughput for 4 mixed workload     =     56464.98
>>>> kB/sec     54140.61 kB/sec       -4.12 %
>>>>     Children see throughput for 4 random writers     =    109128.36
>>>> kB/sec     85359.80 kB/sec      -21.78 %
>>> Similarly, we don't expect random write scores to decrease here. Do you know
>>> why this could be the case here?
>>
>> There is a lot of variation from one run to another
> 
> These run-to-run variations are due to what, any idea?

Not really, but there is no knowing how much internal work the eMMC is
doing, wear-leveling, erasing blocks, cache flushing etc.  Also "random"
writes that hit the same erase block can be combined when flushing the
cache, and random writes to the same sectors can also be combined - so the
potential for variation is very large.

> 21% variations is huge.
> 
> Actually can we try and get some data which shows the difference between
> SeqR and RandR and also RandW should not decrease this much.
> May be by changing iozone parameters?
> 
> 
> How about below data ?

Yes that would be interesting

> 
> For Sequential
> ./iozone -s 64m -r 32m -i 0 -i 1 -i 2 -i 8 -I -t 4 -F /data/mmc/iozone1.tmp
> /data/mmc/iozone2.tmp /data/mmc/iozone3.tmp /data/mmc/iozone4.tmp
> 
> For random -
> ./iozone -s 64m -r 4k -i 0 -i 1 -i 2 -i 8 -I -t 4 -F /data/mmc/iozone1.tmp
> /data/mmc/iozone2.tmp /data/mmc/iozone3.tmp /data/mmc/iozone4.tmp
> 
> 
> Regards
> Ritesh
> 

