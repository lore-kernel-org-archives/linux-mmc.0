From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: Clean up after mmc_pre_req if card was removed
Date: Mon, 05 Mar 2012 15:08:46 +0900
Message-ID: <4F54586E.3020907@samsung.com>
References: <1330616671-11952-1-git-send-email-ulf.hansson@stericsson.com>
 <4F508493.2000107@samsung.com> <4F508A24.50707@stericsson.com>
 <4F50E766.9030802@stericsson.com> <4F544A43.8020601@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:38961 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab2CEGIz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Mar 2012 01:08:55 -0500
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0M0E0026IEE5E4P0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 05 Mar 2012 15:08:53 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0M0E006VREES1VC0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 05 Mar 2012 15:08:53 +0900 (KST)
In-reply-to: <4F544A43.8020601@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>, Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On 03/05/2012 02:08 PM, Jaehoon Chung wrote:

> On 03/03/2012 12:29 AM, Per F=F6rlin wrote:
>=20
>> On 03/02/2012 09:51 AM, Ulf HANSSON wrote:
>>> Hi Jaehoon,
>>>
>>> I did not know this. Which host driver are you using? I would very =
much=20
>>> appreciate of you could debug and share some result.
>>>
>>> Thanks!
>>>
>>> BR
>>> Ulf Hansson
>>>
>>> On 03/02/2012 09:28 AM, Jaehoon Chung wrote:
>>>> Hi Ulf.
>>>>
>>>> I tested with this patch.
>>>> But in my environment, this patch didn't work fine before.
>>>> 1) When remove/insert, didn't entered the suspend.
>>>> 2) When removed during something write,
>>>> [   50.755067] FAT-fs (mmcblk1p1): Directory bread(block 8254) fai=
led
>>>> [   50.761235] FAT-fs (mmcblk1p1): Directory bread(block 8255) fai=
led
>>>> then at next-time, didn't detect sd-card.
>>>>
>>>> Did you know this?
>>>> If you want more information, i will debug, and share the result.
>>>>
>>>> Best Regards,
>>>> Jaehoon Chung
>>>>
>>>> On 03/02/2012 12:44 AM, Ulf Hansson wrote:
>>>>
>>>>> Make sure mmc_start_req cancel the prepared job, if the request
>>>>> was prevented to be started due to the card has been removed.
>>>>>
>>>>> This bug was introduced in commit:
>>>>> mmc: allow upper layers to know immediately if card has been remo=
ved
>>>>>
>>>>> Signed-off-by: Ulf Hansson<ulf.hansson@stericsson.com>
>>>>> ---
>>>>>   drivers/mmc/core/core.c |   35 +++++++++++++++-----------------=
---
>>>>>   1 files changed, 15 insertions(+), 20 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>> index 0b317f0..9e562ab 100644
>>>>> --- a/drivers/mmc/core/core.c
>>>>> +++ b/drivers/mmc/core/core.c
>>>>> @@ -249,16 +249,17 @@ static void mmc_wait_done(struct mmc_reques=
t *mrq)
>>>>>   	complete(&mrq->completion);
>>>>>   }
>>>>>
>>>>> -static void __mmc_start_req(struct mmc_host *host, struct mmc_re=
quest *mrq)
>>>>> +static int __mmc_start_req(struct mmc_host *host, struct mmc_req=
uest *mrq)
>>>>>   {
>>>>>   	init_completion(&mrq->completion);
>>>>>   	mrq->done =3D mmc_wait_done;
>>>>>   	if (mmc_card_removed(host->card)) {
>>>>>   		mrq->cmd->error =3D -ENOMEDIUM;
>>>>>   		complete(&mrq->completion);
>>>>> -		return;
>>>>> +		return -ENOMEDIUM;
>>>>>   	}
>>>>>   	mmc_start_request(host, mrq);
>>>>> +	return 0;
>>>>>   }
>>>>>
>>>>>   static void mmc_wait_for_req_done(struct mmc_host *host,
>>>>> @@ -342,6 +343,7 @@ struct mmc_async_req *mmc_start_req(struct mm=
c_host *host,
>>>>>   				    struct mmc_async_req *areq, int *error)
>>>>>   {
>>>>>   	int err =3D 0;
>>>>> +	int start_err =3D 0;
>>>>>   	struct mmc_async_req *data =3D host->areq;
>>>>>
>>>>>   	/* Prepare a new request */
>>>>> @@ -351,30 +353,23 @@ struct mmc_async_req *mmc_start_req(struct =
mmc_host *host,
>>>>>   	if (host->areq) {
>>>>>   		mmc_wait_for_req_done(host, host->areq->mrq);
>>>>>   		err =3D host->areq->err_check(host->card, host->areq);
>>>>> -		if (err) {
>>>>> -			/* post process the completed failed request */
>>>>> -			mmc_post_req(host, host->areq->mrq, 0);
>>>>> -			if (areq)
>>>>> -				/*
>>>>> -				 * Cancel the new prepared request, because
>>>>> -				 * it can't run until the failed
>>>>> -				 * request has been properly handled.
>>>>> -				 */
>>>>> -				mmc_post_req(host, areq->mrq, -EINVAL);
>>>>> -
>>>>> -			host->areq =3D NULL;
>>>>> -			goto out;
>>>>> -		}
>>>>>   	}
>>>>>
>>>>> -	if (areq)
>>>>> -		__mmc_start_req(host, areq->mrq);
>>>>> +	if (!err&&  areq)
>>>>> +		start_err =3D __mmc_start_req(host, areq->mrq);
>>>>>
>>>>>   	if (host->areq)
>>>>>   		mmc_post_req(host, host->areq->mrq, 0);
>>>>>
>>>>> -	host->areq =3D areq;
>>>>> - out:
>>>>> +	if (err || start_err) {
>>>>> +		if (areq)
>>>>> +			/* The prepared request was not started, cancel it. */
>>>>> +			mmc_post_req(host, areq->mrq, -EINVAL);
>>>>> +		host->areq =3D NULL;
>> There seems to be an issue when setting host->areq=3DNULL when __mmc=
_start_req fails. host->areq =3D=3D NULL indicates there are no ongoing=
 transfers.
>> host->areq is used in block.c to check if there are pending requests=
=2E=20
>>
>> This seem to work:
>> ...
>> if (err || start_err) {
>> 	if (areq)
>> 		/* The prepared request was not started, cancel it. */
>> 		mmc_post_req(host, areq->mrq, -EINVAL);
>> }
>>
>> if (err)
>> 	host->areq =3D NULL;
>> else
>> 	host->areq =3D areq;
>> ...
>>
>> This issue will be addressed in version 2. How to resolve it is not =
decided yet.=20

If start_err is set and err didn't set, maybe should be set "host->areq=
 =3D areq".
Then in block.c, should be check the "status".

But start_err didn't be assigned anywhere, how about this?
=2E..
if (error) {
	*error =3D err
	if (start_err)
		*error =3D start_err;
}
=2E..

Best Regards,
Jaehoon Chung

>=20
> It seems to work fine. But i didn't test yet.
>=20
> Best Regards,
> Jaehoon Chung
>=20
>>
>> Feel free to comment,
>> Per
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


