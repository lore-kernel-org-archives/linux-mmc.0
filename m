From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH V2] mmc: Kill block requests if card is removed
Date: Thu, 24 Nov 2011 16:57:16 +0530
Message-ID: <4ECE2A14.6070005@codeaurora.org>
References: <1321959418-26864-1-git-send-email-sthumma@codeaurora.org> <CAFEEs1n5k-0MqJXanLN=S1uEfzqFxoeCHnT3Gs6DjJB6t5819Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:48016 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab1KXL1V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2011 06:27:21 -0500
In-Reply-To: <CAFEEs1n5k-0MqJXanLN=S1uEfzqFxoeCHnT3Gs6DjJB6t5819Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: linux-mmc@vger.kernel.org, adrian.hunter@intel.com, linux-arm-msm@vger.kernel.org, cjb@laptop.org

Hi Per,

On 11/22/2011 6:40 PM, Per Forlin wrote:
> Hi Sujit,
>
> On Tue, Nov 22, 2011 at 11:56 AM, Sujit Reddy Thumma
> <sthumma@codeaurora.org>  wrote:
>> Kill block requests when the host knows that the card is
>> removed from the slot and is sure that subsequent requests
>> are bound to fail. Do this silently so that the block
>> layer doesn't output unnecessary error messages.
>>
>> This patch implements suggestion from Adrian Hunter,
>> http://thread.gmane.org/gmane.linux.kernel.mmc/2714/focus=3474
>>
>> Signed-off-by: Sujit Reddy Thumma<sthumma@codeaurora.org>
>>
>> ---
>> Changes in v2:
>>         - Changed the implementation with further comments from Adrian
>>         - Set the card removed flag in bus notifier callbacks
>>         - This patch is now dependent on patch from Per Forlin:
>>         http://thread.gmane.org/gmane.linux.kernel.mmc/11128/focus=11211
>> ---
>>   drivers/mmc/card/block.c |   33 ++++++++++++++++++++++++++++-----
>>   drivers/mmc/card/queue.c |    5 +++++
>>   drivers/mmc/core/bus.c   |   32 +++++++++++++++++++++++++++++++-
>>   drivers/mmc/core/core.c  |    8 +++++++-
>>   include/linux/mmc/card.h |    3 +++
>>   5 files changed, 74 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index edc379e..83956fa 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -648,8 +648,15 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
>>         }
>>
>>         /* We couldn't get a response from the card.  Give up. */
>> -       if (err)
>> +       if (err) {
>> +               /*
>> +                * If the card didn't respond to status command,
>> +                * it is likely that card is gone. Flag it as removed,
>> +                * mmc_detect_change() cleans the rest.
>> +                */
>> +               mmc_card_set_removed(card);
>>                 return ERR_ABORT;
>> +       }
>>
>>         /* Flag ECC errors */
>>         if ((status&  R1_CARD_ECC_FAILED) ||
>> @@ -1168,6 +1175,9 @@ static inline struct mmc_async_req *mmc_blk_resend(struct mmc_card *card,
>>                                                    int disable_multi,
>>                                                    struct mmc_async_req *areq)
>>   {
>> +       struct mmc_blk_data *md = mmc_get_drvdata(card);
>> +       struct request *req = mqrq->req;
>> +       int ret;
>>         /*
>>          * Release host after failure in case the host is needed
>>          * by someone else. For instance, if the card is removed the
>> @@ -1175,11 +1185,24 @@ static inline struct mmc_async_req *mmc_blk_resend(struct mmc_card *card,
>>          */
>>         mmc_release_host(card->host);
>>         mmc_claim_host(card->host);
>> -
>> -       mmc_blk_rw_rq_prep(mqrq, card, disable_multi, mq);
>> -       return mmc_start_req(card->host, areq, NULL);
>> +       if (mmc_card_removed(card)) {
>> +               /*
>> +                * End the pending async request without starting
>> +                * it when card is removed.
>> +                */
>> +               spin_lock_irq(&md->lock);
>> +               req->cmd_flags |= REQ_QUIET;
>> +               do {
>> +                       ret = __blk_end_request(req,
>> +                                       -EIO, blk_rq_cur_bytes(req));
>> +               } while (ret);
>> +               spin_unlock_irq(&md->lock);
>> +               return NULL;
>> +       } else {
>> +               mmc_blk_rw_rq_prep(mqrq, card, disable_multi, mq);
>> +               return mmc_start_req(card->host, areq, NULL);
>> +       }
> mmc_blk_resend is only called to resend a request that has failed. If
> the card is removed the request will still be issued, but when it
> retries it will give up here.

Currently, we set the card_removed flag in two places:

1) If the host supports interrupt detection, mmc_detect_change() calls 
the bus detect method and we set card removed flag in bus notifier call 
back.

2) When there is a transfer going on (host is claimed by mmcqd) and the 
card is removed ungracefully, the driver sends an error code to the 
block layer. mmc_blk_cmd_recovery() tries to send CMD13 to the card 
which in this case fails and we set the card_removed flag.

So when we retry or send next async request we end it in 
mmc_blk_resend() and there will be no subsequent request to the driver 
since we are suppressing the requests in the queue layer.

So I guess there is no need to add further checks in the 
__mmc_start_req(), which could be redundant as there are no calls to the 
core layer from block layer once the card is found to be removed.

In summary the sequence I thought would be like this:
Case 1:
1) Transfer is going on (host claimed by mmcqd) and card is removed.
2) Driver is in middle of transaction, hence some kind of timeout error 
is returned.
3) mmc_blk_cmd_recovery(): Block layer does error checking and sets the 
card as removed.
4) Block layer then retries the request calling mmc_blk_resend().
5) Since the mmc_card_removed is true we end the request here and do not 
send any request to the core.

Case 2:
1) When there is no transfer going on (host->claimed = 0)
2) mmc_detect_change() would set card_removed flag.
3) All the subsequent requests would be killed in queue layer itself.

> You have added a check in mmc_wait_for_req(). What about this:

mmc_wait_for_req() will be called to send regular CMDs as well, hence we 
need to add a check.

> --------------------------
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index b526036..dcdcb9a 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -287,11 +287,17 @@ static void mmc_wait_done(struct mmc_request *mrq)
>          complete(&mrq->completion);
>   }
>
> -static void __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
> +static int __mmc_start_req(struct mmc_host *host, struct mmc_request *mrq)
>   {
> -       init_completion(&mrq->completion);
> -       mrq->done = mmc_wait_done;
> -       mmc_start_request(host, mrq);
> +       if (mmc_card_removed(host->card)) {
> +              mrq->cmd->error = -ENOMEDIUM;
> +              return -ENOMEDIUM;
> +       }

This is not yet done here. If an async request comes then it will do a 
wait_for_req_done() for the previous request which returned even without 
doing a init_completion. So we need to handle this case in mmc_start_req().

> +
> +       init_completion(&mrq->completion);
> +       mrq->done = mmc_wait_done;
> +       mmc_start_request(host, mrq);
> +       return 0;
>   }
>
>   static void mmc_wait_for_req_done(struct mmc_host *host,
> @@ -418,7 +424,8 @@ EXPORT_SYMBOL(mmc_start_req);
>    */
>   void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
>   {
> -       __mmc_start_req(host, mrq);
> +       if (__mmc_start_req(host, mrq))
> +               return
>          mmc_wait_for_req_done(host, mrq);
>   }
>   EXPORT_SYMBOL(mmc_wait_for_req);
> ----------------------------------
> This patch will set error to -ENOMEDIUM for both mmc_start_req() and
> mmc_wait_for_req()
>
> mmc_blk_err_check() can check for -ENOMEDIUM and return something like
> MMC_BLK_ENOMEDIUM

If I understand correctly, the above patch handles a third case:
1) issue_fn is called by the queue layer (for the first request)
2) just before the mmcqd claims host card is removed and the 
mmc_detect_change has flagged the card as removed.
3) we send the request and before it was sent to host driver 
__mmc_start_req() sent -ENOMEDIUM and the block layer handles new error 
ENOMEDIUM.

This is a valid case but increases the complexity as we need to take 
care of the async request which does not know we have returned 
prematurely without doing init_completion().

I guess we can live with this rare case with just outputting few errors, 
as the whole idea of patch is to reduce (if not completely eliminate) 
unnecessary prints in the log output which can bog down cpu if some 
wired peripheral like UART console is enabled.

Please let me know if I am missing something.

> And eventually do
> +               /*
> +                * End the pending async request without starting
> +                * it when card is removed.
> +                */
> +               spin_lock_irq(&md->lock);
> +               req->cmd_flags |= REQ_QUIET;
> +               do {
> +                       ret = __blk_end_request(req,
> +                                       -EIO, blk_rq_cur_bytes(req));
> +               } while (ret);
> +               spin_unlock_irq(&md->lock);
>
> Regards,
> Per


-- 
Thanks,
Sujit
