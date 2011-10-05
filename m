From: Heiko =?iso-8859-15?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 3/3] ARM: SAMSUNG: Add lookup of sdhci-s3c clocks using generic names
Date: Wed, 5 Oct 2011 09:30:30 +0200
Message-ID: <201110050930.32216.heiko@sntech.de>
References: <1317792669-19925-1-git-send-email-rajeshwari.s@samsung.com> <1317792669-19925-4-git-send-email-rajeshwari.s@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from h1778886.stratoserver.net ([85.214.133.74]:60057 "EHLO
	h1778886.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624Ab1JEHan (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2011 03:30:43 -0400
In-Reply-To: <1317792669-19925-4-git-send-email-rajeshwari.s@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rajeshwari Shinde <rajeshwari.s@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, heiko@sntech.de

Am Mittwoch, 5. Oktober 2011, 07:31:09 schrieb Rajeshwari Shinde:
> Add support for lookup of sdhci-s3c controller clocks using generic names
> for s3c2416, s3c64xx, s5pc100, s5pv210 and exynos4 SoC's.
> 
> Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
> ---

[...]

> diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/clock.c
> index 72b7c62..cebaf3f 100644
> --- a/arch/arm/mach-s3c2416/clock.c
> +++ b/arch/arm/mach-s3c2416/clock.c

[...]

> @@ -143,8 +142,14 @@ static struct clksrc_clk *clksrcs[] __initdata = {
>  	&hsspi_mux,
>  	&hsmmc_div[0],
>  	&hsmmc_div[1],
> -	&hsmmc_mux[0],
> -	&hsmmc_mux[1],
> +	&hsmmc_mux0,
> +	&hsmmc_mux1,
> +};
> +
> +static struct clk_lookup s3c2416_clk_lookup[] = {
> +	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &hsmmc0_clk),
This is missing the s3c-sdhci.1 mmc_busclk.0 as 4th entry which is defined in 
s3c2443-clock.c. The pclk for hsmmc1 is common to S3C2416/2450 and S3C2443 and 
is therefore defined in plat-s3c24xx [S3C2443 only has a hsmmc1 to be exact].

Also it would be nice to include the hsmmc-clock in mach-s3c2443/clock.c too. 
The sdhci support there seems to be incomplete but it would be nice to have 
the clocks similar to everything else if anyone wants to start on this arch.

> +	CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &hsmmc_mux0.clk),
> +	CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &hsmmc_mux1.clk),
>  };
> 
>  void __init s3c2416_init_clocks(int xtal)
> @@ -164,6 +169,7 @@ void __init s3c2416_init_clocks(int xtal)
>  		s3c_register_clksrc(clksrcs[ptr], 1);
> 
>  	s3c24xx_register_clock(&hsmmc0_clk);
> +	clkdev_add_table(s3c2416_clk_lookup, ARRAY_SIZE(s3c2416_clk_lookup));
> 
>  	s3c_pwmclk_init();
> 

Heiko
