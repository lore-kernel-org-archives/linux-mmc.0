From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2 4/5] mmc: mxcmmc: enable DMA support on mpc512x
Date: Tue, 2 Apr 2013 09:29:44 +0200
Message-ID: <20130402092944.387d6561@crub>
References: <1364768585-5177-1-git-send-email-agust@denx.de>
	<1364768585-5177-5-git-send-email-agust@denx.de>
	<20130402065654.GC1906@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:35302 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759023Ab3DBH3z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Apr 2013 03:29:55 -0400
In-Reply-To: <20130402065654.GC1906@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Markus Pargmann <mpa@pengutronix.de>, devicetree-discuss@lists.ozlabs.org

On Tue, 2 Apr 2013 08:56:54 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:
...
> > @@ -336,6 +359,8 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
> >  	} else {
> >  		host->dma_dir = DMA_TO_DEVICE;
> >  		slave_dirn = DMA_MEM_TO_DEV;
> > +
> > +		mxcmci_fixup_buffers(data);
> 
> For the register accesses it's fine the way you did in this version, but
> here I think a
> 
> 	if (is_mpc512x_mmc())
> 		swap_buffer()
> 
> would look better.

the swapping function uses optimised st_le32() which is not available
on ARM, that's the reason why this is build time selected. Maybe the
"fixup" in the function name is not pretty, I can change it to "swap"
then.

Thanks,

Anatolij
