From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v9] mmc: support BKOPS feature for eMMC
Date: Wed, 13 Jun 2012 19:23:11 +0530
Message-ID: <CANfBPZ8N4eBmrJQgv7fz6UN1KNC3MzeiZaywrm-kQq0GOtv22w@mail.gmail.com>
References: <4FD1821D.4070603@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:55730 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753743Ab2FMNxf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 13 Jun 2012 09:53:35 -0400
Received: by bkcjg15 with SMTP id jg15so461817bkc.10
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jun 2012 06:53:31 -0700 (PDT)
In-Reply-To: <4FD1821D.4070603@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Maya Erez <merez@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>

On Fri, Jun 8, 2012 at 10:09 AM, Jaehoon Chung <jh80.chung@samsung.com>=
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
> Future considerations
> =A0* Check BKOPS_LEVEL=3D1 and start BKOPS in a preventive manner.
> =A0* Interrupt ongoing BKOPS before powering off the card.
> =A0* How get BKOPS_STATUS value.(periodically send ext_csd command?)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
> Signed-off-by: Maya Erez <merez@codeaurora.org>
> ---
> Changelog V9:
> =A0 =A0 =A0 =A0- Rebased on patch-v7.
> =A0 =A0 =A0 =A0- Added Konstantin and Maya's patch
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: mmc:core: Define synchronous BKOPS t=
imeout
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: mmc:core: eMMC4.5 BKOPS fixes
> =A0 =A0 =A0 =A0- Removed periodic bkops
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: This feature will do in future work
> =A0 =A0 =A0 =A0- Add __mmc_switch() for waiting_for_prod_done.
>
Jaehoon,
  (I've been trying to sync up with you offline - but our timings dont
seem to match.)
In essence, you've fixed most of the issue, except for the need for
periodic BKOPS. In my view, BKOPS should have little or no overhead
during read writes. Here is the simple workflow that I think of (and
was discussed with some experts during Linaro connect in HK)

1) Check the status of BKOPS need when the queue has been idle for,
say, ~5 seconds
2) If it's >0, start BKOPS
3) If a request arrives during the above execution of BKOPS, issue HPI
and continue with the request
4) Else let it run indefinitely

There should be no need or procedure to check BKOPS during transactions=
=2E
If this is done, in normal circumstances, the card wouldn't need to
set URGENT_BKOPS. Even if it is set, the above sequence would handle
it gracefully.
Apart from this, I have just one clarification required on the implemen=
tation.
See below..

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
> =A0drivers/mmc/core/core.c =A0 =A0| =A0161 ++++++++++++++++++++++++++=
+++++++++++++++++-
> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0 18 +++++
> =A0drivers/mmc/core/mmc_ops.c | =A0 27 ++++++-
> =A0include/linux/mmc/card.h =A0 | =A0 16 +++++
> =A0include/linux/mmc/core.h =A0 | =A0 =A05 ++
> =A0include/linux/mmc/host.h =A0 | =A0 =A02 +
> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 19 +++++
> =A08 files changed, 243 insertions(+), 7 deletions(-)
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
> index 0b6141d..9adb004 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -41,6 +41,12 @@
> =A0#include "sd_ops.h"
> =A0#include "sdio_ops.h"
>
> +/*
> + * The Background operation can take a long time, depends on the hou=
se keeping
> + * operations the card has to peform
> + */
> +#define MMC_BKOPS_MAX_TIMEOUT =A0(4 * 80 * 1000) /* max time to wait=
 in ms */
> +
> =A0static struct workqueue_struct *workqueue;
> =A0static const unsigned freqs[] =3D { 400000, 300000, 200000, 100000=
 };
>
> @@ -175,6 +181,16 @@ void mmc_request_done(struct mmc_host *host, str=
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((mmc_resp_type(cmd) =3D=
=3D MMC_RSP_R1) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(mmc_resp_type(cmd) =
=3D=3D MMC_RSP_R1B)) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cmd->resp[0] & R1_EXCE=
PTION_EVENT)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_check_bkop=
s(host->card);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_host_clk_release(host);
> =A0 =A0 =A0 =A0}
> =A0}
> @@ -245,6 +261,74 @@ mmc_start_request(struct mmc_host *host, struct =
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
> +*/
> +void mmc_start_bkops(struct mmc_card *card)
> +{
> + =A0 =A0 =A0 int err;
> + =A0 =A0 =A0 int timeout;
> + =A0 =A0 =A0 u8 wait_for_prog_done;
> +
> + =A0 =A0 =A0 BUG_ON(!card);
> + =A0 =A0 =A0 if (!card->ext_csd.bkops_en || !(card->host->caps2 & MM=
C_CAP2_BKOPS))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 if (mmc_card_check_bkops(card)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_check_bkops(card);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_is_exception_event(card, EXT_CS=
D_URGENT_BKOPS))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->ext_csd.raw_b=
kops_status)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_car=
d_set_need_bkops(card);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If card is already doing bkops or need for
> + =A0 =A0 =A0 =A0* bkops flag is not set, then do nothing just
> + =A0 =A0 =A0 =A0* return
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (mmc_card_doing_bkops(card) || !mmc_card_need_bkops(=
card))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 mmc_claim_host(card->host);
> + =A0 =A0 =A0 if (card->ext_csd.raw_bkops_status >=3D EXT_CSD_BKOPS_L=
EVEL_2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D MMC_BKOPS_MAX_TIMEOUT;

I don't think the timeout should be any different for BKOPS_START.
IIUC, the CMD to set BKOPS_START would return immediately, and BKOPS
will continue in the background. So the time to actually do the device
management is not applicable to the CMD execution time..

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_for_prog_done =3D 1;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_for_prog_done =3D 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BKOPS_START, 1,=
 timeout, wait_for_prog_done);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("%s: error %d starting bkops\n"=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(car=
d->host), err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_need_bkops(card);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mmc_card_clr_need_bkops(card);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* For urgent bkops status (LEVEL_2 and more)
> + =A0 =A0 =A0 =A0* bkops executed synchronously, otherwise
> + =A0 =A0 =A0 =A0* the operation is in progress
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (card->ext_csd.raw_bkops_status >=3D EXT_CSD_BKOPS_L=
EVEL_2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_check_bkops(card);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_doing_bkops(card);
> +
> +out:
> + =A0 =A0 =A0 mmc_release_host(card->host);
> +}
> +EXPORT_SYMBOL(mmc_start_bkops);
> +
> =A0static void mmc_wait_done(struct mmc_request *mrq)
> =A0{
> =A0 =A0 =A0 =A0complete(&mrq->completion);
> @@ -359,12 +443,15 @@ struct mmc_async_req *mmc_start_req(struct mmc_=
host *host,
> =A0 =A0 =A0 =A0if (!err && areq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0start_err =3D __mmc_start_req(host, ar=
eq->mrq);
>
> - =A0 =A0 =A0 if (host->areq)
> + =A0 =A0 =A0 if (host->areq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!areq && host->areq && mmc_card_mmc=
(host->card))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_bkops(host->c=
ard);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_post_req(host, host->areq->mrq, 0)=
;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 /* Cancel a prepared request if it was not started. *=
/
> =A0 =A0 =A0 =A0if ((err || start_err) && areq)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_post_req(host, areq=
->mrq, -EINVAL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_post_req(host, areq->mrq, -EINVAL);
>
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->areq =3D NULL;
> @@ -480,6 +567,66 @@ int mmc_wait_for_cmd(struct mmc_host *host, stru=
ct mmc_command *cmd, int retries
> =A0EXPORT_SYMBOL(mmc_wait_for_cmd);
>
> =A0/**
> + * =A0 =A0 mmc_stop_bkops - stop ongoing BKOPS
> + * =A0 =A0 @card: MMC card to check BKOPS
> + *
> + * =A0 =A0 Send HPI command to stop ongoing background operations,
> + * =A0 =A0 to allow rapid servicing of foreground operations,e.g. re=
ad/
> + * =A0 =A0 writes. Wait until the card comes out of the programming =
state
> + * =A0 =A0 to avoid errors in servicing read/write requests.
> + */
> +int mmc_stop_bkops(struct mmc_card *card)
> +{
> + =A0 =A0 =A0 int err =3D 0;
> +
> + =A0 =A0 =A0 BUG_ON(!card);
> +
> + =A0 =A0 =A0 err =3D mmc_interrupt_hpi(card);
> +
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
> @@ -2294,8 +2441,11 @@ int mmc_suspend_host(struct mmc_host *host)
> =A0 =A0 =A0 =A0mmc_bus_get(host);
> =A0 =A0 =A0 =A0if (host->bus_ops && !host->bus_dead) {
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_ops->suspend)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->bus_ops->suspend) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_doing_bkop=
s(host->card))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_sto=
p_bkops(host->card);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D host->bus_ops-=
>suspend(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err =3D=3D -ENOSYS || !host->bus_o=
ps->resume) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> @@ -2382,6 +2532,11 @@ int mmc_pm_notify(struct notifier_block *notif=
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
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&host->lock, flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->rescan_disable =3D 1;
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 258b203..9e036e5 100644
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 pr_warn("%s: Enabling BKOPS failed\n",
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
> index 69370f4..f0bebd9 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -367,18 +367,20 @@ int mmc_spi_set_crc(struct mmc_host *host, int =
use_crc)
> =A0}
>
> =A0/**
> - * =A0 =A0 mmc_switch - modify EXT_CSD register
> + * =A0 =A0 __mmc_switch - modify EXT_CSD register
> =A0* =A0 =A0 @card: the MMC card associated with the data transfer
> =A0* =A0 =A0 @set: cmd set values
> =A0* =A0 =A0 @index: EXT_CSD register index
> =A0* =A0 =A0 @value: value to program into EXT_CSD register
> =A0* =A0 =A0 @timeout_ms: timeout (ms) for operation performed by reg=
ister write,
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout of zero implies maxi=
mum possible timeout
> + * =A0 =A0 =A0@wait_for_prod_done: is waiting for program done
> =A0*
> =A0* =A0 =A0 Modifies the EXT_CSD register for selected card.
> =A0*/
> -int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int timeout_ms)
> +int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int timeout_ms, u8 wait_for_pro=
g_done)
> +
> =A0{
> =A0 =A0 =A0 =A0int err;
> =A0 =A0 =A0 =A0struct mmc_command cmd =3D {0};
> @@ -392,13 +394,23 @@ int mmc_switch(struct mmc_card *card, u8 set, u=
8 index, u8 value,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(index << 16) |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(value << 8) |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set;
> - =A0 =A0 =A0 cmd.flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_A=
C;
> +
> + =A0 =A0 =A0 cmd.flags =3D MMC_CMD_AC;
> + =A0 =A0 =A0 if (wait_for_prog_done)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.flags |=3D MMC_RSP_SPI_R1B | MMC_RS=
P_R1B;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.flags |=3D MMC_RSP_R1 | MMC_RSP_R1;
> +
> =A0 =A0 =A0 =A0cmd.cmd_timeout_ms =3D timeout_ms;
>
> =A0 =A0 =A0 =A0err =3D mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RET=
RIES);
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
> @@ -423,6 +435,13 @@ int mmc_switch(struct mmc_card *card, u8 set, u8=
 index, u8 value,
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> +EXPORT_SYMBOL_GPL(__mmc_switch);
> +
> +int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int timeout_ms)
> +{
> + =A0 =A0 =A0 return __mmc_switch(card, set, index, value, timeout_ms=
, 1);
> +}
> =A0EXPORT_SYMBOL_GPL(mmc_switch);
>
> =A0int mmc_send_status(struct mmc_card *card, u32 *status)
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index d76513b..50b3539 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -76,10 +76,13 @@ struct mmc_ext_csd {
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
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0data_sector_size; =
=A0 =A0 =A0 /* 512 bytes or 4KB */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0data_tag_unit_size=
; =A0 =A0 /* DATA TAG UNIT size */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0boot_ro_lock; =A0 =
=A0 =A0 =A0 =A0 /* ro lock support */
> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0boot_ro_lo=
ckable;
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_excep=
tion_status; =A0 /* 53 */
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_part=
ition_support; =A0/* 160 */
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_eras=
ed_mem_count; =A0 /* 181 */
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_ext_=
csd_structure; =A0/* 194 */
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
> index 1b431c7..bda3d86 100644
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
> @@ -142,6 +145,8 @@ extern int mmc_wait_for_cmd(struct mmc_host *, st=
ruct mmc_command *, int);
> =A0extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *);
> =A0extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card=
 *,
> =A0 =A0 =A0 =A0struct mmc_command *, int);
> +extern void mmc_start_bkops(struct mmc_card *card);
> +extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int,=
 u8);
> =A0extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int)=
;
>
> =A0#define MMC_ERASE_ARG =A0 =A0 =A0 =A0 =A00x00000000
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 0707d22..d23caf2 100644
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
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index d425cab..80cfbf1 100644
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
> @@ -386,4 +392,17 @@ struct _mmc_csd {
> =A0#define MMC_SWITCH_MODE_CLEAR_BITS =A0 =A0 0x02 =A0 =A0/* Clear bi=
ts which are 1 in value */
> =A0#define MMC_SWITCH_MODE_WRITE_BYTE =A0 =A0 0x03 =A0 =A0/* Set targ=
et to value */
>
> +/*
> + * BKOPS status level
> + */
> +#define EXT_CSD_BKOPS_LEVEL_2 =A0 =A0 =A0 =A0 =A00x2
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
> --
> 1.7.4.1
