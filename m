From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: SDHCI: mdelay() in hot path in esdhc_pltfm_set_clock looses CAN
 (!) frames
Date: Wed, 8 Jul 2015 08:43:04 +0200
Message-ID: <20150708064304.GB18700@pengutronix.de>
References: <CAOpc7mG7-RyZ2LSX8n1kh_KWaVf6N=Lo0LGt4ckLJWzp541FZg@mail.gmail.com>
 <CAOMZO5D02tarn9QrOuS3i1ekn=1Jupngo6RBOfyVm9QASPA23A@mail.gmail.com>
 <20150707205243.GK7557@n2100.arm.linux.org.uk>
 <CAOpc7mGgD1c4BW1DXEEZQ06njQO6tgUKi0ssAGyL4SJXajDRGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51493 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247AbbGHGnO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jul 2015 02:43:14 -0400
Content-Disposition: inline
In-Reply-To: <CAOpc7mGgD1c4BW1DXEEZQ06njQO6tgUKi0ssAGyL4SJXajDRGw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Holger Schurig <holgerschurig@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Fabio Estevam <festevam@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, open list <linux-kernel@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Dong Aisheng <b29396@freescale.com>

On Wed, Jul 08, 2015 at 08:22:57AM +0200, Holger Schurig wrote:
> Wow, at last some reaction. And I thought nobody cares ...
> 
> BTW, removing CONFIG_MMC_CLKGATE helped a bit, because the pointless
> clock-off-clock-on while the device is booting (or accessing multiple
> sectors within a short time) isn't going to happen anymore.
> 
> But really, a mdelay(1) in a driver ...

Look for the other mdelays in sdhci.c. There are up to a hundred of
them in sdhci_reset() which is called under a spin_lock_irqsave. I
remember that with the wrong type of card detection the MMC core
frequently polls for a card and if none is found the sdhci core was
resetted which falls into this mdelay polling loop in sdhci_reset. So if
you care about realtime you better have a card inserted...

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
