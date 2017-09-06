From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: 4.13 on thinkpad x220: oops when writing to SD card
Date: Wed, 6 Sep 2017 09:03:47 +0300
Message-ID: <6689241f-a4d8-7a3e-9f0b-482b034e5710@intel.com>
References: <20170905194739.GA31241@amd>
 <8f0f7310-ea4d-a200-75fd-23509947fb38@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:30771 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750788AbdIFGKX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 6 Sep 2017 02:10:23 -0400
In-Reply-To: <8f0f7310-ea4d-a200-75fd-23509947fb38@rock-chips.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Pavel Machek <pavel@ucw.cz>, linux-mmc@vger.kernel.org
Cc: kernel list <linux-kernel@vger.kernel.org>, Seraphime Kirkovski <kirkseraph@gmail.com>

On 06/09/17 05:44, Shawn Lin wrote:
> + Seraphime
> 
> On 2017/9/6 3:47, Pavel Machek wrote:
>> Hi!
>>
>> I tried to write to the MMC card; process hung and I got this in the
>> dmesg.
> 
> 
> A similar report for 4.13 cycle was here:
> 
> https://lkml.org/lkml/2017/8/10/824
> 
> Seems 4.13-rc4 was already broken for that but unfortuantely I didn't
> reproduce that. So maybe Seraphime can do git-bisect as he said "I get
> it everytime" for which I assume it could be easy for him to find out
> the problematic commit?
> 

One obvious weakness in the new mmc_init_request() is the possibility
that it might be called before card->bouncesz is set up.  That could
result in bouncing being done but mq_rq->bounce_sg is null.
This might help:


diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index affa7370ba82..ad3e53e63abb 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -242,6 +242,8 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
 		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
 
+	card->bouncesz = mmc_queue_calc_bouncesz(host);
+
 	mq->card = card;
 	mq->queue = blk_alloc_queue(GFP_KERNEL);
 	if (!mq->queue)
@@ -265,7 +267,6 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
 	if (mmc_can_erase(card))
 		mmc_queue_setup_discard(mq->queue, card);
 
-	card->bouncesz = mmc_queue_calc_bouncesz(host);
 	if (card->bouncesz) {
 		blk_queue_max_hw_sectors(mq->queue, card->bouncesz / 512);
 		blk_queue_max_segments(mq->queue, card->bouncesz / 512);


Another unrelated issue with mmc_init_request() is that mmc_exit_request()
is not called if mmc_init_request() fails, which means mmc_init_request()
must free anything it allocates when it fails.

