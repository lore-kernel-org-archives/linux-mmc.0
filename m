From: Daniel Mack <daniel@caiaq.de>
Subject: libertas: DAT1 signal IRQ in 1-bit SDIO mode
Date: Mon, 29 Mar 2010 20:24:14 +0200
Message-ID: <20100329182414.GJ30801@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:58019 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab0C2SYT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Mar 2010 14:24:19 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: libertas-dev@lists.infradead.org
Cc: linux-mmc@vger.kernel.org

Hi,

I'm still fighting with a MX31 SDHC controller connected to a 8686
module via SDIO. As the libertas firmware uses multiblock transfers,
this can't work in 4bit SDIO mode due to a bug in the SDHC controller
of the MX31 silicon. This is now finally also confirmed by Freescale.

So the only way around this is to use 1-bit transfers. This appears to
work stable now as long as I don't let the host controller announce the
capability of serving SDIO IRQs (MMC_CAP_SDIO_IRQ). The IRQ flag is then
polled by the MMC core which is a performance drawback of course, but at
least it finally works.

However, I also implemented code for proper SDIO IRQ hardware handling
for this controller, but the hardware condition is never triggered. I
measured with an oscilloscope and found out the 8686 does not actually
drive the DAT1 line (which is used as IRQ in 1-bit SDIO mode) low when
it is supposed to do.

My question is - did anyone ever use the chip in this mode? Is that a
firmware bug?

Any pointers appreciated - I would like to post my pending patches for
that issue asap, but need to clear that last issue first.

Thanks,
Daniel

