From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 00/17] MMC/SDHCI fixes
Date: Mon, 21 Dec 2015 11:46:32 +0100
Message-ID: <CAPDyKFpuOymN=SVYQ4-FGP+0MbE5F9RrV5usaJQJn2yh+JGzgw@mail.gmail.com>
References: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34016 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbbLUKqd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Dec 2015 05:46:33 -0500
Received: by mail-yk0-f170.google.com with SMTP id p130so126771875yka.1
        for <linux-mmc@vger.kernel.org>; Mon, 21 Dec 2015 02:46:33 -0800 (PST)
In-Reply-To: <20151219202851.GS8644@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, Marcin Wojtas <mw@semihalf.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>

On 19 December 2015 at 21:28, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This all started with a report from an iMX6 Hummingboard user that
> they were seeing regular "mmc0: Got data interrupt 0x00000002 even
> though no data operation was in progress." messages with 4.4-rc and
> additional patches to enable UHS support in DT for the platform.
>
> When I tested 4.4-rc on an iMX6 Hummingboard with UHS support enabled,
> I found several other issues.  This patch series addresses some of
> the issues.
>
> However, while testing on Armada 388, an issue was found there, and
> a fix is also included in this patch set, however it does not depend
> on the rest of the patch series.
>
> We all know that the SDHCI driver is in poor state, and Ulf's desire
> to see it turned into a library (which actually comes from myself.)
> However, with the driver in such a poor state, it makes sense to fix
> a few of the issues first, especially if they result in the code
> shrinking - which they do.
>
> However, given what I've found below, I have to wonder how many of the
> quirks that we have in this driver are down to the poor code rather than
> real hardware problems: how many of them are due to poorly investigated
> bugs.
>
> This series starts off by shutting up some kernel messages that should
> not be verbose:
> - the voltage-ranges DT property is optional, so we should not print
>   a message saying that it's missing from DT.  That suggests it isn't
>   optional.  As no ill effect comes from not specifying it, I've
>   dropped this message to debug level.
>
> - "retrying because a re-tune was needed" - a re-tune is something that
>   is part of the higher speed SD specs, and it's required to happen
>   periodically.  So it's expected and normal behaviour.  There's no need
>   to print this to the kernel log.
>
> - When tuning fails, rather than a bland "mmc0: tuning execution failed"
>   message, print the error code so that we can see what the reason for
>   the failure is.  MMC fails on this point in many places.
>
> - Move the initialisation of the command ->error member.  It looks to
>   me as if this is not required; mmc_start_request() does this already,
>   as it seems the rest of the MMC core does too.  Maybe this should be
>   removed altogether?
>
> - Testing error bits, then setting the error, then testing the error
>   value, and completing the command is a very lengthy way to deal with
>   errors here.  Test the error bits, and then decide what error occurred
>   before completing.  (This code is actually buggy, see the next change).
>
> - If a command _response_ CRC error occurs, we can't be certain whether
>   the card received the command successfully, and has started processing
>   it.  If it has, and it results in data being read from the card, the
>   card will enter data transfer state, and start sending data to the
>   host.  Therefore, it is completely wrong to blindly terminate the
>   command, especially when such termination fails to clean _anything_
>   up - eg, it leaves DMA in place so the host can continue DMAing to the
>   memory, and it leaves buffers DMA mapped - which eventually annoys the
>   DMA API debugging.  Fix this by assuming that a CRC error is a receive
>   side error.  If the card did not correctly receive the command, it
>   will not initiate a data transfer, and we should time out after the
>   card specified timeout.
>
>   With the unmodified mainline code, even if we reset the state machines
>   when finishing a request in error, the _card_ itself may well still be
>   in data transfer mode when this happens.  How can we be sure what state
>   the data side is actually in?  Could this be why (eg) sdhci-esdhc-imx.c
>   has this:
>
>         /* FIXME: delay a bit for card to be ready for next tuning due to errors */
>         mdelay(1);
>
>   And how many more such _hacks_ are working around similar problems?
>
> - The unaligned buffer handling is a total waste of resources in its
>   current form.  We DMA map, sync, and unmap it on every transfer,
>   whether the buffer is used or not.  For MMC/SD transfers, these will
>   be coming from the VFS/MM layers, which operate through the page
>   cache - hence the vast majority of buffers will be page aligned.
>   Performance measurements on iMX6 show that this additional DMA
>   maintanence is responsible for a 10% reduction in read transfer
>   performance.  Switch this to use a DMA coherent mapping instead, which
>   needs no DMA maintanence.
>
> - sdhci_adma_table_post() is badly coded: we walk the scatterlist
>   looking for any buffers which might not be aligned (which can be a
>   rare event, see above) and then we only do something if we find an
>   unaligned buffer _and_ it's a read transfer.  So for a write transfer,
>   this scatterlist walking is a total waste of CPU cycles.  Testing the
>   transfer direction is much cheaper than walking the scatterlist.
>   Re-organise the code to do the cheap test first.
>
> - There are two paths to identical DMA unmapping code (the code around
>   dma_unmap_sg()) in sdhci_finish_data() and its child function
>   sdhci_adma_table_post().  Trivially simplify this duplication.
>
> - Move sdhci_pre_dma_transfer() so we avoid needing to declare it.
>
> - Do the same thing with sdhci_prepare_data() and sdhci_pre_dma_transfer()
>   as with sdhci_finish_data() and sdhci_adma_table_post().
>
> - Fix the mess that is the data segment host_cookie handling.  The
>   existing code seems like a candidate for the obfuscated coding prize!
>   Four patches address this, turning it into something much easier to
>   understand, which then allows (finally)...
>
> - The DMA API leak which occurs when we have mapped the DMA buffers in
>   sdhci_prepare_data() and an error occurs early on in the processing
>   of a request.
>
> - A final change (mentioned above) which fixes a prior commit for
>   Armada 38x using sdhci-pxav3.c, found while trying to get the higher
>   speed modes working on these SoCs.  Clearly the existing code is
>   broken, this at least resolves some of the breakage by allowing the
>   correct high-order SDHCI capabilities through.
>
> All these patches are resulting from _only_ today; I'm sure more will
> be coming in the forthcoming weeks, as all I seem to have to do is
> give code a little shake and _lots_ of bugs appear.  Despite this being
> a series of 17 patches, it does not yet solve _all_ the problems I've
> found so far on iMX6 with SDHCI.
>
> I've tested these changes on iMX6 at UHS speeds, and Armada 388 SoCs
> at HS speeds so far.  Others should test them.

Thanks for the detailed change-log, really helpful!

I have reviewed the patches, and found only a few minor things.

Related to patch1, I noticed that the callers of
mmc_of_parse_voltage() don't check the return value. Adopting my
suggested change to patch1, would enable them to be able to check the
return code.

Kind regards
Uffe

>
>  drivers/mmc/card/block.c       |   4 +-
>  drivers/mmc/core/core.c        |  10 +-
>  drivers/mmc/host/sdhci-pxav3.c |   6 +-
>  drivers/mmc/host/sdhci.c       | 318 ++++++++++++++++++-----------------------
>  drivers/mmc/host/sdhci.h       |   4 +-
>  5 files changed, 157 insertions(+), 185 deletions(-)
>
> --
> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
