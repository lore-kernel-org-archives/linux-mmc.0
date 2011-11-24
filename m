From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH V2] mmc: Kill block requests if card is removed
Date: Thu, 24 Nov 2011 20:21:42 +0100
Message-ID: <CAFEEs1=1Ex=g9BOTXEWrX-HTau70S6ezfu0S9KXVn991S6AOmg@mail.gmail.com>
References: <1321959418-26864-1-git-send-email-sthumma@codeaurora.org>
	<CAFEEs1n5k-0MqJXanLN=S1uEfzqFxoeCHnT3Gs6DjJB6t5819Q@mail.gmail.com>
	<4ECE2A14.6070005@codeaurora.org>
	<CAFEEs1m2ySFhOKcu_TK8_pjag7zVQyM_DDt+Oxc_5P7E2HBkqQ@mail.gmail.com>
	<9067e7920f97a6def6ef574c597b13f9.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <9067e7920f97a6def6ef574c597b13f9.squirrel@www.codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, adrian.hunter@intel.com, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 24, 2011 at 7:48 PM, Sujit Reddy Thumma
<sthumma@codeaurora.org> wrote:
>
>> On Thu, Nov 24, 2011 at 12:27 PM, Sujit Reddy Thumma
>> <sthumma@codeaurora.org> wrote:
>>> Hi Per,
>>>
>>> On 11/22/2011 6:40 PM, Per Forlin wrote:
>>>>
>>>> Hi Sujit,
>>>>
>>>> On Tue, Nov 22, 2011 at 11:56 AM, Sujit Reddy Thumma
>>>> <sthumma@codeaurora.org> =A0wrote:
>>>>>
>>>>> Kill block requests when the host knows that the card is
>>>>> removed from the slot and is sure that subsequent requests
>>>>> are bound to fail. Do this silently so that the block
>>>>> layer doesn't output unnecessary error messages.
>>>>>
>>>>> This patch implements suggestion from Adrian Hunter,
>>>>> http://thread.gmane.org/gmane.linux.kernel.mmc/2714/focus=3D3474
>>>>>
>>>>> Signed-off-by: Sujit Reddy Thumma<sthumma@codeaurora.org>
>>>>>
>>>>> ---
>>>>> Changes in v2:
>>>>> =A0 =A0 =A0 =A0- Changed the implementation with further comments=
 from Adrian
>>>>> =A0 =A0 =A0 =A0- Set the card removed flag in bus notifier callba=
cks
>>>>> =A0 =A0 =A0 =A0- This patch is now dependent on patch from Per Fo=
rlin:
>>>>>
>>>>> =A0http://thread.gmane.org/gmane.linux.kernel.mmc/11128/focus=3D1=
1211
>>>>> ---
>>>>> =A0drivers/mmc/card/block.c | =A0 33 ++++++++++++++++++++++++++++=
-----
>>>>> =A0drivers/mmc/card/queue.c | =A0 =A05 +++++
>>>>> =A0drivers/mmc/core/bus.c =A0 | =A0 32 ++++++++++++++++++++++++++=
+++++-
>>>>> =A0drivers/mmc/core/core.c =A0| =A0 =A08 +++++++-
>>>>> =A0include/linux/mmc/card.h | =A0 =A03 +++
>>>>> =A05 files changed, 74 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>>>> index edc379e..83956fa 100644
>>>>> --- a/drivers/mmc/card/block.c
>>>>> +++ b/drivers/mmc/card/block.c
>>>>> @@ -648,8 +648,15 @@ static int mmc_blk_cmd_recovery(struct mmc_c=
ard
>>>>> *card, struct request *req,
>>>>> =A0 =A0 =A0 =A0}
>>>>>
>>>>> =A0 =A0 =A0 =A0/* We couldn't get a response from the card. =A0Gi=
ve up. */
>>>>> - =A0 =A0 =A0 if (err)
>>>>> + =A0 =A0 =A0 if (err) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If the card didn't respond to =
status command,
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it is likely that card is gone=
=2E Flag it as removed,
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* mmc_detect_change() cleans the=
 rest.
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_removed(card);
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_ABORT;
>>>>> + =A0 =A0 =A0 }
>>>>>
>>>>> =A0 =A0 =A0 =A0/* Flag ECC errors */
>>>>> =A0 =A0 =A0 =A0if ((status& =A0R1_CARD_ECC_FAILED) ||
>>>>> @@ -1168,6 +1175,9 @@ static inline struct mmc_async_req
>>>>> *mmc_blk_resend(struct mmc_card *card,
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int disable_multi,
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mmc_async_req
>>>>> *areq)
>>>>> =A0{
>>>>> + =A0 =A0 =A0 struct mmc_blk_data *md =3D mmc_get_drvdata(card);
>>>>> + =A0 =A0 =A0 struct request *req =3D mqrq->req;
>>>>> + =A0 =A0 =A0 int ret;
>>>>> =A0 =A0 =A0 =A0/*
>>>>> =A0 =A0 =A0 =A0 * Release host after failure in case the host is =
needed
>>>>> =A0 =A0 =A0 =A0 * by someone else. For instance, if the card is r=
emoved the
>>>>> @@ -1175,11 +1185,24 @@ static inline struct mmc_async_req
>>>>> *mmc_blk_resend(struct mmc_card *card,
>>>>> =A0 =A0 =A0 =A0 */
>>>>> =A0 =A0 =A0 =A0mmc_release_host(card->host);
>>>>> =A0 =A0 =A0 =A0mmc_claim_host(card->host);
>>>>> -
>>>>> - =A0 =A0 =A0 mmc_blk_rw_rq_prep(mqrq, card, disable_multi, mq);
>>>>> - =A0 =A0 =A0 return mmc_start_req(card->host, areq, NULL);
>>>>> + =A0 =A0 =A0 if (mmc_card_removed(card)) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* End the pending async request =
without starting
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it when card is removed.
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->cmd_flags |=3D REQ_QUIET;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_r=
equest(req,
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 -EIO, blk_rq_cur_bytes(req));
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (ret);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&md->lock);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>>>>> + =A0 =A0 =A0 } else {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mqrq, card, disa=
ble_multi, mq);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return mmc_start_req(card->host, ar=
eq, NULL);
>>>>> + =A0 =A0 =A0 }
>>>>
>>>> mmc_blk_resend is only called to resend a request that has failed.=
 If
>>>> the card is removed the request will still be issued, but when it
>>>> retries it will give up here.
>>>
>>> Currently, we set the card_removed flag in two places:
>>>
>>> 1) If the host supports interrupt detection, mmc_detect_change() ca=
lls
>>> the
>>> bus detect method and we set card removed flag in bus notifier call
>>> back.
>>>
>>> 2) When there is a transfer going on (host is claimed by mmcqd) and=
 the
>>> card
>>> is removed ungracefully, the driver sends an error code to the bloc=
k
>>> layer.
>>> mmc_blk_cmd_recovery() tries to send CMD13 to the card which in thi=
s
>>> case
>>> fails and we set the card_removed flag.
>>>
>>> So when we retry or send next async request we end it in
>>> mmc_blk_resend()
>>> and there will be no subsequent request to the driver since we are
>>> suppressing the requests in the queue layer.
>>>
>>> So I guess there is no need to add further checks in the
>>> __mmc_start_req(),
>>> which could be redundant as there are no calls to the core layer fr=
om
>>> block
>>> layer once the card is found to be removed.
>>>
>>> In summary the sequence I thought would be like this:
>>> Case 1:
>>> 1) Transfer is going on (host claimed by mmcqd) and card is removed=
=2E
>>> 2) Driver is in middle of transaction, hence some kind of timeout e=
rror
>>> is
>>> returned.
>>> 3) mmc_blk_cmd_recovery(): Block layer does error checking and sets=
 the
>>> card
>>> as removed.
>>> 4) Block layer then retries the request calling mmc_blk_resend().
>>> 5) Since the mmc_card_removed is true we end the request here and d=
o not
>>> send any request to the core.
>>>
>>> Case 2:
>>> 1) When there is no transfer going on (host->claimed =3D 0)
>>> 2) mmc_detect_change() would set card_removed flag.
>>> 3) All the subsequent requests would be killed in queue layer itsel=
f.
>>>
>>>> You have added a check in mmc_wait_for_req(). What about this:
>>>
>>> mmc_wait_for_req() will be called to send regular CMDs as well, hen=
ce we
>>> need to add a check.
>>>
>>>> --------------------------
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index b526036..dcdcb9a 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -287,11 +287,17 @@ static void mmc_wait_done(struct mmc_request
>>>> *mrq)
>>>> =A0 =A0 =A0 =A0 complete(&mrq->completion);
>>>> =A0}
>>>>
>>>> -static void __mmc_start_req(struct mmc_host *host, struct mmc_req=
uest
>>>> *mrq)
>>>> +static int __mmc_start_req(struct mmc_host *host, struct mmc_requ=
est
>>>> *mrq)
>>>> =A0{
>>>> - =A0 =A0 =A0 init_completion(&mrq->completion);
>>>> - =A0 =A0 =A0 mrq->done =3D mmc_wait_done;
>>>> - =A0 =A0 =A0 mmc_start_request(host, mrq);
>>>> + =A0 =A0 =A0 if (mmc_card_removed(host->card)) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0mrq->cmd->error =3D -ENOMEDIUM;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEDIUM;
>>>> + =A0 =A0 =A0 }
>>>
>>> This is not yet done here. If an async request comes then it will d=
o a
>>> wait_for_req_done() for the previous request which returned even wi=
thout
>>> doing a init_completion. So we need to handle this case in
>>> mmc_start_req().
>>>
>> You're right. Thanks for spotting this. init_completion and done mus=
t
>> be assigned.
>> The patch should look like this:
>> -------------------------------
>> init_completion(&mrq->completion);
>> mrq->done =3D mmc_wait_done;
>> if (mmc_card_removed(host->card)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0complete(&mrq->completion);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0mrq->cmd->error =3D -ENOMEDIUM;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEDIUM;
>> }
>> mmc_start_request(host, mrq);
>> -----------------------
>> What about this?
>
> Looks feasible.
>
>>
>>>> +
>>>> + =A0 =A0 =A0 init_completion(&mrq->completion);
>>>> + =A0 =A0 =A0 mrq->done =3D mmc_wait_done;
>>>> + =A0 =A0 =A0 mmc_start_request(host, mrq);
>>>> + =A0 =A0 =A0 return 0;
>>>> =A0}
>>>>
>>>> =A0static void mmc_wait_for_req_done(struct mmc_host *host,
>>>> @@ -418,7 +424,8 @@ EXPORT_SYMBOL(mmc_start_req);
>>>> =A0 */
>>>> =A0void mmc_wait_for_req(struct mmc_host *host, struct mmc_request=
 *mrq)
>>>> =A0{
>>>> - =A0 =A0 =A0 __mmc_start_req(host, mrq);
>>>> + =A0 =A0 =A0 if (__mmc_start_req(host, mrq))
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return
>>>> =A0 =A0 =A0 =A0 mmc_wait_for_req_done(host, mrq);
>>>> =A0}
>>>> =A0EXPORT_SYMBOL(mmc_wait_for_req);
>>>> ----------------------------------
>>>> This patch will set error to -ENOMEDIUM for both mmc_start_req() a=
nd
>>>> mmc_wait_for_req()
>>>>
>>>> mmc_blk_err_check() can check for -ENOMEDIUM and return something =
like
>>>> MMC_BLK_ENOMEDIUM
>>>
>>> If I understand correctly, the above patch handles a third case:
>>> 1) issue_fn is called by the queue layer (for the first request)
>>> 2) just before the mmcqd claims host card is removed and the
>>> mmc_detect_change has flagged the card as removed.
>>> 3) we send the request and before it was sent to host driver
>>> __mmc_start_req() sent -ENOMEDIUM and the block layer handles new e=
rror
>>> ENOMEDIUM.
>>>
>>> This is a valid case but increases the complexity as we need to tak=
e
>>> care of
>>> the async request which does not know we have returned prematurely
>>> without
>>> doing init_completion().
>> My intention is to simplify the error handling by checking
>> is-card-removed in __mmc_start_req() rather than both
>> mmc_wait_for_req() and mmc_start_req().
>>
>> Flow for async:
>> 0. *card is removed
>> 1. mmc_start_req()
>> 2. -> mmc_wait_for_req_done()
>> 3. ->->err_check()
>> 4. ->->->mmc_blk_cmd_recovery()
>> 5. ->->->->mmc_card_set_removed(card)
>> 6. skip start next request and returns
>> 7. new request from block layer
>
> I guess this new request wouldn't be arrived. Since,
> by now card removed flag is set and the blk_fetch_request()
> would always give req =3D NULL.
>
> We have already made sure to kill new requests in prepare stage itsel=
f:
>
Yes you are right. I forgot about that.

> @@ -37,6 +39,9 @@ static int mmc_prep_request(struct request_queue *q=
,
> struct request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return BLKPREP_KILL;
> =A0 =A0 =A0 }
>
> + =A0 =A0 =A0 if (mq && mmc_card_removed(mq->card))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return BLKPREP_KILL;
> +
> =A0 =A0 =A0 req->cmd_flags |=3D REQ_DONTPREP;
>
> Nevertheless, your patch looks feasible. Please let me know if I can =
add
> it or ignore.
>
I see, the change I proposed doesn't really solve anything. The only
reason for adding it would be to make the code cleaner.
Personally I don't mind a few extra error prints for both commands and
data transfers after the card has been removed as long as new requests
are stopped from coming in.
Two options
* add my change and add check for -ENOMEDIUM in the mmc_blk_err_check f=
unction.
* only check for card-is-removed in block_prep(), let ongoing
transfers try and fail.

Thanks,
Per
