Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A760C2D0DB
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 12:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E07621D7E
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 12:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgATMct (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:32:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:19059 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgATMct (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Jan 2020 07:32:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 04:32:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="399361636"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga005.jf.intel.com with ESMTP; 20 Jan 2020 04:32:45 -0800
Subject: Re: [PATCH 2/3] mmc: sdhci_am654: Update OTAPDLY writes
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org
References: <20200108150920.14547-1-faiz_abbas@ti.com>
 <20200108150920.14547-3-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <dfa97953-7990-e1b5-5e83-9ab6cbdd54e9@intel.com>
Date:   Mon, 20 Jan 2020 14:31:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108150920.14547-3-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/01/20 5:09 pm, Faiz Abbas wrote:
> According to the latest AM65x Data Manual[1], a different output tap
> delay value is optimum for a given speed mode. Therefore, deprecate the
> ti,otap-del-sel binding and introduce a new binding for each of the
> possible MMC/SD speed modes. If the legacy mode is not found, fall back
> to old binding to maintain dts compatibility.
> 
> [1] http://www.ti.com/lit/gpn/am6526
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci_am654.c | 123 ++++++++++++++++++++++++++++-----
>  include/linux/mmc/host.h       |   2 +
>  2 files changed, 107 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index b8fe94fd9525..bb977de43f7d 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -81,7 +81,8 @@ static struct regmap_config sdhci_am654_regmap_config = {
>  
>  struct sdhci_am654_data {
>  	struct regmap *base;
> -	int otap_del_sel;
> +	bool legacy_otapdly;
> +	int otap_del_sel[11];
>  	int trm_icp;
>  	int drv_strength;
>  	bool dll_on;
> @@ -98,11 +99,34 @@ struct sdhci_am654_driver_data {
>  #define DLL_PRESENT	(1 << 3)
>  };
>  
> +struct timing_data {
> +	const char *binding;
> +	u32 capability;
> +};
> +
> +static const struct timing_data td[] = {
> +	[MMC_TIMING_LEGACY] = {"ti,otap-del-sel-legacy", 0},
> +	[MMC_TIMING_MMC_HS] = {"ti,otap-del-sel-mmc-hs", MMC_CAP_MMC_HIGHSPEED},
> +	[MMC_TIMING_SD_HS]  = {"ti,otap-del-sel-sd-hs", MMC_CAP_SD_HIGHSPEED},
> +	[MMC_TIMING_UHS_SDR12] = {"ti,otap-del-sel-sdr12", MMC_CAP_UHS_SDR12},
> +	[MMC_TIMING_UHS_SDR25] = {"ti,otap-del-sel-sdr25", MMC_CAP_UHS_SDR25},
> +	[MMC_TIMING_UHS_SDR50] = {"ti,otap-del-sel-sdr50", MMC_CAP_UHS_SDR50},
> +	[MMC_TIMING_UHS_SDR104] = {"ti,otap-del-sel-sdr104",
> +				   MMC_CAP_UHS_SDR104},
> +	[MMC_TIMING_UHS_DDR50] = {"ti,otap-del-sel-ddr50", MMC_CAP_UHS_DDR50},
> +	[MMC_TIMING_MMC_DDR52] = {"ti,otap-del-sel-ddr52", MMC_CAP_DDR},
> +	[MMC_TIMING_MMC_HS200] = {"ti,otap-del-sel-hs200", MMC_CAP2_HS200},
> +	[MMC_TIMING_MMC_HS400] = {"ti,otap-del-sel-hs400", MMC_CAP2_HS400},
> +};
> +
>  static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +	unsigned char timing = host->mmc->ios.timing;
>  	int sel50, sel100, freqsel;
> +	u32 otap_del_sel;
> +	u32 otap_del_ena;
>  	u32 mask, val;
>  	int ret;
>  
> @@ -116,22 +140,29 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>  
>  	if (clock > CLOCK_TOO_SLOW_HZ) {
>  		/* Setup DLL Output TAP delay */
> +		if (sdhci_am654->legacy_otapdly)
> +			otap_del_sel = sdhci_am654->otap_del_sel[0];
> +		else
> +			otap_del_sel = sdhci_am654->otap_del_sel[timing];
> +
> +		otap_del_ena = (timing > MMC_TIMING_UHS_SDR25) ? 1 : 0;
> +
>  		mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
> -		val = (1 << OTAPDLYENA_SHIFT) |
> -		      (sdhci_am654->otap_del_sel << OTAPDLYSEL_SHIFT);
> -		regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
> +		val = (otap_del_ena << OTAPDLYENA_SHIFT) |
> +		      (otap_del_sel << OTAPDLYSEL_SHIFT);
> +
>  		/* Write to STRBSEL for HS400 speed mode */
> -		if (host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
> +		if (timing == MMC_TIMING_MMC_HS400) {
>  			if (sdhci_am654->flags & STRBSEL_4_BIT)
> -				mask = STRBSEL_4BIT_MASK;
> +				mask |= STRBSEL_4BIT_MASK;
>  			else
> -				mask = STRBSEL_8BIT_MASK;
> +				mask |= STRBSEL_8BIT_MASK;
>  
> -			regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask,
> -					   sdhci_am654->strb_sel <<
> -					   STRBSEL_SHIFT);
> +			val |= sdhci_am654->strb_sel << STRBSEL_SHIFT;
>  		}
>  
> +		regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
> +
>  		if (sdhci_am654->flags & FREQSEL_2_BIT) {
>  			switch (clock) {
>  			case 200000000:
> @@ -198,11 +229,19 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> -	int val, mask;
> +	unsigned char timing = host->mmc->ios.timing;
> +	u32 otap_del_sel;
> +	u32 mask, val;
> +
> +	/* Setup DLL Output TAP delay */
> +	if (sdhci_am654->legacy_otapdly)
> +		otap_del_sel = sdhci_am654->otap_del_sel[0];
> +	else
> +		otap_del_sel = sdhci_am654->otap_del_sel[timing];
>  
>  	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
> -	val = (1 << OTAPDLYENA_SHIFT) |
> -	      (sdhci_am654->otap_del_sel << OTAPDLYSEL_SHIFT);
> +	val = (0x1 << OTAPDLYENA_SHIFT) |
> +	      (otap_del_sel << OTAPDLYSEL_SHIFT);
>  	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
>  
>  	sdhci_set_clock(host, clock);
> @@ -371,6 +410,55 @@ static int sdhci_am654_cqe_add_host(struct sdhci_host *host)
>  	return ret;
>  }
>  
> +static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
> +				      struct sdhci_am654_data *sdhci_am654)
> +{
> +	struct device *dev = mmc_dev(host->mmc);
> +	int i;
> +	int ret;
> +
> +	ret = device_property_read_u32(dev, td[MMC_TIMING_LEGACY].binding,
> +				 &sdhci_am654->otap_del_sel[MMC_TIMING_LEGACY]);
> +	if (ret) {
> +		/*
> +		 * ti,otap-del-sel-legacy is mandatory, look for old binding
> +		 * if not found.
> +		 */
> +		ret = device_property_read_u32(dev, "ti,otap-del-sel",
> +					       &sdhci_am654->otap_del_sel[0]);
> +		if (ret) {
> +			dev_err(dev, "Couldn't find otap-del-sel\n");
> +
> +			return ret;
> +		}
> +
> +		dev_info(dev, "Using legacy binding ti,otap-del-sel\n");
> +		sdhci_am654->legacy_otapdly = true;
> +
> +		return 0;
> +	}
> +
> +	for (i = MMC_TIMING_MMC_HS; i <= MMC_TIMING_MMC_HS400; i++) {
> +
> +		ret = device_property_read_u32(dev, td[i].binding,
> +					       &sdhci_am654->otap_del_sel[i]);
> +		if (ret) {
> +			dev_dbg(dev, "Couldn't find %s\n",
> +				td[i].binding);
> +			/*
> +			 * Remove the corresponding capability
> +			 * if an otap-del-sel value is not found
> +			 */
> +			if (i <= MMC_TIMING_MMC_DDR52)
> +				host->mmc->caps &= ~td[i].capability;
> +			else
> +				host->mmc->caps2 &= ~td[i].capability;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int sdhci_am654_init(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -419,6 +507,10 @@ static int sdhci_am654_init(struct sdhci_host *host)
>  	if (ret)
>  		goto err_cleanup_host;
>  
> +	ret = sdhci_am654_get_otap_delay(host, sdhci_am654);
> +	if (ret)
> +		goto err_cleanup_host;
> +
>  	ret = __sdhci_add_host(host);
>  	if (ret)
>  		goto err_cleanup_host;
> @@ -437,11 +529,6 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>  	int drv_strength;
>  	int ret;
>  
> -	ret = device_property_read_u32(dev, "ti,otap-del-sel",
> -				       &sdhci_am654->otap_del_sel);
> -	if (ret)
> -		return ret;
> -
>  	if (sdhci_am654->flags & DLL_PRESENT) {
>  		ret = device_property_read_u32(dev, "ti,trm-icp",
>  					       &sdhci_am654->trm_icp);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ba703384bea0..a22a10456c62 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -322,6 +322,8 @@ struct mmc_host {
>  #define MMC_CAP_3_3V_DDR	(1 << 11)	/* Host supports eMMC DDR 3.3V */
>  #define MMC_CAP_1_8V_DDR	(1 << 12)	/* Host supports eMMC DDR 1.8V */
>  #define MMC_CAP_1_2V_DDR	(1 << 13)	/* Host supports eMMC DDR 1.2V */
> +#define MMC_CAP_DDR		(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR | \
> +				 MMC_CAP_1_2V_DDR)
>  #define MMC_CAP_POWER_OFF_CARD	(1 << 14)	/* Can power off after boot */
>  #define MMC_CAP_BUS_WIDTH_TEST	(1 << 15)	/* CMD14/CMD19 bus width ok */
>  #define MMC_CAP_UHS_SDR12	(1 << 16)	/* Host supports UHS SDR12 mode */
> 

