From: "Konstantin Dorfman" <kdorfman@codeaurora.org>
Subject: Re: [PATCH v3] mmc: support BKOPS feature for eMMC
Date: Thu, 1 Dec 2011 18:13:48 +0200 (IST)
Message-ID: <051ff64068f04c729d6f6a32c25db5cc.squirrel@www.codeaurora.org>
References: <4EC45A39.5030706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:45144 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116Ab1LAQNs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2011 11:13:48 -0500
In-Reply-To: <4EC45A39.5030706@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per Forlin <per.lkml@gmail.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>

Hello Jaehoon,
After applying your patch and debugging it for some time,
I want to share my results and suggests some changes to the patch.
See comments below:

> +void mmc_start_bkops(struct mmc_card *card)
> +{
> +	int err;
> +	unsigned long flags;
> +
> +	BUG_ON(!card);
> +	if ((!card->ext_csd.bkops_en) ||
> +			!(card->host->caps2 & MMC_CAP2_BKOPS))
> +		return;
> +
> +	/*
> +	 * If card is already doing bkops or need for
> +	 * bkops flag is not set, then do nothing just
> +	 * return
> +	 */
> +	if (mmc_card_doing_bkops(card)
> +			|| !mmc_card_need_bkops(card))
> +		return;
> +
> +	mmc_claim_host(card->host);
> +	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +			EXT_CSD_BKOPS_START, 1, 0);
> +	if (err) {
> +		pr_warning("error %d starting bkops\n", err);
> +		mmc_card_clr_need_bkops(card);
> +		goto out;
> +	}
> +	spin_lock_irqsave(&card->host->lock, flags);
> +	mmc_card_clr_need_bkops(card);
> +	mmc_card_set_doing_bkops(card);

mmc_switch() will use CMD6 with MMC_RSP_R1B flag (see mmc_switch()
implementation), this flag
causes mmc controler to wait until busy line (DAT0) released:

----from eMMC v4.5 protocol----
6.12 Responses
...
R1b is identical to R1 with an optional busy signal transmitted on the
data line DAT0.
The Device may become busy after receiving these commands based on its
state prior to the command reception.
...
7.4.56 BKOPS_START [164]
Writing any value to this field shall manually start background
operations. Device shall stay busy till no more
background operations are needed.
----cut----

This means, that mmc_switch() returns only after BKOPS finished by card
and there is no point
in setting mmc_card_set_doing_bkops(card). Also, HPI command send to the
card in order to interrupt BKOPS in mmc_queue_thread()
will never actually interrupt BKOPS. To resolve this I suggest following:

1)  Define two variants of mmc_switch(...,wait_flag) for BKOPS, where
      wait_flag is true sends CMD6 with MMC_RSP_R1b flag as it happens now.
      wait_flag is false sends CMD6 with MMC_RSP_R1 flag (the only
difference is MMC_RSP_BUSY bit),
    so the flow continues immediately after CMD response arrives and will
not wait for busy line release.

2) The only situation when we want to use synchronous mmc_switch(...,
true) is URGENT bit arrives from card, in mmc_blk_issue_rw_rq().
   There is no point in waiting for idle time check in mmc_queue_thread(),
host should start synchronous BKOPS immediately.

3) When in idle (no requests to issue) we can read BKOPS_STATUS[246] from
card and depending on state decide:
     0: nothing to do go idle
     1: start BKOPS with no wait for busy line ( mmc_switch(..., false))
and mmc_set_doing_bkops()
     3&2: start synchronous BKOPS

Let me describe this by pseudo-code below:

queue.c:  mmc_queue_thread():
...
req = blk_fetch_request(q)
if(req == NULL) {
  state = read_bkops_state(); // read BKOPS_STATUS[246] from card
  switch(state) {
    case 0:
      go_idle()
      break;
    case 1:
      start_asynch_bkops()  // send CMD6 with no wait for busy
      mmc_set_doing_bkops() // update flag
      break;
    case 2:
    case 3:
      start_synch_bkops() // start CMD6 with wait for busy
      break;
    default:
      go_idle()
  }
} else {
   if( mmc_doing_bkops() ) {
     mmc_send_hpi()
     mmc_clear_doing_bkops()
   }
   issue(req)
}

mmc\card\block.c: mmc_blk_issue_rw_rq()
...
  if ( (mmc_is_exception_event(card,EXT_CSD_URGENT_BKOPS)) {
	start_synch_bkops() // start CMD6 with wait for busy
  }
...
-----------------------end of pseudo code-------------

Does this make sense?
Thanks, Kostya



