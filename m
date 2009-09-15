From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 4/4] s3c6410: Remove redundant mpll parent assignment.
Date: Wed, 16 Sep 2009 00:41:27 +0100
Message-ID: <20090915234127.GA24720@trinity.fluff.org>
References: <1252388401-31529-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:40980 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224AbZIOXl3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Sep 2009 19:41:29 -0400
Content-Disposition: inline
In-Reply-To: <1252388401-31529-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: thomas.ab@samsung.com
Cc: ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

On Tue, Sep 08, 2009 at 02:40:01PM +0900, thomas.ab@samsung.com wrote:
> From: Thomas Abraham <thomas.ab@samsung.com>
> 
> This patch removes the redundant MPLL parent assignment
> in the function s3c6400_register_clocks.

Where is the other assignment being done from?
 
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> ---
>  arch/arm/plat-s3c64xx/s3c6400-clock.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-s3c64xx/s3c6400-clock.c b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> index 9745852..72c03ab 100644
> --- a/arch/arm/plat-s3c64xx/s3c6400-clock.c
> +++ b/arch/arm/plat-s3c64xx/s3c6400-clock.c
> @@ -758,6 +758,5 @@ void __init s3c6400_register_clocks(unsigned armclk_divlimit)
>  		}
>  	}
>  
> -	clk_mpll.parent = &clk_mout_mpll.clk;
>  	clk_epll.parent = &clk_mout_epll.clk;
>  }
> -- 
> 1.5.3.4
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

