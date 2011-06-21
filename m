From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v6 11/11] mmc: add handling for two parallel block
 requests in issue_rw_rq
Date: Tue, 21 Jun 2011 08:40:32 +0200
Message-ID: <BANLkTimp1cu36uaky+zSWua+Civg_uQF+w@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<1308518257-9783-12-git-send-email-per.forlin@linaro.org>
	<BANLkTi=+di-5yciD7KVx3LySHVj-L1yfrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51077 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256Ab1FUGkd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 02:40:33 -0400
Received: by qwk3 with SMTP id 3so1127525qwk.19
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2011 23:40:32 -0700 (PDT)
In-Reply-To: <BANLkTi=+di-5yciD7KVx3LySHVj-L1yfrg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>

On 20 June 2011 17:17, Kishore Kadiyala <kishorek.kadiyala@gmail.com> w=
rote:
> On Mon, Jun 20, 2011 at 2:47 AM, Per Forlin <per.forlin@linaro.org> w=
rote:
>> Change mmc_blk_issue_rw_rq() to become asynchronous.
>> The execution flow looks like this:
>> The mmc-queue calls issue_rw_rq(), which sends the request
>> to the host and returns back to the mmc-queue. The mmc-queue calls
>> issue_rw_rq() again with a new request. This new request is prepared=
,
>> in isuue_rw_rq(), then it waits for the active request to complete b=
efore
>> pushing it to the host. When to mmc-queue is empty it will call
>> isuue_rw_rq() with req=3DNULL to finish off the active request
>> without starting a new request.
>>
>> Signed-off-by: Per Forlin <per.forlin@linaro.org>
>> ---
>> =A0drivers/mmc/card/block.c | =A0121 +++++++++++++++++++++++++++++++=
++-------------
>> =A0drivers/mmc/card/queue.c | =A0 17 +++++--
>> =A0drivers/mmc/card/queue.h | =A0 =A01 +
>> =A03 files changed, 101 insertions(+), 38 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 6a84a75..66db77a 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -108,6 +108,7 @@ static DEFINE_MUTEX(open_lock);
>>
>> =A0enum mmc_blk_status {
>> =A0 =A0 =A0 =A0MMC_BLK_SUCCESS =3D 0,
>> + =A0 =A0 =A0 MMC_BLK_PARTIAL,
>> =A0 =A0 =A0 =A0MMC_BLK_RETRY,
>> =A0 =A0 =A0 =A0MMC_BLK_DATA_ERR,
>> =A0 =A0 =A0 =A0MMC_BLK_CMD_ERR,
>> @@ -668,14 +669,16 @@ static inline void mmc_apply_rel_rw(struct mmc=
_blk_request *brq,
>> =A0 =A0 =A0 =A0}
>> =A0}
>>
>> -static enum mmc_blk_status mmc_blk_err_check(struct mmc_blk_request=
 *brq,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0struct request *req,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0struct mmc_card *card,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0struct mmc_blk_data *md)
>> +static int mmc_blk_err_check(struct mmc_card *card,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mmc_=
async_req *areq)
>> =A0{
>> =A0 =A0 =A0 =A0struct mmc_command cmd;
>> =A0 =A0 =A0 =A0u32 status =3D 0;
>> =A0 =A0 =A0 =A0enum mmc_blk_status ret =3D MMC_BLK_SUCCESS;
>> + =A0 =A0 =A0 struct mmc_queue_req *mq_mrq =3D container_of(areq, st=
ruct mmc_queue_req,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_active);
>> + =A0 =A0 =A0 struct mmc_blk_request *brq =3D &mq_mrq->brq;
>> + =A0 =A0 =A0 struct request *req =3D mq_mrq->req;
>>
>> =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 * Check for errors here, but don't jump to cmd_err
>> @@ -770,7 +773,11 @@ static enum mmc_blk_status mmc_blk_err_check(st=
ruct mmc_blk_request *brq,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D MMC_BLK_DATA_=
ERR;
>> =A0 =A0 =A0 =A0}
>> -out:
>> +
>> + =A0 =A0 =A0 if (ret =3D=3D MMC_BLK_SUCCESS &&
>> + =A0 =A0 =A0 =A0 =A0 blk_rq_bytes(req) !=3D brq->data.bytes_xfered)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D MMC_BLK_PARTIAL;
>> + out:
>> =A0 =A0 =A0 =A0return ret;
>> =A0}
>>
>> @@ -901,27 +908,59 @@ static void mmc_blk_rw_rq_prep(struct mmc_queu=
e_req *mqrq,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq->data.sg_len =3D i;
>> =A0 =A0 =A0 =A0}
>>
>> + =A0 =A0 =A0 mqrq->mmc_active.mrq =3D &brq->mrq;
>> + =A0 =A0 =A0 mqrq->mmc_active.err_check =3D mmc_blk_err_check;
>> +
>> =A0 =A0 =A0 =A0mmc_queue_bounce_pre(mqrq);
>> =A0}
>>
>> -static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request=
 *req)
>> +static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request=
 *rqc)
>> =A0{
>> =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mq->data;
>> =A0 =A0 =A0 =A0struct mmc_card *card =3D md->queue.card;
>> - =A0 =A0 =A0 struct mmc_blk_request *brq =3D &mq->mqrq_cur->brq;
>> - =A0 =A0 =A0 int ret =3D 1, disable_multi =3D 0;
>> + =A0 =A0 =A0 struct mmc_blk_request *brq;
>> + =A0 =A0 =A0 int ret =3D 1;
>> + =A0 =A0 =A0 int disable_multi =3D 0;
>> =A0 =A0 =A0 =A0enum mmc_blk_status status;
>> + =A0 =A0 =A0 struct mmc_queue_req *mq_rq;
>> + =A0 =A0 =A0 struct request *req;
>> + =A0 =A0 =A0 struct mmc_async_req *areq;
>> +
>> + =A0 =A0 =A0 if (!rqc && !mq->mqrq_prev->req)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>
>> =A0 =A0 =A0 =A0do {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mq->mqrq_cur, card,=
 disable_multi, mq);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_wait_for_req(card->host, &brq->mrq=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rqc) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mq-=
>mqrq_cur, card, 0, mq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 areq =3D &mq->mqrq_cur=
->mmc_active;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 areq =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 areq =3D mmc_start_req(card->host, are=
q, (int *) &status);
>
> I think 'status' is used uninitialized.
status is an out parameter. From that perspective it is always initiali=
sed.
I should update the doc description of mmc_start_req to clarify this.

> With this struct mmc_async_req *mmc_start_req in your first patch
> if (error)
> =A0 =A0 =A0 =A0*error =3D err;
> return data;
> condition which always passes.
>
> You can have
> enum mmc_blk_status status =3D MMC_BLK_SUCCESS;
>
> struct mmc_async_req *mmc_start_req =A0{
> err =3D host->areq->err_check(host->card, host->areq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *error =3D er=
r;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> no need to update * error here in success case
> return data
> }
I agree, makes the code more clear.

Thanks,
Per
