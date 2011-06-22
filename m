From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v7 01/11] mmc: add non-blocking mmc request function
Date: Wed, 22 Jun 2011 11:08:06 +0200
Message-ID: <BANLkTinGRy5KRJLYmEzzeFhOm0WpngzhhA@mail.gmail.com>
References: <1308699521-20556-1-git-send-email-per.forlin@linaro.org>
	<1308699521-20556-2-git-send-email-per.forlin@linaro.org>
	<BANLkTikhZRb5GWFvTVG0bFjD6rAyJPka1w@mail.gmail.com>
	<BANLkTi=TY3wrH2GH1B2p+L506aUKOjg9uA@mail.gmail.com>
	<BANLkTinW1Wrvq6ma6L7he5iCtVCeofL-cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50826 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab1FVJIH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2011 05:08:07 -0400
In-Reply-To: <BANLkTinW1Wrvq6ma6L7he5iCtVCeofL-cg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: linaro-dev <linaro-dev@lists.linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On 22 June 2011 10:53, S, Venkatraman <svenkatr@ti.com> wrote:
> On Wed, Jun 22, 2011 at 2:15 PM, Per Forlin <per.forlin@linaro.org> w=
rote:
>> On 22 June 2011 09:42, Venkatraman S <svenkatr@ti.com> wrote:
>>> On Wed, Jun 22, 2011 at 5:08 AM, Per Forlin <per.forlin@linaro.org>=
 wrote:
>>>> Previously there has only been one function mmc_wait_for_req()
>>>> to start and wait for a request. This patch adds
>>>> =A0* mmc_start_req() - starts a request wihtout waiting
>>>> =A0 If there is on ongoing request wait for completion
>>>> =A0 of that request and start the new one and return.
>>>> =A0 Does not wait for the new command to complete.
>>>>
>>>> This patch also adds new function members in struct mmc_host_ops
>>>> only called from core.c
>>>> =A0* pre_req - asks the host driver to prepare for the next job
>>>> =A0* post_req - asks the host driver to clean up after a completed=
 job
>>>>
>>>> The intention is to use pre_req() and post_req() to do cache maint=
enance
>>>> while a request is active. pre_req() can be called while a request=
 is active
>>>> to minimize latency to start next job. post_req() can be used afte=
r the next
>>>> job is started to clean up the request. This will minimize the hos=
t driver
>>>> request end latency. post_req() is typically used before ending th=
e block
>>>> request and handing over the buffer to the block layer.
>>>>
>>>> Add a host-private member in mmc_data to be used by
>>>> pre_req to mark the data. The host driver will then
>>>> check this mark to see if the data is prepared or not.
>>>>
>>>> Signed-off-by: Per Forlin <per.forlin@linaro.org>
>>>> ---
>>>> =A0drivers/mmc/core/core.c =A0| =A0110 +++++++++++++++++++++++++++=
++++++++++++++----
>>>> =A0include/linux/mmc/core.h | =A0 =A06 ++-
>>>> =A0include/linux/mmc/host.h | =A0 21 +++++++++
>>>> =A03 files changed, 126 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index 68091dd..c82fa3b 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -198,9 +198,106 @@ mmc_start_request(struct mmc_host *host, str=
uct mmc_request *mrq)
>>>>
>>>> =A0static void mmc_wait_done(struct mmc_request *mrq)
>>>> =A0{
>>>> - =A0 =A0 =A0 complete(mrq->done_data);
>>>> + =A0 =A0 =A0 complete(&mrq->completion);
>>>> =A0}
>>>>
>>>> +static void __mmc_start_req(struct mmc_host *host, struct mmc_req=
uest *mrq)
>>>> +{
>>>> + =A0 =A0 =A0 init_completion(&mrq->completion);
>>>> + =A0 =A0 =A0 mrq->done =3D mmc_wait_done;
>>>> + =A0 =A0 =A0 mmc_start_request(host, mrq);
>>>> +}
>>>> +
>>>> +static void mmc_wait_for_req_done(struct mmc_host *host,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
struct mmc_request *mrq)
>>>> +{
>>>> + =A0 =A0 =A0 wait_for_completion(&mrq->completion);
>>>> +}
>>>> +
>>>> +/**
>>>> + * =A0 =A0 mmc_pre_req - Prepare for a new request
>>>> + * =A0 =A0 @host: MMC host to prepare command
>>>> + * =A0 =A0 @mrq: MMC request to prepare for
>>>> + * =A0 =A0 @is_first_req: true if there is no previous started re=
quest
>>>> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 that may run in parell=
el to this call, otherwise false
>>>> + *
>>>> + * =A0 =A0 mmc_pre_req() is called in prior to mmc_start_req() to=
 let
>>>> + * =A0 =A0 host prepare for the new request. Preparation of a req=
uest may be
>>>> + * =A0 =A0 performed while another request is running on the host=
=2E
>>>> + */
>>>> +static void mmc_pre_req(struct mmc_host *host, struct mmc_request=
 *mrq,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bool is_first_req)
>>>> +{
>>>> + =A0 =A0 =A0 if (host->ops->pre_req)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->pre_req(host, mrq, is_fir=
st_req);
>>>> +}
>>>> +
>>>> +/**
>>>> + * =A0 =A0 mmc_post_req - Post process a completed request
>>>> + * =A0 =A0 @host: MMC host to post process command
>>>> + * =A0 =A0 @mrq: MMC request to post process for
>>>> + * =A0 =A0 @err: Error, if non zero, clean up any resources made =
in pre_req
>>>> + *
>>>> + * =A0 =A0 Let the host post process a completed request. Post pr=
ocessing of
>>>> + * =A0 =A0 a request may be performed while another reuqest is ru=
nning.
>>>> + */
>>>> +static void mmc_post_req(struct mmc_host *host, struct mmc_reques=
t *mrq,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int err)
>>>> +{
>>>> + =A0 =A0 =A0 if (host->ops->post_req)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->post_req(host, mrq, err);
>>>> +}
>>>> +
>>>> +/**
>>>> + * =A0 =A0 mmc_start_req - start a non-blocking request
>>>> + * =A0 =A0 @host: MMC host to start command
>>>> + * =A0 =A0 @areq: async request to start
>>>> + * =A0 =A0 @error: out parameter returns 0 for success, otherwise=
 non zero
>>>> + *
>>>> + * =A0 =A0 Start a new MMC custom command request for a host.
>>>> + * =A0 =A0 If there is on ongoing async request wait for completi=
on
>>>> + * =A0 =A0 of that request and start the new one and return.
>>>> + * =A0 =A0 Does not wait for the new request to complete.
>>>> + *
>>>> + * =A0 =A0 Returns the completed async request, NULL in case of n=
one completed.
>>>> + */
>>>> +struct mmc_async_req *mmc_start_req(struct mmc_host *host,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct mmc_async_req *areq, int *error)
>>>> +{
>>>> + =A0 =A0 =A0 int err =3D 0;
>>>> + =A0 =A0 =A0 struct mmc_async_req *data =3D host->areq;
>>>> +
>>>> + =A0 =A0 =A0 /* Prepare a new request */
>>>> + =A0 =A0 =A0 if (areq)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_pre_req(host, areq->mrq, !host->=
areq);
>>>> +
>>>> + =A0 =A0 =A0 if (host->areq) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_wait_for_req_done(host, host->ar=
eq->mrq);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D host->areq->err_check(host->=
card, host->areq);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_post_req(host, h=
ost->areq->mrq, 0);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (areq)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_=
post_req(host, areq->mrq, -EINVAL);
>>>> +
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->areq =3D NULL;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> In this sequence, would the return value (data) have the previous a=
req ?
>>> Is that intentional - doesn't seem to fit with the description.
>> It will return the data that belongs to the completed request. The
>> completed request will be the same as the previous request. The
>> mmc_start_req will start a new request and return data for the
>> completed request, if any.
>>
>
> I meant that in case of an error (err !=3D0), data is already assigne=
d
> to host->areq
> and goto out returns 'data'. So my question was 'Does returning a non=
-null
> pointer for a unsuccessful request doesn't fit with the description, =
does it ?'
>
Now I get it. Thanks for your patience :)

>>>> +       struct mmc_async_req *data =3D host->areq;
=2E..
>>>> +               mmc_wait_for_req_done(host, host->areq->mrq);
>>>> +               err =3D host->areq->err_check(host->card, host->ar=
eq);
in case of error host->areq is returned. Basically the failing request
is returned.
block.c needs the failing request in order to do error handling.

>>>> + *     @error: out parameter returns 0 for success, otherwise non=
 zero
This parameter indicates error.

Returning NULL is not error. NULL is returned when starting a new
request and there is no ongoing (previous) request.

Regards,
Per
