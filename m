From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: mmci.c regression
Date: Mon, 2 Jul 2012 14:07:57 +0100
Message-ID: <20120702130757.GH16319@n2100.arm.linux.org.uk>
References: <4FF190A2.6@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36462 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861Ab2GBNIF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jul 2012 09:08:05 -0400
Content-Disposition: inline
In-Reply-To: <4FF190A2.6@antcom.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: linux-mmc@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, cjb@laptop.org, Alexandre Pereira da Silva <aletes.xgr@gmail.com>

On Mon, Jul 02, 2012 at 02:14:26PM +0200, Roland Stigge wrote:
> Hi,
> 
> I'm getting a strange regression with mmci.c at v3.5-rc4 -> v3.5-rc5: Bootup:
> 
> v3.5-rc4:
> 
> mmci-pl18x 20098000.sd: mmc0: PL180 manf 41 rev0 at 0x20098000 irq 15,13 (pio)
> mmci-pl18x 20098000.sd: no DMA platform data
> mmc0: new SD card at address bd34
> mmcblk0: mmc0:bd34 SD02G 1.83 GiB 
> mmcblk0: error -5 transferring data, sector 0, nr 8, cmd response 0x900, card status 0xb00
> mmcblk0: retrying using single block read
>  mmcblk0: p1
> 
> v3.5-rc5:
> 
> mmci-pl18x 20098000.sd: mmc0: PL180 manf 41 rev0 at 0x20098000 irq 15,13 (pio)
> mmci-pl18x 20098000.sd: no DMA platform data
> mmc0: new SD card at address bd34
> mmcblk0: mmc0:bd34 SD02G 1.83 GiB 
> mmcblk0: error -5 transferring data, sector 0, nr 8, cmd response 0x0, card status 0x900
> mmcblk0: retrying using single block read
> mmcblk0: error -5 transferring data, sector 0, nr 8, cmd response 0x0, card status 0x0
> end_request: I/O error, dev mmcblk0, sector 0
> mmcblk0: error -5 transferring data, sector 1, nr 7, cmd response 0x0, card status 0x0
> end_request: I/O error, dev mmcblk0, sector 1
> mmcblk0: error -5 transferring data, sector 2, nr 6, cmd response 0x0, card status 0x0
> end_request: I/O error, dev mmcblk0, sector 2
> Buffer I/O error on device mmcblk0, logical block 0
>  mmcblk0: unable to read partition table

Nothing changed with the mmci driver between these two, but there is this
change:

commit d380443cd0271903bf9516bc04cead81676be034
Author: Subhash Jadavani <subhashj@codeaurora.org>
Date:   Wed Jun 13 17:10:43 2012 +0530

    mmc: block: fix the data timeout issue with ACMD22

You could try reverting that and seeing whether that fixes it, otherwise
it's going to have to be a git bisect.

There's three things that would cause an -EIO error:

1. if DMA is being used, and there is data left in the FIFO after the DMA
   has allegedly completed.
2. an underrun on sending data to the card (you're trying to receive so
   this doesn't apply)
3. an overrun on receiving data from the card (eg, the PIO interrupt handling
   is not fast enough to keep up with the data coming off the card.)

I suspect (3) is your problem, and finding out what caused that is
definitely going to be a matter for bisect - and this will probably be
where you'd probably end up wishing that running all IRQ handlers
exclusively wasn't done now.
