Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ED7C63777
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 08:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308B620872
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 08:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388768AbgKZIQw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:16:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:23279 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730401AbgKZIQw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 03:16:52 -0500
IronPort-SDR: pr3rvny3orrfSVX1IULpWUOTL/KdoZScLie0JmdsppiykbZqs5piX9pJUG2WytQeZ5ClJpxf0k
 zy7JfjLKTmAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="256962834"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="256962834"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 00:16:51 -0800
IronPort-SDR: +IGtqaFWGtDkeOyXZ0Csg3nYle1p+XC50JI7QD+VamAYhilbMCn5CvRQoCNqazGcfy1Kqwe5uQ
 vvh+b8RByebg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="362721598"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2020 00:16:49 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH v3.1 13/27] mmc: sdhci-uhs2: add set_power() to
 support vdd2
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-14-takahiro.akashi@linaro.org>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3b47a2d4-a281-3fac-29c4-82dd769459a1@intel.com>
Date:   Thu, 26 Nov 2020 10:16:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106022726.19831-14-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> This is a UHS-II version of sdhci's set_power operation.
> VDD2, as well as VDD, is handled here.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 80 +++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-uhs2.h |  2 +
>  drivers/mmc/host/sdhci.c      | 58 +++++++++++++++----------
>  drivers/mmc/host/sdhci.h      |  2 +
>  4 files changed, 119 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index e2b9743fe17d..2bf78cc4e9ed 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -98,6 +98,86 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
>  
> +void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
> +			  unsigned short vdd)

This function isn't used, so let's rename it sdhci_uhs2_set_power_noreg and
drop regulator support.

> +{
> +	struct mmc_host *mmc = host->mmc;
> +	u8 pwr;
> +
> +	/* FIXME: check if flags & MMC_UHS2_SUPPORT? */
> +	if (!(host->mmc->caps & MMC_CAP_UHS2)) {

As commented in another patch, please use a helper fn

> +		sdhci_set_power(host, mode, vdd);
> +		return;
> +	}
> +
> +	if (mode != MMC_POWER_OFF) {
> +		pwr = sdhci_get_vdd_value(vdd);

Simpler to open code this esp. as there are only 2 valid values:

		switch (1 << vdd) {
		case MMC_VDD_29_30..MMC_VDD_30_31:
			pwr = SDHCI_POWER_300;
			break;
		case MMC_VDD_32_33..MMC_VDD_33_34:
			pwr = SDHCI_POWER_330;
			break;
		default:
			WARN(1, "%s: Invalid vdd %#x\n",
			     mmc_hostname(host->mmc), vdd);
			break;
		}


> +		if (!pwr)
> +			WARN(1, "%s: Invalid vdd %#x\n",
> +			     mmc_hostname(host->mmc), vdd);
> +
> +		pwr |= SDHCI_VDD2_POWER_180;
> +	}
> +
> +	if (host->pwr == pwr)
> +		return;
> +	host ->pwr = pwr;
> +
> +	if (pwr == 0) {
> +		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +
> +		if (!IS_ERR(host->mmc->supply.vmmc))
> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +		if (!IS_ERR_OR_NULL(host->mmc->supply.vmmc2))
> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
> +
> +		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)

Please drop support for legacy quirk SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON

> +			sdhci_runtime_pm_bus_off(host);
> +	} else {
> +		if (!IS_ERR(host->mmc->supply.vmmc))
> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
> +		if (!IS_ERR_OR_NULL(host->mmc->supply.vmmc2))
> +			/* support 1.8v only for now */
> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2,
> +					      fls(MMC_VDD2_165_195) - 1);
> +
> +		/*
> +		 * Spec says that we should clear the power reg before setting
> +		 * a new value. Some controllers don't seem to like this though.
> +		 */
> +		if (!(host->quirks & SDHCI_QUIRK_SINGLE_POWER_WRITE))

Please drop support for legacy quirk here and several cases below.  As I
mentioned in another patch, just put a comment somewhere listing what is
not supported for UHS2 host controllers.

> +			sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +
> +		/*
> +		 * At least the Marvell CaFe chip gets confused if we set the
> +		 * voltage and set turn on power at the same time, so set the
> +		 * voltage first.
> +		 */
> +		if (host->quirks & SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER)
> +			sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> +
> +		/* vdd first */
> +		pwr |= SDHCI_POWER_ON;
> +		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> +		mdelay(5);
> +
> +		pwr |= SDHCI_VDD2_POWER_ON;
> +		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> +		mdelay(5);
> +
> +		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
> +			sdhci_runtime_pm_bus_on(host);
> +
> +		/*
> +		 * Some controllers need an extra 10ms delay of 10ms before
> +		 * they can apply clock after applying power
> +		 */
> +		if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
> +			mdelay(10);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> index 7bb7a0d67109..3c19d8e44c36 100644
> --- a/drivers/mmc/host/sdhci-uhs2.h
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -211,5 +211,7 @@ struct sdhci_host;
>  
>  void sdhci_uhs2_dump_regs(struct sdhci_host *host);
>  void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
> +void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
> +			  unsigned short vdd);
>  
>  #endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index af336bdb4305..0b741eb546cb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -187,13 +187,14 @@ static void sdhci_disable_card_detection(struct sdhci_host *host)
>  	sdhci_set_card_detection(host, false);
>  }
>  
> -static void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
> +void sdhci_runtime_pm_bus_on(struct sdhci_host *host)
>  {
>  	if (host->bus_on)
>  		return;
>  	host->bus_on = true;
>  	pm_runtime_get_noresume(host->mmc->parent);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_runtime_pm_bus_on);
>  
>  void sdhci_runtime_pm_bus_off(struct sdhci_host *host)
>  {
> @@ -2017,36 +2018,47 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
>  		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
>  }
>  
> +unsigned short sdhci_get_vdd_value(unsigned short vdd)
> +{
> +	u8 pwr;
> +
> +	switch (1 << vdd) {
> +	case MMC_VDD_165_195:
> +	/*
> +	 * Without a regulator, SDHCI does not support 2.0v
> +	 * so we only get here if the driver deliberately
> +	 * added the 2.0v range to ocr_avail. Map it to 1.8v
> +	 * for the purpose of turning on the power.
> +	 */
> +	case MMC_VDD_20_21:
> +		pwr = SDHCI_POWER_180;
> +		break;
> +	case MMC_VDD_29_30:
> +	case MMC_VDD_30_31:
> +		pwr = SDHCI_POWER_300;
> +		break;
> +	case MMC_VDD_32_33:
> +	case MMC_VDD_33_34:
> +		pwr = SDHCI_POWER_330;
> +		break;
> +	default:
> +		pwr = 0;
> +	}
> +
> +	return pwr;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_get_vdd_value);
> +
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  			   unsigned short vdd)
>  {
>  	u8 pwr = 0;
>  
>  	if (mode != MMC_POWER_OFF) {
> -		switch (1 << vdd) {
> -		case MMC_VDD_165_195:
> -		/*
> -		 * Without a regulator, SDHCI does not support 2.0v
> -		 * so we only get here if the driver deliberately
> -		 * added the 2.0v range to ocr_avail. Map it to 1.8v
> -		 * for the purpose of turning on the power.
> -		 */
> -		case MMC_VDD_20_21:
> -			pwr = SDHCI_POWER_180;
> -			break;
> -		case MMC_VDD_29_30:
> -		case MMC_VDD_30_31:
> -			pwr = SDHCI_POWER_300;
> -			break;
> -		case MMC_VDD_32_33:
> -		case MMC_VDD_33_34:
> -			pwr = SDHCI_POWER_330;
> -			break;
> -		default:
> +		pwr = sdhci_get_vdd_value(vdd);
> +		if (!pwr)
>  			WARN(1, "%s: Invalid vdd %#x\n",
>  			     mmc_hostname(host->mmc), vdd);
> -			break;
> -		}
>  	}
>  
>  	if (host->pwr == pwr)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index b9932423db08..2b5b8295cf92 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -831,6 +831,7 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
>  	__sdhci_read_caps(host, NULL, NULL, NULL);
>  }
>  
> +void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
>  void sdhci_runtime_pm_bus_off(struct sdhci_host *host);
>  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  		   unsigned int *actual_clock);
> @@ -841,6 +842,7 @@ void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
>  				     unsigned char mode,
>  				     unsigned short vdd);
> +unsigned short sdhci_get_vdd_value(unsigned short vdd);
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  			   unsigned short vdd);
>  void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
> 

