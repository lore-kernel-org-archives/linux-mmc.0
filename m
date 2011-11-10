From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH] mmc: core: Kill block requests if card is removed
Date: Thu, 10 Nov 2011 09:32:50 +0530
Message-ID: <4EBB4CEA.1050901@codeaurora.org>
References: <1320813119-24383-1-git-send-email-sthumma@codeaurora.org> <4EBA4940.6030808@intel.com> <CAFEEs1nPe3=TFwdf8rbPk6AtWzMdfaKR=-Rv0OVJhnANX=3fUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:62119 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934250Ab1KJEC4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2011 23:02:56 -0500
In-Reply-To: <CAFEEs1nPe3=TFwdf8rbPk6AtWzMdfaKR=-Rv0OVJhnANX=3fUQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, cjb@laptop.org

Hi,
> Hi Adrian,
>
> On Wed, Nov 9, 2011 at 10:34 AM, Adrian Hunter<adrian.hunter@intel.com>  wrote:
>> On 09/11/11 06:31, Sujit Reddy Thumma wrote:
>>> Kill block requests when the host knows that the card is
>>> removed from the slot and is sure that subsequent requests
>>> are bound to fail. Do this silently so that the block
>>> layer doesn't output unnecessary error messages.
>>>
>>> This patch implements suggestion from Adrian Hunter,
>>> http://thread.gmane.org/gmane.linux.kernel.mmc/2714/focus=3474
>>>
>>> Signed-off-by: Sujit Reddy Thumma<sthumma@codeaurora.org>
>>> ---
>>
>>
>> It is safer to have zero initialisations so I suggest inverting
>> the meaning of the state bit i.e.

Makes sense. Will take care in V2.

>>
>> #define MMC_STATE_CARD_GONE     (1<<7)          /* card removed from the slot */
>>
>>
>> Also it would be nice is a request did not start if the card is
>> gone.  For the non-async case, that is easy:
>>
> As far as I understand Sujit's patch it will stop new requests from
> being issued, blk_fetch_request(q) returns NULL.

Yes, Per you are right. The ongoing requests will fail at the controller 
driver layer and only the new requests coming to MMC queue layer will be 
blocked.

Adrian's suggestion is to stop all the requests reaching host controller 
layer by mmc core. This seems to be a good approach but the problem here 
is the host driver should inform mmc core that card is gone.

Adrian, do you agree if we need to change all the host drivers to set 
the MMC_STATE_CARD_GONE flag as soon as the card detect irq handler 
detects the card as removed?

>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 5278ffb..91d7721 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -259,7 +259,7 @@ static void mmc_wait_for_req_done(struct mmc_host *host,
>>                 wait_for_completion(&mrq->completion);
>>
>>                 cmd = mrq->cmd;
>> -               if (!cmd->error || !cmd->retries)
>> +               if (!cmd->error || !cmd->retries || mmc_card_gone(host->card))
> host->card will be NULL

Yes, the host->card will be NULL for some requests. Will take care of it.

> static void mmc_remove(struct mmc_host *host)
> {
> 	BUG_ON(!host);
> 	BUG_ON(!host->card);
>
> 	mmc_remove_card(host->card);
> 	host->card = NULL;
> }
> card is not freed until later.
>
>>                         break;
>>
>>                 pr_debug("%s: req failed (CMD%u): %d, retrying...\n",
>> @@ -374,6 +374,10 @@ EXPORT_SYMBOL(mmc_start_req);
>>   */
>>   void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
>>   {
>> +       if (mmc_card_gone(host->card)) {
>> +               mrq->cmd->error = -ENODEV;
>> +               return;
>> +       }

Looks good. Just for clarification, some host controller drivers return 
-ENOMEDIUM in host->ops->request() when they see the card is gone. Do 
you think we can remove this now from host controller drivers?


>>         __mmc_start_req(host, mrq);
>>         mmc_wait_for_req_done(host, mrq);
>>   }
>>
>>
>>
>> The async case is harder...
>>
> I can help out with the non-async code if we go for your proposal.

I will check the possibilities.

>
>>
>>>   drivers/mmc/card/queue.c |    5 +++++
>>>   drivers/mmc/core/bus.c   |    2 ++
>>>   include/linux/mmc/card.h |    3 +++
>>>   3 files changed, 10 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>>> index dcad59c..f8a3298 100644
>>> --- a/drivers/mmc/card/queue.c
>>> +++ b/drivers/mmc/card/queue.c
>>> @@ -29,6 +29,8 @@
>>>    */
>>>   static int mmc_prep_request(struct request_queue *q, struct request *req)
>>>   {
>>> +     struct mmc_queue *mq = q->queuedata;
>>> +
>>>        /*
>>>         * We only like normal block requests and discards.
>>>         */
>>> @@ -37,6 +39,9 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
>>>                return BLKPREP_KILL;
>>>        }
>>>
>>> +     if (mq&&  mq->card&&  !mmc_card_inserted(mq->card))
>>> +             return BLKPREP_KILL;
>>> +
>>>        req->cmd_flags |= REQ_DONTPREP;
>>>
>>>        return BLKPREP_OK;
>>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>>> index 46b6e84..ea3be5d 100644
>>> --- a/drivers/mmc/core/bus.c
>>> +++ b/drivers/mmc/core/bus.c
>>> @@ -308,6 +308,7 @@ int mmc_add_card(struct mmc_card *card)
>>>                        mmc_card_ddr_mode(card) ? "DDR " : "",
>>>                        type, card->rca);
>>>        }
>>> +     mmc_card_set_inserted(card);
>>>
>>>   #ifdef CONFIG_DEBUG_FS
>>>        mmc_add_card_debugfs(card);
>>> @@ -340,6 +341,7 @@ void mmc_remove_card(struct mmc_card *card)
>>>                        pr_info("%s: card %04x removed\n",
>>>                                mmc_hostname(card->host), card->rca);
>>>                }
>>> +             card->state&= ~MMC_STATE_INSERTED;
>>>                device_del(&card->dev);
>>>        }
>>>
>>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>>> index b7a8cb1..be4125a 100644
>>> --- a/include/linux/mmc/card.h
>>> +++ b/include/linux/mmc/card.h
>>> @@ -209,6 +209,7 @@ struct mmc_card {
>>>   #define MMC_STATE_HIGHSPEED_DDR (1<<4)               /* card is in high speed mode */
>>>   #define MMC_STATE_ULTRAHIGHSPEED (1<<5)              /* card is in ultra high speed mode */
>>>   #define MMC_CARD_SDXC                (1<<6)          /* card is SDXC */
>>> +#define MMC_STATE_INSERTED   (1<<7)          /* card present in the slot */
>>>        unsigned int            quirks;         /* card quirks */
>>>   #define MMC_QUIRK_LENIENT_FN0        (1<<0)          /* allow SDIO FN0 writes outside of the VS CCCR range */
>>>   #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) /* use func->cur_blksize */
>>> @@ -362,6 +363,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
>>>   #define mmc_card_sdio(c)     ((c)->type == MMC_TYPE_SDIO)
>>>
>>>   #define mmc_card_present(c)  ((c)->state&  MMC_STATE_PRESENT)
>>> +#define mmc_card_inserted(c) ((c)->state&  MMC_STATE_INSERTED)
>>>   #define mmc_card_readonly(c) ((c)->state&  MMC_STATE_READONLY)
>>>   #define mmc_card_highspeed(c)        ((c)->state&  MMC_STATE_HIGHSPEED)
>>>   #define mmc_card_blockaddr(c)        ((c)->state&  MMC_STATE_BLOCKADDR)
>>> @@ -370,6 +372,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
>>>   #define mmc_card_ext_capacity(c) ((c)->state&  MMC_CARD_SDXC)
>>>
>>>   #define mmc_card_set_present(c)      ((c)->state |= MMC_STATE_PRESENT)
>>> +#define mmc_card_set_inserted(c) ((c)->state |= MMC_STATE_INSERTED)
>>>   #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
>>>   #define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
>>>   #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
>>


-- 
Thanks, Sujit
