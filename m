From: Michael Hunold <hunold@linuxtv.org>
Subject: omap_hsmmc.c and MMC_CAP_SDIO_IRQ
Date: Tue, 24 Jan 2012 15:33:07 +0100
Message-ID: <4F1EC123.8070103@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bar.sig21.net ([80.81.252.164]:49933 "EHLO bar.sig21.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756597Ab2AXOdM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 Jan 2012 09:33:12 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-mmc@vger.kernel.org

Hi,

I am experimenting with an SDIO card on the Beagleboard. I have started
my experiments with Linux-3.1.4 some time ago and basically everything
is working.

Except the fact that currently no native SDIO interrupts are used, but
the status register is polled to recognise the interrupts. Ugh.

So I tried to find out the current state of MMC_CAP_SDIO_IRQ support.

0. No support for MMC_CAP_SDIO_IRQ in omap_hsmmc.c is present in mainline.

1. The "beagleboard-validation" kernel seems to have support for
MMC_CAP_SDIO_IRQ in omap_hsmmc.c:

http://gitorious.org/beagleboard-validation/linux/blobs/beagleboardXM/drivers/mmc/host/omap_hsmmc.c

But this is an ancient 2.6.32 kernel. I tried to use it anyway, but
compilation failed for me. I did not try to find the route cause of the
problem.

2. Another indication of MMC_CAP_SDIO_IRQ support in omap_hsmmc.c can be
found here:

http://git.angstrom-distribution.org/cgi-bin/cgit.cgi/meta-texasinstruments/tree/recipes-kernel/linux/linux-omap-2.6.39/sakoman/0013-Enable-the-use-of-SDIO-card-interrupts.patch?id=1735237550d85da337ea57cb5d6be9ccc8c0355c

I don't use Angstrom, so I just got a 2.6.39.4 kernel and tried to apply
that patch (and the
0012-Don-t-turn-SDIO-cards-off-to-save-power.-Doing-so-wi.patch) patch
as well, but they did not apply cleanly.

I tried to apply these patches to my 3.1.4 kernel, but of course they
did not apply cleanly either.

3. There is one discussion from October 2009:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg17802.html

4. There is patchset from David Vrabel from Februrary 2010:
http://www.spinics.net/lists/linux-mmc/msg01184.html

This seems to be the same as in 2.

So what is the current state of MMC_CAP_SDIO_IRQ support in omap_hsmmc.c?

Any hints how to proceed or which road to take?

I noticed that the Pandaboard uses a wifi SDIO adapter. AFAIK the OMAP4
uses omap_hsmmc.c as well. Is it true that interrupt polling is used
there, too?

CU
Michael.
