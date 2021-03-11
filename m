Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105B5C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 11:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B958264FA8
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 11:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhCKLOL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Mar 2021 06:14:11 -0500
Received: from mga12.intel.com ([192.55.52.136]:25824 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232433AbhCKLNo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 11 Mar 2021 06:13:44 -0500
IronPort-SDR: OoLoXf1U2kw1aJbXVVAV84zKdBXv9/7oxwD7wblh4DkMvFsuxrAnIiTkUxEdPv2WgVWMGywzRH
 orjcMMSJLnDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="167925247"
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="167925247"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 03:13:43 -0800
IronPort-SDR: qXBoO97ufliEy+zsvwjiFKrvhh15rEXMo/E2Pg4lJHEa2nceba/51X0Frx4cQwpPp9R9NBiLxx
 izKI9gejpnlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,240,1610438400"; 
   d="scan'208";a="409454190"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2021 03:13:42 -0800
Subject: Re: [PATCH] mmc: sdhci: Use "mmc" directly rather than "host->mmc"
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210311174046.597d1951@xhacker.debian>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <82e6505d-08a1-a661-8360-5355341fb9fa@intel.com>
Date:   Thu, 11 Mar 2021 13:13:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210311174046.597d1951@xhacker.debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/03/21 11:40 am, Jisheng Zhang wrote:
> Clean up the code to use the "mmc" directly instead of "host->mmc".
> If the code sits in hot code path, this clean up also brings trvial
> performance improvement. Take the sdhci_post_req() for example:
> 
> before the patch:
>      ...
>      8d0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
>      8d4:	910003fd 	mov	x29, sp
>      8d8:	f9000bf3 	str	x19, [sp, #16]
>      8dc:	f9400833 	ldr	x19, [x1, #16]
>      8e0:	b9404261 	ldr	w1, [x19, #64]
>      8e4:	34000161 	cbz	w1, 910 <sdhci_post_req+0x50>
>      8e8:	f9424400 	ldr	x0, [x0, #1160]
>      8ec:	d2800004 	mov	x4, #0x0                   	// #0
>      8f0:	b9401a61 	ldr	w1, [x19, #24]
>      8f4:	b9403262 	ldr	w2, [x19, #48]
>      8f8:	f9400000 	ldr	x0, [x0]
>      8fc:	f278003f 	tst	x1, #0x100
>      900:	f9401e61 	ldr	x1, [x19, #56]
>      904:	1a9f17e3 	cset	w3, eq  // eq = none
>      908:	11000463 	add	w3, w3, #0x1
>      90c:	94000000 	bl	0 <dma_unmap_sg_attrs>
>      ...
> 
> After the patch:
>      ...
>      8d0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
>      8d4:	910003fd 	mov	x29, sp
>      8d8:	f9000bf3 	str	x19, [sp, #16]
>      8dc:	f9400833 	ldr	x19, [x1, #16]
>      8e0:	b9404261 	ldr	w1, [x19, #64]
>      8e4:	34000141 	cbz	w1, 90c <sdhci_post_req+0x4c>
>      8e8:	b9401a61 	ldr	w1, [x19, #24]
>      8ec:	d2800004 	mov	x4, #0x0                   	// #0
>      8f0:	b9403262 	ldr	w2, [x19, #48]
>      8f4:	f9400000 	ldr	x0, [x0]
>      8f8:	f278003f 	tst	x1, #0x100
>      8fc:	f9401e61 	ldr	x1, [x19, #56]
>      900:	1a9f17e3 	cset	w3, eq  // eq = none
>      904:	11000463 	add	w3, w3, #0x1
>      908:	94000000 	bl	0 <dma_unmap_sg_attrs>
>      ...
> 
> We saved one ldr instruction: "ldr     x0, [x0, #1160]"
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2d73407ee52e..b1afabab9cae 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -907,7 +907,7 @@ static void sdhci_calc_sw_timeout(struct sdhci_host *host,
>  
>  	if (data) {
>  		blksz = data->blksz;
> -		freq = host->mmc->actual_clock ? : host->clock;
> +		freq = mmc->actual_clock ? : host->clock;
>  		transfer_time = (u64)blksz * NSEC_PER_SEC * (8 / bus_width);
>  		do_div(transfer_time, freq);
>  		/* multiply by '2' to account for any unknowns */
> @@ -2269,14 +2269,14 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  		if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
>  		    host->clock) {
> -			host->timeout_clk = host->mmc->actual_clock ?
> -						host->mmc->actual_clock / 1000 :
> +			host->timeout_clk = mmc->actual_clock ?
> +						mmc->actual_clock / 1000 :
>  						host->clock / 1000;
> -			host->mmc->max_busy_timeout =
> +			mmc->max_busy_timeout =
>  				host->ops->get_max_timeout_count ?
>  				host->ops->get_max_timeout_count(host) :
>  				1 << 27;
> -			host->mmc->max_busy_timeout /= host->timeout_clk;
> +			mmc->max_busy_timeout /= host->timeout_clk;
>  		}
>  	}
>  
> @@ -2399,7 +2399,7 @@ static int sdhci_get_cd(struct mmc_host *mmc)
>  		return 0;
>  
>  	/* If nonremovable, assume that the card is always present. */
> -	if (!mmc_card_is_removable(host->mmc))
> +	if (!mmc_card_is_removable(mmc))
>  		return 1;
>  
>  	/*
> @@ -2489,14 +2489,14 @@ void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  	unsigned long flags;
>  
>  	if (enable)
> -		pm_runtime_get_noresume(host->mmc->parent);
> +		pm_runtime_get_noresume(mmc->parent);
>  
>  	spin_lock_irqsave(&host->lock, flags);
>  	sdhci_enable_sdio_irq_nolock(host, enable);
>  	spin_unlock_irqrestore(&host->lock, flags);
>  
>  	if (!enable)
> -		pm_runtime_put_noidle(host->mmc->parent);
> +		pm_runtime_put_noidle(mmc->parent);
>  }
>  EXPORT_SYMBOL_GPL(sdhci_enable_sdio_irq);
>  
> @@ -2837,7 +2837,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  		goto out;
>  	}
>  
> -	host->mmc->retune_period = tuning_count;
> +	mmc->retune_period = tuning_count;
>  
>  	if (host->tuning_delay < 0)
>  		host->tuning_delay = opcode == MMC_SEND_TUNING_BLOCK;
> @@ -2886,11 +2886,10 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
>  static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
>  				int err)
>  {
> -	struct sdhci_host *host = mmc_priv(mmc);
>  	struct mmc_data *data = mrq->data;
>  
>  	if (data->host_cookie != COOKIE_UNMAPPED)
> -		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> +		dma_unmap_sg(mmc_dev(mmc), data->sg, data->sg_len,
>  			     mmc_get_dma_dir(data));
>  
>  	data->host_cookie = COOKIE_UNMAPPED;
> @@ -2941,9 +2940,9 @@ static void sdhci_card_event(struct mmc_host *mmc)
>  	/* Check sdhci_has_requests() first in case we are runtime suspended */
>  	if (sdhci_has_requests(host) && !present) {
>  		pr_err("%s: Card removed during transfer!\n",
> -			mmc_hostname(host->mmc));
> +			mmc_hostname(mmc));
>  		pr_err("%s: Resetting controller.\n",
> -			mmc_hostname(host->mmc));
> +			mmc_hostname(mmc));
>  
>  		sdhci_do_reset(host, SDHCI_RESET_CMD);
>  		sdhci_do_reset(host, SDHCI_RESET_DATA);
> @@ -3675,7 +3674,7 @@ int sdhci_resume_host(struct sdhci_host *host)
>  			host->ops->enable_dma(host);
>  	}
>  
> -	if ((host->mmc->pm_flags & MMC_PM_KEEP_POWER) &&
> +	if ((mmc->pm_flags & MMC_PM_KEEP_POWER) &&
>  	    (host->quirks2 & SDHCI_QUIRK2_HOST_OFF_CARD_ON)) {
>  		/* Card keeps power but host controller does not */
>  		sdhci_init(host, 0);
> @@ -3683,7 +3682,7 @@ int sdhci_resume_host(struct sdhci_host *host)
>  		host->clock = 0;
>  		mmc->ops->set_ios(mmc, &mmc->ios);
>  	} else {
> -		sdhci_init(host, (host->mmc->pm_flags & MMC_PM_KEEP_POWER));
> +		sdhci_init(host, (mmc->pm_flags & MMC_PM_KEEP_POWER));
>  	}
>  
>  	if (host->irq_wake_enabled) {
> @@ -3691,7 +3690,7 @@ int sdhci_resume_host(struct sdhci_host *host)
>  	} else {
>  		ret = request_threaded_irq(host->irq, sdhci_irq,
>  					   sdhci_thread_irq, IRQF_SHARED,
> -					   mmc_hostname(host->mmc), host);
> +					   mmc_hostname(mmc), host);
>  		if (ret)
>  			return ret;
>  	}
> @@ -4378,7 +4377,7 @@ int sdhci_setup_host(struct sdhci_host *host)
>  
>  	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
>  	    mmc_card_is_removable(mmc) &&
> -	    mmc_gpio_get_cd(host->mmc) < 0)
> +	    mmc_gpio_get_cd(mmc) < 0)
>  		mmc->caps |= MMC_CAP_NEEDS_POLL;
>  
>  	if (!IS_ERR(mmc->supply.vqmmc)) {
> 

