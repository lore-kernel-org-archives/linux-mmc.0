From: merez@codeaurora.org
Subject: Re: [PATCH v8 2/2] mmc: support packed write command for eMMC4.5   
         device
Date: Wed, 14 Nov 2012 00:14:58 -0800 (PST)
Message-ID: <c990a66b72acaaf514c4ff2cbbcd6236.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:47320 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450Ab2KNIPO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Nov 2012 03:15:14 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: merez@codeaurora.org, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>

Hi Chris,

The amount of improvement from the packed commands, as from any other
eMMC4.5 feature, depends on several parameters:
1. The card support of this feature. If the card supports only the feat=
ure
interface, then you'll see no improvement when using the feature.
2. The benchmark tool used. Since the packed command preparation is
stopped due to a FLUSH request, a benchmark that issues many FLUSH
requests can result in a small amount of packing and you will see no
improvement.

You can use the following patch to get the packed commands statistics:
http://marc.info/?l=3Dlinux-mmc&m=3D134374508625826&w=3D2
With this patch you will be able to see the amount of packing and what
caused the packed preparation to stop.

We tested the packed commands feature with SanDisk cards and got
improvement of 30% when using lmdd and tiotest. We don't use iozone for
sequential tests but if you'll send me the exact command that you use w=
e
can try it as well.

It is true that packed commands can cause degradation of read in
read-write collisions. However, it is only nature that when having long=
er
write request a read request has to wait for a longer time and its late=
ncy
will increase. I believe that it is not our duty to decide if this is a
reason to exclude this feature. Everyone should take its own decision i=
f
he wants to benefit from the write improvement, while risking the
read-write collisions scenarios.
eMMC4.5 introduces the HPI and stop transmission to overcome the
degradation of read latency due to write (regardless of the packed
commands).
The packing control is our own enhancement that we believe can also be
used to overcome this degradation. It is tunable and requires a specifi=
c
enabling, so it can be the developer=92s decision whether to use it or =
not.
Since it is not a standard feature we can discuss separately if it shou=
ld
be accepted or not and what is the best way to use it.

Packed commands is not the only eMMC4.5 feature that can cause degradat=
ion
in specific scenarios. If we will look at the cache feature, it causes
degradation by almost a half in random operations when FLUSH is being
used.
When using the following iozone command when cache is enabled, you will
see degradation in the iozone results:
=2E/data/iozone -i0 -i2 -r4k -s50m -O -o -I -f /data/mmc0/file3
However, cache support was accepted regardless of this degradation and =
it
is the developer=92s responsibility to decide if to use this feature or=
 not.

To summarize, all eMMC4.5 features that were added are tunable and
disabled by default.
I believe that when someone would enable a certain feature he will do a=
ll
the required testing for determining if he can benefit from this featur=
e
or not in his own environment.

Thanks,
Maya

On Tue, November 13, 2012 6:54 pm, Chris Ball wrote:
> Hi Maya,
>
> On Sun, Nov 04 2012, merez@codeaurora.org wrote:
>> Packed commands is a mandatory eMMC4.5 feature and is supported by a=
ll
the card vendors.
>
> We're still only talking about using packed writes, though, right?
>
>> It wa proven to be beneficial for eMMC4.5 cards and harmless for non
eMMC4.5 cards.
>
> My understanding is that write packing causes a regression in read
performance that can be tuned/fixed by your num_wr_reqs_to_start_packin=
g
tunable (and read packing causes a read regression with current eMMC 4.=
5
cards).  Is that wrong?
>
>> I don't see a point to hold it back while it can be enabled or
>> disabled by a flag and most of the code it adds is guarded in specif=
ic
functions and is not active when packed commands is disabled.
>
> Earlier in the thread I wrote:
>
>>> * I still don't have a good set of representative benchmarks showin=
g
>>>   what kind of performance changes come with this patchset. It seem=
s
like we've had a small amount of testing on one controller/eMMC part
combo from Seungwon, and an entirely different test from Maya, and
the results aren't documented fully anywhere to the level of
describing what the hardware was, what the test was, and what the
results were before and after the patchset.
>
> I still feel this way.  I'm worried that we might be merging code tha=
t
works well on your controller/card but causes large regressions for
everyone else.  I don't want to handle this by making a tunable that
everyone has to tune for their system, because I don't think anyone wil=
l
tune it.  I don't think that shipping a capability that will probably
lead to performance regressions if you turn it on is a good idea.
>
> I'm in a better position to help now, though -- I have some motherboa=
rds
with Marvell SoCs and a socketed eMMC slot, and I have eMMC 4.5 parts
from Sandisk and Toshiba.  So I can try to help work out how
> generalizable your results are across other controllers and cards.
>
> So far I've only tried the Sandisk part, but it didn't show any write
improvement with write packing.  I've verified that the switch command
to turn on packed_event_en happens and succeeds, and that the caps are
set correctly, so I'm not sure what's wrong yet.  With iozone I get:
>
>                        KB  reclen   write rewrite
> Unpacked writes:    10240    8192   17250   16794
> Packed writes:      10240    8192   16930   17353
>
> I'll try the Toshiba part next, and I'll start using lmdd as well as
iozone.  Any ideas on why I might not be seeing improvements with
Sandisk?
>
> I'm not opposed to merging packed write support in principle, I just
want to be convinced that we're not causing regressions for most users
who turn it on.  (And more than that, I want to see that it leads to
improvements that make it worth adding the code complexity for.)
>
> Thanks,
>
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
>


--=20
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a mem=
ber
of Code Aurora Forum, hosted by The Linux Foundation



