From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: set dto to 14 for all devices
Date: Thu, 12 Apr 2012 11:56:06 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204121130370.29473@utopia.booyaka.com>
References: <1330622780-1909-1-git-send-email-Chase.Maupin@ti.com> <m2399iqtgf.fsf@bob.laptop.org> <alpine.DEB.2.00.1203120435200.11332@utopia.booyaka.com> <87bonxcjrh.fsf@laptop.org> <20120405220848.GF3785@atomide.com> <87obr57rmh.fsf@laptop.org>
 <alpine.DEB.2.00.1204051743360.10302@utopia.booyaka.com> <87k41t7n13.fsf@laptop.org> <4F86A461.4010006@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49209 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932099Ab2DLR4H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Apr 2012 13:56:07 -0400
In-Reply-To: <4F86A461.4010006@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tushar Behera <tushar.behera@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Tony Lindgren <tony@atomide.com>, Chase Maupin <Chase.Maupin@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, sakoman@gmail.com

Hello Tushar,

On Thu, 12 Apr 2012, Tushar Behera wrote:

> With this patch, I continuously get following message on my console.
> (Tested on Origen board, based on EXYNOS4210).
> 
> mmc0: Too large timeout requested for CMD25!
> 
> So, with this change, should we update sdhci_calc_timeout() also?

Looks like most of the host drivers that range-check the timeout value 
silently clamp it at the hardware-supported maximum value:

drivers/mmc/host/atmel-mci.c
drivers/mmc/host/davinci_mmc.c
drivers/mmc/host/mvsdio.c
drivers/mmc/host/omap_hsmmc.c
drivers/mmc/host/wbsd.c
drivers/mmc/host/tifm_sd.c

So maybe try the same thing for your driver?

Of course it seems that some drivers don't range-check the timeout value 
at all :-(

drivers/mmc/host/bfin_sdh.c
drivers/mmc/host/mmci.c
drivers/mmc/host/msm_sdcc.c
drivers/mmc/host/pxamci.c
drivers/mmc/host/mxs-mmc.c
drivers/mmc/host/omap.c



- Paul
