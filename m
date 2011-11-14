From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH] mmc: core: Kill block requests if card is removed
Date: Mon, 14 Nov 2011 14:16:46 +0530
Message-ID: <4EC0D576.6070000@codeaurora.org>
References: <1320813119-24383-1-git-send-email-sthumma@codeaurora.org> <4EBA4940.6030808@intel.com> <CAFEEs1nPe3=TFwdf8rbPk6AtWzMdfaKR=-Rv0OVJhnANX=3fUQ@mail.gmail.com> <4EBB4CEA.1050901@codeaurora.org> <4EBB9AE1.2060909@intel.com> <CAFEEs1nFkWv5x1RbJ923JJk9C3A3XX84k+=RT1+rd9S1rau99A@mail.gmail.com> <4EC096CE.7000003@codeaurora.org> <CAFEEs1mD9pSBrZrC5GPLVcEywS9uHbZtTd2inzU7uYSUMF+2Kg@mail.gmail.com> <CAFEEs1kXy4GB-kWZ++v7tBPeDj=HJqj+Tcv+tnmvV_O86xbuBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAFEEs1kXy4GB-kWZ++v7tBPeDj=HJqj+Tcv+tnmvV_O86xbuBA@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

On 11/14/2011 1:54 PM, Per Forlin wrote:
> On Mon, Nov 14, 2011 at 8:52 AM, Per Forlin<per.lkml@gmail.com>  wrote:
>> On Mon, Nov 14, 2011 at 5:19 AM, Sujit Reddy Thumma
>> <sthumma@codeaurora.org>  wrote:
>>> On 11/10/2011 7:50 PM, Per Forlin wrote:
>>>>
>>>> On Thu, Nov 10, 2011 at 10:35 AM, Adrian Hunter<adrian.hunter@intel.com>
>>>>   wrote:
>>>>>
>>>>> On 10/11/11 06:02, Sujit Reddy Thumma wrote:
>>>>>>
>>>>>> Hi,
>>>>>>>
>>>>>>> Hi Adrian,
>>>>>>>
>>>>>>> On Wed, Nov 9, 2011 at 10:34 AM, Adrian Hunter<adrian.hunter@intel.com>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>> On 09/11/11 06:31, Sujit Reddy Thumma wrote:
>>>>>>>>>
>>>>>>>>> Kill block requests when the host knows that the card is
>>>>>>>>> removed from the slot and is sure that subsequent requests
>>>>>>>>> are bound to fail. Do this silently so that the block
>>>>>>>>> layer doesn't output unnecessary error messages.
>>>>>>>>>
>>>>>>>>> This patch implements suggestion from Adrian Hunter,
>>>>>>>>> http://thread.gmane.org/gmane.linux.kernel.mmc/2714/focus=3474
>>>>>>>>>
>>>>>>>>> Signed-off-by: Sujit Reddy Thumma<sthumma@codeaurora.org>
>>>>>>>>> ---
>>>>>>>>
>>>>>>>>
>>>>>>>> It is safer to have zero initialisations so I suggest inverting
>>>>>>>> the meaning of the state bit i.e.
>>>>>>
>>>>>> Makes sense. Will take care in V2.
>>>>>>
>>>>>>>>
>>>>>>>> #define MMC_STATE_CARD_GONE     (1<<7)          /* card removed from
>>>>>>>> the
>>>>>>>> slot */
>>>>>>>>
>>>>>>>>
>>>>>>>> Also it would be nice is a request did not start if the card is
>>>>>>>> gone.  For the non-async case, that is easy:
>>>>>>>>
>>>>>>> As far as I understand Sujit's patch it will stop new requests from
>>>>>>> being issued, blk_fetch_request(q) returns NULL.
>>>>>>
>>>>>> Yes, Per you are right. The ongoing requests will fail at the controller
>>>>>> driver layer and only the new requests coming to MMC queue layer will be
>>>>>> blocked.
>>>>>>
>>>>>> Adrian's suggestion is to stop all the requests reaching host controller
>>>>>> layer by mmc core. This seems to be a good approach but the problem here
>>>>>> is
>>>>>> the host driver should inform mmc core that card is gone.
>>>>>>
>>>>>> Adrian, do you agree if we need to change all the host drivers to set
>>>>>> the
>>>>>> MMC_STATE_CARD_GONE flag as soon as the card detect irq handler detects
>>>>>> the
>>>>>> card as removed?
>>>>>
>>>>> Typically a card detect interrupt queues a rescan which in turn will have
>>>>> to wait to claim the host.  In the meantime, in the async case, the block
>>>>> driver will not release the host until the queue is empty.
>>>>
>>>> Here is a patch that let async-mmc release host and reclaim it in case of
>>>> error.
>>>> When the host is released mmc_rescan will claim the host and run.
>>>> --------------------------------
>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>>> index cf73877..8952e63 100644
>>>> --- a/drivers/mmc/card/block.c
>>>> +++ b/drivers/mmc/card/block.c
>>>> @@ -1209,6 +1209,28 @@ static int mmc_blk_cmd_err(struct mmc_blk_data
>>>> *md, struct mmc_card *card,
>>>>         return ret;
>>>>   }
>>>>
>>>> +/*
>>>> + * This function should be called to resend a request after failure.
>>>> + * Prepares and starts the request.
>>>> + */
>>>> +static inline struct mmc_async_req *mmc_blk_resend(struct mmc_card *card,
>>>> +                                                  struct mmc_queue *mq,
>>>> +                                                  struct mmc_queue_req
>>>> *mqrq,
>>>> +                                                  int disable_multi,
>>>> +                                                  struct mmc_async_req
>>>> *areq)
>>>> +{
>>>> +       /*
>>>> +        * Release host after failure in case the host is needed
>>>> +        * by someone else. For instance, if the card is removed the
>>>> +        * worker thread needs to claim the host in order to do
>>>> mmc_rescan.
>>>> +        */
>>>> +       mmc_release_host(card->host);
>>>> +       mmc_claim_host(card->host);
>>>> +
>>>> +       mmc_blk_rw_rq_prep(mqrq, card, disable_multi, mq);
>>>> +       return mmc_start_req(card->host, areq, NULL);
>>>> +}
>>>> +
>>>>   static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>>>>   {
>>>>         struct mmc_blk_data *md = mq->data;
>>>> @@ -1308,14 +1330,14 @@ static int mmc_blk_issue_rw_rq(struct
>>>> mmc_queue *mq, struct request *rqc)
>>>>                         break;
>>>>                 }
>>>>
>>>> -               if (ret) {
>>>> +               if (ret)
>>>>                         /*
>>>>                          * In case of a incomplete request
>>>>                          * prepare it again and resend.
>>>>                          */
>>>> -                       mmc_blk_rw_rq_prep(mq_rq, card, disable_multi,
>>>> mq);
>>>> -                       mmc_start_req(card->host,&mq_rq->mmc_active,
>>>> NULL);
>>>> -               }
>>>> +                       mmc_blk_prep_start(card, mq, mq_rq, disable_multi,
>>>> +&mq_rq->mmc_active);
>>>> +
>>>
>>> :%s/mmc_blk_prep_start/mmc_blk_resend
>>>
>> I'll update.
>>
>>>>         } while (ret);
>>>>
>>>>         return 1;
>>>> @@ -1327,10 +1349,9 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
>>>> *mq, struct request *rqc)
>>>>         spin_unlock_irq(&md->lock);
>>>>
>>>>    start_new_req:
>>>> -       if (rqc) {
>>>> -               mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
>>>> -               mmc_start_req(card->host,&mq->mqrq_cur->mmc_active, NULL);
>>>> -       }
>>>> +       if (rqc)
>>>> +               mmc_blk_prep_start(card, mq, mq->mqrq_cur, 0,
>>>> +&mq->mqrq_cur->mmc_active);
>>>>
>>>>         return 0;
>>>>   }
>>>
>>> Thanks Per. This looks good. Can we split this into a different patch?
>>>
>> Yes I agree. My intention was to treat this as a separate patch.
>> I'll post it.
>>
>>>> -------------------------------------
>>>>
>>>>
>>>>>   The block
>>>>> driver will see errors and will use a send status command which will fail
>>>>> so the request will be aborted, but the next request will be started
>>>>> anyway.
>>>>>
>>>>> There are two problems:
>>>>>
>>>>> 1. When do we reliably know that the card has really gone?
>>>>>
>>>>> At present, the detect method for SD and MMC is just the send status
>>>>> command, which is what the block driver is doing i.e. if the block
>>>>> driver sees send status fail, after an errored request, and the
>>>>> card is removable, then it is very likely the card has gone.
>>>>>
>>>>> At present, it is not considered that the host controller driver
>>>>> knows whether the card is really gone - just that it might be.
>>>>>
>>>>> Setting a MMC_STATE_CARD_GONE flag early may be a little complicated.
>>>>> e.g. mmc_detect_change() flags that the card may be gone.  After an
>>>>> error, if the "card may be gone" flag is set a new bus method could
>>>>> be called that just does send status.  If that fails, then the
>>>>> MMC_STATE_CARD_GONE flag is set.  Any calls to the detect method
>>>>> must first check the MMC_STATE_CARD_GONE flag so that, once gone,
>>>>> a card can not come back.
>>>>>
>>>>> Maybe you can think of something simpler.
>>>
>>> Can we do something like this:
>>>
>>> --- a/drivers/mmc/card/block.c
>>> +++ b/drivers/mmc/card/block.c
>>> @@ -648,8 +648,15 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card,
>>> struct request *req,
>>>         }
>>>
>>>         /* We couldn't get a response from the card.  Give up. */
>>> -       if (err)
>>> +       if (err) {
>>> +               /*
>>> +                * If the card didn't respond to status command,
>>> +                * it is likely that card is gone. Flag it as removed,
>>> +                * mmc_detect_change() cleans the rest.
>>> +                */
>>> +               mmc_card_set_card_gone(card);
>>>                 return ERR_ABORT;
>>> +       }
>>>
>>>         /* Flag ECC errors */
>>>         if ((status&  R1_CARD_ECC_FAILED) ||
>>>
>>> and some additions to Per's patch, changes denoted in (++):
>>>
>>> +/*
>>> + * This function should be called to resend a request after failure.
>>> + * Prepares and starts the request.
>>> + */
>>> +static inline struct mmc_async_req *mmc_blk_resend(struct mmc_card *card,
>>> +                                                  struct mmc_queue *mq,
>>> +                                                  struct mmc_queue_req
>>> *mqrq,
>>> +                                                  int disable_multi,
>>> +                                                  struct mmc_async_req
>>> *areq)
>>> +{
>>> +       /*
>>> +        * Release host after failure in case the host is needed
>>> +        * by someone else. For instance, if the card is removed the
>>> +        * worker thread needs to claim the host in order to do mmc_rescan.
>>> +        */
>>> +       mmc_release_host(card->host);
>>> +       mmc_claim_host(card->host);
>>> ++      if (mmc_card_gone(card)) {
>>> ++      /*
>>> ++       * End the pending async request without starting it when card
>>> ++       * is removed.
>>> ++       */
>>> ++              req->cmd_flags |= REQ_QUIET;
>>> ++              __blk_end_request(req, -EIO, blk_rq_cur_bytes(req));
>> I'll add this to the patch and send it out.
> I'll wait adding this since mmc_card_gone() is not available yet.
> Maybe we should send these two patches (aync error release and kill
> block request) in the same patch-set?

I think we can split this up without having this change in your patch. I 
can add this as part of kill block request change itself which makes 
your patch independent.

>
> Thanks,
> Per


-- 
Thanks,
Sujit
