From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: 4.8-rc1 REGRESSION mmc-blk triggers WARN_ON(!host->claimed),
 related to: "drivers: use req op accessor" ?
Date: Thu, 25 Aug 2016 11:19:27 +0300
Message-ID: <6bfb134a-43bf-addd-3ff0-cc1d677a1606@intel.com>
References: <6e68ae5a-4b79-a636-2c46-5726cf2cc44b@redhat.com>
 <57BB23D0.3050606@redhat.com>
 <2a2ee1e8-8682-0647-a66d-04ceb54f58ec@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8496 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756813AbcHYIYC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 25 Aug 2016 04:24:02 -0400
In-Reply-To: <2a2ee1e8-8682-0647-a66d-04ceb54f58ec@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mike Christie <mchristi@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@fb.com>, regressions@leemhuis.info, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 24/08/16 11:47, Hans de Goede wrote:
> Hi,
> 
> On 22-08-16 18:09, Mike Christie wrote:
>> On 08/21/2016 10:15 AM, Hans de Goede wrote:
>>> Hi All,
>>>
>>> With 4.8-rc1 I'm seeing WARN_ON(!host->claimed) triggering in both
>>> mmc_start_request() as well as in mmc_release_host(). The first
>>> indicating that we're executing mmc commands without doing
>>> mmc_claim_host() and the second one indicating that we're
>>> releasing the host without having claimed it first.
>>>
>>> The backtraces all point to mmc_blk_issue_rq(). I've done
>>> a very naive hack / workaround:
>>>
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -2151,9 +2151,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq,
>>> struct request *req)
>>>      struct mmc_host *host = card->host;
>>>      unsigned long flags;
>>>
>>> -    if (req && !mq->mqrq_prev->req)
>>> -        /* claim host only for the first request */
>>> -        mmc_get_card(card);
>>> +    mmc_get_card(card);
>>>
>>>      ret = mmc_blk_part_switch(card, md);
>>>      if (ret) {
>>> @@ -2190,15 +2188,8 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq,
>>> struct request *req)
>>>      }
>>>
>>>  out:
>>> -    if ((!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST)) ||
>>> -        mmc_req_is_special(req))
>>> -        /*
>>> -         * Release host when there are no more requests
>>> -         * and after special request(discard, flush) is done.
>>> -         * In case sepecial request, there is no reentry to
>>> -         * the 'mmc_blk_issue_rq' with 'mqrq_prev->req'.
>>> -         */
>>> -        mmc_put_card(card);
>>> +    mmc_put_card(card);
>>> +
>>>      return ret;
>>>  }
>>>
>>>
>>> Which fixes this, further pointing to the somewhat magical claim / release
>>> code in mmc_blk_issue_rq() being the culprit.
>>>
>>> Looking at recent commits these 2 stand out as possible causes of this:
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=c2df40dfb8c015211ec55f4b1dd0587f875c7b34
>>>
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=3a5e02ced11e22ecd9da3d6710afe15bcfee1d10
>>>
>>>
>>>
>>> I've the feeling that one of these is making mmc_blk_issue_rq() not
>>> claiming
>>> the host while it should do so ...
>>>
>>
>> There is a bug with those patches and the secure discard ones where when
>> REQ_OP_SECURE_ERASE is sent, mmc_put_card above will not be called, and
>> they will be treated as normal requests instead of special one so the
>> drivers lists are not executed properly.
> 
> Actually the problem seems to be mmc_get_card not getting called while it
> should at the top of mmc_blk_issue_rq, I first get a WARN_ON(!host->claimed)
> triggering in mmc_start_request (so missing mmc_card_get) and then
> in mmc_release_host (mmc_card_put called without mc_card_get being called
> first).
> 
>> The patch in Jens's tree
>> https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git/commit/?h=for-linus&id=7afafc8a44bf0ab841b17d450b02aedb3a138985
>>
>> fixes the issue.
> 
> I've tried 4.8-rc3 with my hack drop and this commit cherry-picked,
> but the problem is still there, so this patch does not fix it.

I wasn't able to reproduce your problem, but a possibility could be
accessing the request after it is completed.  You could try this:

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 82503e6f04b3..2206d4477dbb 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -2151,6 +2151,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	struct mmc_card *card = md->queue.card;
 	struct mmc_host *host = card->host;
 	unsigned long flags;
+	bool req_is_special = mmc_req_is_special(req);
 
 	if (req && !mq->mqrq_prev->req)
 		/* claim host only for the first request */
@@ -2191,8 +2192,7 @@ static int mmc_blk_issue_rq(struct mmc_queue *mq, struct request *req)
 	}
 
 out:
-	if ((!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST)) ||
-	    mmc_req_is_special(req))
+	if ((!req && !(mq->flags & MMC_QUEUE_NEW_REQUEST)) || req_is_special)
 		/*
 		 * Release host when there are no more requests
 		 * and after special request(discard, flush) is done.
diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
index 29578e98603d..708057261b38 100644
--- a/drivers/mmc/card/queue.c
+++ b/drivers/mmc/card/queue.c
@@ -65,6 +65,8 @@ static int mmc_queue_thread(void *d)
 		spin_unlock_irq(q->queue_lock);
 
 		if (req || mq->mqrq_prev->req) {
+			bool req_is_special = mmc_req_is_special(req);
+
 			set_current_state(TASK_RUNNING);
 			mq->issue_fn(mq, req);
 			cond_resched();
@@ -80,7 +82,7 @@ static int mmc_queue_thread(void *d)
 			 * has been finished. Do not assign it to previous
 			 * request.
 			 */
-			if (mmc_req_is_special(req))
+			if (req_is_special)
 				mq->mqrq_cur->req = NULL;
 
 			mq->mqrq_prev->brq.mrq.data = NULL;


