From: "Konstantin Dorfman" <kdorfman@codeaurora.org>
Subject: Re: [PATCH v3] mmc: support BKOPS feature for eMMC
Date: Tue, 22 Nov 2011 16:00:38 +0200 (IST)
Message-ID: <e32cfeb959b1b8849a6f3644b157056d.squirrel@www.codeaurora.org>
References: <4EC45A39.5030706@samsung.com>
    <3f75bb7f25e649376784536d819e7fbf.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:51948 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab1KVOAj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2011 09:00:39 -0500
In-Reply-To: <3f75bb7f25e649376784536d819e7fbf.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per Forlin <per.lkml@gmail.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>

> Hello Jaehoon,
>
> ...
>> +/**
>> + *	mmc_start_bkops - start BKOPS for supported cards
>> + *	@card: MMC card to start BKOPS
>> + *
>> + *	Start background operations whenever requested.
>> + *	when the urgent BKOPS bit is set in a R1 command response
>> + *	then background operations should be started immediately.
>> +*/
>> +void mmc_start_bkops(struct mmc_card *card)
>> +{
>> +	int err;
>> +	unsigned long flags;
>> +
>> +	BUG_ON(!card);
>> +	if ((!card->ext_csd.bkops_en) ||
>> +			!(card->host->caps2 & MMC_CAP2_BKOPS))
>> +		return;
>> +
>> +	/*
>> +	 * If card is already doing bkops or need for
>> +	 * bkops flag is not set, then do nothing just
>> +	 * return
>> +	 */
>> +	if (mmc_card_doing_bkops(card)
>> +			|| !mmc_card_need_bkops(card))
>> +		return;
>> +
>> +	mmc_claim_host(card->host);
>> +	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +			EXT_CSD_BKOPS_START, 1, 0);
>> +	if (err) {
>> +		pr_warning("error %d starting bkops\n", err);
>> +		mmc_card_clr_need_bkops(card);
>> +		goto out;
>> +	}
>> +	spin_lock_irqsave(&card->host->lock, flags);
>> +	mmc_card_clr_need_bkops(card);
>> +	mmc_card_set_doing_bkops(card);
> Sending CMD6 (by mmc_switch()) will start BKOPS on card,
> according to eMMC spec:
> -----
> 7.4.56 BKOPS_START [164]
> Writing any value to this field shall manually start background
> operations.
> Device shall stay busy till no more background operations are needed.
> -----
> Where/when mmc_card_clear_doing_bkops() should called? The only place I
> see this happens is
> in mmc_interrupt_bkops(). This means, that once BKOPS started, next
> read/write request
> will _always_(and not when card really busy) send HPI and only then will
> clear "doing" flag.
>
> May be it is possible to poll for ack from card about when BKOPS finished?
> Another possibility that
> mmc_switch() synchronous and after flow returns from it, we can clear
> "doing" flag immediately.
> Does it make sense?
> ...

Now I understand that mmc_switch() command was modified for BKOPS_START to
be non-blocking, so the flow never waits for BKOPS to be finished. Because
of this HPI is always sent before next request.
Since start bkops flow is not frequent, it is ok.
Thanks,
Kostya

>> +	spin_unlock_irqrestore(&card->host->lock, flags);
>> +out:
>> +	mmc_release_host(card->host);
>> +}
>> +EXPORT_SYMBOL(mmc_start_bkops);
>> +
>
> Thanks,
> Kostya
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


