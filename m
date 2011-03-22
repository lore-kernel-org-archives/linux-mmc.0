From: Simon Horman <horms@verge.net.au>
Subject: Re: SDHC Read Performance
Date: Tue, 22 Mar 2011 16:16:12 +0900
Message-ID: <20110322071611.GC23009@verge.net.au>
References: <20110119000909.GA9412@verge.net.au>
 <AANLkTi=fw1C0cj9U9=c0PxvOPHZtM66pDc+zpR9p=68c@mail.gmail.com>
 <20110321223809.GA27019@verge.net.au>
 <201103212355.36951.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:46005 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab1CVHQS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Mar 2011 03:16:18 -0400
Content-Disposition: inline
In-Reply-To: <201103212355.36951.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Arnd Hannemann <arnd@arndnet.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Mon, Mar 21, 2011 at 11:55:36PM +0100, Arnd Bergmann wrote:
> On Monday 21 March 2011 23:38:56 Simon Horman wrote:
> > Write Speed
> > # dd if=/dev/zero of=/dev/mmcblk0 bs=512 count=100000
> > SD1.1:                  2.5 MB/s   <-- Faster than expected
> > SD2.0:                  3.0 MB/s   <-- Faster than expected
> > SDHC Class 2:           2.3 MB/s   <-- Faster than expected
> > SDHC Class 10:          4.0 MB/s   <-- Slower than expected
> > SanDisk SDHC Class 10:  4.3 MB/s   <-- Slower than expected
> > MMC4.0:                 2.3 MB/s   <-- Clocked down to 12Mhz due to
> >                                        driver limitations
> 
> Please see https://lwn.net/Articles/428584/ and https://wiki.linaro.org/WorkingGroups/KernelConsolidation/Projects/FlashCardSurvey
> for possible explanations why your speed is not what you think
> it should be.
> 
> I have written a tool that will give you more conclusive
> data: git clone git://git.linaro.org/people/arnd/flashbench.git
> 
> Please Cc flashbench-results@lists.linaro.org when you have
> measurements from that. You will first need to find out
> the erase block size of each card (typically 4 MB), and then
> pass that to the --open-au --erasesize=${SIZE} --open-au-nr=${NR}
> benchmark to get useful results.
> 
> The write speed for writing full erase blocks (allocation units)
> is normally the best that a card can provide, and you will see
> how it gets worse with smaller block sizes. Try different
> values for ${NR} to find out what the maximum is that the card
> can sustain at full performance, most cards get really slow as
> soon as it runs out of segments (not the case with your
> benchmarking, since you write from start to end).

Thanks Arnd,

I'll report back once I have some numbers.

