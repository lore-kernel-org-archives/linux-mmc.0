From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH v7 01/11] mmc: add non-blocking mmc request function
Date: Wed, 22 Jun 2011 13:12:28 +0530
Message-ID: <BANLkTikhZRb5GWFvTVG0bFjD6rAyJPka1w@mail.gmail.com>
References: <1308699521-20556-1-git-send-email-per.forlin@linaro.org>
	<1308699521-20556-2-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49228 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab1FVHma convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2011 03:42:30 -0400
In-Reply-To: <1308699521-20556-2-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linaro-dev@lists.linaro.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Jun 22, 2011 at 5:08 AM, Per Forlin <per.forlin@linaro.org> wro=
te:
> Previously there has only been one function mmc_wait_for_req()
> to start and wait for a request. This patch adds
> =A0* mmc_start_req() - starts a request wihtout waiting
> =A0 If there is on ongoing request wait for completion
> =A0 of that request and start the new one and return.
> =A0 Does not wait for the new command to complete.
>
> This patch also adds new function members in struct mmc_host_ops
> only called from core.c
> =A0* pre_req - asks the host driver to prepare for the next job
> =A0* post_req - asks the host driver to clean up after a completed jo=
b
>
> The intention is to use pre_req() and post_req() to do cache maintena=
nce
> while a request is active. pre_req() can be called while a request is=
 active
> to minimize latency to start next job. post_req() can be used after t=
he next
> job is started to clean up the request. This will minimize the host d=
river
> request end latency. post_req() is typically used before ending the b=
lock
> request and handing over the buffer to the block layer.
>
> Add a host-private member in mmc_data to be used by
> pre_req to mark the data. The host driver will then
> check this mark to see if the data is prepared or not.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> ---
> =A0drivers/mmc/core/core.c =A0| =A0110 ++++++++++++++++++++++++++++++=
+++++++++++----
> =A0include/linux/mmc/core.h | =A0 =A06 ++-
> =A0include/linux/mmc/host.h | =A0 21 +++++++++
> =A03 files changed, 126 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 68091dd..c82fa3b 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -198,9 +198,106 @@ mmc_start_request(struct mmc_host *host, struct=
 mmc_request *mrq)
>
> =A0static void mmc_wait_done(struct mmc_request *mrq)
> =A0{
> - =A0 =A0 =A0 complete(mrq->done_data);
> + =A0 =A0 =A0 complete(&mrq->completion);
> =A0}
>
> +static void __mmc_start_req(struct mmc_host *host, struct mmc_reques=
t *mrq)
> +{
> + =A0 =A0 =A0 init_completion(&mrq->completion);
> + =A0 =A0 =A0 mrq->done =3D mmc_wait_done;
> + =A0 =A0 =A0 mmc_start_request(host, mrq);
> +}
> +
> +static void mmc_wait_for_req_done(struct mmc_host *host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=
uct mmc_request *mrq)
> +{
> + =A0 =A0 =A0 wait_for_completion(&mrq->completion);
> +}
> +
> +/**
> + * =A0 =A0 mmc_pre_req - Prepare for a new request
> + * =A0 =A0 @host: MMC host to prepare command
> + * =A0 =A0 @mrq: MMC request to prepare for
> + * =A0 =A0 @is_first_req: true if there is no previous started reque=
st
> + * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 that may run in parellel =
to this call, otherwise false
> + *
> + * =A0 =A0 mmc_pre_req() is called in prior to mmc_start_req() to le=
t
> + * =A0 =A0 host prepare for the new request. Preparation of a reques=
t may be
> + * =A0 =A0 performed while another request is running on the host.
> + */
> +static void mmc_pre_req(struct mmc_host *host, struct mmc_request *m=
rq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bool is_first_req)
> +{
> + =A0 =A0 =A0 if (host->ops->pre_req)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->pre_req(host, mrq, is_first_=
req);
> +}
> +
> +/**
> + * =A0 =A0 mmc_post_req - Post process a completed request
> + * =A0 =A0 @host: MMC host to post process command
> + * =A0 =A0 @mrq: MMC request to post process for
> + * =A0 =A0 @err: Error, if non zero, clean up any resources made in =
pre_req
> + *
> + * =A0 =A0 Let the host post process a completed request. Post proce=
ssing of
> + * =A0 =A0 a request may be performed while another reuqest is runni=
ng.
> + */
> +static void mmc_post_req(struct mmc_host *host, struct mmc_request *=
mrq,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int err)
> +{
> + =A0 =A0 =A0 if (host->ops->post_req)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->post_req(host, mrq, err);
> +}
> +
> +/**
> + * =A0 =A0 mmc_start_req - start a non-blocking request
> + * =A0 =A0 @host: MMC host to start command
> + * =A0 =A0 @areq: async request to start
> + * =A0 =A0 @error: out parameter returns 0 for success, otherwise no=
n zero
> + *
> + * =A0 =A0 Start a new MMC custom command request for a host.
> + * =A0 =A0 If there is on ongoing async request wait for completion
> + * =A0 =A0 of that request and start the new one and return.
> + * =A0 =A0 Does not wait for the new request to complete.
> + *
> + * =A0 =A0 Returns the completed async request, NULL in case of none=
 completed.
> + */
> +struct mmc_async_req *mmc_start_req(struct mmc_host *host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct mmc_async_req *areq, int *error)
> +{
> + =A0 =A0 =A0 int err =3D 0;
> + =A0 =A0 =A0 struct mmc_async_req *data =3D host->areq;
> +
> + =A0 =A0 =A0 /* Prepare a new request */
> + =A0 =A0 =A0 if (areq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_pre_req(host, areq->mrq, !host->are=
q);
> +
> + =A0 =A0 =A0 if (host->areq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_wait_for_req_done(host, host->areq-=
>mrq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D host->areq->err_check(host->car=
d, host->areq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_post_req(host, host=
->areq->mrq, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (areq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_pos=
t_req(host, areq->mrq, -EINVAL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->areq =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
In this sequence, would the return value (data) have the previous areq =
?
Is that intentional - doesn't seem to fit with the description.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (areq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __mmc_start_req(host, areq->mrq);
> +
> + =A0 =A0 =A0 if (host->areq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_post_req(host, host->areq->mrq, 0);
> +
> + =A0 =A0 =A0 host->areq =3D areq;
> + out:
> + =A0 =A0 =A0 if (error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *error =3D err;
> + =A0 =A0 =A0 return data;
> +}
> +EXPORT_SYMBOL(mmc_start_req);
> +
