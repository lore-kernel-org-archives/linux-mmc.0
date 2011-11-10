From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH] mmc: core: Kill block requests if card is removed
Date: Thu, 10 Nov 2011 11:01:58 +0530
Message-ID: <4EBB61CE.4090306@codeaurora.org>
References: <1320813119-24383-1-git-send-email-sthumma@codeaurora.org> <CAFEEs1=rbYKv9uWXJ0A-aD5bsUfHEYbBrc98hcB7o+C9b+nvNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:25034 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933629Ab1KJFcE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Nov 2011 00:32:04 -0500
In-Reply-To: <CAFEEs1=rbYKv9uWXJ0A-aD5bsUfHEYbBrc98hcB7o+C9b+nvNQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: linux-mmc@vger.kernel.org, adrian.hunter@intel.com, linux-arm-msm@vger.kernel.org, cjb@laptop.org

Hi Per,

On 11/10/2011 3:17 AM, Per Forlin wrote:
> Hi Sujit,
>
> On Wed, Nov 9, 2011 at 5:31 AM, Sujit Reddy Thumma
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
>> ---
>>   drivers/mmc/card/queue.c |    5 +++++
>>   drivers/mmc/core/bus.c   |    2 ++
>>   include/linux/mmc/card.h |    3 +++
>>   3 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>> index dcad59c..f8a3298 100644
>> --- a/drivers/mmc/card/queue.c
>> +++ b/drivers/mmc/card/queue.c
>> @@ -29,6 +29,8 @@
>>   */
>>   static int mmc_prep_request(struct request_queue *q, struct request *req)
>>   {
>> +       struct mmc_queue *mq = q->queuedata;
>> +
>>         /*
>>          * We only like normal block requests and discards.
>>          */
>> @@ -37,6 +39,9 @@ static int mmc_prep_request(struct request_queue *q, struct request *req)
>>                 return BLKPREP_KILL;
>>         }
>>
>> +       if (mq&&  mq->card&&  !mmc_card_inserted(mq->card))
> I guess the card is not freed until all pending requests have been
> flushed? mq->card will be valid as long as the queue is active.

Agreed. This is a redundant check, will remove it in v2.

>
> Another way to detect card removal is to subscribe for
> "BUS_NOTIFY_DEL_DEVICE" mmc card device.

Thanks, this sounds good, for the current v1 patch.
I have a concern about this when we take Adrian's suggestion. If we want 
to set the card gone flag as soon as the card is removed, then we can 
stop any new block request. Registering for BUS_NOTIFY_DEL_DEVICE only 
stops sync requests issued in device_del().

>
>> +               return BLKPREP_KILL;
>> +
>>         req->cmd_flags |= REQ_DONTPREP;
>>
>>         return BLKPREP_OK;
>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> index 46b6e84..ea3be5d 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -308,6 +308,7 @@ int mmc_add_card(struct mmc_card *card)
>>                         mmc_card_ddr_mode(card) ? "DDR " : "",
>>                         type, card->rca);
>>         }
>> +       mmc_card_set_inserted(card);
> If the card-alloction is freed when the card is removed. Is it
> necessary to set this bit for the new allocated card? Or could this be
> the same card allocation?
>
Adrian's suggestion, "It is safer to have zero initialisations so I 
suggest inverting the meaning of the state bit," I guess, answer your 
question. We set the card gone flag when the card is removed i.e., 
either in mmc_remove_card() or host driver's card detect irq handler and 
while card allocation is freed it is cleared anyways.

