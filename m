From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH] mmc: core: Kill block requests if card is removed
Date: Mon, 14 Nov 2011 08:52:43 +0100
Message-ID: <CAFEEs1mD9pSBrZrC5GPLVcEywS9uHbZtTd2inzU7uYSUMF+2Kg@mail.gmail.com>
References: <1320813119-24383-1-git-send-email-sthumma@codeaurora.org>
	<4EBA4940.6030808@intel.com>
	<CAFEEs1nPe3=TFwdf8rbPk6AtWzMdfaKR=-Rv0OVJhnANX=3fUQ@mail.gmail.com>
	<4EBB4CEA.1050901@codeaurora.org>
	<4EBB9AE1.2060909@intel.com>
	<CAFEEs1nFkWv5x1RbJ923JJk9C3A3XX84k+=RT1+rd9S1rau99A@mail.gmail.com>
	<4EC096CE.7000003@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <4EC096CE.7000003@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Nov 14, 2011 at 5:19 AM, Sujit Reddy Thumma
<sthumma@codeaurora.org> wrote:
> On 11/10/2011 7:50 PM, Per Forlin wrote:
>>
>> On Thu, Nov 10, 2011 at 10:35 AM, Adrian Hunter<adrian.hunter@intel.=
com>
>> =A0wrote:
>>>
>>> On 10/11/11 06:02, Sujit Reddy Thumma wrote:
>>>>
>>>> Hi,
>>>>>
>>>>> Hi Adrian,
>>>>>
>>>>> On Wed, Nov 9, 2011 at 10:34 AM, Adrian Hunter<adrian.hunter@inte=
l.com>
>>>>> wrote:
>>>>>>
>>>>>> On 09/11/11 06:31, Sujit Reddy Thumma wrote:
>>>>>>>
>>>>>>> Kill block requests when the host knows that the card is
>>>>>>> removed from the slot and is sure that subsequent requests
>>>>>>> are bound to fail. Do this silently so that the block
>>>>>>> layer doesn't output unnecessary error messages.
>>>>>>>
>>>>>>> This patch implements suggestion from Adrian Hunter,
>>>>>>> http://thread.gmane.org/gmane.linux.kernel.mmc/2714/focus=3D347=
4
>>>>>>>
>>>>>>> Signed-off-by: Sujit Reddy Thumma<sthumma@codeaurora.org>
>>>>>>> ---
>>>>>>
>>>>>>
>>>>>> It is safer to have zero initialisations so I suggest inverting
>>>>>> the meaning of the state bit i.e.
>>>>
>>>> Makes sense. Will take care in V2.
>>>>
>>>>>>
>>>>>> #define MMC_STATE_CARD_GONE =A0 =A0 (1<<7) =A0 =A0 =A0 =A0 =A0/*=
 card removed from
>>>>>> the
>>>>>> slot */
>>>>>>
>>>>>>
>>>>>> Also it would be nice is a request did not start if the card is
>>>>>> gone. =A0For the non-async case, that is easy:
>>>>>>
>>>>> As far as I understand Sujit's patch it will stop new requests fr=
om
>>>>> being issued, blk_fetch_request(q) returns NULL.
>>>>
>>>> Yes, Per you are right. The ongoing requests will fail at the cont=
roller
>>>> driver layer and only the new requests coming to MMC queue layer w=
ill be
>>>> blocked.
>>>>
>>>> Adrian's suggestion is to stop all the requests reaching host cont=
roller
>>>> layer by mmc core. This seems to be a good approach but the proble=
m here
>>>> is
>>>> the host driver should inform mmc core that card is gone.
>>>>
>>>> Adrian, do you agree if we need to change all the host drivers to =
set
>>>> the
>>>> MMC_STATE_CARD_GONE flag as soon as the card detect irq handler de=
tects
>>>> the
>>>> card as removed?
>>>
>>> Typically a card detect interrupt queues a rescan which in turn wil=
l have
>>> to wait to claim the host. =A0In the meantime, in the async case, t=
he block
>>> driver will not release the host until the queue is empty.
>>
>> Here is a patch that let async-mmc release host and reclaim it in ca=
se of
>> error.
>> When the host is released mmc_rescan will claim the host and run.
>> --------------------------------
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index cf73877..8952e63 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1209,6 +1209,28 @@ static int mmc_blk_cmd_err(struct mmc_blk_dat=
a
>> *md, struct mmc_card *card,
>> =A0 =A0 =A0 =A0return ret;
>> =A0}
>>
>> +/*
>> + * This function should be called to resend a request after failure=
=2E
>> + * Prepares and starts the request.
>> + */
>> +static inline struct mmc_async_req *mmc_blk_resend(struct mmc_card =
*card,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mmc_queue *mq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mmc_queue_req
>> *mqrq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int disable_multi,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mmc_async_req
>> *areq)
>> +{
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Release host after failure in case the host is ne=
eded
>> + =A0 =A0 =A0 =A0* by someone else. For instance, if the card is rem=
oved the
>> + =A0 =A0 =A0 =A0* worker thread needs to claim the host in order to=
 do
>> mmc_rescan.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 mmc_release_host(card->host);
>> + =A0 =A0 =A0 mmc_claim_host(card->host);
>> +
>> + =A0 =A0 =A0 mmc_blk_rw_rq_prep(mqrq, card, disable_multi, mq);
>> + =A0 =A0 =A0 return mmc_start_req(card->host, areq, NULL);
>> +}
>> +
>> =A0static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct reque=
st *rqc)
>> =A0{
>> =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mq->data;
>> @@ -1308,14 +1330,14 @@ static int mmc_blk_issue_rw_rq(struct
>> mmc_queue *mq, struct request *rqc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * In case of a incom=
plete request
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * prepare it again a=
nd resend.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mq_=
rq, card, disable_multi,
>> mq);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_req(card->ho=
st,&mq_rq->mmc_active,
>> NULL);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_prep_start(car=
d, mq, mq_rq, disable_multi,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &mq_rq->mmc_active);
>> +
>
> :%s/mmc_blk_prep_start/mmc_blk_resend
>
I'll update.

>> =A0 =A0 =A0 =A0} while (ret);
>>
>> =A0 =A0 =A0 =A0return 1;
>> @@ -1327,10 +1349,9 @@ static int mmc_blk_issue_rw_rq(struct mmc_que=
ue
>> *mq, struct request *rqc)
>> =A0 =A0 =A0 =A0spin_unlock_irq(&md->lock);
>>
>> =A0 start_new_req:
>> - =A0 =A0 =A0 if (rqc) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mq->mqrq_cur, card,=
 0, mq);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_req(card->host,&mq->mqrq_cur=
->mmc_active, NULL);
>> - =A0 =A0 =A0 }
>> + =A0 =A0 =A0 if (rqc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_prep_start(card, mq, mq->mqrq_=
cur, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &mq->m=
qrq_cur->mmc_active);
>>
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>
> Thanks Per. This looks good. Can we split this into a different patch=
?
>
Yes I agree. My intention was to treat this as a separate patch.
I'll post it.

>> -------------------------------------
>>
>>
>>> =A0The block
>>> driver will see errors and will use a send status command which wil=
l fail
>>> so the request will be aborted, but the next request will be starte=
d
>>> anyway.
>>>
>>> There are two problems:
>>>
>>> 1. When do we reliably know that the card has really gone?
>>>
>>> At present, the detect method for SD and MMC is just the send statu=
s
>>> command, which is what the block driver is doing i.e. if the block
>>> driver sees send status fail, after an errored request, and the
>>> card is removable, then it is very likely the card has gone.
>>>
>>> At present, it is not considered that the host controller driver
>>> knows whether the card is really gone - just that it might be.
>>>
>>> Setting a MMC_STATE_CARD_GONE flag early may be a little complicate=
d.
>>> e.g. mmc_detect_change() flags that the card may be gone. =A0After =
an
>>> error, if the "card may be gone" flag is set a new bus method could
>>> be called that just does send status. =A0If that fails, then the
>>> MMC_STATE_CARD_GONE flag is set. =A0Any calls to the detect method
>>> must first check the MMC_STATE_CARD_GONE flag so that, once gone,
>>> a card can not come back.
>>>
>>> Maybe you can think of something simpler.
>
> Can we do something like this:
>
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -648,8 +648,15 @@ static int mmc_blk_cmd_recovery(struct mmc_card =
*card,
> struct request *req,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* We couldn't get a response from the card. =A0Give u=
p. */
> - =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If the card didn't respond to stat=
us command,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it is likely that card is gone. Fl=
ag it as removed,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* mmc_detect_change() cleans the res=
t.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_card_gone(card);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_ABORT;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* Flag ECC errors */
> =A0 =A0 =A0 =A0if ((status & R1_CARD_ECC_FAILED) ||
>
> and some additions to Per's patch, changes denoted in (++):
>
> +/*
> + * This function should be called to resend a request after failure.
> + * Prepares and starts the request.
> + */
> +static inline struct mmc_async_req *mmc_blk_resend(struct mmc_card *=
card,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mmc_queue *mq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mmc_queue_req
> *mqrq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int disable_multi,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mmc_async_req
> *areq)
> +{
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Release host after failure in case the host is nee=
ded
> + =A0 =A0 =A0 =A0* by someone else. For instance, if the card is remo=
ved the
> + =A0 =A0 =A0 =A0* worker thread needs to claim the host in order to =
do mmc_rescan.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 mmc_release_host(card->host);
> + =A0 =A0 =A0 mmc_claim_host(card->host);
> ++ =A0 =A0 =A0if (mmc_card_gone(card)) {
> ++ =A0 =A0 =A0/*
> ++ =A0 =A0 =A0 * End the pending async request without starting it wh=
en card
> ++ =A0 =A0 =A0 * is removed.
> ++ =A0 =A0 =A0 */
> ++ =A0 =A0 =A0 =A0 =A0 =A0 =A0req->cmd_flags |=3D REQ_QUIET;
> ++ =A0 =A0 =A0 =A0 =A0 =A0 =A0__blk_end_request(req, -EIO, blk_rq_cur=
_bytes(req));
I'll add this to the patch and send it out.


Thanks,
Per
