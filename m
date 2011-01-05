From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/6 v3] mfd: sh_mobile_sdhi: activate SDIO IRQ for
	tmio_mmc
Date: Wed, 5 Jan 2011 20:58:17 +0000
Message-ID: <20110105205817.GH9198@void.printf.net>
References: <1293574956-30035-1-git-send-email-arnd@arndnet.de> <1293574956-30035-3-git-send-email-arnd@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41005 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006Ab1AEU6S (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Jan 2011 15:58:18 -0500
Content-Disposition: inline
In-Reply-To: <1293574956-30035-3-git-send-email-arnd@arndnet.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

Hi Arnd,

On Tue, Dec 28, 2010 at 11:22:32PM +0100, Arnd Hannemann wrote:
> The SDHI Controller on SH-Mobile SoCs supports SDIO IRQ signalling.
> This patch advertises this fact to the tmio_mmc driver.
> 
> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  drivers/mfd/sh_mobile_sdhi.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mfd/sh_mobile_sdhi.c b/drivers/mfd/sh_mobile_sdhi.c
> index 3ca20ec..0a7df44 100644
> --- a/drivers/mfd/sh_mobile_sdhi.c
> +++ b/drivers/mfd/sh_mobile_sdhi.c
> @@ -131,6 +131,11 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
>  	 */
>  	mmc_data->flags |= TMIO_MMC_BLKSZ_2BYTES;
>  
> +	/*
> +	 * All SDHI blocks support SDIO IRQ signalling.
> +	 */
> +	mmc_data->flags |= TMIO_MMC_SDIO_IRQ;
> +
>  	if (p && p->dma_slave_tx >= 0 && p->dma_slave_rx >= 0) {
>  		priv->param_tx.slave_id = p->dma_slave_tx;
>  		priv->param_rx.slave_id = p->dma_slave_rx;

Thanks, pushed to mmc-next for .38.  You can send on the arch
dependencies now, explaining that the code they depend on is
waiting in -next.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
