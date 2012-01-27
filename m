From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: omap_hsmmc.c and MMC_CAP_SDIO_IRQ
Date: Fri, 27 Jan 2012 06:09:49 -0800
Message-ID: <CAGDS+nnVosHsv4SUcGXCieVQG2cjW=mL7DZ7_W2p+uNhUYfPyw@mail.gmail.com>
References: <4F1EC123.8070103@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:39810 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752510Ab2A0OJt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Jan 2012 09:09:49 -0500
In-Reply-To: <4F1EC123.8070103@linuxtv.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Hunold <hunold@linuxtv.org>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

On Tue, Jan 24, 2012 at 6:33 AM, Michael Hunold <hunold@linuxtv.org> wrote:
> Hi,
>
> I am experimenting with an SDIO card on the Beagleboard. I have started
> my experiments with Linux-3.1.4 some time ago and basically everything
> is working.
>
> Except the fact that currently no native SDIO interrupts are used, but
> the status register is polled to recognise the interrupts. Ugh.
>
> So I tried to find out the current state of MMC_CAP_SDIO_IRQ support.

Your summary below is a pretty accurate description of the current state.

> 0. No support for MMC_CAP_SDIO_IRQ in omap_hsmmc.c is present in mainline.
>
> 1. The "beagleboard-validation" kernel seems to have support for
> MMC_CAP_SDIO_IRQ in omap_hsmmc.c:
>
> http://gitorious.org/beagleboard-validation/linux/blobs/beagleboardXM/drivers/mmc/host/omap_hsmmc.c
>
> But this is an ancient 2.6.32 kernel. I tried to use it anyway, but
> compilation failed for me. I did not try to find the route cause of the
> problem.
>
> 2. Another indication of MMC_CAP_SDIO_IRQ support in omap_hsmmc.c can be
> found here:
>
> http://git.angstrom-distribution.org/cgi-bin/cgit.cgi/meta-texasinstruments/tree/recipes-kernel/linux/linux-omap-2.6.39/sakoman/0013-Enable-the-use-of-SDIO-card-interrupts.patch?id=1735237550d85da337ea57cb5d6be9ccc8c0355c
>
> I don't use Angstrom, so I just got a 2.6.39.4 kernel and tried to apply
> that patch (and the
> 0012-Don-t-turn-SDIO-cards-off-to-save-power.-Doing-so-wi.patch) patch
> as well, but they did not apply cleanly.
>
> I tried to apply these patches to my 3.1.4 kernel, but of course they
> did not apply cleanly either.

Indeed, the structure of omap_hsmmc.c has changed significantly and
applying those patches is not a trivial exercise.

I've made an attempt at creating a patch for 3.2 that follows David
Vrabel's original patch series as closely as possible with the new
structure.

Unfortunately it doesn't quite work.  I've only been doing this as a
background task so progress is pretty slow.

The patch doesn't seem to break support for memory devices (which is
good since my rootfs is on an mmc device!) and I do see SDIO
interrupts occurring and being handled in the debug log, so it is a
good start:

omap_hsmmc omap_hsmmc.1: enabled
mmc1: starting CMD52 arg 10004000 flags 00000195
omap_hsmmc omap_hsmmc.1: mmc1: CMD52, argument 0x10004000
omap_hsmmc omap_hsmmc.1: IRQ Status is 100
Disabling SDIO interrupts
omap_hsmmc omap_hsmmc.1: IRQ Status is 1
mmc1: req done (CMD52): 0: 0000100a 00000000 00000000 00000000
mmc1: starting CMD53 arg 92000094 flags 000001b5
mmc1:     blksz 148 blocks 1 flags 00000100 tsac 1000 ms nsac 0
omap_hsmmc omap_hsmmc.1: mmc1: CMD53, argument 0x92000094
omap_hsmmc omap_hsmmc.1: IRQ Status is 3
mmc1: req done (CMD53): 0: 00002000 00000000 00000000 00000000
mmc1:     148 bytes transferred: 0
mmc1: starting CMD52 arg 10000a00 flags 00000195
omap_hsmmc omap_hsmmc.1: mmc1: CMD52, argument 0x10000a00
omap_hsmmc omap_hsmmc.1: IRQ Status is 1
mmc1: req done (CMD52): 0: 00001003 00000000 00000000 00000000
mmc1: starting CMD52 arg 90000afc flags 00000195
omap_hsmmc omap_hsmmc.1: mmc1: CMD52, argument 0x90000afc
omap_hsmmc omap_hsmmc.1: IRQ Status is 1
mmc1: req done (CMD52): 0: 000010fc 00000000 00000000 00000000
mmc1: starting CMD52 arg 10006800 flags 00000195
omap_hsmmc omap_hsmmc.1: mmc1: CMD52, argument 0x10006800
omap_hsmmc omap_hsmmc.1: IRQ Status is 1
mmc1: req done (CMD52): 0: 00001012 00000000 00000000 00000000
mmc1: starting CMD52 arg 10006a00 flags 00000195
omap_hsmmc omap_hsmmc.1: mmc1: CMD52, argument 0x10006a00
omap_hsmmc omap_hsmmc.1: IRQ Status is 1
mmc1: req done (CMD52): 0: 00001000 00000000 00000000 00000000
mmc1: starting CMD52 arg 10004000 flags 00000195
omap_hsmmc omap_hsmmc.1: mmc1: CMD52, argument 0x10004000
omap_hsmmc omap_hsmmc.1: IRQ Status is 1
mmc1: req done (CMD52): 0: 00001009 00000000 00000000 00000000
mmc1: starting CMD53 arg 12000014 flags 000001b5
mmc1:     blksz 20 blocks 1 flags 00000200 tsac 1000 ms nsac 0
omap_hsmmc omap_hsmmc.1: mmc1: CMD53, argument 0x12000014
omap_hsmmc omap_hsmmc.1: IRQ Status is 3
mmc1: req done (CMD53): 0: 00002000 00000000 00000000 00000000
mmc1:     20 bytes transferred: 0
Enabling SDIO interrupts
omap_hsmmc omap_hsmmc.1: IRQ Status is 100
Disabling SDIO interrupts
mmc1: starting CMD52 arg 10000a00 flags 00000195
omap_hsmmc omap_hsmmc.1: mmc1: CMD52, argument 0x10000a00
omap_hsmmc omap_hsmmc.1: IRQ Status is 1
mmc1: req done (CMD52): 0: 00001001 00000000 00000000 00000000
mmc1: starting CMD52 arg 90000afe flags 00000195
omap_hsmmc omap_hsmmc.1: mmc1: CMD52, argument 0x90000afe
omap_hsmmc omap_hsmmc.1: IRQ Status is 1
mmc1: req done (CMD52): 0: 000010fe 00000000 00000000 00000000
mmc1: starting CMD52 arg 10006800 flags 00000195
omap_hsmmc omap_hsmmc.1: mmc1: CMD52, argument 0x10006800
omap_hsmmc omap_hsmmc.1: IRQ Status is 1
mmc1: req done (CMD52): 0: 00001092 00000000 00000000 00000000
mmc1: starting CMD52 arg 10006a00 flags 00000195
omap_hsmmc omap_hsmmc.1: mmc1: CMD52, argument 0x10006a00
omap_hsmmc omap_hsmmc.1: IRQ Status is 1
mmc1: req done (CMD52): 0: 00001000 00000000 00000000 00000000
mmc1: starting CMD52 arg 10004000 flags 00000195
omap_hsmmc omap_hsmmc.1: mmc1: CMD52, argument 0x10004000
omap_hsmmc omap_hsmmc.1: IRQ Status is 1
mmc1: req done (CMD52): 0: 0000100a 00000000 00000000 00000000
mmc1: starting CMD53 arg 12000094 flags 000001b5
mmc1:     blksz 148 blocks 1 flags 00000200 tsac 1000 ms nsac 0
omap_hsmmc omap_hsmmc.1: mmc1: CMD53, argument 0x12000094
omap_hsmmc omap_hsmmc.1: IRQ Status is 1
omap_hsmmc omap_hsmmc.1: IRQ Status is 2
mmc1: req done (CMD53): 0: 00002000 00000000 00000000 00000000
mmc1:     148 bytes transferred: 0
Enabling SDIO interrupts
mmc1: starting CMD52 arg 10004000 flags 00000195
omap_hsmmc omap_hsmmc.1: mmc1: CMD52, argument 0x10004000
omap_hsmmc omap_hsmmc.1: IRQ Status is 1
mmc1: req done (CMD52): 0: 00001008 00000000 00000000 00000000
mmc1: starting CMD53 arg 92000010 flags 000001b5
mmc1:     blksz 16 blocks 1 flags 00000100 tsac 1000 ms nsac 0
omap_hsmmc omap_hsmmc.1: mmc1: CMD53, argument 0x92000010
omap_hsmmc omap_hsmmc.1: IRQ Status is 3
mmc1: req done (CMD53): 0: 00002000 00000000 00000000 00000000
mmc1:     16 bytes transferred: 0
omap_hsmmc omap_hsmmc.1: disabled

However the SDIO device does not function properly due to multiple
timeout errors, so something is still not quite right.

> I noticed that the Pandaboard uses a wifi SDIO adapter. AFAIK the OMAP4
> uses omap_hsmmc.c as well. Is it true that interrupt polling is used
> there, too?

In that case interrupts are used, but sadly they are implemented via a
separate GPIO and not the SDIO interrupt mechanism!

I suspect they did this as a hw workaround to the lack of support for
SDIO interrupts in mainline :-(

Let me know if you would like to help with further development of the
patch and I will send you a copy.  It is rough enough and broken
enough that it probably isn't yet ready for even an RFC to these
lists.

Regards,

Steve
