Return-Path: <SRS0=v+1n=B7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3175C433E1
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 14:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D252177B
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Aug 2020 14:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgHUOL6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:11:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:15816 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgHUOL5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 21 Aug 2020 10:11:57 -0400
IronPort-SDR: C5WKlHHMs54HVZoCzF85CSn5PE7pCQ2B0ne18Y58d7OjiSw5CdK6FWbI/G2kOC4LvKQ6UpBKIy
 sA1ernXX2YSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="173583857"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="173583857"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 07:11:56 -0700
IronPort-SDR: qajr4MYG8DtfAdVI6Y+vxHOOo17IWvpXLceceBf4ndSFs/CzPr4gBS+X4G8Q6XoszccclzciER
 mtgt9qmGdYlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="442357848"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by orsmga004.jf.intel.com with ESMTP; 21 Aug 2020 07:11:51 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH V3 15/21] mmc: sdhci: UHS-II support, modify
 set_power() to handle vdd2
To:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw
References: <20200710111140.29725-1-benchuanggli@gmail.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <97c43596-a18f-4c7a-c226-5209772d91d1@intel.com>
Date:   Fri, 21 Aug 2020 17:11:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710111140.29725-1-benchuanggli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/07/20 2:11 pm, Ben Chuang wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> VDD2 is used for powering UHS-II interface.
> Modify sdhci_set_power_and_bus_voltage(), sdhci_set_power_noreg()
> and sdhci_set_power_noreg() to handle VDD2.

vdd2 is always 1.8 V and I suspect there may never be support for anything
else, so we should start with 1.8 V only.

Also can we create uhs2_set_power_reg() and uhs2_set_power_noreg() and use
the existing ->set_power() callback

> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci-omap.c     |  2 +-
>  drivers/mmc/host/sdhci-pci-core.c |  4 +--
>  drivers/mmc/host/sdhci-pxav3.c    |  4 +--
>  drivers/mmc/host/sdhci-xenon.c    |  4 +--
>  drivers/mmc/host/sdhci.c          | 42 ++++++++++++++++++++++++-------
>  drivers/mmc/host/sdhci.h          |  9 +++----
>  6 files changed, 43 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index 1ec74c2d5c17..1926585debe5 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -678,7 +678,7 @@ static void sdhci_omap_set_clock(struct sdhci_host *host, unsigned int clock)
>  }
>  
>  static void sdhci_omap_set_power(struct sdhci_host *host, unsigned char mode,
> -			  unsigned short vdd)
> +			  unsigned short vdd, unsigned short vdd2)
>  {
>  	struct mmc_host *mmc = host->mmc;
>  
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index bb6802448b2f..40f5a24a8982 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -629,12 +629,12 @@ static int bxt_get_cd(struct mmc_host *mmc)
>  #define SDHCI_INTEL_PWR_TIMEOUT_UDELAY	100
>  
>  static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
> -				  unsigned short vdd)
> +				  unsigned short vdd, unsigned short vdd2)
>  {
>  	int cntr;
>  	u8 reg;
>  
> -	sdhci_set_power(host, mode, vdd);
> +	sdhci_set_power(host, mode, vdd, -1);
>  
>  	if (mode == MMC_POWER_OFF)
>  		return;
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index e55037ceda73..457e9425339a 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -298,12 +298,12 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>  }
>  
>  static void pxav3_set_power(struct sdhci_host *host, unsigned char mode,
> -			    unsigned short vdd)
> +			    unsigned short vdd, unsigned short vdd2)
>  {
>  	struct mmc_host *mmc = host->mmc;
>  	u8 pwr = host->pwr;
>  
> -	sdhci_set_power_noreg(host, mode, vdd);
> +	sdhci_set_power_noreg(host, mode, vdd, -1);
>  
>  	if (host->pwr == pwr)
>  		return;
> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> index 4703cd540c7f..2b0ebb91895a 100644
> --- a/drivers/mmc/host/sdhci-xenon.c
> +++ b/drivers/mmc/host/sdhci-xenon.c
> @@ -214,12 +214,12 @@ static void xenon_set_uhs_signaling(struct sdhci_host *host,
>  }
>  
>  static void xenon_set_power(struct sdhci_host *host, unsigned char mode,
> -		unsigned short vdd)
> +		unsigned short vdd, unsigned short vdd2)
>  {
>  	struct mmc_host *mmc = host->mmc;
>  	u8 pwr = host->pwr;
>  
> -	sdhci_set_power_noreg(host, mode, vdd);
> +	sdhci_set_power_noreg(host, mode, vdd, -1);
>  
>  	if (host->pwr == pwr)
>  		return;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d38d734ec83f..ca3d4a506e01 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2089,12 +2089,15 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  EXPORT_SYMBOL_GPL(sdhci_set_clock);
>  
>  static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
> -				unsigned short vdd)
> +				unsigned short vdd, unsigned short vdd2)
>  {
>  	struct mmc_host *mmc = host->mmc;
>  
>  	mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>  
> +	if (mmc->caps & MMC_CAP_UHS2 && !IS_ERR(mmc->supply.vmmc2))
> +		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, vdd2);
> +
>  	if (mode != MMC_POWER_OFF)
>  		sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
>  	else
> @@ -2102,7 +2105,7 @@ static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
>  }
>  
>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> -			   unsigned short vdd)
> +			   unsigned short vdd, unsigned short vdd2)
>  {
>  	u8 pwr = 0;
>  
> @@ -2133,6 +2136,20 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  		}
>  	}
>  
> +	if (mode != MMC_POWER_OFF) {
> +		if (vdd2 != (unsigned short)-1) {
> +			switch (1 << vdd2) {
> +			case MMC_VDD2_165_195:
> +				pwr |= SDHCI_VDD2_POWER_180;
> +				break;
> +			default:
> +				WARN(1, "%s: Invalid vdd2 %#x\n",
> +				     mmc_hostname(host->mmc), vdd2);
> +				break;
> +			}
> +		}
> +	}
> +
>  	if (host->pwr == pwr)
>  		return;
>  
> @@ -2159,7 +2176,13 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  			sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
>  
>  		pwr |= SDHCI_POWER_ON;
> +		if (vdd2 != (unsigned short)-1)
> +			pwr |= SDHCI_VDD2_POWER_ON;
> +
> +		sdhci_writeb(host, pwr & 0xf, SDHCI_POWER_CONTROL);
> +		mdelay(5);
>  		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> +		mdelay(5);
>  
>  		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
>  			sdhci_runtime_pm_bus_on(host);
> @@ -2175,12 +2198,12 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>  EXPORT_SYMBOL_GPL(sdhci_set_power_noreg);
>  
>  void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
> -		     unsigned short vdd)
> +		     unsigned short vdd, unsigned short vdd2)
>  {
>  	if (IS_ERR(host->mmc->supply.vmmc))
> -		sdhci_set_power_noreg(host, mode, vdd);
> +		sdhci_set_power_noreg(host, mode, vdd, vdd2);
>  	else
> -		sdhci_set_power_reg(host, mode, vdd);
> +		sdhci_set_power_reg(host, mode, vdd, vdd2);
>  }
>  EXPORT_SYMBOL_GPL(sdhci_set_power);
>  
> @@ -2192,14 +2215,15 @@ EXPORT_SYMBOL_GPL(sdhci_set_power);
>   */
>  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
>  				     unsigned char mode,
> -				     unsigned short vdd)
> +				     unsigned short vdd,
> +				     unsigned short vdd2)
>  {
>  	if (!IS_ERR(host->mmc->supply.vmmc)) {
>  		struct mmc_host *mmc = host->mmc;
>  
>  		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
>  	}
> -	sdhci_set_power_noreg(host, mode, vdd);
> +	sdhci_set_power_noreg(host, mode, vdd, -1);
>  }
>  EXPORT_SYMBOL_GPL(sdhci_set_power_and_bus_voltage);
>  
> @@ -2377,9 +2401,9 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	}
>  
>  	if (host->ops->set_power)
> -		host->ops->set_power(host, ios->power_mode, ios->vdd);
> +		host->ops->set_power(host, ios->power_mode, ios->vdd, -1);
>  	else
> -		sdhci_set_power(host, ios->power_mode, ios->vdd);
> +		sdhci_set_power(host, ios->power_mode, ios->vdd, -1);
>  
>  	/* 4.0 host support */
>  	if (host->version >= SDHCI_SPEC_400) {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index ecf55394ea46..f6732f33f29f 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -689,7 +689,7 @@ struct sdhci_ops {
>  
>  	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
>  	void	(*set_power)(struct sdhci_host *host, unsigned char mode,
> -			     unsigned short vdd);
> +			     unsigned short vdd, unsigned short vdd2);
>  
>  	u32		(*irq)(struct sdhci_host *host, u32 intmask);
>  
> @@ -852,13 +852,10 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>  		   unsigned int *actual_clock);
>  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
>  void sdhci_enable_clk(struct sdhci_host *host, u16 clk);
> -void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
> -		     unsigned short vdd);
>  void sdhci_set_power_and_bus_voltage(struct sdhci_host *host,
>  				     unsigned char mode,
> -				     unsigned short vdd);
> -void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
> -			   unsigned short vdd);
> +				     unsigned short vdd,
> +				     unsigned short vdd2);
>  void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq);
>  int sdhci_request_atomic(struct mmc_host *mmc, struct mmc_request *mrq);
>  void sdhci_set_bus_width(struct sdhci_host *host, int width);
> 

