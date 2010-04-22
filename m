From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/7] OMAP4-HSMMC: Adds Dummy Interface clock's for MMC
     controllers
Date: Wed, 21 Apr 2010 19:14:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1004211912540.24256@utopia.booyaka.com>
References: <63593.10.24.255.18.1271874056.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37720 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569Ab0DVBOr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Apr 2010 21:14:47 -0400
In-Reply-To: <63593.10.24.255.18.1271874056.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, jarkko.lavinen@nokia.com, tony@atomide.com, rmk+lkml@arm.linux.org.uk, santosh.shilimkar@ti.com

Kishore,

On Wed, 21 Apr 2010, kishore kadiyala wrote:

> This patch adds dummy Interface clocks for MMC controllers

Um, your patch removes the existing dummy interface clocks and adds them 
back again.  Or is there some other point?

> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> ---
>  arch/arm/mach-omap2/clock44xx_data.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index 1dd7dc8..6177a89 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -2675,11 +2675,11 @@ static struct omap_clk omap44xx_clks[] = {
>  	CLK("omap-mcspi.2",	"ick",				&dummy_ck,	CK_443X),
>  	CLK("omap-mcspi.3",	"ick",				&dummy_ck,	CK_443X),
>  	CLK("omap-mcspi.4",	"ick",				&dummy_ck,	CK_443X),
> -	CLK("mmci-omap-hs.0",	"ick",			&dummy_ck,	CK_443X),
> -	CLK("mmci-omap-hs.1",	"ick",			&dummy_ck,	CK_443X),
> -	CLK("mmci-omap-hs.2",	"ick",			&dummy_ck,	CK_443X),
> -	CLK("mmci-omap-hs.3",	"ick",			&dummy_ck,	CK_443X),
> -	CLK("mmci-omap-hs.4",	"ick",			&dummy_ck,	CK_443X),
> +	CLK("mmci-omap-hs.0",	"ick",		&dummy_ck,	CK_443X),
> +	CLK("mmci-omap-hs.1",	"ick",		&dummy_ck,	CK_443X),
> +	CLK("mmci-omap-hs.2",	"ick",		&dummy_ck,	CK_443X),
> +	CLK("mmci-omap-hs.3",	"ick",		&dummy_ck,	CK_443X),
> +	CLK("mmci-omap-hs.4",	"ick",		&dummy_ck,	CK_443X),
>  	CLK(NULL,	"uart1_ick",			&dummy_ck,	CK_443X),
>  	CLK(NULL,	"uart2_ick",			&dummy_ck,	CK_443X),
>  	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
