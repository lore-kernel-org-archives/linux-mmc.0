Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C5EC2D0DB
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 12:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7CA21D7E
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 12:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgATMdL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:33:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:61124 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgATMdK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Jan 2020 07:33:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 04:33:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="399361694"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga005.jf.intel.com with ESMTP; 20 Jan 2020 04:33:08 -0800
Subject: Re: [PATCH 3/3] mmc: sdhci_am654: Enable DLL only for some speed
 modes
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org
References: <20200108150920.14547-1-faiz_abbas@ti.com>
 <20200108150920.14547-4-faiz_abbas@ti.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d18a8c92-125e-cab4-ae74-8129fdf40da1@intel.com>
Date:   Mon, 20 Jan 2020 14:32:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108150920.14547-4-faiz_abbas@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/01/20 5:09 pm, Faiz Abbas wrote:
> Its recommended that DLL must only be enabled for SDR50, DDR50, DDR52,
> SDR104, HS200 and HS400 speed modes. Move DLL configuration to its own
> function and call it only in the above speed modes.
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci_am654.c | 128 +++++++++++++++++----------------
>  1 file changed, 68 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index bb977de43f7d..575bbab1a6ed 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -119,16 +119,80 @@ static const struct timing_data td[] = {
>  	[MMC_TIMING_MMC_HS400] = {"ti,otap-del-sel-hs400", MMC_CAP2_HS400},
>  };
>  
> +static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +	int sel50, sel100, freqsel;
> +	u32 mask, val;
> +	int ret;
> +
> +	if (sdhci_am654->flags & FREQSEL_2_BIT) {
> +		switch (clock) {
> +		case 200000000:
> +			sel50 = 0;
> +			sel100 = 0;
> +			break;
> +		case 100000000:
> +			sel50 = 0;
> +			sel100 = 1;
> +			break;
> +		default:
> +			sel50 = 1;
> +			sel100 = 0;
> +		}
> +
> +		/* Configure PHY DLL frequency */
> +		mask = SEL50_MASK | SEL100_MASK;
> +		val = (sel50 << SEL50_SHIFT) | (sel100 << SEL100_SHIFT);
> +		regmap_update_bits(sdhci_am654->base, PHY_CTRL5, mask, val);
> +
> +	} else {
> +		switch (clock) {
> +		case 200000000:
> +			freqsel = 0x0;
> +			break;
> +		default:
> +			freqsel = 0x4;
> +		}
> +
> +		regmap_update_bits(sdhci_am654->base, PHY_CTRL5, FREQSEL_MASK,
> +				   freqsel << FREQSEL_SHIFT);
> +	}
> +	/* Configure DLL TRIM */
> +	mask = DLL_TRIM_ICP_MASK;
> +	val = sdhci_am654->trm_icp << DLL_TRIM_ICP_SHIFT;
> +
> +	/* Configure DLL driver strength */
> +	mask |= DR_TY_MASK;
> +	val |= sdhci_am654->drv_strength << DR_TY_SHIFT;
> +	regmap_update_bits(sdhci_am654->base, PHY_CTRL1, mask, val);
> +
> +	/* Enable DLL */
> +	regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK,
> +			   0x1 << ENDLL_SHIFT);
> +	/*
> +	 * Poll for DLL ready. Use a one second timeout.
> +	 * Works in all experiments done so far
> +	 */
> +	ret = regmap_read_poll_timeout(sdhci_am654->base, PHY_STAT1, val,
> +				       val & DLLRDY_MASK, 1000, 1000000);
> +	if (ret) {
> +		dev_err(mmc_dev(host->mmc), "DLL failed to relock\n");
> +		return;
> +	}
> +
> +	sdhci_am654->dll_on = true;
> +}
> +
>  static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>  	unsigned char timing = host->mmc->ios.timing;
> -	int sel50, sel100, freqsel;
>  	u32 otap_del_sel;
>  	u32 otap_del_ena;
>  	u32 mask, val;
> -	int ret;
>  
>  	if (sdhci_am654->dll_on) {
>  		regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK, 0);
> @@ -163,64 +227,8 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
>  
>  		regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
>  
> -		if (sdhci_am654->flags & FREQSEL_2_BIT) {
> -			switch (clock) {
> -			case 200000000:
> -				sel50 = 0;
> -				sel100 = 0;
> -				break;
> -			case 100000000:
> -				sel50 = 0;
> -				sel100 = 1;
> -				break;
> -			default:
> -				sel50 = 1;
> -				sel100 = 0;
> -			}
> -
> -			/* Configure PHY DLL frequency */
> -			mask = SEL50_MASK | SEL100_MASK;
> -			val = (sel50 << SEL50_SHIFT) | (sel100 << SEL100_SHIFT);
> -			regmap_update_bits(sdhci_am654->base, PHY_CTRL5, mask,
> -					   val);
> -		} else {
> -			switch (clock) {
> -			case 200000000:
> -				freqsel = 0x0;
> -				break;
> -			default:
> -				freqsel = 0x4;
> -			}
> -
> -			regmap_update_bits(sdhci_am654->base, PHY_CTRL5,
> -					   FREQSEL_MASK,
> -					   freqsel << FREQSEL_SHIFT);
> -		}
> -
> -		/* Configure DLL TRIM */
> -		mask = DLL_TRIM_ICP_MASK;
> -		val = sdhci_am654->trm_icp << DLL_TRIM_ICP_SHIFT;
> -
> -		/* Configure DLL driver strength */
> -		mask |= DR_TY_MASK;
> -		val |= sdhci_am654->drv_strength << DR_TY_SHIFT;
> -		regmap_update_bits(sdhci_am654->base, PHY_CTRL1, mask, val);
> -		/* Enable DLL */
> -		regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK,
> -				   0x1 << ENDLL_SHIFT);
> -		/*
> -		 * Poll for DLL ready. Use a one second timeout.
> -		 * Works in all experiments done so far
> -		 */
> -		ret = regmap_read_poll_timeout(sdhci_am654->base, PHY_STAT1,
> -					       val, val & DLLRDY_MASK, 1000,
> -					       1000000);
> -		if (ret) {
> -			dev_err(mmc_dev(host->mmc), "DLL failed to relock\n");
> -			return;
> -		}
> -
> -		sdhci_am654->dll_on = true;
> +		if (timing > MMC_TIMING_UHS_SDR25)
> +			sdhci_am654_setup_dll(host, clock);
>  	}
>  }
>  
> 

