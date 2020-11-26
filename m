Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0626C63777
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 08:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B6E20B80
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 08:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgKZISx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:18:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:58607 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgKZISx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 03:18:53 -0500
IronPort-SDR: t5LV36X2n6/BnuTrM5TEtxKa3RO2xT54PTlcqrxr+FfhfjnoAXk50i8yin2jz22SnBgyEevT9f
 1shPs8RZ1GTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="159300621"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="159300621"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 00:18:53 -0800
IronPort-SDR: u8oP1Ki2WJa3HH7Q1dfy9TmnVAlHlSOaKd8eB56iaiGjty5M9CtM6lD/Hr2tKa6UuIc2Wk7SYc
 0r6yiOfdflHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="362722293"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2020 00:18:49 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH v3.1 19/27] mmc: sdhci-uhs2: add set_reg() to
 initialise the interface
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-20-takahiro.akashi@linaro.org>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2356a6bc-bb19-0689-3b69-93f612ccb719@intel.com>
Date:   Thu, 26 Nov 2020 10:18:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106022726.19831-20-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> This is a sdhci version of mmc's uhs2_set_reg operation.
> UHS-II interface (related registers) will be initialised here.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci-uhs2.c | 103 ++++++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 55362ace1857..d8afb99a9918 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -332,6 +332,68 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>  
> +/* TODO: move this function to sdhci.c */
> +static void sdhci_clear_set_irqs(struct sdhci_host *host, u32 clear, u32 set)
> +{
> +	u32 ier;
> +
> +	ier = sdhci_readl(host, SDHCI_INT_ENABLE);
> +	ier &= ~clear;
> +	ier |= set;
> +	sdhci_writel(host, ier, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
> +}
> +
> +static void sdhci_uhs2_set_config(struct sdhci_host *host)
> +{
> +	u32 value;
> +	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SET_PTR);
> +	u16 sdhci_uhs2_gen_set_reg = (sdhci_uhs2_set_ptr + 0);
> +	u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
> +	u16 sdhci_uhs2_tran_set_reg = (sdhci_uhs2_set_ptr + 8);
> +	u16 sdhci_uhs2_tran_set_1_reg = (sdhci_uhs2_set_ptr + 12);
> +
> +	/* Set Gen Settings */
> +	sdhci_writel(host, host->mmc->uhs2_caps.n_lanes_set <<
> +		SDHCI_UHS2_GEN_SET_N_LANES_POS, sdhci_uhs2_gen_set_reg);
> +
> +	/* Set PHY Settings */
> +	value = (host->mmc->uhs2_caps.n_lss_dir_set <<
> +			SDHCI_UHS2_PHY_SET_N_LSS_DIR_POS) |
> +		(host->mmc->uhs2_caps.n_lss_sync_set <<
> +			SDHCI_UHS2_PHY_SET_N_LSS_SYN_POS);
> +	if (host->mmc->flags & MMC_UHS2_SPEED_B)
> +		value |= 1 << SDHCI_UHS2_PHY_SET_SPEED_POS;
> +	sdhci_writel(host, value, sdhci_uhs2_phy_set_reg);
> +
> +	/* Set LINK-TRAN Settings */
> +	value = (host->mmc->uhs2_caps.max_retry_set <<
> +			SDHCI_UHS2_TRAN_SET_RETRY_CNT_POS) |
> +		(host->mmc->uhs2_caps.n_fcu_set <<
> +			SDHCI_UHS2_TRAN_SET_N_FCU_POS);
> +	sdhci_writel(host, value, sdhci_uhs2_tran_set_reg);
> +	sdhci_writel(host, host->mmc->uhs2_caps.n_data_gap_set,
> +		     sdhci_uhs2_tran_set_1_reg);
> +}
> +
> +static int sdhci_uhs2_check_dormant(struct sdhci_host *host)
> +{
> +	int timeout = 100;
> +
> +	while (!(sdhci_readl(host, SDHCI_PRESENT_STATE) &
> +		SDHCI_UHS2_IN_DORMANT_STATE)) {

Can use read_poll_timeout(sdhci_readl,..., host, SDHCI_PRESENT_STATE)

> +		if (timeout == 0) {
> +			pr_warn("%s: UHS2 IN_DORMANT fail in 100ms.\n",
> +				mmc_hostname(host->mmc));
> +			sdhci_dumpregs(host);
> +			return -EIO;
> +		}
> +		timeout--;
> +		mdelay(1);
> +	}
> +	return 0;
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * MMC callbacks                                                             *
> @@ -422,6 +484,45 @@ static void sdhci_uhs2_enable_clk(struct mmc_host *mmc)
>  	}
>  }
>  
> +static int sdhci_uhs2_set_reg(struct mmc_host *mmc, enum uhs2_act act)
> +{
> +        struct sdhci_host *host = mmc_priv(mmc);
> +	unsigned long flags;
> +	int err = 0;
> +	u16 sdhci_uhs2_set_ptr = sdhci_readw(host, SDHCI_UHS2_SET_PTR);
> +	u16 sdhci_uhs2_phy_set_reg = (sdhci_uhs2_set_ptr + 4);
> +
> +	DBG("Begin sdhci_uhs2_set_reg, act %d.\n", act);
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	switch (act) {
> +	case SET_CONFIG:
> +		sdhci_uhs2_set_config(host);
> +		break;
> +	case ENABLE_INT:
> +		sdhci_clear_set_irqs(host, 0, SDHCI_INT_CARD_INT);
> +		break;
> +	case DISABLE_INT:
> +		sdhci_clear_set_irqs(host, SDHCI_INT_CARD_INT, 0);
> +		break;
> +	case SET_SPEED_B:
> +		sdhci_writeb(host, 1 << SDHCI_UHS2_PHY_SET_SPEED_POS,
> +			     sdhci_uhs2_phy_set_reg);
> +		break;
> +	case CHECK_DORMANT:
> +		err = sdhci_uhs2_check_dormant(host);
> +		break;
> +	default:
> +		pr_err("%s: input action %d is wrong!\n",
> +		       mmc_hostname(host->mmc), act);
> +		err = -EIO;
> +		break;
> +	}
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +	return err;
> +}
> +
>  /*****************************************************************************\
>   *                                                                           *
>   * Driver init/exit                                                          *
> @@ -597,6 +698,8 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
>  		host->mmc_host_ops.uhs2_disable_clk = sdhci_uhs2_disable_clk;
>  	if (!host->mmc_host_ops.uhs2_enable_clk)
>  		host->mmc_host_ops.uhs2_enable_clk = sdhci_uhs2_enable_clk;
> +	if (!host->mmc_host_ops.uhs2_set_reg)
> +		host->mmc_host_ops.uhs2_set_reg = sdhci_uhs2_set_reg;
>  
>  	return 0;
>  }
> 

