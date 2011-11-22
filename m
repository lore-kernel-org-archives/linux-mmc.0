From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3] mmc: support BKOPS feature for eMMC
Date: Wed, 23 Nov 2011 08:54:13 +0900
Message-ID: <4ECC3625.3090109@samsung.com>
References: <4EC45A39.5030706@samsung.com>
 <3f75bb7f25e649376784536d819e7fbf.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:36120 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186Ab1KVXyc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2011 18:54:32 -0500
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LV3008G96ES4Y70@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 23 Nov 2011 08:54:30 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LV300KG46EHK440@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 23 Nov 2011 08:54:30 +0900 (KST)
In-reply-to: <3f75bb7f25e649376784536d819e7fbf.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per Forlin <per.lkml@gmail.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>

Hi Konstantin

On 11/22/2011 09:44 PM, Konstantin Dorfman wrote:

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
> Writing any value to this field shall manually start background operations.
> Device shall stay busy till no more background operations are needed.
> -----
> Where/when mmc_card_clear_doing_bkops() should called? The only place I
> see this happens is
> in mmc_interrupt_bkops(). This means, that once BKOPS started, next
> read/write request
> will _always_(and not when card really busy) send HPI and only then will
> clear "doing" flag.


Right, that is called only in mmc_interrupt_bkops. I wonder how did you check
to finish the bkops without hpi command?

> May be it is possible to poll for ack from card about when BKOPS finished?
> Another possibility that
> mmc_switch() synchronous and after flow returns from it, we can clear
> "doing" flag immediately.
> Does it make sense?

i didn't know how poll for ack from card..did you know?
So i implemented that send the hpi command whatever status.

If let me know checking for ack from card, i will consider that.

Thanks

Best Regards,
Jaehoon Chung
