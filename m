From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] mmc, sh: use a consistent pr_ prefix
Date: Wed, 10 Nov 2010 20:00:49 +0900
Message-ID: <20101110110049.GA1475@linux-sh.org>
References: <1289384864-6531-1-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:45366 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747Ab0KJLBO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2010 06:01:14 -0500
Content-Disposition: inline
In-Reply-To: <1289384864-6531-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Chris Ball <cjb@laptop.org>

On Wed, Nov 10, 2010 at 07:27:44PM +0900, Simon Horman wrote:
> Use pr_fmt to set the prefix for pr_ messages.
> I believe this method is common in other
> source files in the kernel tree.
> 
pr_fmt() is ok when you have no better options, but in this case you have
the struct device working for you, so you really should be using it.

Consider the case where you have multiple MMCIF blocks, the debug
messages here won't really give you much helpful information if you have
no idea which block you're on.

For example..

> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 3f49273..9f37f74 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -221,8 +222,8 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
>  
>  	state1 = sh_mmcif_readl(host->addr, MMCIF_CE_HOST_STS1);
>  	state2 = sh_mmcif_readl(host->addr, MMCIF_CE_HOST_STS2);
> -	pr_debug("%s: ERR HOST_STS1 = %08x\n", DRIVER_NAME, state1);
> -	pr_debug("%s: ERR HOST_STS2 = %08x\n", DRIVER_NAME, state2);
> +	pr_debug("ERR HOST_STS1 = %08x\n", state1);
> +	pr_debug("ERR HOST_STS2 = %08x\n", state2);
>  
>  	if (state1 & STS1_CMDSEQ) {
>  		sh_mmcif_bitset(host, MMCIF_CE_CMD_CTRL, CMD_CTRL_BREAK);

You can just convert these to:

	dev_dbg(&host->pd->dev, ...);

> @@ -230,7 +231,7 @@ static int sh_mmcif_error_manage(struct sh_mmcif_host *host)
>  		while (1) {
>  			timeout--;
>  			if (timeout < 0) {
> -				pr_err(DRIVER_NAME": Forceed end of " \
> +				pr_err("Forceed end of " \
>  					"command sequence timeout err\n");
>  				return -EIO;
>  			}

dev_err(), and so on.
