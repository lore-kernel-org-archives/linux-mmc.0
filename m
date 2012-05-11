From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v8] mmc: support BKOPS feature for eMMC
Date: Fri, 11 May 2012 17:10:05 +0530
Message-ID: <CANfBPZ96r_KEe_5fwrQb-iRF44R1r=MYZvpOnsZqKKAsQUcJOg@mail.gmail.com>
References: <4FABC495.8060708@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:45416 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752657Ab2EKLk2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 May 2012 07:40:28 -0400
Received: by bkcjg15 with SMTP id jg15so2677532bkc.24
        for <linux-mmc@vger.kernel.org>; Fri, 11 May 2012 04:40:25 -0700 (PDT)
In-Reply-To: <4FABC495.8060708@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, "Luca Porzio (lporzio)" <lporzio@micron.com>

On Thu, May 10, 2012 at 7:07 PM, Jaehoon Chung <jh80.chung@samsung.com>=
 wrote:
> Enable eMMC background operations (BKOPS) feature.
>
> If URGENT_BKOPS is set after a response, note that BKOPS
> are required. After all I/O requests are finished, run
> BKOPS if required. Should read/write operations be requested
> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
> and then service the request.
> If BKOPS-STATUS is upper than LEVEL2, need to check until clear
> the BKOPS-STATUS vaule.
>
> If you want to enable this feature, set MMC_CAP2_BKOPS.
> And if you want to set the BKOPS_EN bit in ext_csd register,
> use the MMC_CAP2_INIT_BKOPS.
>
> When BKOPS_STATUS is Level-3, if we're waiting for done, it spent 60~=
80sec.
> So Added timeout value. if timeout value is set to 0, send hpi comman=
d.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Changelog V8:
> =A0 =A0 =A0 =A0- Remove host->lock spin lock reviewed by Adrian
> =A0 =A0 =A0 =A0- Support periodic start bkops
> =A0 =A0 =A0 =A0- when bkops_status is level-3, if timeout is set to 0=
, send hpi.
> =A0 =A0 =A0 =A0- Move the start-bkops point
> Changelog V7:
> =A0 =A0 =A0 =A0- Use HPI command when issued URGENT_BKOPS
> =A0 =A0 =A0 =A0- Recheck until clearing the bkops-status bit.
> Changelog V6:
> =A0 =A0 =A0 =A0- Add the flag of check-bkops-status.
> =A0 =A0 =A0 =A0 =A0(For fixing async_req problem)
> =A0 =A0 =A0 =A0- Add the capability for MMC_CAP2_INIT_BKOPS.
> =A0 =A0 =A0 =A0 =A0(When unset the bkops_en bit in ext_csd register)
> =A0 =A0 =A0 =A0- modify the wrong condition.
> Changelog V5:
> =A0 =A0 =A0 =A0- Rebase based on the latest mmc-next.
> =A0 =A0 =A0 =A0- modify codes based-on Chris's comment
> Changelog V4:
> =A0 =A0 =A0 =A0- Add mmc_read_bkops_status
> =A0 =A0 =A0 =A0- When URGENT_BKOPS(level2-3), didn't use HPI command.
> =A0 =A0 =A0 =A0- In mmc_switch(), use R1B/R1 according to level.
> Changelog V3:
> =A0 =A0 =A0 =A0- move the bkops setting's location in mmc_blk_issue_r=
w_rq
> =A0 =A0 =A0 =A0- modify condition checking
> =A0 =A0 =A0 =A0- bkops_en is assigned ext_csd[EXT_CSD_BKOPS_EN] inste=
ad of "1"
> =A0 =A0 =A0 =A0- remove the unused code
> =A0 =A0 =A0 =A0- change pr_debug instead of pr_warn in mmc_send_hpi_c=
md
> =A0 =A0 =A0 =A0- Add the Future consideration suggested by Per
> Changelog V2:
> =A0 =A0 =A0 =A0- Use EXCEPTION_STATUS instead of URGENT_BKOPS
> =A0 =A0 =A0 =A0- Add function to check Exception_status(for eMMC4.5)
> ---
> =A0drivers/mmc/card/queue.c =A0 | =A0 =A02 +
> =A0drivers/mmc/core/core.c =A0 =A0| =A0170 ++++++++++++++++++++++++++=
+++++++++++++++++-
> =A0drivers/mmc/core/host.c =A0 =A0| =A0 =A01 +
> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0 18 +++++
> =A0drivers/mmc/core/mmc_ops.c | =A0 =A04 +
> =A0include/linux/mmc/card.h =A0 | =A0 16 ++++
> =A0include/linux/mmc/core.h =A0 | =A0 =A05 ++
> =A0include/linux/mmc/host.h =A0 | =A0 =A04 +
> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 20 +++++
> =A09 files changed, 238 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index e360a97..e4a2cde 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -66,6 +66,8 @@ static int mmc_queue_thread(void *d)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irq(q->queue_lock);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (req || mq->mqrq_prev->req) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_doing_bkop=
s(mq->card))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_sto=
p_bkops(mq->card);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_current_state(TASK=
_RUNNING);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mq->issue_fn(mq, req);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 0b6141d..91a03d5 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -175,6 +175,13 @@ void mmc_request_done(struct mmc_host *host, str=
uct mmc_request *mrq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mrq->done)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mrq->done(mrq);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check BKOPS urgency from each R1 r=
esponse
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->card && mmc_card_mmc(host->ca=
rd) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cmd->resp[0] & R1_EXCE=
PTION_EVENT))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_check_bkop=
s(host->card);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_host_clk_release(host);
> =A0 =A0 =A0 =A0}
> =A0}
> @@ -245,6 +252,76 @@ mmc_start_request(struct mmc_host *host, struct =
mmc_request *mrq)
> =A0 =A0 =A0 =A0host->ops->request(host, mrq);
> =A0}
>
> +static void mmc_send_bkops_cmd(struct mmc_card *card)
> +{
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 BUG_ON(!card);
> +
> + =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BKOPS_START, 1,=
 0);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: error %d starting bkops=
\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(car=
d->host), err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_need_bkops(card);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mmc_card_clr_need_bkops(card);
> + =A0 =A0 =A0 mmc_card_set_doing_bkops(card);
> +
> +}
> +
> +void mmc_start_periodic_bkops(struct work_struct *work)

There's nothing periodic about this function, by looking at the content=
s.
Maybe this one should be called mmc_start_bkops ..

> +{
> + =A0 =A0 =A0 struct mmc_host *host =3D container_of(work, struct mmc=
_host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 start_bkops.work);
> +
> + =A0 =A0 =A0 mmc_card_set_check_bkops(host->card);
Why is this being set here. The condition should be in the caller conte=
xt.

> +
> + =A0 =A0 =A0 mmc_claim_host(host);
> + =A0 =A0 =A0 mmc_start_bkops(host->card);
> + =A0 =A0 =A0 mmc_release_host(host);
> +}
> +EXPORT_SYMBOL(mmc_start_periodic_bkops);
> +
> +/**
> + * =A0 =A0 mmc_start_bkops - start BKOPS for supported cards
> + * =A0 =A0 @card: MMC card to start BKOPS
> + *
> + * =A0 =A0 Start background operations whenever requested.
> + * =A0 =A0 when the urgent BKOPS bit is set in a R1 command response
> + * =A0 =A0 then background operations should be started immediately.
> +*/
> +void mmc_start_bkops(struct mmc_card *card)

=2E. and this one should be called __mmc_start_bkops() ?

> +{
> + =A0 =A0 =A0 BUG_ON(!card);
> + =A0 =A0 =A0 if (!card->ext_csd.bkops_en || !(card->host->caps2 & MM=
C_CAP2_BKOPS))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (mmc_card_check_bkops(card)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_check_bkops(card);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_is_exception_event(card, EXT_CS=
D_URGENT_BKOPS)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->ext_csd.raw_b=
kops_status)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_car=
d_set_need_bkops(card);

This breaks abstraction. Why check ext_csd even after URGENT_BKOPS is s=
et ?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_need_bkops=
(card);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If card_need_bkops_flag didn't set, then do nothin=
g just
> + =A0 =A0 =A0 =A0* return
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (mmc_card_doing_bkops(card) || !mmc_card_need_bkops(=
card))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto check_bkops;
> +
> + =A0 =A0 =A0 mmc_send_bkops_cmd(card);
> +
> +check_bkops:
> + =A0 =A0 =A0 queue_delayed_work(system_nrt_wq, &card->host->start_bk=
ops, 5 * HZ);

IIUC, queue_delayed_work->start_bkops =3D mmc_start_periodic_bkops ->
mmc_start_bkops -> queue_delayed_work
=2E. ad infinitum ?

> +}
> +EXPORT_SYMBOL(mmc_start_bkops);
> +
> =A0static void mmc_wait_done(struct mmc_request *mrq)
> =A0{
> =A0 =A0 =A0 =A0complete(&mrq->completion);
> @@ -348,8 +425,10 @@ struct mmc_async_req *mmc_start_req(struct mmc_h=
ost *host,
> =A0 =A0 =A0 =A0struct mmc_async_req *data =3D host->areq;
>
> =A0 =A0 =A0 =A0/* Prepare a new request */
> - =A0 =A0 =A0 if (areq)
> + =A0 =A0 =A0 if (areq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work_sync(&host->start_b=
kops);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_pre_req(host, areq->mrq, !host->ar=
eq);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (host->areq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_wait_for_req_done(host, host->areq=
->mrq);
> @@ -359,8 +438,11 @@ struct mmc_async_req *mmc_start_req(struct mmc_h=
ost *host,
> =A0 =A0 =A0 =A0if (!err && areq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0start_err =3D __mmc_start_req(host, ar=
eq->mrq);
>
> - =A0 =A0 =A0 if (host->areq)
> + =A0 =A0 =A0 if (host->areq) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_post_req(host, host->areq->mrq, 0)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!areq && host->areq && mmc_card_mmc=
(host->card))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_bkops(host->c=
ard);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 /* Cancel a prepared request if it was not started. *=
/
> =A0 =A0 =A0 =A0if ((err || start_err) && areq)
> @@ -480,6 +562,84 @@ int mmc_wait_for_cmd(struct mmc_host *host, stru=
ct mmc_command *cmd, int retries
> =A0EXPORT_SYMBOL(mmc_wait_for_cmd);
>
> =A0/**
> + * =A0 =A0 mmc_stop_bkops - stop ongoing BKOPS
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
> +int mmc_stop_bkops(struct mmc_card *card)
> +{
> + =A0 =A0 =A0 int err =3D 0;
> + =A0 =A0 =A0 unsigned int timeout =3D 0x10000;
> + =A0 =A0 =A0 u32 status;
> +
> + =A0 =A0 =A0 BUG_ON(!card);
> + =A0 =A0 =A0 cancel_delayed_work_sync(&card->host->start_bkops);
> +
> + =A0 =A0 =A0 if (card->ext_csd.raw_bkops_status =3D=3D EXT_CSD_BKOPS=
_LEVEL_3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (timeout =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_claim_host(card->ho=
st);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_send_status(card, &=
status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_release_host(card->=
host);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (R1_CURRENT_STATE(status) =3D=3D=
 R1_STATE_PRG);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (timeout !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto done;
> + =A0 =A0 =A0 }

This won't necessarily work all the time. Once BKOPS_START is issued, t=
he card
might finish GC and move to transfer state even before HPI can be sent.
So just exit if the card is in transfer state already.

In this context, kdorfman's comments on "mmc:fix HPI execution
sequence" makes sense.

> +
> + =A0 =A0 =A0 err =3D mmc_interrupt_hpi(card);
> +
> +done:
> + =A0 =A0 =A0 mmc_card_clr_doing_bkops(card);
> +
> + =A0 =A0 =A0 return err;
> +}
> +EXPORT_SYMBOL(mmc_stop_bkops);
> +
> +int mmc_read_bkops_status(struct mmc_card *card)
> +{
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 u8 ext_csd[512];
> +
> + =A0 =A0 =A0 mmc_claim_host(card->host);
> + =A0 =A0 =A0 err =3D mmc_send_ext_csd(card, ext_csd);
> + =A0 =A0 =A0 mmc_release_host(card->host);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 card->ext_csd.raw_bkops_status =3D ext_csd[EXT_CSD_BKOP=
S_STATUS];
> + =A0 =A0 =A0 card->ext_csd.raw_exception_status =3D ext_csd[EXT_CSD_=
EXCEPTION_STATUS];
> +
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL(mmc_read_bkops_status);
> +
> +int mmc_is_exception_event(struct mmc_card *card, unsigned int value=
)
> +{
> + =A0 =A0 =A0 int err;
> +
> + =A0 =A0 =A0 err =3D mmc_read_bkops_status(card);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Didn't read bkops status : =
%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(card->host)=
, err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* In eMMC 4.41, R1_EXCEPTION_EVENT is URGENT_BKOPS */
> + =A0 =A0 =A0 if (card->ext_csd.rev =3D=3D 5)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;

Please swap the order in which you are doing this.
=46or eMMC4.41, we can save the mmc_read_bkops_status atleast for 4.41 =
card
for _every_ request, which is not used.

> +
> + =A0 =A0 =A0 return (card->ext_csd.raw_exception_status & value) ? 1=
 : 0;
> +}
> +EXPORT_SYMBOL(mmc_is_exception_event);
> +
> +/**
> =A0* =A0 =A0 mmc_set_data_timeout - set the timeout for a data comman=
d
> =A0* =A0 =A0 @data: data phase for command
> =A0* =A0 =A0 @card: the MMC card associated with the data transfer
> @@ -2382,6 +2542,12 @@ int mmc_pm_notify(struct notifier_block *notif=
y_block,
> =A0 =A0 =A0 =A0switch (mode) {
> =A0 =A0 =A0 =A0case PM_HIBERNATION_PREPARE:
> =A0 =A0 =A0 =A0case PM_SUSPEND_PREPARE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->card && mmc_card_mmc(host->ca=
rd) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_car=
d_doing_bkops(host->card)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_interrupt_hpi(host-=
>card);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_doing_bkop=
s(host->card);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cancel_delayed_work_sync(&host->start_b=
kops);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&host->lock, flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->rescan_disable =3D 1;
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 91c84c7..3b6a8e4 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -330,6 +330,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct=
 device *dev)
> =A0 =A0 =A0 =A0spin_lock_init(&host->lock);
> =A0 =A0 =A0 =A0init_waitqueue_head(&host->wq);
> =A0 =A0 =A0 =A0INIT_DELAYED_WORK(&host->detect, mmc_rescan);
> + =A0 =A0 =A0 INIT_DELAYED_WORK(&host->start_bkops, mmc_start_periodi=
c_bkops);
> =A0#ifdef CONFIG_PM
> =A0 =A0 =A0 =A0host->pm_notify.notifier_call =3D mmc_pm_notify;
> =A0#endif
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 2f0e11c..275555a 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -463,6 +463,24 @@ static int mmc_read_ext_csd(struct mmc_card *car=
d, u8 *ext_csd)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (card->ext_csd.rev >=3D 5) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check whether the eMMC card support =
BKOPS */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x=
1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops =3D=
 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops_en =
=3D ext_csd[EXT_CSD_BKOPS_EN];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.raw_bkops=
_status =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd=
[EXT_CSD_BKOPS_STATUS];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!card->ext_csd.bkop=
s_en &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->h=
ost->caps2 & MMC_CAP2_INIT_BKOPS) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D=
 mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_BKOPS_EN, 1, 0);

I am not too comfortable tying a OTP register setting to a host
controller capability.
What if I had multiple instances of MMC and reuse the same HC, and
each needs a different
setting ? Or the same HC used in multiple SoCs ?
A sysfs entry would be better - program the INIT when a user
explicitly sets "enable_bkops" for the device
that is being used.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 pr_warning("%s: Enabling BKOPS failed\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 card->ext_csd.bkops_en =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* check whether the eMMC card support=
s HPI */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x=
1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.hpi =3D =
1;
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 69370f4..bc8da17 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -399,6 +399,10 @@ int mmc_switch(struct mmc_card *card, u8 set, u8=
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
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index d76513b..52b507d 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -76,6 +76,9 @@ struct mmc_ext_csd {
> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hpi_en; =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* HPI enablebit */
> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hpi; =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* HPI support bit */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0hpi_cmd; =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* cmd used as HPI */
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bkops; =A0 =
=A0 =A0 =A0 =A0/* background support bit */
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bkops_en; =A0=
 =A0 =A0 /* background enable bit */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_excep=
tion_status; =A0 /* 53 */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0data_sector_size; =
=A0 =A0 =A0 /* 512 bytes or 4KB */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0data_tag_unit_size=
; =A0 =A0 /* DATA TAG UNIT size */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0boot_ro_lock; =A0 =
=A0 =A0 =A0 =A0 /* ro lock support */
> @@ -93,6 +96,7 @@ struct mmc_ext_csd {
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_sec_=
erase_mult; =A0 =A0 /* 230 */
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_sec_=
feature_support;/* 231 */
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_trim=
_mult; =A0 =A0 =A0 =A0 =A0/* 232 */
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_bkops=
_status; =A0 =A0 =A0 /* 246 */
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_sect=
ors[4]; =A0 =A0 =A0 =A0 /* 212 - 4 bytes */
>
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0feature_support;
> @@ -225,6 +229,9 @@ struct mmc_card {
> =A0#define MMC_CARD_REMOVED =A0 =A0 =A0 (1<<7) =A0 =A0 =A0 =A0 =A0/* =
card has been removed */
> =A0#define MMC_STATE_HIGHSPEED_200 =A0 =A0 =A0 =A0(1<<8) =A0 =A0 =A0 =
=A0 =A0/* card is in HS200 mode */
> =A0#define MMC_STATE_SLEEP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<9) =A0 =
=A0 =A0 =A0 =A0/* card is in sleep state */
> +#define MMC_STATE_NEED_BKOPS =A0 (1<<10) =A0 =A0 =A0 =A0 /* card nee=
d to do BKOPS */
> +#define MMC_STATE_DOING_BKOPS =A0(1<<11) =A0 =A0 =A0 =A0 /* card is =
doing BKOPS */
> +#define MMC_STATE_CHECK_BKOPS =A0(1<<12) =A0 =A0 =A0 =A0 /* card nee=
d to check BKOPS */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0 =A0=
 =A0 /* card quirks */
> =A0#define MMC_QUIRK_LENIENT_FN0 =A0(1<<0) =A0 =A0 =A0 =A0 =A0/* allo=
w SDIO FN0 writes outside of the VS CCCR range */
> =A0#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) =A0 /* use func->cur_=
blksize */
> @@ -391,6 +398,9 @@ static inline void __maybe_unused remove_quirk(st=
ruct mmc_card *card, int data)
> =A0#define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
> =A0#define mmc_card_removed(c) =A0 =A0((c) && ((c)->state & MMC_CARD_=
REMOVED))
> =A0#define mmc_card_is_sleep(c) =A0 ((c)->state & MMC_STATE_SLEEP)
> +#define mmc_card_need_bkops(c) ((c)->state & MMC_STATE_NEED_BKOPS)
> +#define mmc_card_doing_bkops(c) =A0 =A0 =A0 =A0((c)->state & MMC_STA=
TE_DOING_BKOPS)
> +#define mmc_card_check_bkops(c) ((c)->state & MMC_STATE_CHECK_BKOPS)
>
> =A0#define mmc_card_set_present(c) =A0 =A0 =A0 =A0((c)->state |=3D MM=
C_STATE_PRESENT)
> =A0#define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_READON=
LY)
> @@ -403,7 +413,13 @@ static inline void __maybe_unused remove_quirk(s=
truct mmc_card *card, int data)
> =A0#define mmc_card_set_ext_capacity(c) ((c)->state |=3D MMC_CARD_SDX=
C)
> =A0#define mmc_card_set_removed(c) ((c)->state |=3D MMC_CARD_REMOVED)
> =A0#define mmc_card_set_sleep(c) =A0((c)->state |=3D MMC_STATE_SLEEP)
> +#define mmc_card_set_need_bkops(c) =A0 =A0 ((c)->state |=3D MMC_STAT=
E_NEED_BKOPS)
> +#define mmc_card_set_doing_bkops(c) =A0 =A0((c)->state |=3D MMC_STAT=
E_DOING_BKOPS)
> +#define mmc_card_set_check_bkops(c) ((c)->state |=3D MMC_STATE_CHECK=
_BKOPS)
>
> +#define mmc_card_clr_need_bkops(c) =A0 =A0 ((c)->state &=3D ~MMC_STA=
TE_NEED_BKOPS)
> +#define mmc_card_clr_doing_bkops(c) =A0 =A0((c)->state &=3D ~MMC_STA=
TE_DOING_BKOPS)
> +#define mmc_card_clr_check_bkops(c) ((c)->state &=3D ~MMC_STATE_CHEC=
K_BKOPS)
> =A0#define mmc_card_clr_sleep(c) =A0((c)->state &=3D ~MMC_STATE_SLEEP=
)
> =A0/*
> =A0* Quirk add/remove for MMC products.
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 1b431c7..c920250 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -134,6 +134,9 @@ struct mmc_host;
> =A0struct mmc_card;
> =A0struct mmc_async_req;
>
> +extern int mmc_stop_bkops(struct mmc_card *);
> +extern int mmc_read_bkops_status(struct mmc_card *);
> +extern int mmc_is_exception_event(struct mmc_card *, unsigned int);
> =A0extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 struct mmc_async_req *, int *);
> =A0extern int mmc_interrupt_hpi(struct mmc_card *);
> @@ -163,6 +166,8 @@ extern int mmc_can_sanitize(struct mmc_card *card=
);
> =A0extern int mmc_can_secure_erase_trim(struct mmc_card *card);
> =A0extern int mmc_erase_group_aligned(struct mmc_card *card, unsigned=
 int from,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u=
nsigned int nr);
> +extern void mmc_start_periodic_bkops(struct work_struct *work);
> +extern void mmc_start_bkops(struct mmc_card *card);
> =A0extern unsigned int mmc_calc_max_discard(struct mmc_card *card);
>
> =A0extern int mmc_set_blocklen(struct mmc_card *card, unsigned int bl=
ocklen);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0707d22..186d146 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -238,6 +238,8 @@ struct mmc_host {
> =A0#define MMC_CAP2_BROKEN_VOLTAGE =A0 =A0 =A0 =A0(1 << 7) =A0 =A0 =A0=
 =A0/* Use the broken voltage */
> =A0#define MMC_CAP2_DETECT_ON_ERR (1 << 8) =A0 =A0 =A0 =A0/* On I/O e=
rr check card removal */
> =A0#define MMC_CAP2_HC_ERASE_SZ =A0 (1 << 9) =A0 =A0 =A0 =A0/* High-c=
apacity erase size */
> +#define MMC_CAP2_INIT_BKOPS =A0 =A0(1 << 10) =A0 =A0 =A0 /* To enabl=
e BKOPS */
> +#define MMC_CAP2_BKOPS =A0 =A0 =A0 =A0 (1 << 11) =A0 =A0 =A0 /* BKOP=
S supported */
>
> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0power_notify_type;
> @@ -320,6 +322,8 @@ struct mmc_host {
>
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0actual_clock; =A0 =
/* Actual HC clock rate */
>
> + =A0 =A0 =A0 struct delayed_work =A0 =A0 start_bkops; =A0 =A0/* Peri=
odic bkops start */
> +
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 private[0] ____cache=
line_aligned;
> =A0};
>
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index d425cab..06afeb4 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -139,6 +139,7 @@ static inline bool mmc_op_multi(u32 opcode)
> =A0#define R1_CURRENT_STATE(x) =A0 =A0((x & 0x00001E00) >> 9) /* sx, =
b (4 bits) */
> =A0#define R1_READY_FOR_DATA =A0 =A0 =A0(1 << 8) =A0 =A0 =A0 =A0/* sx=
, a */
> =A0#define R1_SWITCH_ERROR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7) =A0=
 =A0 =A0 =A0/* sx, c */
> +#define R1_EXCEPTION_EVENT =A0 =A0 (1 << 6) =A0 =A0 =A0 =A0/* sx, a =
*/
> =A0#define R1_APP_CMD =A0 =A0 =A0 =A0 =A0 =A0 (1 << 5) =A0 =A0 =A0 =A0=
/* sr, c */
>
> =A0#define R1_STATE_IDLE =A00
> @@ -274,12 +275,15 @@ struct _mmc_csd {
> =A0#define EXT_CSD_FLUSH_CACHE =A0 =A0 =A0 =A0 =A0 =A032 =A0 =A0 =A0/=
* W */
> =A0#define EXT_CSD_CACHE_CTRL =A0 =A0 =A0 =A0 =A0 =A0 33 =A0 =A0 =A0/=
* R/W */
> =A0#define EXT_CSD_POWER_OFF_NOTIFICATION 34 =A0 =A0 =A0/* R/W */
> +#define EXT_CSD_EXCEPTION_STATUS =A0 =A0 =A0 54 =A0 =A0 =A0/* RO */
> =A0#define EXT_CSD_DATA_SECTOR_SIZE =A0 =A0 =A0 61 =A0 =A0 =A0/* R */
> =A0#define EXT_CSD_GP_SIZE_MULT =A0 =A0 =A0 =A0 =A0 143 =A0 =A0 /* R/=
W */
> =A0#define EXT_CSD_PARTITION_ATTRIBUTE =A0 =A0156 =A0 =A0 /* R/W */
> =A0#define EXT_CSD_PARTITION_SUPPORT =A0 =A0 =A0160 =A0 =A0 /* RO */
> =A0#define EXT_CSD_HPI_MGMT =A0 =A0 =A0 =A0 =A0 =A0 =A0 161 =A0 =A0 /=
* R/W */
> =A0#define EXT_CSD_RST_N_FUNCTION =A0 =A0 =A0 =A0 162 =A0 =A0 /* R/W =
*/
> +#define EXT_CSD_BKOPS_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 163 =A0 =A0 /* =
R/W */
> +#define EXT_CSD_BKOPS_START =A0 =A0 =A0 =A0 =A0 =A0164 =A0 =A0 /* W =
*/
> =A0#define EXT_CSD_SANITIZE_START =A0 =A0 =A0 =A0 165 =A0 =A0 /* W */
> =A0#define EXT_CSD_WR_REL_PARAM =A0 =A0 =A0 =A0 =A0 166 =A0 =A0 /* RO=
 */
> =A0#define EXT_CSD_BOOT_WP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0173 =A0 =A0 /* R/W */
> @@ -313,11 +317,13 @@ struct _mmc_csd {
> =A0#define EXT_CSD_PWR_CL_200_360 =A0 =A0 =A0 =A0 237 =A0 =A0 /* RO *=
/
> =A0#define EXT_CSD_PWR_CL_DDR_52_195 =A0 =A0 =A0238 =A0 =A0 /* RO */
> =A0#define EXT_CSD_PWR_CL_DDR_52_360 =A0 =A0 =A0239 =A0 =A0 /* RO */
> +#define EXT_CSD_BKOPS_STATUS =A0 =A0 =A0 =A0 =A0 246 =A0 =A0 /* RO *=
/
> =A0#define EXT_CSD_POWER_OFF_LONG_TIME =A0 =A0247 =A0 =A0 /* RO */
> =A0#define EXT_CSD_GENERIC_CMD6_TIME =A0 =A0 =A0248 =A0 =A0 /* RO */
> =A0#define EXT_CSD_CACHE_SIZE =A0 =A0 =A0 =A0 =A0 =A0 249 =A0 =A0 /* =
RO, 4 bytes */
> =A0#define EXT_CSD_TAG_UNIT_SIZE =A0 =A0 =A0 =A0 =A0498 =A0 =A0 /* RO=
 */
> =A0#define EXT_CSD_DATA_TAG_SUPPORT =A0 =A0 =A0 499 =A0 =A0 /* RO */
> +#define EXT_CSD_BKOPS_SUPPORT =A0 =A0 =A0 =A0 =A0502 =A0 =A0 /* RO *=
/
> =A0#define EXT_CSD_HPI_FEATURES =A0 =A0 =A0 =A0 =A0 503 =A0 =A0 /* RO=
 */
>
> =A0/*
> @@ -386,4 +392,18 @@ struct _mmc_csd {
> =A0#define MMC_SWITCH_MODE_CLEAR_BITS =A0 =A0 0x02 =A0 =A0/* Clear bi=
ts which are 1 in value */
> =A0#define MMC_SWITCH_MODE_WRITE_BYTE =A0 =A0 0x03 =A0 =A0/* Set targ=
et to value */
>
> +/*
> + * BKOPS status level
> + */
> +#define EXT_CSD_BKOPS_LEVEL_2 =A0 =A0 =A0 =A0 =A00x2
> +#define EXT_CSD_BKOPS_LEVEL_3 =A0 =A0 =A0 =A0 =A00x3
> +
> +/*
> + * EXCEPTION_EVENT_STATUS field (eMMC4.5)
> + */
> +#define EXT_CSD_URGENT_BKOPS =A0 =A0 =A0 =A0 =A0 BIT(0)
> +#define EXT_CSD_DYNCAP_NEEDED =A0 =A0 =A0 =A0 =A0BIT(1)
> +#define EXT_CSD_SYSPOOL_EXHAUSTED =A0 =A0 =A0BIT(2)
> +#define EXT_CSD_PACKED_FAILURE =A0 =A0 =A0 =A0 BIT(3)
> +
> =A0#endif /* LINUX_MMC_MMC_H */


Overall, my significant concern is about performance.
IIUC, There is a ext_csd query during the execution of _every_ request
- this is far too obsessive and could kill throughput.
A more pragmatic approach would be to trigger on a threshold of number
of writes or discards (ex: After 1M sector writes)
This means that a predominantly read only disk, which wouldn't need
any BKOPS, wouldn't have any overhead.

Let me know if my assumption is incorrect.

~Venkat.
