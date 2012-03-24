From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/2] mmc: sh_mmcif: double clock speed
Date: Sat, 24 Mar 2012 18:56:16 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1203241845060.19427@axis700.grange>
References: <1332320549-28584-1-git-send-email-horms@verge.net.au>
 <1332320549-28584-2-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:59947 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755648Ab2CXR4o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 24 Mar 2012 13:56:44 -0400
In-Reply-To: <1332320549-28584-2-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Cao Minh Hiep <hiepcm@gmail.com>

Hi Simon

On Wed, 21 Mar 2012, Simon Horman wrote:

> This corrects an off-by one error when calculating the clock divisor.
> The code previously assumed that for example a divisor of 2 is
> set using a value of 0001 (the inverse of 1/2), a divisor of 4 is
> set using a value of 0010 (the inverse of 1/4) etc.. However, the correct
> values are 0000, 0001, etc...
> 
> The use of DIV_ROUND_UP() was suggested by Guennadi Liakhovetski to avoid
> understating the divisor by one in the case where the host clock is not a
> binary power of the MMCIF clock.

The patch looks good, but the commit message is not quite right. Cases of 
host->clk / clk != 2^n are handled by using fls(x - 1) instead of fls(x) - 
1, as you initially suggested. DIV_ROUND_UP() is needed for divisions with 
a residue. E.g., for host clock 13MHz, target clock 3MHz you want a 
divisor of 5, resulting in 2 << 16, not 4, resulting in 1 << 16. With this 
fixed

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi

> 
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Tested-by: Cao Minh Hiep <hiepcm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  drivers/mmc/host/sh_mmcif.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 8057bf3..5014bc4 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -453,7 +453,8 @@ static void sh_mmcif_clock_control(struct sh_mmcif_host *host, unsigned int clk)
>  		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_SUP_PCLK);
>  	else
>  		sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_CLEAR &
> -				((fls(host->clk / clk) - 1) << 16));
> +				((fls(DIV_ROUND_UP(host->clk,
> +						   clk) - 1) - 1) << 16));
>  
>  	sh_mmcif_bitset(host, MMCIF_CE_CLK_CTRL, CLK_ENABLE);
>  }
> -- 
> 1.7.6.3
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
