From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 2/4] s3c6410: update clk->parent when setting clock source
Date: Wed, 16 Sep 2009 00:57:34 +0100
Message-ID: <20090915235734.GH13508@trinity.fluff.org>
References: <1252387848-21869-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:33212 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895AbZIOX5b (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Sep 2009 19:57:31 -0400
Content-Disposition: inline
In-Reply-To: <1252387848-21869-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: thomas.ab@samsung.com
Cc: ben-linux@fluff.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Sep 08, 2009 at 02:30:48PM +0900, thomas.ab@samsung.com wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> This ensures the clock hierarchy data structures are
> updated when we change the clock source in the actual
> hardware registers.

Applied to next-s3c64xx-fixes.
 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/plat-s3c64xx/s3c6400-clock.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> index c972d2f..54eef93 100644
> --- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
> +++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> @@ -328,6 +328,8 @@ static int s3c64xx_setparent_clksrc(struct clk *clk, struct clk *parent)
>  		clksrc |= src_nr << sclk->shift;
>  
>  		__raw_writel(clksrc, S3C_CLK_SRC);
> +
> +		clk->parent = parent;
>  		return 0;
>  	}
>  
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

