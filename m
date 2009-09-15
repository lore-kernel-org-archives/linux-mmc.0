From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 1/4] s3c6410: use correct divider_shift in setrate_clksrc()
Date: Wed, 16 Sep 2009 00:57:18 +0100
Message-ID: <20090915235718.GG13508@trinity.fluff.org>
References: <1252387560-11234-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:33191 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526AbZIOX5P (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Sep 2009 19:57:15 -0400
Content-Disposition: inline
In-Reply-To: <1252387560-11234-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: thomas.ab@samsung.com
Cc: ben-linux@fluff.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Sep 08, 2009 at 02:26:00PM +0900, thomas.ab@samsung.com wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> In s3c64xx_setrate_clksrc() we used sclk->shift,
> but actually need to use sclk->divider_shift to
> correctly calculate the value for the divider register.

applied to next-s3c64xx-fixes.
 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/plat-s3c64xx/s3c6400-clock.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> index febac19..c972d2f 100644
> --- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
> +++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> @@ -302,8 +302,8 @@ static int s3c64xx_setrate_clksrc(struct clk *clk, unsigned long rate)
>  		return -EINVAL;
>  
>  	val = __raw_readl(reg);
> -	val &= ~(0xf << sclk->shift);
> -	val |= (div - 1) << sclk->shift;
> +	val &= ~(0xf << sclk->divider_shift);
> +	val |= (div - 1) << sclk->divider_shift;
>  	__raw_writel(val, reg);
>  
>  	return 0;
> -- 
> 1.5.3.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

