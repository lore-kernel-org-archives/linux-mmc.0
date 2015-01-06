From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/9] mmc: tmio: tmio_mmc_host has .dma
Date: Tue, 06 Jan 2015 14:19:19 +0100
Message-ID: <1500078.pT8EpI6Sos@wuerfel>
References: <87zj9xogln.wl%kuninori.morimoto.gx@renesas.com> <7306460.62PqiTEhxi@wuerfel> <87tx04vdi7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:61209 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820AbbAFNTg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Jan 2015 08:19:36 -0500
In-Reply-To: <87tx04vdi7.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On Tuesday 06 January 2015 02:38:53 Kuninori Morimoto wrote:
> Hi Arnd again
> 
> > > > The alignment_shift and dma_rx_offset values seem to always be
> > > > the same for all users (at least the remaining ones, possibly there
> > > > were others originally), so you could hardcode those in tmio_mmc_dma.c
> > > > and remove the tmio_mmc_dma structure entirely.
> > > 
> > > Unfortunately, alignment_shift and dma_rx_offset value are based on SoC.
> > > we can't hardcode these.
> > 
> > Which SoCs use a different value here? Both of these look like
> > implementation details of the tmio_mmc, not of the integration
> > into the SoC, so they could just be keyed off the device identification.
> 
> About .alignment_shift, it is not implemented today, but our new SoC
> want to use different value (= .alignment_shift = 5).

Ok, I see.

> About .dma_rx_offset, please check this
>   ${LINUX}/drivers/mmc/host/sh_mobile_sdhi.c :: of_rcar_gen1_compatible
>   ${LINUX}/drivers/mmc/host/sh_mobile_sdhi.c :: of_rcar_gen2_compatible
> or
> 384b2cbd56a02efb16358ed7c0c039e4afca5ed0
> (mmc: tmio: care about DMA tx/rx addr offset)

Right. How about moving these two into tmio_mmc_data then along with
the other members of tmio_mmc_dma?

	Arnd
