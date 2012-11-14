From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v8 2/2] mmc: support packed write command for eMMC4.5  device
Date: Tue, 13 Nov 2012 21:54:08 -0500
Message-ID: <87mwykdhdb.fsf@octavius.laptop.org>
References: <ed6366950474fb35cac89881648fb9e9.squirrel@www.codeaurora.org>
	<009701cd5d64$c7dc2aa0$57947fe0$%jun@samsung.com>
	<fc9caa907c442ce8390e774744d9dae7.squirrel@www.codeaurora.org>
	<00c401cd5dbb$6d605630$48210290$%jun@samsung.com>
	<37d6acd1dfb6cc6436a3047b1e17d823.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47811 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932494Ab2KNCyS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Nov 2012 21:54:18 -0500
In-Reply-To: <37d6acd1dfb6cc6436a3047b1e17d823.squirrel@www.codeaurora.org>
	(merez@codeaurora.org's message of "Sat, 3 Nov 2012 22:05:18 -0700
	(PDT)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>

Hi Maya,

On Sun, Nov 04 2012, merez@codeaurora.org wrote:
> Packed commands is a mandatory eMMC4.5 feature and is supported by all
> the card vendors.

We're still only talking about using packed writes, though, right?

> It wa proven to be beneficial for eMMC4.5 cards and harmless for non
> eMMC4.5 cards.

My understanding is that write packing causes a regression in read
performance that can be tuned/fixed by your num_wr_reqs_to_start_packing
tunable (and read packing causes a read regression with current eMMC 4.5
cards).  Is that wrong?

> I don't see a point to hold it back while it can be enabled or
> disabled by a flag and most of the code it adds is guarded in specific
> functions and is not active when packed commands is disabled.

Earlier in the thread I wrote:

>> * I still don't have a good set of representative benchmarks showing
>>   what kind of performance changes come with this patchset. It seems
>>   like we've had a small amount of testing on one controller/eMMC
>>   part combo from Seungwon, and an entirely different test from Maya,
>>   and the results aren't documented fully anywhere to the level of
>>   describing what the hardware was, what the test was, and what the
>>   results were before and after the patchset.

I still feel this way.  I'm worried that we might be merging code that
works well on your controller/card but causes large regressions for
everyone else.  I don't want to handle this by making a tunable that
everyone has to tune for their system, because I don't think anyone will
tune it.  I don't think that shipping a capability that will probably
lead to performance regressions if you turn it on is a good idea.

I'm in a better position to help now, though -- I have some motherboards
with Marvell SoCs and a socketed eMMC slot, and I have eMMC 4.5 parts
from Sandisk and Toshiba.  So I can try to help work out how
generalizable your results are across other controllers and cards.

So far I've only tried the Sandisk part, but it didn't show any write
improvement with write packing.  I've verified that the switch command
to turn on packed_event_en happens and succeeds, and that the caps are
set correctly, so I'm not sure what's wrong yet.  With iozone I get:

                       KB  reclen   write rewrite
Unpacked writes:    10240    8192   17250   16794 
Packed writes:      10240    8192   16930   17353

I'll try the Toshiba part next, and I'll start using lmdd as well as
iozone.  Any ideas on why I might not be seeing improvements with
Sandisk?

I'm not opposed to merging packed write support in principle, I just
want to be convinced that we're not causing regressions for most users
who turn it on.  (And more than that, I want to see that it leads to
improvements that make it worth adding the code complexity for.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
