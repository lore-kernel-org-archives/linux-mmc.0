From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v6 11/11] mmc: add handling for two parallel block
 requests in issue_rw_rq
Date: Tue, 21 Jun 2011 09:14:54 +0200
Message-ID: <BANLkTi=+hvETqVS-=tA0fer1+kF3WqiKkg@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<1308518257-9783-12-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52532 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749Ab1FUHO4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 03:14:56 -0400
Received: by qwk3 with SMTP id 3so1136961qwk.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2011 00:14:55 -0700 (PDT)
In-Reply-To: <1308518257-9783-12-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Venkatraman S <svenkatr@ti.com>
Cc: Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>

On 19 June 2011 23:17, Per Forlin <per.forlin@linaro.org> wrote:
> Change mmc_blk_issue_rw_rq() to become asynchronous.
> The execution flow looks like this:
> The mmc-queue calls issue_rw_rq(), which sends the request
> to the host and returns back to the mmc-queue. The mmc-queue calls
> issue_rw_rq() again with a new request. This new request is prepared,
> in isuue_rw_rq(), then it waits for the active request to complete be=
fore
> pushing it to the host. When to mmc-queue is empty it will call
> isuue_rw_rq() with req=3DNULL to finish off the active request
> without starting a new request.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> ---
> =A0drivers/mmc/card/block.c | =A0121 ++++++++++++++++++++++++++++++++=
+-------------
> =A0drivers/mmc/card/queue.c | =A0 17 +++++--
> =A0drivers/mmc/card/queue.h | =A0 =A01 +
> =A03 files changed, 101 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 6a84a75..66db77a 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -108,6 +108,7 @@ static DEFINE_MUTEX(open_lock);
>
> =A0enum mmc_blk_status {
> =A0 =A0 =A0 =A0MMC_BLK_SUCCESS =3D 0,
> + =A0 =A0 =A0 MMC_BLK_PARTIAL,
> =A0 =A0 =A0 =A0MMC_BLK_RETRY,
> =A0 =A0 =A0 =A0MMC_BLK_DATA_ERR,
> =A0 =A0 =A0 =A0MMC_BLK_CMD_ERR,
> @@ -668,14 +669,16 @@ static inline void mmc_apply_rel_rw(struct mmc_=
blk_request *brq,
> =A0 =A0 =A0 =A0}
> =A0}
>
> -static enum mmc_blk_status mmc_blk_err_check(struct mmc_blk_request =
*brq,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0struct request *req,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0struct mmc_card *card,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0struct mmc_blk_data *md)
> +static int mmc_blk_err_check(struct mmc_card *card,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct mmc_a=
sync_req *areq)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_command cmd;
> =A0 =A0 =A0 =A0u32 status =3D 0;
> =A0 =A0 =A0 =A0enum mmc_blk_status ret =3D MMC_BLK_SUCCESS;
> + =A0 =A0 =A0 struct mmc_queue_req *mq_mrq =3D container_of(areq, str=
uct mmc_queue_req,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_active);
> + =A0 =A0 =A0 struct mmc_blk_request *brq =3D &mq_mrq->brq;
> + =A0 =A0 =A0 struct request *req =3D mq_mrq->req;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Check for errors here, but don't jump to cmd_err
> @@ -770,7 +773,11 @@ static enum mmc_blk_status mmc_blk_err_check(str=
uct mmc_blk_request *brq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D MMC_BLK_DATA_E=
RR;
> =A0 =A0 =A0 =A0}
> -out:
> +
> + =A0 =A0 =A0 if (ret =3D=3D MMC_BLK_SUCCESS &&
> + =A0 =A0 =A0 =A0 =A0 blk_rq_bytes(req) !=3D brq->data.bytes_xfered)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D MMC_BLK_PARTIAL;
> + out:
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> @@ -901,27 +908,59 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue=
_req *mqrq,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq->data.sg_len =3D i;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 mqrq->mmc_active.mrq =3D &brq->mrq;
> + =A0 =A0 =A0 mqrq->mmc_active.err_check =3D mmc_blk_err_check;
> +
> =A0 =A0 =A0 =A0mmc_queue_bounce_pre(mqrq);
> =A0}
>
> -static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request =
*req)
> +static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request =
*rqc)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mq->data;
> =A0 =A0 =A0 =A0struct mmc_card *card =3D md->queue.card;
> - =A0 =A0 =A0 struct mmc_blk_request *brq =3D &mq->mqrq_cur->brq;
> - =A0 =A0 =A0 int ret =3D 1, disable_multi =3D 0;
> + =A0 =A0 =A0 struct mmc_blk_request *brq;
> + =A0 =A0 =A0 int ret =3D 1;
> + =A0 =A0 =A0 int disable_multi =3D 0;
> =A0 =A0 =A0 =A0enum mmc_blk_status status;
> + =A0 =A0 =A0 struct mmc_queue_req *mq_rq;
> + =A0 =A0 =A0 struct request *req;
> + =A0 =A0 =A0 struct mmc_async_req *areq;
> +
> + =A0 =A0 =A0 if (!rqc && !mq->mqrq_prev->req)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
> =A0 =A0 =A0 =A0do {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mq->mqrq_cur, card, =
disable_multi, mq);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_wait_for_req(card->host, &brq->mrq)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rqc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mq->=
mqrq_cur, card, 0, mq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 areq =3D &mq->mqrq_cur-=
>mmc_active;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 areq =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 areq =3D mmc_start_req(card->host, areq=
, (int *) &status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!areq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_queue_bounce_post(mq->mqrq_cur);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D mmc_blk_err_check(brq, req, =
card, md);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq_rq =3D container_of(areq, struct mmc=
_queue_req, mmc_active);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 brq =3D &mq_rq->brq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req =3D mq_rq->req;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_queue_bounce_post(mq_rq);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (status) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BLK_CMD_ERR:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto cmd_err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BLK_SUCCESS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BLK_PARTIAL:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* A block was succes=
sfully transferred.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_reque=
st(req, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 brq->data.bytes_xfered);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&md->lo=
ck);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status =3D=3D MMC_B=
LK_SUCCESS && ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If t=
his happen it is a bug */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
KERN_ERR "%s BUG rq_tot %d d_xfer %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0__func__, blk_rq_bytes(req),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0brq->data.bytes_xfered);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto cm=
d_err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_BLK_RETRY:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0disable_multi =3D 1;
> @@ -934,36 +973,41 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue=
 *mq, struct request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * read a single secto=
r.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irq(&md->loc=
k);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_reque=
st(req, -EIO,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 brq->data.blksz);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_reque=
st(req, -EIO, brq->data.blksz);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irq(&md->l=
ock);
> -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto st=
art_new_req;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BLK_SUCCESS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BLK_CMD_ERR:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto cmd_err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* A block was succes=
sfully transferred.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* In case of a none =
complete request
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* prepare it again a=
nd resend.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_reque=
st(req, 0, brq->data.bytes_xfered);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&md->lo=
ck);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mq_r=
q, card, disable_multi, mq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_req(card->hos=
t, &mq_rq->mmc_active, NULL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0} while (ret);
>
> =A0 =A0 =A0 =A0return 1;
> -
> + out:
> + =A0 =A0 =A0 return 0;
> =A0cmd_err:
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* If this is an SD card and we're writing, we can fi=
rst
> - =A0 =A0 =A0 =A0* mark the known good sectors as ok.
> - =A0 =A0 =A0 =A0*
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If this is an SD card and we're writing, we can fi=
rst
> + =A0 =A0 =A0 =A0* mark the known good sectors as ok.
> + =A0 =A0 =A0 =A0*
> =A0 =A0 =A0 =A0 * If the card is not SD, we can still ok written sect=
ors
> =A0 =A0 =A0 =A0 * as reported by the controller (which might be less =
than
> =A0 =A0 =A0 =A0 * the real number of written sectors, but never more)=
=2E
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (mmc_card_sd(card)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 blocks;
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0blocks =3D mmc_sd_num_wr_blocks(card);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (blocks !=3D (u32)-1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irq(&md->loc=
k);
> @@ -981,6 +1025,12 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue=
 *mq, struct request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D __blk_end_request(req, -EIO, b=
lk_rq_cur_bytes(req));
> =A0 =A0 =A0 =A0spin_unlock_irq(&md->lock);
>
> + start_new_req:
> + =A0 =A0 =A0 if (rqc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_rw_rq_prep(mq->mqrq_cur, card, =
0, mq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_req(card->host, &mq->mqrq_cur=
->mmc_active, NULL);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -990,26 +1040,31 @@ static int mmc_blk_issue_rq(struct mmc_queue *=
mq, struct request *req)
> =A0 =A0 =A0 =A0struct mmc_blk_data *md =3D mq->data;
> =A0 =A0 =A0 =A0struct mmc_card *card =3D md->queue.card;
>
> - =A0 =A0 =A0 mmc_claim_host(card->host);
> + =A0 =A0 =A0 if (req && !mq->mqrq_prev->req)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* claim host only for the first reques=
t */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_claim_host(card->host);
> +
> =A0 =A0 =A0 =A0ret =3D mmc_blk_part_switch(card, md);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (req->cmd_flags & REQ_DISCARD) {
> + =A0 =A0 =A0 if (req && req->cmd_flags & REQ_DISCARD) {
		/* complete ongoing async transfer before issuing discard */
		if (card->host->areq)
			mmc_blk_issue_rw_rq(mq, NULL);

prevent mmc_erase to run in parallel to mmc async request.

/Per
