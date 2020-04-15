Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9D6C2BA19
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 09:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D97820771
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 09:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895626AbgDOJfV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:35:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:10350 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895613AbgDOJfT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 15 Apr 2020 05:35:19 -0400
IronPort-SDR: HOxahpQ08nuLL3rHiQN1oMTcqGy8j0ipai/oxjZ4grQpfLDjBfykxgGZgC7Ymij0JYk6fxATpp
 G7vlCt5WB4YA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 02:35:18 -0700
IronPort-SDR: k4rRel3jDwOX9z9ZY15vHKbdib2oiO1AyNV9W1xXF+YaVV8LKuXXH7IdhwsYYovzclndUvdm7d
 u5JZuYKtSOHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="332447829"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by orsmga001.jf.intel.com with ESMTP; 15 Apr 2020 02:35:14 -0700
Subject: Re: [PATCH 2/2] mmc: sdhci: use FIELD_GET/PREP for capabilities bit
 masks
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        masahiroy@kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Fabio Estevam <festevam@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20200408072105.422-1-yamada.masahiro@socionext.com>
 <20200408072105.422-2-yamada.masahiro@socionext.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3cc8c9b8-b957-2fef-d6da-47980d1926aa@intel.com>
Date:   Wed, 15 Apr 2020 12:34:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200408072105.422-2-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/04/20 10:21 am, Masahiro Yamada wrote:
> Use FIELD_GET and FIELD_PREP to get access to the register fields.
> Delete the shift macros. I used GENMASK() for touched macros.

That has the side-effect of changing the constants to 64-bit on 64-bit
platforms, which needs to be mentioned in the commit message.

> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Apart from above:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
>  drivers/mmc/host/sdhci-esdhc-imx.c |  4 +++-
>  drivers/mmc/host/sdhci-of-at91.c   |  5 +++--
>  drivers/mmc/host/sdhci-pci-core.c  |  8 ++------
>  drivers/mmc/host/sdhci.c           | 19 +++++++------------
>  drivers/mmc/host/sdhci.h           | 17 ++++++-----------
>  5 files changed, 21 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 5ec8e4bf1ac7..38cd83118082 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -8,6 +8,7 @@
>   *   Author: Wolfram Sang <kernel@pengutronix.de>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/delay.h>
> @@ -399,7 +400,8 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>  				val = SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_SDR104
>  					| SDHCI_SUPPORT_SDR50
>  					| SDHCI_USE_SDR50_TUNING
> -					| (SDHCI_TUNING_MODE_3 << SDHCI_RETUNING_MODE_SHIFT);
> +					| FIELD_PREP(SDHCI_RETUNING_MODE_MASK,
> +						     SDHCI_TUNING_MODE_3);
>  
>  			if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
>  				val |= SDHCI_SUPPORT_HS400;
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index c79bff5e2280..25f4e0f4f53b 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -6,6 +6,7 @@
>   *		 2015 Ludovic Desroches <ludovic.desroches@atmel.com>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> @@ -179,9 +180,9 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
>  	clk_mul = gck_rate / clk_base_rate - 1;
>  
>  	caps0 &= ~SDHCI_CLOCK_V3_BASE_MASK;
> -	caps0 |= (clk_base << SDHCI_CLOCK_BASE_SHIFT) & SDHCI_CLOCK_V3_BASE_MASK;
> +	caps0 |= FIELD_PREP(SDHCI_CLOCK_V3_BASE_MASK, clk_base);
>  	caps1 &= ~SDHCI_CLOCK_MUL_MASK;
> -	caps1 |= (clk_mul << SDHCI_CLOCK_MUL_SHIFT) & SDHCI_CLOCK_MUL_MASK;
> +	caps1 |= FIELD_PREP(SDHCI_CLOCK_MUL_MASK, clk_mul);
>  	/* Set capabilities in r/w mode. */
>  	writel(SDMMC_CACR_KEY | SDMMC_CACR_CAPWREN, host->ioaddr + SDMMC_CACR);
>  	writel(caps0, host->ioaddr + SDHCI_CAPABILITIES);
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 525de2454a4d..a98c9476bfc8 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -249,12 +249,8 @@ static int ricoh_probe(struct sdhci_pci_chip *chip)
>  static int ricoh_mmc_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	slot->host->caps =
> -		((0x21 << SDHCI_TIMEOUT_CLK_SHIFT)
> -			& SDHCI_TIMEOUT_CLK_MASK) |
> -
> -		((0x21 << SDHCI_CLOCK_BASE_SHIFT)
> -			& SDHCI_CLOCK_BASE_MASK) |
> -
> +		FIELD_PREP(SDHCI_TIMEOUT_CLK_MASK, 0x21) |
> +		FIELD_PREP(SDHCI_CLOCK_BASE_MASK, 0x21) |
>  		SDHCI_TIMEOUT_CLK_UNIT |
>  		SDHCI_CAN_VDD_330 |
>  		SDHCI_CAN_DO_HISPD |
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3f716466fcfd..344a7e0e33fe 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -4117,11 +4117,9 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	}
>  
>  	if (host->version >= SDHCI_SPEC_300)
> -		host->max_clk = (host->caps & SDHCI_CLOCK_V3_BASE_MASK)
> -			>> SDHCI_CLOCK_BASE_SHIFT;
> +		host->max_clk = FIELD_GET(SDHCI_CLOCK_V3_BASE_MASK, host->caps);
>  	else
> -		host->max_clk = (host->caps & SDHCI_CLOCK_BASE_MASK)
> -			>> SDHCI_CLOCK_BASE_SHIFT;
> +		host->max_clk = FIELD_GET(SDHCI_CLOCK_BASE_MASK, host->caps);
>  
>  	host->max_clk *= 1000000;
>  	if (host->max_clk == 0 || host->quirks &
> @@ -4139,8 +4137,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>  	 * In case of Host Controller v3.00, find out whether clock
>  	 * multiplier is supported.
>  	 */
> -	host->clk_mul = (host->caps1 & SDHCI_CLOCK_MUL_MASK) >>
> -			SDHCI_CLOCK_MUL_SHIFT;
> +	host->clk_mul = FIELD_GET(SDHCI_CLOCK_MUL_MASK, host->caps1);
>  
>  	/*
>  	 * In case the value in Clock Multiplier is 0, then programmable
> @@ -4173,8 +4170,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		mmc->f_max = max_clk;
>  
>  	if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
> -		host->timeout_clk = (host->caps & SDHCI_TIMEOUT_CLK_MASK) >>
> -					SDHCI_TIMEOUT_CLK_SHIFT;
> +		host->timeout_clk = FIELD_GET(SDHCI_TIMEOUT_CLK_MASK, host->caps);
>  
>  		if (host->caps & SDHCI_TIMEOUT_CLK_UNIT)
>  			host->timeout_clk *= 1000;
> @@ -4326,8 +4322,8 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		mmc->caps |= MMC_CAP_DRIVER_TYPE_D;
>  
>  	/* Initial value for re-tuning timer count */
> -	host->tuning_count = (host->caps1 & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
> -			     SDHCI_RETUNING_TIMER_COUNT_SHIFT;
> +	host->tuning_count = FIELD_GET(SDHCI_RETUNING_TIMER_COUNT_MASK,
> +				       host->caps1);
>  
>  	/*
>  	 * In case Re-tuning Timer is not disabled, the actual value of
> @@ -4337,8 +4333,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>  		host->tuning_count = 1 << (host->tuning_count - 1);
>  
>  	/* Re-tuning mode supported by the Host Controller */
> -	host->tuning_mode = (host->caps1 & SDHCI_RETUNING_MODE_MASK) >>
> -			     SDHCI_RETUNING_MODE_SHIFT;
> +	host->tuning_mode = FIELD_GET(SDHCI_RETUNING_MODE_MASK, host->caps1);
>  
>  	ocr_avail = 0;
>  
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index b786b68e0302..d7f1441b0fc3 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -200,12 +200,10 @@
>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
>  
>  #define SDHCI_CAPABILITIES	0x40
> -#define  SDHCI_TIMEOUT_CLK_MASK	0x0000003F
> -#define  SDHCI_TIMEOUT_CLK_SHIFT 0
> +#define  SDHCI_TIMEOUT_CLK_MASK		GENMASK(5, 0)
>  #define  SDHCI_TIMEOUT_CLK_UNIT	0x00000080
> -#define  SDHCI_CLOCK_BASE_MASK	0x00003F00
> -#define  SDHCI_CLOCK_V3_BASE_MASK	0x0000FF00
> -#define  SDHCI_CLOCK_BASE_SHIFT	8
> +#define  SDHCI_CLOCK_BASE_MASK		GENMASK(13, 8)
> +#define  SDHCI_CLOCK_V3_BASE_MASK	GENMASK(15, 8)
>  #define  SDHCI_MAX_BLOCK_MASK	0x00030000
>  #define  SDHCI_MAX_BLOCK_SHIFT  16
>  #define  SDHCI_CAN_DO_8BIT	0x00040000
> @@ -227,13 +225,10 @@
>  #define  SDHCI_DRIVER_TYPE_A	0x00000010
>  #define  SDHCI_DRIVER_TYPE_C	0x00000020
>  #define  SDHCI_DRIVER_TYPE_D	0x00000040
> -#define  SDHCI_RETUNING_TIMER_COUNT_MASK	0x00000F00
> -#define  SDHCI_RETUNING_TIMER_COUNT_SHIFT	8
> +#define  SDHCI_RETUNING_TIMER_COUNT_MASK	GENMASK(11, 8)
>  #define  SDHCI_USE_SDR50_TUNING			0x00002000
> -#define  SDHCI_RETUNING_MODE_MASK		0x0000C000
> -#define  SDHCI_RETUNING_MODE_SHIFT		14
> -#define  SDHCI_CLOCK_MUL_MASK	0x00FF0000
> -#define  SDHCI_CLOCK_MUL_SHIFT	16
> +#define  SDHCI_RETUNING_MODE_MASK		GENMASK(15, 14)
> +#define  SDHCI_CLOCK_MUL_MASK			GENMASK(23, 16)
>  #define  SDHCI_CAN_DO_ADMA3	0x08000000
>  #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
>  
> 

