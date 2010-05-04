From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 4/5] OMAP4-HSMMC: Adds Dummy Interface clock's for
 MMC controllers
Date: Tue, 4 May 2010 17:03:14 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005041702170.20898@utopia.booyaka.com>
References: <35156.10.24.255.17.1272988905.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49785 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760287Ab0EDXDQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 May 2010 19:03:16 -0400
In-Reply-To: <35156.10.24.255.17.1272988905.squirrel@dbdmail.itg.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk

On Tue, 4 May 2010, kishore kadiyala wrote:

> This patch adds dummy Interface clocks for MMC controllers
> 
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

> ---
>  arch/arm/mach-omap2/clock44xx_data.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
> index a5c0c9c..0280422 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -2675,6 +2675,11 @@ static struct omap_clk omap44xx_clks[] = {
>  	CLK("omap2_mcspi.2",	"ick",			&dummy_ck,	CK_443X),
>  	CLK("omap2_mcspi.3",	"ick",			&dummy_ck,	CK_443X),
>  	CLK("omap2_mcspi.4",	"ick",			&dummy_ck,	CK_443X),
> +	CLK("mmci-omap-hs.0",	"ick",		&dummy_ck,	CK_443X),
> +	CLK("mmci-omap-hs.1",	"ick",		&dummy_ck,	CK_443X),
> +	CLK("mmci-omap-hs.2",	"ick",		&dummy_ck,	CK_443X),
> +	CLK("mmci-omap-hs.3",	"ick",		&dummy_ck,	CK_443X),
> +	CLK("mmci-omap-hs.4",	"ick",		&dummy_ck,	CK_443X),
>  	CLK(NULL,	"uart1_ick",			&dummy_ck,	CK_443X),
>  	CLK(NULL,	"uart2_ick",			&dummy_ck,	CK_443X),
>  	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),


- Paul
