From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH] mmc: fix race condition between dma and omap_hsmmc
	callback
Date: Sun, 18 Apr 2010 19:07:00 +0530
Message-ID: <x2s618f0c911004180637gde02aecn57c650cc19d142f0@mail.gmail.com>
References: <618f0c911003240600m1a38935av68f31a232ed8b8ad@mail.gmail.com>
	 <4BC43D99.6030809@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49651 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126Ab0DRNhB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 18 Apr 2010 09:37:01 -0400
In-Reply-To: <4BC43D99.6030809@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Madhusudhan Chikkature <madhu.cr@ti.com>, Tony Lindgren <tony@atomide.com>

On Tue, Apr 13, 2010 at 3:17 PM, Adrian Hunter <adrian.hunter@nokia.com=
> wrote:
> Venkatraman S wrote:
>>
>> This patch addresses the possible race condition between the dma
>> callback and hsmmc callback.
>
> Can you explain the problem in more detail? =A0If the final DMA inter=
rupt
> comes before TC then all should be well.
   Actually it isn't, with descriptor loading. If the DMA callback arri=
ves
"too early", the MMC TC is missed sometimes. The last transfer in the l=
og
below is actually stalled waiting for TC. This happens more often when =
the
transfer is large (> 300 blocks)

>If it comes after, then we need
> to be sure that the DMA has finished - particularly in the "read" cas=
e.
> Neither the existing code nor this patch seems to address that issue.
>
   With this patch the assumption is that MMC TC correctly signals the
end of read / write as requested. I don't know if there are any specifi=
c reasons
to believe otherwise.

> Also, how can we be sure the final DMA interrupt doesn't race with th=
e
> start of the next request?
>
Till the time omap_hsmmc_xfer_done is called, the next request is not
expected to arrive.
The requests are implicitly serialised by host->sem, which is released
only on the DMA callback.
The code releases the semaphore only after freeing the DMA channel.
-----------------------------------------------------------------------=
----------------------

mmc0: starting CMD17 arg 00000066 flags 000000b5
mmc0:     blksz 512 blocks 1 flags 00000200 tsac 100 ms nsac 0
mmci-omap-hs mmci-omap-hs.0: mmc0: CMD17, argument 0x00000066
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 1
mmci-omap-hs mmci-omap-hs.0: final dma callback
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 2
mmc0: req done (CMD17): 0: 00000900 00000000 00000000 00000000
mmc0:     512 bytes transferred: 0
mmc0: starting CMD18 arg 000025df flags 000000b5
mmc0:     blksz 512 blocks 32 flags 00000200 tsac 100 ms nsac 0
mmc0:     CMD12 arg 00000000 flags 0000049d
mmci-omap-hs mmci-omap-hs.0: mmc0: CMD18, argument 0x000025df
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 1
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 2
mmci-omap-hs mmci-omap-hs.0: mmc0: CMD12, argument 0x00000000
mmci-omap-hs mmci-omap-hs.0: final dma callback
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 3
mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
mmc0:     16384 bytes transferred: 0
mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
mmc0: starting CMD18 arg 000025ff flags 000000b5
mmc0:     blksz 512 blocks 192 flags 00000200 tsac 100 ms nsac 0
mmc0:     CMD12 arg 00000000 flags 0000049d
mmci-omap-hs mmci-omap-hs.0: new sglist 9fd00000 len =3D23
mmci-omap-hs mmci-omap-hs.0: mmc0: CMD18, argument 0x000025ff
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 1
mmci-omap-hs mmci-omap-hs.0: final dma callback
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 2
mmci-omap-hs mmci-omap-hs.0: mmc0: CMD12, argument 0x00000000
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 3
mmc0: req done (CMD18): 0: 00000900 00000000 00000000 00000000
mmc0:     98304 bytes transferred: 0
mmc0:     (CMD12): 0: 00000b00 00000000 00000000 00000000
mmc0: starting CMD18 arg 000026bf flags 000000b5
mmc0:     blksz 512 blocks 512 flags 00000200 tsac 100 ms nsac 0
mmc0:     CMD12 arg 00000000 flags 0000049d
mmci-omap-hs mmci-omap-hs.0: new sglist 9fd00000 len =3D26
mmci-omap-hs mmci-omap-hs.0: mmc0: CMD18, argument 0x000026bf
mmci-omap-hs mmci-omap-hs.0: IRQ Status is 1
mmci-omap-hs mmci-omap-hs.0: final dma callback
