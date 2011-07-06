From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] mmc: enable background operations for emmc4.41 with HPI support
Date: Wed, 6 Jul 2011 09:32:22 +0900
Message-ID: <CAH9JG2ULqXD0-5P11jAXmWP2s900VRV99-2CiQJCWaJ58M6eiA@mail.gmail.com>
References: <1309868840-15089-1-git-send-email-hanumath.prasad@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64870 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272Ab1GFAc0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2011 20:32:26 -0400
Received: by vws1 with SMTP id 1so4586760vws.19
        for <linux-mmc@vger.kernel.org>; Tue, 05 Jul 2011 17:32:25 -0700 (PDT)
In-Reply-To: <1309868840-15089-1-git-send-email-hanumath.prasad@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hanumath Prasad <hanumath.prasad@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linus.walleij@stericsson.com, per.forlin@linaro.org, chuanxiao.dong@intel.com, Venkatraman S <venkat@linaro.org>, Arnd Bergmann <arnd@arndb.de>

Hi Hanumath,

=46irst thank you for working this tasks,
HPI & BKOPS is required for eMMC performance and latency.

But before implement these features. we should define what's addressed
by these features.
HPI is a feature to handle a higher or urgent request then pre-ongoing
request and it's only possible when some conditions are met.
BKOPS is a feature to give a chance to optimize the internal for next o=
peration.

Current implementation is HPI is used for BKOPS but I think HPI is
used for Write operation to reduce the latency.
There are some reasons.
1. I wonder BKOPS is really required to perform frequently? Yes I know
it's helpful to use but no need to call it frequently.
2. Previous time only one request is handled at mmc block. so it can't
implement the HPI for user request. but as Per Forlin implement the
double buffering concept. it can possible to implement the HPI,
interrupt the current write operation and do urgent read request.
Related with this, you can find a "HPI background and one of possible
solutions" in the mmc Spec.
3. real use scenario, realtime class read request has too much latency
since previous write request, (when merge operation is happened eMMC
internally)

With these reason, I hope implement the write HPI first and continue
to work BKOPS support.

Thank you,
Kyungmin Park

On Tue, Jul 5, 2011 at 9:27 PM, Hanumath Prasad
<hanumath.prasad@stericsson.com> wrote:
> Background operations is an optional feature defined in eMMC4.41 spec=
=2E
> The need for BKOPS will be checked after servicing each user request
> in R1 response. If need for BKOPS flag is set, then start BKOPS when
> request queue is idle. Once bkops is started and meanwhile any
> user read/write request comes then the bkops will be interrupted by
> issuing HPI, otherwise bkops keep going =A0until it gets finished.
> This patch is based on the four patches submitted by Chuanxiao Dong
> to linux-mmc.
>
> Signed-off-by: Hanumath Prasad <hanumath.prasad@stericsson.com>
> ---
> =A0drivers/mmc/card/block.c =A0 | =A0 14 +++++++-
> =A0drivers/mmc/card/queue.c =A0 | =A0 =A01 +
> =A0drivers/mmc/core/core.c =A0 =A0| =A0 75 ++++++++++++++++++++++++++=
++++++++++++++++++
> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0 52 ++++++++++++++++++++++++++=
+++-
> =A0drivers/mmc/core/mmc_ops.c | =A0 33 +++++++++++++++++++
> =A0drivers/mmc/core/mmc_ops.h | =A0 =A01 +
> =A0include/linux/mmc/card.h =A0 | =A0 14 ++++++++
> =A0include/linux/mmc/core.h =A0 | =A0 =A03 +-
> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 =A06 +++
> =A09 files changed, 195 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 71da564..26a87ca 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -799,6 +799,11 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue =
*mq, struct request *req)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_queue_bounce_pre(mq);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_doing_bkops(card)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_interrupt_bkops=
(card))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto cm=
d_err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_wait_for_req(card->host, &brq.mrq)=
;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_queue_bounce_post(mq);
> @@ -897,10 +902,17 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue=
 *mq, struct request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto cmd_err;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check BKOPS urgency from each R1 r=
esponse
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_mmc(card) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (brq.cmd.resp[0] & R1_U=
RGENT_BKOPS))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_need_bkops=
(card);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * A block was successfully transferre=
d.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D __blk_end_request(req, 0, brq.=
data.bytes_xfered);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irq(&md->lock);
> =A0 =A0 =A0 =A0} while (ret);
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index c07322c..c491edd 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -64,6 +64,7 @@ static int mmc_queue_thread(void *d)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_cu=
rrent_state(TASK_RUNNING);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_bkops(mq->car=
d);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up(&mq->thread_sem);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0down(&mq->thread_sem);
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 68091dd..e5e1d7c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -196,6 +196,48 @@ mmc_start_request(struct mmc_host *host, struct =
mmc_request *mrq)
> =A0 =A0 =A0 =A0host->ops->request(host, mrq);
> =A0}
>
> +/**
> + * =A0 =A0 mmc_start_bkops - start BKOPS for supported cards
> + * =A0 =A0 @card: MMC card to start BKOPS
> + *
> + * =A0 =A0 Start background operations whenever requested.
> + * =A0 =A0 when the urgent BKOPS bit is set in a R1 command response
> + * =A0 =A0 then background operations should be started immediately.
> + */
> +void mmc_start_bkops(struct mmc_card *card)
> +{
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 if (!card || !card->ext_csd.bkops_en)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If card is already doing bkops or need for
> + =A0 =A0 =A0 =A0* bkops flag is not set, then do nothing just
> + =A0 =A0 =A0 =A0* return
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (mmc_card_doing_bkops(card)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || !mmc_card_need_bkops=
(card))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 mmc_claim_host(card->host);
> + =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BKOPS_START, 1,=
 0);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "error %d starting bkop=
s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_need_bkops(card);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_lock_irqsave(&card->host->lock, flags);
> + =A0 =A0 =A0 mmc_card_clr_need_bkops(card);
> + =A0 =A0 =A0 mmc_card_set_doing_bkops(card);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&card->host->lock, flags);
> +out:
> + =A0 =A0 =A0 mmc_release_host(card->host);
> +}
> +EXPORT_SYMBOL(mmc_start_bkops);
> +
> =A0static void mmc_wait_done(struct mmc_request *mrq)
> =A0{
> =A0 =A0 =A0 =A0complete(mrq->done_data);
> @@ -254,6 +296,39 @@ int mmc_wait_for_cmd(struct mmc_host *host, stru=
ct mmc_command *cmd, int retries
> =A0EXPORT_SYMBOL(mmc_wait_for_cmd);
>
> =A0/**
> + * =A0 =A0 mmc_interrupt_bkops - interrupt ongoing BKOPS
> + * =A0 =A0 @card: MMC card to check BKOPS
> + *
> + * =A0 =A0 Send HPI command to interrupt ongoing background operatio=
ns,
> + * =A0 =A0 to allow rapid servicing of foreground operations,e.g. re=
ad/
> + * =A0 =A0 writes. Wait until the card comes out of the programming =
state
> + * =A0 =A0 to avoid errors in servicing read/write requests.
> + */
> +int mmc_interrupt_bkops(struct mmc_card *card)
> +{
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 u32 status;
> +
> + =A0 =A0 =A0 BUG_ON(!card);
> +
> + =A0 =A0 =A0 /* send HPI to interrupt BKOPS. */
> + =A0 =A0 =A0 err =3D mmc_send_hpi_cmd(card, &status);
> + =A0 =A0 =A0 if (err || R1_CURRENT_STATE(status) =3D=3D 7) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_status=
(card, &status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return =
err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (R1_CURRENT_STATE(status) =3D=3D=
 7);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_lock_irqsave(&card->host->lock, flags);
> + =A0 =A0 =A0 mmc_card_clr_doing_bkops(card);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&card->host->lock, flags);
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL(mmc_interrupt_bkops);
> +
> +/**
> =A0* =A0 =A0 mmc_set_data_timeout - set the timeout for a data comman=
d
> =A0* =A0 =A0 @data: data phase for command
> =A0* =A0 =A0 @card: the MMC card associated with the data transfer
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 2a7e43b..03dcbb3 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -383,9 +383,23 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d, u8 *ext_csd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_TRIM_M=
ULT];
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (card->ext_csd.rev >=3D 5)
> + =A0 =A0 =A0 if (card->ext_csd.rev >=3D 5) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check whether the eMMC card support =
BKOPS */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x=
1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops =3D=
 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check whether the eMMC card support =
HPI */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hpi =3D 1=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_HPI=
_FEATURES] & 0x2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->e=
xt_csd.hpi_cmd =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 MMC_STOP_TRANSMISSION;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->e=
xt_csd.hpi_cmd =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 MMC_SEND_STATUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.rel_param =3D ext_csd[EX=
T_CSD_WR_REL_PARAM];
> -
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0if (ext_csd[EXT_CSD_ERASED_MEM_CONT])
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->erased_byte =3D 0xFF;
> =A0 =A0 =A0 =A0else
> @@ -702,6 +716,40 @@ static int mmc_init_card(struct mmc_host *host, =
u32 ocr,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0* enable BKOPS feature (if supported)
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (card->ext_csd.bkops) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SE=
T_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BKOPS_EN, 1, 0)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s=
: Enabling BKOPS failed\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hos=
tname(card->host));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops_en =
=3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Enable HPI feature (if supported)
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (card->ext_csd.hpi) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SE=
T_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_HPI_MGMT, 1, 0)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s=
: Enabling HPI failed\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hos=
tname(card->host));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hpi_en =3D=
 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * Compute bus speed.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0max_dtr =3D (unsigned int)-1;
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 845ce7c..a4accfb 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -398,6 +398,10 @@ int mmc_switch(struct mmc_card *card, u8 set, u8=
 index, u8 value,
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>
> + =A0 =A0 =A0 /* No need to check card status in case of BKOPS switch=
*/
> + =A0 =A0 =A0 if (index =3D=3D EXT_CSD_BKOPS_START)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> =A0 =A0 =A0 =A0/* Must check status to be sure of no errors */
> =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_send_status(card, &status)=
;
> @@ -547,3 +551,32 @@ int mmc_bus_test(struct mmc_card *card, u8 bus_w=
idth)
> =A0 =A0 =A0 =A0err =3D mmc_send_bus_test(card, card->host, MMC_BUS_TE=
ST_R, width);
> =A0 =A0 =A0 =A0return err;
> =A0}
> +
> +int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
> +{
> + =A0 =A0 =A0 struct mmc_command cmd;
> + =A0 =A0 =A0 unsigned int opcode;
> + =A0 =A0 =A0 unsigned int flags;
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 opcode =3D card->ext_csd.hpi_cmd;
> + =A0 =A0 =A0 if (opcode =3D=3D MMC_STOP_TRANSMISSION)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D MMC_RSP_R1B | MMC_CMD_AC;
> + =A0 =A0 =A0 else if (opcode =3D=3D MMC_SEND_STATUS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> +
> + =A0 =A0 =A0 memset(&cmd, 0, sizeof(struct mmc_command));
> + =A0 =A0 =A0 cmd.opcode =3D opcode;
> + =A0 =A0 =A0 cmd.arg =3D card->rca << 16 | 1;
> + =A0 =A0 =A0 cmd.flags =3D flags;
> + =A0 =A0 =A0 err =3D mmc_wait_for_cmd(card->host, &cmd, 0);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "error %d interrupting =
operation"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "HPI command response =A0=
%#x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err, cm=
d.resp[0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (status)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *status =3D cmd.resp[0];
> + =A0 =A0 =A0 return 0;
> +}
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 9276946..d539f55 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -21,6 +21,7 @@ int mmc_set_relative_addr(struct mmc_card *card);
> =A0int mmc_send_csd(struct mmc_card *card, u32 *csd);
> =A0int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
> =A0int mmc_send_status(struct mmc_card *card, u32 *status);
> +int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status);
> =A0int mmc_send_cid(struct mmc_host *host, u32 *cid);
> =A0int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp=
);
> =A0int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index c6927a4..9bbfed2 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -64,6 +64,11 @@ struct mmc_ext_csd {
> =A0 =A0 =A0 =A0unsigned long long =A0 =A0 =A0enhanced_area_offset; =A0=
 /* Units: Byte */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0enhanced_area_size=
; =A0 =A0 /* Units: KB */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0boot_size; =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* in bytes */
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bkops; =A0 =
=A0 =A0 =A0 =A0/* background support bit */
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bkops_en; =A0=
 =A0 =A0 /* background enable bit */
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hpi_en; =A0=
 =A0 =A0 =A0 /*HPI enablebit */
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hpi; =A0 =A0=
 =A0 =A0 =A0 =A0/* HPI support bit */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0hpi_cmd; =A0 =A0 =A0=
 =A0/* cmd used as HPI */
> =A0};
>
> =A0struct sd_scr {
> @@ -164,6 +169,8 @@ struct mmc_card {
> =A0#define MMC_STATE_HIGHSPEED_DDR (1<<4) =A0 =A0 =A0 =A0 /* card is =
in high speed mode */
> =A0#define MMC_STATE_ULTRAHIGHSPEED (1<<5) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0/* card is in ultra high speed mode */
> =A0#define MMC_CARD_SDXC =A0 =A0 =A0 =A0 =A0(1<<6) =A0 =A0 =A0 =A0 =A0=
/* card is SDXC */
> +#define MMC_STATE_NEED_BKOPS =A0 (1<<7) =A0 =A0 =A0 =A0 =A0/* card n=
eed to do BKOPS */
> +#define MMC_STATE_DOING_BKOPS =A0(1<<8) =A0 =A0 =A0 =A0 =A0/* card i=
s doing BKOPS */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0 =A0=
 =A0 /* card quirks */
> =A0#define MMC_QUIRK_LENIENT_FN0 =A0(1<<0) =A0 =A0 =A0 =A0 =A0/* allo=
w SDIO FN0 writes outside of the VS CCCR range */
> =A0#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) =A0 /* use func->cur_=
blksize */
> @@ -301,6 +308,8 @@ static inline void __maybe_unused remove_quirk(st=
ruct mmc_card *card, int data)
> =A0#define mmc_card_ddr_mode(c) =A0 ((c)->state & MMC_STATE_HIGHSPEED=
_DDR)
> =A0#define mmc_sd_card_uhs(c) ((c)->state & MMC_STATE_ULTRAHIGHSPEED)
> =A0#define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
> +#define mmc_card_need_bkops(c) ((c)->state & MMC_STATE_NEED_BKOPS)
> +#define mmc_card_doing_bkops(c) =A0 =A0 =A0 =A0((c)->state & MMC_STA=
TE_DOING_BKOPS)
>
> =A0#define mmc_card_set_present(c) =A0 =A0 =A0 =A0((c)->state |=3D MM=
C_STATE_PRESENT)
> =A0#define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_READON=
LY)
> @@ -309,6 +318,11 @@ static inline void __maybe_unused remove_quirk(s=
truct mmc_card *card, int data)
> =A0#define mmc_card_set_ddr_mode(c) ((c)->state |=3D MMC_STATE_HIGHSP=
EED_DDR)
> =A0#define mmc_sd_card_set_uhs(c) ((c)->state |=3D MMC_STATE_ULTRAHIG=
HSPEED)
> =A0#define mmc_card_set_ext_capacity(c) ((c)->state |=3D MMC_CARD_SDX=
C)
> +#define mmc_card_set_need_bkops(c) =A0 =A0 ((c)->state |=3D MMC_STAT=
E_NEED_BKOPS)
> +#define mmc_card_set_doing_bkops(c) =A0 =A0((c)->state |=3D MMC_STAT=
E_DOING_BKOPS)
> +
> +#define mmc_card_clr_need_bkops(c) =A0 =A0 ((c)->state &=3D ~MMC_STA=
TE_NEED_BKOPS)
> +#define mmc_card_clr_doing_bkops(c) =A0 =A0((c)->state &=3D ~MMC_STA=
TE_DOING_BKOPS)
>
> =A0/*
> =A0* Quirk add/remove for MMC products.
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index b6718e5..53dca10 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -132,6 +132,7 @@ struct mmc_request {
> =A0struct mmc_host;
> =A0struct mmc_card;
>
> +extern int mmc_interrupt_bkops(struct mmc_card *);
> =A0extern void mmc_wait_for_req(struct mmc_host *, struct mmc_request=
 *);
> =A0extern int mmc_wait_for_cmd(struct mmc_host *, struct mmc_command =
*, int);
> =A0extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *);
> @@ -155,7 +156,7 @@ extern int mmc_can_trim(struct mmc_card *card);
> =A0extern int mmc_can_secure_erase_trim(struct mmc_card *card);
> =A0extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned=
 int from,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u=
nsigned int nr);
> -
> +extern void mmc_start_bkops(struct mmc_card *card);
> =A0extern int mmc_set_blocklen(struct mmc_card *card, unsigned int bl=
ocklen);
>
> =A0extern void mmc_set_data_timeout(struct mmc_data *, const struct m=
mc_card *);
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index ac26a68..98aa47d 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -138,6 +138,7 @@ static inline bool mmc_op_multi(u32 opcode)
> =A0#define R1_CURRENT_STATE(x) =A0 =A0((x & 0x00001E00) >> 9) /* sx, =
b (4 bits) */
> =A0#define R1_READY_FOR_DATA =A0 =A0 =A0(1 << 8) =A0 =A0 =A0 =A0/* sx=
, a */
> =A0#define R1_SWITCH_ERROR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7) =A0=
 =A0 =A0 =A0/* sx, c */
> +#define R1_URGENT_BKOPS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 6) =A0 =
=A0 =A0 =A0/* sx, a */
> =A0#define R1_APP_CMD =A0 =A0 =A0 =A0 =A0 =A0 (1 << 5) =A0 =A0 =A0 =A0=
/* sr, c */
>
> =A0/*
> @@ -262,6 +263,9 @@ struct _mmc_csd {
>
> =A0#define EXT_CSD_PARTITION_ATTRIBUTE =A0 =A0156 =A0 =A0 /* R/W */
> =A0#define EXT_CSD_PARTITION_SUPPORT =A0 =A0 =A0160 =A0 =A0 /* RO */
> +#define EXT_CSD_HPI_MGMT =A0 =A0 =A0 =A0 =A0 =A0 =A0 161 =A0 =A0 /* =
R/W */
> +#define EXT_CSD_BKOPS_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 163 =A0 =A0 /* =
R/W */
> +#define EXT_CSD_BKOPS_START =A0 =A0 =A0 =A0 =A0 =A0164 =A0 =A0 /* W =
*/
> =A0#define EXT_CSD_WR_REL_PARAM =A0 =A0 =A0 =A0 =A0 166 =A0 =A0 /* RO=
 */
> =A0#define EXT_CSD_ERASE_GROUP_DEF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0175=
 =A0 =A0 /* R/W */
> =A0#define EXT_CSD_PART_CONFIG =A0 =A0 =A0 =A0 =A0 =A0179 =A0 =A0 /* =
R/W */
> @@ -283,6 +287,8 @@ struct _mmc_csd {
> =A0#define EXT_CSD_SEC_ERASE_MULT =A0 =A0 =A0 =A0 230 =A0 =A0 /* RO *=
/
> =A0#define EXT_CSD_SEC_FEATURE_SUPPORT =A0 =A0231 =A0 =A0 /* RO */
> =A0#define EXT_CSD_TRIM_MULT =A0 =A0 =A0 =A0 =A0 =A0 =A0232 =A0 =A0 /=
* RO */
> +#define EXT_CSD_BKOPS_SUPPORT =A0 =A0 =A0 =A0 =A0502 =A0 =A0 /* RO *=
/
> +#define EXT_CSD_HPI_FEATURES =A0 =A0 =A0 =A0 =A0 503 =A0 =A0 /* RO *=
/
>
> =A0/*
> =A0* EXT_CSD field definitions
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
