Return-Path: <SRS0=tKpl=5S=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B220EC18E5B
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 10:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921F42082F
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Apr 2020 10:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbgDBKLw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:11:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:64567 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgDBKLv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Apr 2020 06:11:51 -0400
IronPort-SDR: iM8BaZyYB/pzaPlzXhuvckQiK995vqa7DMy2FncKyPkbccR0uAesCHnkkzdysAonF+gtoCbsi8
 wL3mJ4HvmWlQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 03:11:51 -0700
IronPort-SDR: 5Ol59ojbG8TQbWA9M2qTweVS+xpHJzdJxRr+kr9yxFpwijRH7C1igmvBhTWfPkDar3rMJhY5qs
 6Kv6KwOM52vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,335,1580803200"; 
   d="scan'208";a="240782641"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.87]) ([10.237.72.87])
  by fmsmga007.fm.intel.com with ESMTP; 02 Apr 2020 03:11:48 -0700
Subject: Re: [PATCH v2 2/4] sdhci: arasan: Add support for Versal Tap Delays
To:     Manish Narani <manish.narani@xilinx.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
References: <1585546879-91037-1-git-send-email-manish.narani@xilinx.com>
 <1585546879-91037-3-git-send-email-manish.narani@xilinx.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4268fa5d-f32d-6231-287c-7ffb159c1b34@intel.com>
Date:   Thu, 2 Apr 2020 13:11:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1585546879-91037-3-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/03/20 8:41 am, Manish Narani wrote:
> Add support to set tap delays for Xilinx Versal SD controller. The tap
> delay registers have moved to SD controller space in Versal. Make the
> changes accordingly.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 175 +++++++++++++++++++++++++++++
>  1 file changed, 175 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 0146d7dd315b..34403b2cac97 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -28,15 +28,26 @@
>  #include "sdhci-pltfm.h"
>  
>  #define SDHCI_ARASAN_VENDOR_REGISTER	0x78
> +
> +#define SDHCI_ARASAN_ITAPDLY_REGISTER	0xF0F8
> +#define SDHCI_ARASAN_OTAPDLY_REGISTER	0xF0FC
> +
>  #define SDHCI_ARASAN_CQE_BASE_ADDR	0x200
>  #define VENDOR_ENHANCED_STROBE		BIT(0)
>  
>  #define PHY_CLK_TOO_SLOW_HZ		400000
>  
> +#define SDHCI_ITAPDLY_CHGWIN		0x200
> +#define SDHCI_ITAPDLY_ENABLE		0x100
> +#define SDHCI_OTAPDLY_ENABLE		0x40
> +
>  /* Default settings for ZynqMP Clock Phases */
>  #define ZYNQMP_ICLK_PHASE {0, 63, 63, 0, 63,  0,   0, 183, 54,  0, 0}
>  #define ZYNQMP_OCLK_PHASE {0, 72, 60, 0, 60, 72, 135, 48, 72, 135, 0}
>  
> +#define VERSAL_ICLK_PHASE {0, 132, 132, 0, 132, 0, 0, 162, 90, 0, 0}
> +#define VERSAL_OCLK_PHASE {0,  60, 48, 0, 48, 72, 90, 36, 60, 90, 0}
> +
>  /*
>   * On some SoCs the syscon area has a feature where the upper 16-bits of
>   * each 32-bit register act as a write mask for the lower 16-bits.  This allows
> @@ -566,6 +577,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
>  		.compatible = "xlnx,zynqmp-8.9a",
>  		.data = &sdhci_arasan_zynqmp_data,
>  	},
> +	{
> +		.compatible = "xlnx,versal-8.9a",
> +		.data = &sdhci_arasan_zynqmp_data,
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_arasan_of_match);
> @@ -768,6 +783,152 @@ static const struct clk_ops zynqmp_sampleclk_ops = {
>  	.set_phase = sdhci_zynqmp_sampleclk_set_phase,
>  };
>  
> +/**
> + * sdhci_versal_sdcardclk_set_phase - Set the SD Output Clock Tap Delays
> + *
> + * Set the SD Output Clock Tap Delays for Output path
> + *
> + * @hw:			Pointer to the hardware clock structure.
> + * @degrees		The clock phase shift between 0 - 359.
> + * Return: 0 on success and error value on error
> + */
> +static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
> +{
> +	struct sdhci_arasan_clk_data *clk_data =
> +		container_of(hw, struct sdhci_arasan_clk_data, sdcardclk_hw);
> +	struct sdhci_arasan_data *sdhci_arasan =
> +		container_of(clk_data, struct sdhci_arasan_data, clk_data);
> +	struct sdhci_host *host = sdhci_arasan->host;
> +	u8 tap_delay, tap_max = 0;
> +	int ret;
> +
> +	/*
> +	 * This is applicable for SDHCI_SPEC_300 and above
> +	 * Versal does not set phase for <=25MHz clock.
> +	 * If degrees is zero, no need to do anything.
> +	 */
> +	if (host->version < SDHCI_SPEC_300 ||
> +	    host->timing == MMC_TIMING_LEGACY ||
> +	    host->timing == MMC_TIMING_UHS_SDR12 || !degrees)
> +		return 0;
> +
> +	switch (host->timing) {
> +	case MMC_TIMING_MMC_HS:
> +	case MMC_TIMING_SD_HS:
> +	case MMC_TIMING_UHS_SDR25:
> +	case MMC_TIMING_UHS_DDR50:
> +	case MMC_TIMING_MMC_DDR52:
> +		/* For 50MHz clock, 30 Taps are available */
> +		tap_max = 30;
> +		break;
> +	case MMC_TIMING_UHS_SDR50:
> +		/* For 100MHz clock, 15 Taps are available */
> +		tap_max = 15;
> +		break;
> +	case MMC_TIMING_UHS_SDR104:
> +	case MMC_TIMING_MMC_HS200:
> +		/* For 200MHz clock, 8 Taps are available */
> +		tap_max = 8;
> +	default:
> +		break;
> +	}
> +
> +	tap_delay = (degrees * tap_max) / 360;
> +
> +	/* Set the Clock Phase */
> +	if (tap_delay) {
> +		u32 regval;
> +
> +		regval = sdhci_readl(host, SDHCI_ARASAN_OTAPDLY_REGISTER);
> +		regval |= SDHCI_OTAPDLY_ENABLE;
> +		sdhci_writel(host, regval, SDHCI_ARASAN_OTAPDLY_REGISTER);
> +		regval |= tap_delay;
> +		sdhci_writel(host, regval, SDHCI_ARASAN_OTAPDLY_REGISTER);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct clk_ops versal_sdcardclk_ops = {
> +	.recalc_rate = sdhci_arasan_sdcardclk_recalc_rate,
> +	.set_phase = sdhci_versal_sdcardclk_set_phase,
> +};
> +
> +/**
> + * sdhci_versal_sampleclk_set_phase - Set the SD Input Clock Tap Delays
> + *
> + * Set the SD Input Clock Tap Delays for Input path
> + *
> + * @hw:			Pointer to the hardware clock structure.
> + * @degrees		The clock phase shift between 0 - 359.
> + * Return: 0 on success and error value on error
> + */
> +static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
> +{
> +	struct sdhci_arasan_clk_data *clk_data =
> +		container_of(hw, struct sdhci_arasan_clk_data, sampleclk_hw);
> +	struct sdhci_arasan_data *sdhci_arasan =
> +		container_of(clk_data, struct sdhci_arasan_data, clk_data);
> +	struct sdhci_host *host = sdhci_arasan->host;
> +	u8 tap_delay, tap_max = 0;
> +	int ret;
> +
> +	/*
> +	 * This is applicable for SDHCI_SPEC_300 and above
> +	 * Versal does not set phase for <=25MHz clock.
> +	 * If degrees is zero, no need to do anything.
> +	 */
> +	if (host->version < SDHCI_SPEC_300 ||
> +	    host->timing == MMC_TIMING_LEGACY ||
> +	    host->timing == MMC_TIMING_UHS_SDR12 || !degrees)
> +		return 0;
> +
> +	switch (host->timing) {
> +	case MMC_TIMING_MMC_HS:
> +	case MMC_TIMING_SD_HS:
> +	case MMC_TIMING_UHS_SDR25:
> +	case MMC_TIMING_UHS_DDR50:
> +	case MMC_TIMING_MMC_DDR52:
> +		/* For 50MHz clock, 120 Taps are available */
> +		tap_max = 120;
> +		break;
> +	case MMC_TIMING_UHS_SDR50:
> +		/* For 100MHz clock, 60 Taps are available */
> +		tap_max = 60;
> +		break;
> +	case MMC_TIMING_UHS_SDR104:
> +	case MMC_TIMING_MMC_HS200:
> +		/* For 200MHz clock, 30 Taps are available */
> +		tap_max = 30;
> +	default:
> +		break;
> +	}
> +
> +	tap_delay = (degrees * tap_max) / 360;
> +
> +	/* Set the Clock Phase */
> +	if (tap_delay) {
> +		u32 regval;
> +
> +		regval = sdhci_readl(host, SDHCI_ARASAN_ITAPDLY_REGISTER);
> +		regval |= SDHCI_ITAPDLY_CHGWIN;
> +		sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
> +		regval |= SDHCI_ITAPDLY_ENABLE;
> +		sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
> +		regval |= tap_delay;
> +		sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
> +		regval &= ~SDHCI_ITAPDLY_CHGWIN;
> +		sdhci_writel(host, regval, SDHCI_ARASAN_ITAPDLY_REGISTER);
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct clk_ops versal_sampleclk_ops = {
> +	.recalc_rate = sdhci_arasan_sampleclk_recalc_rate,
> +	.set_phase = sdhci_versal_sampleclk_set_phase,
> +};
> +
>  static void arasan_zynqmp_dll_reset(struct sdhci_host *host, u32 deviceid)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -965,6 +1126,16 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
>  		}
>  	}
>  
> +	if (of_device_is_compatible(dev->of_node, "xlnx,versal-8.9a")) {
> +		iclk_phase = (int [MMC_TIMING_MMC_HS400 + 1]) VERSAL_ICLK_PHASE;
> +		oclk_phase = (int [MMC_TIMING_MMC_HS400 + 1]) VERSAL_OCLK_PHASE;
> +
> +		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
> +			clk_data->clk_phase_in[i] = iclk_phase[i];
> +			clk_data->clk_phase_out[i] = oclk_phase[i];
> +		}
> +	}
> +
>  	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_LEGACY,
>  				 "clk-phase-legacy");
>  	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS,
> @@ -1025,6 +1196,8 @@ sdhci_arasan_register_sdcardclk(struct sdhci_arasan_data *sdhci_arasan,
>  	sdcardclk_init.flags = CLK_GET_RATE_NOCACHE;
>  	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a"))
>  		sdcardclk_init.ops = &zynqmp_sdcardclk_ops;
> +	else if (of_device_is_compatible(np, "xlnx,versal-8.9a"))
> +		sdcardclk_init.ops = &versal_sdcardclk_ops;
>  	else
>  		sdcardclk_init.ops = &arasan_sdcardclk_ops;
>  
> @@ -1077,6 +1250,8 @@ sdhci_arasan_register_sampleclk(struct sdhci_arasan_data *sdhci_arasan,
>  	sampleclk_init.flags = CLK_GET_RATE_NOCACHE;
>  	if (of_device_is_compatible(np, "xlnx,zynqmp-8.9a"))
>  		sampleclk_init.ops = &zynqmp_sampleclk_ops;
> +	else if (of_device_is_compatible(np, "xlnx,versal-8.9a"))
> +		sampleclk_init.ops = &versal_sampleclk_ops;
>  	else
>  		sampleclk_init.ops = &arasan_sampleclk_ops;
>  
> 

