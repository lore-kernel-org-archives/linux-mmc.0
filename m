From: "Sujit Reddy Thumma" <sthumma@codeaurora.org>
Subject: Re: [PATCH V2] mmc: Kill block requests if card is removed
Date: Thu, 24 Nov 2011 10:48:09 -0800 (PST)
Message-ID: <9067e7920f97a6def6ef574c597b13f9.squirrel@www.codeaurora.org>
References: <1321959418-26864-1-git-send-email-sthumma@codeaurora.org>
    <CAFEEs1n5k-0MqJXanLN=S1uEfzqFxoeCHnT3Gs6DjJB6t5819Q@mail.gmail.com>
    <4ECE2A14.6070005@codeaurora.org>
    <CAFEEs1m2ySFhOKcu_TK8_pjag7zVQyM_DDt+Oxc_5P7E2HBkqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAFEEs1m2ySFhOKcu_TK8_pjag7zVQyM_DDt+Oxc_5P7E2HBkqQ@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: linux-mmc@vger.kernel.org, adrian.hunter@intel.com, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org


> On Thu, Nov 24, 2011 at 12:27 PM, Sujit Reddy Thumma
> <sthumma@codeaurora.org> wrote:
>> Hi Per,
>>
>> On 11/22/2011 6:40 PM, Per Forlin wrote:
>>>
>>> Hi Sujit,
>>>
>>> On Tue, Nov 22, 2011 at 11:56 AM, Sujit Reddy Thumma
>>> <sthumma@codeaurora.org> =A0wrote:
>>>>
>>>> Kill block requests when the host knows that the card is
>>>> removed from the slot and is sure that subsequent requests
>>>> are bound to fail. Do this silently so that the block
>>>> layer doesn't output unnecessary error messages.
>>>>
>>>> This patch implements suggestion from Adrian Hunter,
>>>> http://thread.gmane.org/gmane.linux.kernel.mmc/2714/focus=3D3474
>>>>
>>>> Signed-off-by: Sujit Reddy Thumma<sthumma@codeaurora.org>
>>>>
>>>> ---
>>>> Changes in v2:
>>>> =A0 =A0 =A0 =A0- Changed the implementation with further comments =
from Adrian
>>>> =A0 =A0 =A0 =A0- Set the card removed flag in bus notifier callbac=
ks
>>>> =A0 =A0 =A0 =A0- This patch is now dependent on patch from Per For=
lin:
>>>> =A0 =A0 =A0
>>>> =A0http://thread.gmane.org/gmane.linux.kernel.mmc/11128/focus=3D11=
211
>>>> ---
>>>> =A0drivers/mmc/card/block.c | =A0 33 ++++++++++++++++++++++++++++-=
----
>>>> =A0drivers/mmc/card/queue.c | =A0 =A05 +++++
>>>> =A0drivers/mmc/core/bus.c =A0 | =A0 32 +++++++++++++++++++++++++++=
++++-
>>>> =A0drivers/mmc/core/core.c =A0| =A0 =A08 +++++++-
>>>> =A0include/linux/mmc/card.h | =A0 =A03 +++
>>>> =A05 files changed, 74 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>>> index edc379e..83956fa 100644
>>>> --- a/drivers/mmc/card/block.c
>>>> +++ b/drivers/mmc/card/block.c
>>>> @@ -648,8 +648,15 @@ static int mmc_blk_cmd_recovery(struct mmc_ca=
rd
>>>> *card, struct request *req,
>>>> =A0 =A0 =A0 =A0}
>>>>
>>>> =A0 =A0 =A0 =A0/* We couldn't get a response from the card. =A0Giv=
e up. */
>>>> - =A0 =A0 =A0 if (err)
>>>> + =A0 =A0 =A0 if (err) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If the card didn't respond to s=
tatus command,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it is likely that card is gone.=
 Flag it as removed,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* mmc_detect_change() cleans the =
rest.
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_removed(card);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_ABORT;
>>>> + =A0 =A0 =A0 }
>>>>
>>>> =A0 =A0 =A0 =A0/* Flag ECC errors */
>>>> =A0 =A0 =A0 =A0if ((status& =A0R1_CARD_ECC_FAILED) ||
>>>> @@ -1168,6 +1175,9 @@ static inline struct mmc_async_req
>>>> *mmc_blk_resend(struct mmc_card *card,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int disable_multi,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mmc_async_req
>>>> *areq)
>>>> =A0{
>>>> + =A0 =A0 =A0 struct mmc_blk_data *md =3D mmc_get_drvdata(card);
>>>> + =A0 =A0 =A0 struct request *req =3D mqrq->req;
>>>> + =A0 =A0 =A0 int ret;
>>>> =A0 =A0 =A0 =A0/*
>>>> =A0 =A0 =A0 =A0 * Release host after failure in case the host is n=
eeded
>>>> =A0 =A0 =A0 =A0 * by someone else. For instance, if the card is re=
moved the
>>>> @@ -1175,11 +1185,24 @@ static inline struct mmc_async_req
>>>> *mmc_blk_resend(struct mmc_card *card,
>>>> =A0 =A0 =A0 =A0 */
>>>> =A0 =A0 =A0 =A0mmc_release_host(card->host);
>>>> =A0 =A0 =A0 =A0mmc_claim_host(card->host);
>>>> -
>>>> - =A0 =A0 =A0 mmc_blk_rw_rq_prep(mqrq, card, disable_multi, mq);
>>>> - =A0 =A0 =A0 return mmc_start_req(card->host, areq, NULL);
>>>> + =A0 =A0 =A0 if (mmc_card_removed(card)) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* End the pending async request w=
ithout starting
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it when card is removed.
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->cmd_flags |=3D REQ_QUIET;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_re=
quest(req,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 -EIO, blk_rq_cur_bytes(req));
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (ret);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&md->lock);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>>>> + =A0 =A0 =A0 } else {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mqrq, card, disab=
le_multi, mq);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mmc_start_req(card->host, are=
q, NULL);
>>>> + =A0 =A0 =A0 }
>>>
>>> mmc_blk_resend is only called to resend a request that has failed. =
If
>>> the card is removed the request will still be issued, but when it
>>> retries it will give up here.
>>
>> Currently, we set the card_removed flag in two places:
>>
>> 1) If the host supports interrupt detection, mmc_detect_change() cal=
ls
>> the
>> bus detect method and we set card removed flag in bus notifier call
>> back.
>>
>> 2) When there is a transfer going on (host is claimed by mmcqd) and =
the
>> card
>> is removed ungracefully, the driver sends an error code to the block
>> layer.
>> mmc_blk_cmd_recovery() tries to send CMD13 to the card which in this
>> case
>> fails and we set the card_removed flag.
>>
>> So when we retry or send next async request we end it in
>> mmc_blk_resend()
>> and there will be no subsequent request to the driver since we are
>> suppressing the requests in the queue layer.
>>
>> So I guess there is no need to add further checks in the
>> __mmc_start_req(),
>> which could be redundant as there are no calls to the core layer fro=
m
>> block
>> layer once the card is found to be removed.
>>
>> In summary the sequence I thought would be like this:
>> Case 1:
>> 1) Transfer is going on (host claimed by mmcqd) and card is removed.
>> 2) Driver is in middle of transaction, hence some kind of timeout er=
ror
>> is
>> returned.
>> 3) mmc_blk_cmd_recovery(): Block layer does error checking and sets =
the
>> card
>> as removed.
>> 4) Block layer then retries the request calling mmc_blk_resend().
>> 5) Since the mmc_card_removed is true we end the request here and do=
 not
>> send any request to the core.
>>
>> Case 2:
>> 1) When there is no transfer going on (host->claimed =3D 0)
>> 2) mmc_detect_change() would set card_removed flag.
>> 3) All the subsequent requests would be killed in queue layer itself=
=2E
>>
>>> You have added a check in mmc_wait_for_req(). What about this:
>>
>> mmc_wait_for_req() will be called to send regular CMDs as well, henc=
e we
>> need to add a check.
>>
>>> --------------------------
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index b526036..dcdcb9a 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -287,11 +287,17 @@ static void mmc_wait_done(struct mmc_request
>>> *mrq)
>>> =A0 =A0 =A0 =A0 complete(&mrq->completion);
>>> =A0}
>>>
>>> -static void __mmc_start_req(struct mmc_host *host, struct mmc_requ=
est
>>> *mrq)
>>> +static int __mmc_start_req(struct mmc_host *host, struct mmc_reque=
st
>>> *mrq)
>>> =A0{
>>> - =A0 =A0 =A0 init_completion(&mrq->completion);
>>> - =A0 =A0 =A0 mrq->done =3D mmc_wait_done;
>>> - =A0 =A0 =A0 mmc_start_request(host, mrq);
>>> + =A0 =A0 =A0 if (mmc_card_removed(host->card)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0mrq->cmd->error =3D -ENOMEDIUM;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEDIUM;
>>> + =A0 =A0 =A0 }
>>
>> This is not yet done here. If an async request comes then it will do=
 a
>> wait_for_req_done() for the previous request which returned even wit=
hout
>> doing a init_completion. So we need to handle this case in
>> mmc_start_req().
>>
> You're right. Thanks for spotting this. init_completion and done must
> be assigned.
> The patch should look like this:
> -------------------------------
> init_completion(&mrq->completion);
> mrq->done =3D mmc_wait_done;
> if (mmc_card_removed(host->card)) {
>              complete(&mrq->completion);
>              mrq->cmd->error =3D -ENOMEDIUM;
>              return -ENOMEDIUM;
> }
> mmc_start_request(host, mrq);
> -----------------------
> What about this?

Looks feasible.

>
>>> +
>>> + =A0 =A0 =A0 init_completion(&mrq->completion);
>>> + =A0 =A0 =A0 mrq->done =3D mmc_wait_done;
>>> + =A0 =A0 =A0 mmc_start_request(host, mrq);
>>> + =A0 =A0 =A0 return 0;
>>> =A0}
>>>
>>> =A0static void mmc_wait_for_req_done(struct mmc_host *host,
>>> @@ -418,7 +424,8 @@ EXPORT_SYMBOL(mmc_start_req);
>>> =A0 */
>>> =A0void mmc_wait_for_req(struct mmc_host *host, struct mmc_request =
*mrq)
>>> =A0{
>>> - =A0 =A0 =A0 __mmc_start_req(host, mrq);
>>> + =A0 =A0 =A0 if (__mmc_start_req(host, mrq))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return
>>> =A0 =A0 =A0 =A0 mmc_wait_for_req_done(host, mrq);
>>> =A0}
>>> =A0EXPORT_SYMBOL(mmc_wait_for_req);
>>> ----------------------------------
>>> This patch will set error to -ENOMEDIUM for both mmc_start_req() an=
d
>>> mmc_wait_for_req()
>>>
>>> mmc_blk_err_check() can check for -ENOMEDIUM and return something l=
ike
>>> MMC_BLK_ENOMEDIUM
>>
>> If I understand correctly, the above patch handles a third case:
>> 1) issue_fn is called by the queue layer (for the first request)
>> 2) just before the mmcqd claims host card is removed and the
>> mmc_detect_change has flagged the card as removed.
>> 3) we send the request and before it was sent to host driver
>> __mmc_start_req() sent -ENOMEDIUM and the block layer handles new er=
ror
>> ENOMEDIUM.
>>
>> This is a valid case but increases the complexity as we need to take
>> care of
>> the async request which does not know we have returned prematurely
>> without
>> doing init_completion().
> My intention is to simplify the error handling by checking
> is-card-removed in __mmc_start_req() rather than both
> mmc_wait_for_req() and mmc_start_req().
>
> Flow for async:
> 0. *card is removed
> 1. mmc_start_req()
> 2. -> mmc_wait_for_req_done()
> 3. ->->err_check()
> 4. ->->->mmc_blk_cmd_recovery()
> 5. ->->->->mmc_card_set_removed(card)
> 6. skip start next request and returns
> 7. new request from block layer

I guess this new request wouldn't be arrived. Since,
by now card removed flag is set and the blk_fetch_request()
would always give req =3D NULL.

We have already made sure to kill new requests in prepare stage itself:

@@ -37,6 +39,9 @@ static int mmc_prep_request(struct request_queue *q,
struct request *req)
               return BLKPREP_KILL;
       }

+       if (mq && mmc_card_removed(mq->card))
+               return BLKPREP_KILL;
+
       req->cmd_flags |=3D REQ_DONTPREP;

Nevertheless, your patch looks feasible. Please let me know if I can ad=
d
it or ignore.

> 8. mmc_start_req()
> 9. ->__mmc_start_req()
> 10.new request from block layer
> 11. mmc_start_req()
> 12. -> mmc_wait_for_req_done() /* completion is already completed in
> __mmc_start_req(), checks card-is-removed and returns */
> 13. ->-> err_check() /* prints no warning since error is -ENOMEDIUM *=
/
>
>>
>> I guess we can live with this rare case with just outputting few err=
ors,
>> as
>> the whole idea of patch is to reduce (if not completely eliminate)
>> unnecessary prints in the log output which can bog down cpu if some
>> wired
>> peripheral like UART console is enabled.
>>
>> Please let me know if I am missing something.
>>
> Here's my case. in mmci.c: mmc_detect_change(host->mmc,
> msecs_to_jiffies(500));
> It takes 500 ms until mmc_rescan is called. Of course, I can change
> the timing but let's skip that part for now.
> This means the block layer will continue to issue requests for 500 ms
> after the card is ejected. There will be no warnings for the retries
> because the card-is-removed is checked in resend(), but for new
> incoming requests there will be error prints.
