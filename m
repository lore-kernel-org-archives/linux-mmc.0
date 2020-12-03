Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7D1C64E7B
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 09:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DABED20C56
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 09:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgLCJwN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Dec 2020 04:52:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:46766 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgLCJwM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 3 Dec 2020 04:52:12 -0500
IronPort-SDR: 12GvVvOfbgbLV9Z/d9UbfEnqAKqYp4fXNKhVvY1J/pq2DhpkZJd8vQ+1E4IW/Z8QOKY6S1fNwP
 k8nQGs2r6/bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="160221763"
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="160221763"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 01:51:27 -0800
IronPort-SDR: QcBU1u04JhpWQiRdJLxFxX/cSdBACFhwKw4FLICfVLwHDP+FfVgIXGuOYWazRNN9Cx7nIiT70T
 ep8agBBk2HmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="315636700"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga008.fm.intel.com with ESMTP; 03 Dec 2020 01:51:25 -0800
Subject: Re: [RFC PATCH v3.1 16/27] mmc: sdhci-uhs2: add set_ios()
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-17-takahiro.akashi@linaro.org>
 <7d2b6524-b6ab-0fd0-edfa-8d7ff274cd1a@intel.com>
 <20201130075147.GF48535@laputa>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <bd9b974b-c3c8-33b2-9f13-7cef99140172@intel.com>
Date:   Thu, 3 Dec 2020 11:51:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201130075147.GF48535@laputa>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30/11/20 9:51 am, AKASHI Takahiro wrote:
> On Thu, Nov 26, 2020 at 10:17:11AM +0200, Adrian Hunter wrote:
>> On 6/11/20 4:27 am, AKASHI Takahiro wrote:
>>> This is a sdhci version of mmc's set_ios operation.
>>> It covers both UHS-I and UHS-II.
>>>
>>> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>> ---
>>>  drivers/mmc/host/sdhci-uhs2.c | 100 ++++++++++++++++++++++++++++++++++
>>>  drivers/mmc/host/sdhci-uhs2.h |   1 +
>>>  drivers/mmc/host/sdhci.c      |  40 +++++++++-----
>>>  drivers/mmc/host/sdhci.h      |   2 +
>>>  4 files changed, 128 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
>>> index d9e98c097bfe..637464748cc4 100644
>>> --- a/drivers/mmc/host/sdhci-uhs2.c
>>> +++ b/drivers/mmc/host/sdhci-uhs2.c
>>> @@ -263,6 +263,74 @@ void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>>>  }
>>>  EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
>>>  
>>> +/**
>>> + * sdhci_uhs2_clear_set_irqs - set Error Interrupt Status Enable register
>>> + * @host:	SDHCI host
>>> + * @clear:	bit-wise clear mask
>>> + * @set:	bit-wise set mask
>>> + *
>>> + * Set/unset bits in UHS-II Error Interrupt Status Enable register
>>> + */
>>> +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
>>> +{
>>> +	u32 ier;
>>> +
>>> +	ier = sdhci_readl(host, SDHCI_UHS2_ERR_INT_STATUS_EN);
>>> +	ier &= ~clear;
>>> +	ier |= set;
>>> +	sdhci_writel(host, ier, SDHCI_UHS2_ERR_INT_STATUS_EN);
>>> +	sdhci_writel(host, ier, SDHCI_UHS2_ERR_INT_SIG_EN);
>>> +}
>>> +EXPORT_SYMBOL_GPL(sdhci_uhs2_clear_set_irqs);
>>> +
>>> +static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>> +{
>>> +	struct sdhci_host *host = mmc_priv(mmc);
>>> +	u8 cmd_res, dead_lock;
>>> +	u16 ctrl_2;
>>> +	unsigned long flags;
>>> +
>>> +	/* FIXME: why lock? */
>>> +	spin_lock_irqsave(&host->lock, flags);
>>> +
>>> +	/* UHS2 Timeout Control */
>>> +	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
>>> +
>>> +	/* change to use calculate value */
>>> +	cmd_res |= dead_lock << SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT;
>>> +
>>> +	sdhci_uhs2_clear_set_irqs(host,
>>> +				  SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT |
>>> +				  SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT,
>>> +				  0);
>>> +	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
>>> +	sdhci_uhs2_clear_set_irqs(host, 0,
>>> +				  SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT |
>>> +				  SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT);
>>> +
>>> +	/* UHS2 timing */
>>> +	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>> +	if (ios->timing == MMC_TIMING_UHS2)
>>> +		ctrl_2 |= SDHCI_CTRL_UHS_2 | SDHCI_CTRL_UHS2_INTERFACE_EN;
>>> +	else
>>> +		ctrl_2 &= ~(SDHCI_CTRL_UHS_2 | SDHCI_CTRL_UHS2_INTERFACE_EN);
>>> +	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>>> +
>>> +	if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
>>> +		sdhci_enable_preset_value(host, true);
>>> +
>>> +	if (host->ops->set_power)
>>> +		host->ops->set_power(host, ios->power_mode, ios->vdd);
>>> +	else
>>> +		sdhci_set_power(host, ios->power_mode, ios->vdd);
>>> +	udelay(100);
>>> +
>>> +	host->timing = ios->timing;
>>> +	sdhci_set_clock(host, host->clock);
>>
>> sdhci_set_ios_common() already called ->set_clock() and ->set_power(), so I
>> am not really following what is going on here.  Can you explain some more?
> 
> To be frank, I don't know. The logic in Intel's (and/or Ben's?)
> original code does so.
> What I changed is to remove the code of setting (ios->vdd and) ios->vdd2,
> which is executed before calling set_power(), in __sdhci_uhs2_set_ios().
> 
> So yes, effectively it may be of no use to call set_power() here.

Please try to rationalize it.  Also set_ios() should not need the spin lock,
and that allows clock and power callbacks to sleep if needed.

> 
> -Takahiro Akashi
> 
>>> +
>>> +	spin_unlock_irqrestore(&host->lock, flags);
>>> +}
>>> +
>>>  /*****************************************************************************\
>>>   *                                                                           *
>>>   * MMC callbacks                                                             *
>>> @@ -286,6 +354,37 @@ static int sdhci_uhs2_start_signal_voltage_switch(struct mmc_host *mmc,
>>>  	return sdhci_start_signal_voltage_switch(mmc, ios);
>>>  }
>>>  
>>> +void sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>> +{
>>> +	struct sdhci_host *host = mmc_priv(mmc);
>>> +
>>> +	if (!(host->version >= SDHCI_SPEC_400) ||
>>> +	    !(host->mmc->flags & MMC_UHS2_SUPPORT &&
>>> +	      host->mmc->caps & MMC_CAP_UHS2)) {
>>> +		sdhci_set_ios(mmc, ios);
>>> +		return;
>>> +	}
>>> +
>>> +	if (ios->power_mode == MMC_POWER_UNDEFINED)
>>> +		return;
>>> +
>>> +	if (host->flags & SDHCI_DEVICE_DEAD) {
>>> +		if (!IS_ERR(mmc->supply.vmmc) &&
>>> +		    ios->power_mode == MMC_POWER_OFF)
>>> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>>> +		if (!IS_ERR_OR_NULL(mmc->supply.vmmc2) &&
>>> +		    ios->power_mode == MMC_POWER_OFF)
>>> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
>>> +		return;
>>> +	}
>>> +
>>> +	/* FIXME: host->timing = ios->timing */
>>> +
>>> +	sdhci_set_ios_common(mmc, ios);
>>> +
>>> +	__sdhci_uhs2_set_ios(mmc, ios);
>>> +}
>>> +
>>>  /*****************************************************************************\
>>>   *                                                                           *
>>>   * Driver init/exit                                                          *
>>> @@ -296,6 +395,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>>>  {
>>>  	host->mmc_host_ops.start_signal_voltage_switch =
>>>  		sdhci_uhs2_start_signal_voltage_switch;
>>> +	host->mmc_host_ops.set_ios = sdhci_uhs2_set_ios;
>>>  
>>>  	return 0;
>>>  }
>>> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
>>> index efe70577bc74..c1ff4ac1ab7a 100644
>>> --- a/drivers/mmc/host/sdhci-uhs2.h
>>> +++ b/drivers/mmc/host/sdhci-uhs2.h
>>> @@ -214,5 +214,6 @@ void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
>>>  void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode,
>>>  			  unsigned short vdd);
>>>  void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
>>> +void sdhci_uhs2_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set);
>>>  
>>>  #endif /* __SDHCI_UHS2_H */
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 0b741eb546cb..becb228330af 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -48,8 +48,6 @@
>>>  static unsigned int debug_quirks = 0;
>>>  static unsigned int debug_quirks2;
>>>  
>>> -static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
>>> -
>>>  static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd);
>>>  
>>>  void sdhci_dumpregs(struct sdhci_host *host)
>>> @@ -1836,6 +1834,9 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
>>>  	case MMC_TIMING_MMC_HS400:
>>>  		preset = sdhci_readw(host, SDHCI_PRESET_FOR_HS400);
>>>  		break;
>>> +	case MMC_TIMING_UHS2:
>>> +		preset = sdhci_readw(host, SDHCI_PRESET_FOR_UHS2);
>>> +		break;
>>>  	default:
>>>  		pr_warn("%s: Invalid UHS-I mode selected\n",
>>>  			mmc_hostname(host->mmc));
>>> @@ -2249,20 +2250,9 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>>>  }
>>>  EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
>>>  
>>> -void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>> +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
>>>  {
>>>  	struct sdhci_host *host = mmc_priv(mmc);
>>> -	u8 ctrl;
>>> -
>>> -	if (ios->power_mode == MMC_POWER_UNDEFINED)
>>> -		return;
>>> -
>>> -	if (host->flags & SDHCI_DEVICE_DEAD) {
>>> -		if (!IS_ERR(mmc->supply.vmmc) &&
>>> -		    ios->power_mode == MMC_POWER_OFF)
>>> -			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>>> -		return;
>>> -	}
>>>  
>>>  	/*
>>>  	 * Reset the chip on each power off.
>>> @@ -2299,6 +2289,25 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>  		host->ops->set_power(host, ios->power_mode, ios->vdd);
>>>  	else
>>>  		sdhci_set_power(host, ios->power_mode, ios->vdd);
>>> +}
>>> +EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
>>> +
>>> +void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>> +{
>>> +	struct sdhci_host *host = mmc_priv(mmc);
>>> +	u8 ctrl;
>>> +
>>> +	if (ios->power_mode == MMC_POWER_UNDEFINED)
>>> +		return;
>>> +
>>> +	if (host->flags & SDHCI_DEVICE_DEAD) {
>>> +		if (!IS_ERR(mmc->supply.vmmc) &&
>>> +		    ios->power_mode == MMC_POWER_OFF)
>>> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>>> +		return;
>>> +	}
>>> +
>>> +	sdhci_set_ios_common(mmc, ios);
>>>  
>>>  	if (host->ops->platform_send_init_74_clocks)
>>>  		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
>>> @@ -2869,7 +2878,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>>  }
>>>  EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
>>>  
>>> -static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
>>> +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
>>>  {
>>>  	/* Host Controller v3.00 defines preset value registers */
>>>  	if (host->version < SDHCI_SPEC_300)
>>> @@ -2897,6 +2906,7 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
>>>  		host->preset_enabled = enable;
>>>  	}
>>>  }
>>> +EXPORT_SYMBOL_GPL(sdhci_enable_preset_value);
>>>  
>>>  static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
>>>  				int err)
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index 2b5b8295cf92..e84ebddb20d8 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -851,6 +851,8 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
>>>  void sdhci_reset(struct sdhci_host *host, u8 mask);
>>>  void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
>>>  int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
>>> +void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
>>> +void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios);
>>>  void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
>>>  int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>>>  				      struct mmc_ios *ios);
>>>
>>

