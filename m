From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/3] mfd: sdhi: require the tmio-mmc driver to bounce
	unaligned buffers
Date: Wed, 5 Jan 2011 20:49:16 +0000
Message-ID: <20110105204916.GF9198@void.printf.net>
References: <Pine.LNX.4.64.1011231711240.25676@axis700.grange> <Pine.LNX.4.64.1011231723370.25676@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33738 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752992Ab1AEUtR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Jan 2011 15:49:17 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1011231723370.25676@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

On Tue, Nov 23, 2010 at 05:24:19PM +0100, Guennadi Liakhovetski wrote:
> The SDHI controller on SH-Mobile SoCs requires even buffer addresses, when used
> with DMA.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  drivers/mfd/sh_mobile_sdhi.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mfd/sh_mobile_sdhi.c b/drivers/mfd/sh_mobile_sdhi.c
> index f1714f9..3ca20ec 100644
> --- a/drivers/mfd/sh_mobile_sdhi.c
> +++ b/drivers/mfd/sh_mobile_sdhi.c
> @@ -136,6 +136,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
>  		priv->param_rx.slave_id = p->dma_slave_rx;
>  		priv->dma_priv.chan_priv_tx = &priv->param_tx;
>  		priv->dma_priv.chan_priv_rx = &priv->param_rx;
> +		priv->dma_priv.alignment_shift = 1; /* 2-byte alignment */
>  		mmc_data->dma = &priv->dma_priv;
>  	}
>  

Pushed to mmc-next for .38, thanks.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
