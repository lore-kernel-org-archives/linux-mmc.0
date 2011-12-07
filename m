From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V3] mmc: Kill block requests if card is removed
Date: Wed, 07 Dec 2011 18:06:52 +0200
Message-ID: <4EDF8F1C.4080805@intel.com>
References: <1322735441-3911-1-git-send-email-sthumma@codeaurora.org> <4EDDD9BF.2090608@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42765 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756349Ab1LGQG6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Dec 2011 11:06:58 -0500
In-Reply-To: <4EDDD9BF.2090608@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: per.lkml@gmail.com, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, cjb@laptop.org

On 06/12/11 11:00, Sujit Reddy Thumma wrote:
> Hi Adrian/Per,
> 
> Any comments on this patch?

What about adding the following to the top of  mmc_blk_cmd_recovery()

	if (mmc_card_removed(card))
		return ERR_NOMEDIUM;


> 
> Thanks,
> Sujit
> 
> On 12/1/2011 4:00 PM, Sujit Reddy Thumma wrote:
>> Kill block requests when the host realizes that the card is
>> removed from the slot and is sure that subsequent requests
>> are bound to fail. Do this silently so that the block
>> layer doesn't output unnecessary error messages.
>>
>> Signed-off-by: Sujit Reddy Thumma<sthumma@codeaurora.org>
>>
>> ---
>> Changes in v3:
>>     - Dropped dependency on Per's patch and is now dependent
>>     on "[PATCH V4] mmc: allow upper layers to determine immediately
>>     if a card has been removed" by Adrian Hunter.
>>     - Modified commit text slightly as Adrian has
>>     implemented his own suggestion in a different patch.
>>
>> Changes in v2:
>>     - Changed the implementation with further comments from Adrian
>>     - Set the card removed flag in bus notifier callbacks
>>     - This patch is now dependent on patch from Per Forlin:
>>     http://thread.gmane.org/gmane.linux.kernel.mmc/11128/focus=11211
>> ---
>>   drivers/mmc/card/block.c |   14 +++++++++++++-
>>   drivers/mmc/card/queue.c |    5 +++++
>>   2 files changed, 18 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index c80bb6d..20350cb 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -119,6 +119,7 @@ enum mmc_blk_status {
>>       MMC_BLK_ABORT,
>>       MMC_BLK_DATA_ERR,
>>       MMC_BLK_ECC_ERR,
>> +    MMC_BLK_NOMEDIUM,
>>   };
>>
>>   module_param(perdev_minors, int, 0444);
>> @@ -565,6 +566,7 @@ static int get_card_status(struct mmc_card *card, u32 *status, int retries)
>>       return err;
>>   }
>>
>> +#define ERR_NOMEDIUM    3
>>   #define ERR_RETRY    2
>>   #define ERR_ABORT    1
>>   #define ERR_CONTINUE    0
>> @@ -648,8 +650,12 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
>>       }
>>
>>       /* We couldn't get a response from the card.  Give up. */
>> -    if (err)
>> +    if (err) {
>> +        /* Check if the card is removed */
>> +        if (mmc_detect_card_removed(card->host))
>> +            return ERR_NOMEDIUM;
>>           return ERR_ABORT;
>> +    }
>>
>>       /* Flag ECC errors */
>>       if ((status&  R1_CARD_ECC_FAILED) ||
>> @@ -922,6 +928,8 @@ static int mmc_blk_err_check(struct mmc_card *card,
>>               return MMC_BLK_RETRY;
>>           case ERR_ABORT:
>>               return MMC_BLK_ABORT;
>> +        case ERR_NOMEDIUM:
>> +            return MMC_BLK_NOMEDIUM;
>>           case ERR_CONTINUE:
>>               break;
>>           }
>> @@ -1255,6 +1263,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>>               if (!ret)
>>                   goto start_new_req;
>>               break;
>> +        case MMC_BLK_NOMEDIUM:
>> +            goto cmd_abort;
>>           }
>>
>>           if (ret) {
>> @@ -1271,6 +1281,8 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>>
>>    cmd_abort:
>>       spin_lock_irq(&md->lock);
>> +    if (mmc_card_removed(card))
>> +        req->cmd_flags |= REQ_QUIET;
>>       while (ret)
>>           ret = __blk_end_request(req, -EIO, blk_rq_cur_bytes(req));
>>       spin_unlock_irq(&md->lock);
>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>> index dcad59c..2517547 100644
>> --- a/drivers/mmc/card/queue.c
>> +++ b/drivers/mmc/card/queue.c
>> @@ -29,6 +29,8 @@
>>    */
>>   static int mmc_prep_request(struct request_queue *q, struct request *req)
>>   {
>> +    struct mmc_queue *mq = q->queuedata;
>> +
>>       /*
>>        * We only like normal block requests and discards.
>>        */
>> @@ -37,6 +39,9 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
>>           return BLKPREP_KILL;
>>       }
>>
>> +    if (mq&&  mmc_card_removed(mq->card))
>> +        return BLKPREP_KILL;
>> +
>>       req->cmd_flags |= REQ_DONTPREP;
>>
>>       return BLKPREP_OK;
> 
> 

