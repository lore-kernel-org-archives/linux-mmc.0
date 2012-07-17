From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v10] mmc: support BKOPS feature for eMMC
Date: Tue, 17 Jul 2012 15:30:37 +0300
Message-ID: <50055AED.4000709@intel.com>
References: <5004D176.7090306@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:64063 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159Ab2GQM3n (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 17 Jul 2012 08:29:43 -0400
In-Reply-To: <5004D176.7090306@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Maya Erez <merez@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>

On 17/07/12 05:44, Jaehoon Chung wrote:

<snip>

> +/**
> + *	mmc_start_bkops - start BKOPS for supported cards
> + *	@card: MMC card to start BKOPS
> + *
> + *	Start background operations whenever requested.
> + *	when the urgent BKOPS bit is set in a R1 command response
> + *	then background operations should be started immediately.
> +*/
> +void mmc_start_bkops(struct mmc_card *card)
> +{
> +	int err;
> +	int timeout;
> +	u8 use_busy_signal;
> +
> +	BUG_ON(!card);
> +	if (!card->ext_csd.bkops_en || !(card->host->caps2 & MMC_CAP2_BKOPS))
> +		return;
> +
> +	if (mmc_is_exception_event(card, EXT_CSD_URGENT_BKOPS))
> +		if (card->ext_csd.raw_bkops_status)
> +			mmc_card_set_need_bkops(card);
> +
> +	/*
> +	 * If card is already doing bkops or need for
> +	 * bkops flag is not set, then do nothing just
> +	 * return
> +	 */
> +	if (mmc_card_doing_bkops(card) || !mmc_card_need_bkops(card))
> +		return;
> +
> +	mmc_claim_host(card->host);
> +	if (card->ext_csd.raw_bkops_status >= EXT_CSD_BKOPS_LEVEL_2) {
> +		timeout = MMC_BKOPS_MAX_TIMEOUT;
> +		use_busy_signal = 0;
> +	} else {
> +		timeout = 0;
> +		use_busy_signal = 1;
> +	}

Is this the right way around?
