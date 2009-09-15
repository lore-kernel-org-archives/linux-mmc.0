From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 3/4] s3c6410: Fix divider value calculation in s3c64xx_roundrate_clksrc
Date: Wed, 16 Sep 2009 00:57:51 +0100
Message-ID: <20090915235751.GI13508@trinity.fluff.org>
References: <1252388129-22722-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:33226 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526AbZIOX5r (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Sep 2009 19:57:47 -0400
Content-Disposition: inline
In-Reply-To: <1252388129-22722-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: thomas.ab@samsung.com
Cc: ben-linux@fluff.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Sep 08, 2009 at 02:35:29PM +0900, thomas.ab@samsung.com wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> In s3c64xx_roundrate_clksrc function, the calculation is wrong. This
> patch fixes this calculation.

Applied to next-s3c64xx-fixes.
 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/plat-s3c64xx/s3c6400-clock.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> index 54eef93..9745852 100644
> --- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
> +++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> @@ -345,7 +345,7 @@ static unsigned long s3c64xx_roundrate_clksrc(struct clk *clk,
>  	if (rate > parent_rate)
>  		rate = parent_rate;
>  	else {
> -		div = rate / parent_rate;
> +		div = parent_rate / rate;
>  
>  		if (div == 0)
>  			div = 1;
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

