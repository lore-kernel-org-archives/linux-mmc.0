From: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>
Subject: Re: [PATCH] mmc: core: Clean up after mmc_pre_req if card was removed
Date: Mon, 5 Mar 2012 09:35:08 +0100
Message-ID: <4F547ABC.4060201@stericsson.com>
References: <1330616671-11952-1-git-send-email-ulf.hansson@stericsson.com> <4F508493.2000107@samsung.com> <4F508A24.50707@stericsson.com> <4F50E766.9030802@stericsson.com> <4F544A43.8020601@samsung.com> <4F54586E.3020907@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog118.obsmtp.com ([207.126.144.145]:37563 "EHLO
	eu1sys200aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754891Ab2CEIg1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Mar 2012 03:36:27 -0500
In-Reply-To: <4F54586E.3020907@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On 03/05/2012 07:08 AM, Jaehoon Chung wrote:
> On 03/05/2012 02:08 PM, Jaehoon Chung wrote:
>=20
>> On 03/03/2012 12:29 AM, Per F=F6rlin wrote:
>>
>>> On 03/02/2012 09:51 AM, Ulf HANSSON wrote:
>>>> Hi Jaehoon,
>>>>
>>>> I did not know this. Which host driver are you using? I would very=
 much=20
>>>> appreciate of you could debug and share some result.
>>>>
>>>> Thanks!
>>>>
>>>> BR
>>>> Ulf Hansson
>>>>
>>>> On 03/02/2012 09:28 AM, Jaehoon Chung wrote:
>>>>> Hi Ulf.
>>>>>
>>>>> I tested with this patch.
>>>>> But in my environment, this patch didn't work fine before.
>>>>> 1) When remove/insert, didn't entered the suspend.
>>>>> 2) When removed during something write,
>>>>> [   50.755067] FAT-fs (mmcblk1p1): Directory bread(block 8254) fa=
iled
>>>>> [   50.761235] FAT-fs (mmcblk1p1): Directory bread(block 8255) fa=
iled
>>>>> then at next-time, didn't detect sd-card.
>>>>>
>>>>> Did you know this?
>>>>> If you want more information, i will debug, and share the result.
>>>>>
>>>>> Best Regards,
>>>>> Jaehoon Chung
>>>>>
>>>>> On 03/02/2012 12:44 AM, Ulf Hansson wrote:
>>>>>
>>>>>> Make sure mmc_start_req cancel the prepared job, if the request
>>>>>> was prevented to be started due to the card has been removed.
>>>>>>
>>>>>> This bug was introduced in commit:
>>>>>> mmc: allow upper layers to know immediately if card has been rem=
oved
>>>>>>
>>>>>> Signed-off-by: Ulf Hansson<ulf.hansson@stericsson.com>
>>>>>> ---
>>>>>>   drivers/mmc/core/core.c |   35 +++++++++++++++----------------=
----
>>>>>>   1 files changed, 15 insertions(+), 20 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>>> index 0b317f0..9e562ab 100644
>>>>>> --- a/drivers/mmc/core/core.c
>>>>>> +++ b/drivers/mmc/core/core.c
>>>>>> @@ -249,16 +249,17 @@ static void mmc_wait_done(struct mmc_reque=
st *mrq)
>>>>>>   	complete(&mrq->completion);
>>>>>>   }
>>>>>>
>>>>>> -static void __mmc_start_req(struct mmc_host *host, struct mmc_r=
equest *mrq)
>>>>>> +static int __mmc_start_req(struct mmc_host *host, struct mmc_re=
quest *mrq)
>>>>>>   {
>>>>>>   	init_completion(&mrq->completion);
>>>>>>   	mrq->done =3D mmc_wait_done;
>>>>>>   	if (mmc_card_removed(host->card)) {
>>>>>>   		mrq->cmd->error =3D -ENOMEDIUM;
>>>>>>   		complete(&mrq->completion);
>>>>>> -		return;
>>>>>> +		return -ENOMEDIUM;
>>>>>>   	}
>>>>>>   	mmc_start_request(host, mrq);
>>>>>> +	return 0;
>>>>>>   }
>>>>>>
>>>>>>   static void mmc_wait_for_req_done(struct mmc_host *host,
>>>>>> @@ -342,6 +343,7 @@ struct mmc_async_req *mmc_start_req(struct m=
mc_host *host,
>>>>>>   				    struct mmc_async_req *areq, int *error)
>>>>>>   {
>>>>>>   	int err =3D 0;
>>>>>> +	int start_err =3D 0;
>>>>>>   	struct mmc_async_req *data =3D host->areq;
>>>>>>
>>>>>>   	/* Prepare a new request */
>>>>>> @@ -351,30 +353,23 @@ struct mmc_async_req *mmc_start_req(struct=
 mmc_host *host,
>>>>>>   	if (host->areq) {
>>>>>>   		mmc_wait_for_req_done(host, host->areq->mrq);
>>>>>>   		err =3D host->areq->err_check(host->card, host->areq);
>>>>>> -		if (err) {
>>>>>> -			/* post process the completed failed request */
>>>>>> -			mmc_post_req(host, host->areq->mrq, 0);
>>>>>> -			if (areq)
>>>>>> -				/*
>>>>>> -				 * Cancel the new prepared request, because
>>>>>> -				 * it can't run until the failed
>>>>>> -				 * request has been properly handled.
>>>>>> -				 */
>>>>>> -				mmc_post_req(host, areq->mrq, -EINVAL);
>>>>>> -
>>>>>> -			host->areq =3D NULL;
>>>>>> -			goto out;
>>>>>> -		}
>>>>>>   	}
>>>>>>
>>>>>> -	if (areq)
>>>>>> -		__mmc_start_req(host, areq->mrq);
>>>>>> +	if (!err&&  areq)
>>>>>> +		start_err =3D __mmc_start_req(host, areq->mrq);
>>>>>>
>>>>>>   	if (host->areq)
>>>>>>   		mmc_post_req(host, host->areq->mrq, 0);
>>>>>>
>>>>>> -	host->areq =3D areq;
>>>>>> - out:
>>>>>> +	if (err || start_err) {
>>>>>> +		if (areq)
>>>>>> +			/* The prepared request was not started, cancel it. */
>>>>>> +			mmc_post_req(host, areq->mrq, -EINVAL);
>>>>>> +		host->areq =3D NULL;
>>> There seems to be an issue when setting host->areq=3DNULL when __mm=
c_start_req fails. host->areq =3D=3D NULL indicates there are no ongoin=
g transfers.
>>> host->areq is used in block.c to check if there are pending request=
s.=20
>>>
>>> This seem to work:
>>> ...
>>> if (err || start_err) {
>>> 	if (areq)
>>> 		/* The prepared request was not started, cancel it. */
>>> 		mmc_post_req(host, areq->mrq, -EINVAL);
>>> }
>>>
>>> if (err)
>>> 	host->areq =3D NULL;
>>> else
>>> 	host->areq =3D areq;
>>> ...
>>>
>>> This issue will be addressed in version 2. How to resolve it is not=
 decided yet.=20
>=20
> If start_err is set and err didn't set, maybe should be set "host->ar=
eq =3D areq".
> Then in block.c, should be check the "status".
>=20
> But start_err didn't be assigned anywhere, how about this?
> ...
> if (error) {
> 	*error =3D err
> 	if (start_err)
> 		*error =3D start_err;
> }
> ...
Thanks for your feedback.

The execution flow may look like this.
1. mmc_start_req(req1)
2. (request starts)
3. (card is removed)
4. mmc_start(req2)
5. req1 is returned with error code set, but req2 gets start_err.
In this case start_err should not be returned.

If NULL is returned from mmc_start_req the error code is discarded.
I think you may set *error=3Dstart_err and return data, but only if err=
 is 0.

if (!err && start_err)
	*error =3D start_err;

Br
Per
