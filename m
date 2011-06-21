From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v6 11/11] mmc: add handling for two parallel block
 requests in issue_rw_rq
Date: Tue, 21 Jun 2011 19:22:11 +0530
Message-ID: <BANLkTi=Xb=-umFpWdE7Gt8wad1guKtrWqA@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
 <1308518257-9783-12-git-send-email-per.forlin@linaro.org> <BANLkTi=+di-5yciD7KVx3LySHVj-L1yfrg@mail.gmail.com>
 <BANLkTimp1cu36uaky+zSWua+Civg_uQF+w@mail.gmail.com> <BANLkTikkjhjmv8oJ-coGSzPwQjZ_eUurqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45474 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab1FUNwc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 09:52:32 -0400
Received: by gxk21 with SMTP id 21so733604gxk.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2011 06:52:31 -0700 (PDT)
In-Reply-To: <BANLkTikkjhjmv8oJ-coGSzPwQjZ_eUurqA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>

Hi Per,

<snip>

>>>> --- a/drivers/mmc/card/block.c
>>>> +++ b/drivers/mmc/card/block.c
>>>> @@ -108,6 +108,7 @@ static DEFINE_MUTEX(open_lock);
>>>>
>>>> =A0enum mmc_blk_status {
>>>> =A0 =A0 =A0 =A0MMC_BLK_SUCCESS =3D 0,
>>>> + =A0 =A0 =A0 MMC_BLK_PARTIAL,
>>>> =A0 =A0 =A0 =A0MMC_BLK_RETRY,
>>>> =A0 =A0 =A0 =A0MMC_BLK_DATA_ERR,
>>>> =A0 =A0 =A0 =A0MMC_BLK_CMD_ERR,

<snip>

>>>> -static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct reque=
st *req)
>>>> +static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct reque=
st *rqc)
>>>> =A0{
>>>> =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mq->data;
>>>> =A0 =A0 =A0 =A0struct mmc_card *card =3D md->queue.card;
>>>> - =A0 =A0 =A0 struct mmc_blk_request *brq =3D &mq->mqrq_cur->brq;
>>>> - =A0 =A0 =A0 int ret =3D 1, disable_multi =3D 0;
>>>> + =A0 =A0 =A0 struct mmc_blk_request *brq;
>>>> + =A0 =A0 =A0 int ret =3D 1;
>>>> + =A0 =A0 =A0 int disable_multi =3D 0;
>>>> =A0 =A0 =A0 =A0enum mmc_blk_status status;
Can initialize here
                enum mmc_blk_status =3D MMC_BLK_SUCCESS

>>>> + =A0 =A0 =A0 struct mmc_queue_req *mq_rq;
>>>> + =A0 =A0 =A0 struct request *req;
>>>> + =A0 =A0 =A0 struct mmc_async_req *areq;
>>>> +
>>>> + =A0 =A0 =A0 if (!rqc && !mq->mqrq_prev->req)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>>
<snip>

I meant doing initialization in block.c itself and not core.c as above.

> The intention is to make this function available for SDIO as well.

Totally agree, having the API access to SDIO

> "int err =3D 0;" is set at the top of mmc_start_req(). Default err co=
ndition is 0.
>
> What do you think about the following changes?
>
> =A0* =A0 =A0 @areq: async request to start
> - * =A0 =A0 @error: non zero in case of error
> + * =A0 =A0 @error: out parameter returns 0 for success, otherwise no=
n zero
> =A0*
> =A0* =A0 =A0 Start a new MMC custom command request for a host.
> =A0* =A0 =A0 If there is on ongoing async request wait for completion
> @@ -334,9 +334,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_ho=
st *host,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_po=
st_req(host, areq->mrq, -EINVAL);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->areq =3D NULL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *error =
=3D err;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> @@ -347,6 +345,7 @@ struct mmc_async_req *mmc_start_req(struct mmc_ho=
st *host,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_post_req(host, host->areq->mrq, 0)=
;
>
> =A0 =A0 =A0 =A0host->areq =3D areq;
> + out:
> =A0 =A0 =A0 =A0if (error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*error =3D err;
> =A0 =A0 =A0 =A0return data;
>

The above change reduced the code size but still since 'error' is
pointer to the 'status' which is uninitialized,
so if(error) will be always true.
If you want to update *error in success/failure case [based on 'err'
]then can remove the if(error) check
else to update the error case only can look at the way proposed in my
previous mail.

Regards,
Kishore
