From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH v5] mmc: support BKOPS feature for eMMC
Date: Sun, 8 Jan 2012 02:18:44 +0000
Message-ID: <17296D9F8FF2234F831FC3DF505A87A90FCB43D7@SHSMSX101.ccr.corp.intel.com>
References: <4F04F512.1020909@samsung.com>
 <CANfBPZ-RV=9qMm95yaN3J8no10ZBMa+sB+tO2qpqOZMVpbx-8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:56777 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779Ab2AHCSv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Jan 2012 21:18:51 -0500
In-Reply-To: <CANfBPZ-RV=9qMm95yaN3J8no10ZBMa+sB+tO2qpqOZMVpbx-8g@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, "per.forlin@stericsson.com" <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, Konstantin Dorfman <kdorfman@codeaurora.org>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org
> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of S, Venkatraman
> Sent: Saturday, January 07, 2012 12:42 AM
> To: Jaehoon Chung
> Cc: linux-mmc; Chris Ball; Kyungmin Park; Hanumath Prasad;
> per.forlin@stericsson.com; Sebastian Rasmussen; Dong, Chuanxiao; Kons=
tantin
> Dorfman
> Subject: Re: [PATCH v5] mmc: support BKOPS feature for eMMC
>=20
> On Thu, Jan 5, 2012 at 6:25 AM, Jaehoon Chung <jh80.chung@samsung.com=
>
> wrote:
> > Enable eMMC background operations (BKOPS) feature.
> >
> > If URGENT_BKOPS is set after a response, note that BKOPS
> > are required. After all I/O requests are finished, run
> > BKOPS if required. Should read/write operations be requested
> > during BKOPS, first issue HPI to interrupt the ongoing BKOPS
> > and then service the request.
> >
> > If you want to enable this feature, set MMC_CAP2_BKOPS.
> >
> > Future considerations
> > =A0* Check BKOPS_LEVEL=3D1 and start BKOPS in a preventive manner.
> > =A0* Interrupt ongoing BKOPS before powering off the card.
> > =A0* How get BKOPS_STATUS value.(periodically send ext_csd command?=
)
> >
> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> > Changelog V5:
> > =A0 =A0 =A0 =A0- Rebase based on the latest mmc-next.
> > =A0 =A0 =A0 =A0- modify codes based-on Chris's comment
> > Changelog V4:
> > =A0 =A0 =A0 =A0- Add mmc_read_bkops_status
> > =A0 =A0 =A0 =A0- When URGENT_BKOPS(level2-3), didn't use HPI comman=
d.
> > =A0 =A0 =A0 =A0- In mmc_switch(), use R1B/R1 according to level.
> > Changelog V3:
> > =A0 =A0 =A0 =A0- move the bkops setting's location in mmc_blk_issue=
_rw_rq
> > =A0 =A0 =A0 =A0- modify condition checking
> > =A0 =A0 =A0 =A0- bkops_en is assigned ext_csd[EXT_CSD_BKOPS_EN] ins=
tead of "1"
> > =A0 =A0 =A0 =A0- remove the unused code
> > =A0 =A0 =A0 =A0- change pr_debug instead of pr_warn in mmc_send_hpi=
_cmd
> > =A0 =A0 =A0 =A0- Add the Future consideration suggested by Per
> > Changelog V2:
> > =A0 =A0 =A0 =A0- Use EXCEPTION_STATUS instead of URGENT_BKOPS
> > =A0 =A0 =A0 =A0- Add function to check Exception_status(for eMMC4.5=
)
> >
> > =A0drivers/mmc/card/block.c =A0 | =A0 11 +++++
> > =A0drivers/mmc/card/queue.c =A0 | =A0 =A03 +
> > =A0drivers/mmc/core/core.c =A0 =A0| =A0105
> ++++++++++++++++++++++++++++++++++++++++++++
> > =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0 =A08 +++
> > =A0drivers/mmc/core/mmc_ops.c | =A0 12 +++++-
> > =A0include/linux/mmc/card.h =A0 | =A0 13 +++++
> > =A0include/linux/mmc/core.h =A0 | =A0 =A04 ++
> > =A0include/linux/mmc/host.h =A0 | =A0 =A01 +
> > =A0include/linux/mmc/mmc.h =A0 =A0| =A0 19 ++++++++
> > =A09 files changed, 175 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> > index 0cad48a..5e3c580 100644
> > --- a/drivers/mmc/card/block.c
> > +++ b/drivers/mmc/card/block.c
> > @@ -1273,6 +1273,17 @@ static int mmc_blk_issue_rw_rq(struct mmc_qu=
eue
> *mq, struct request *rqc)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type =3D rq_data_dir(req) =3D=3D REA=
D ? MMC_BLK_READ :
> MMC_BLK_WRITE;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_queue_bounce_post(mq_rq);
> >
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check BKOPS urgency from each R1=
 response
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_mmc(card) &&
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (brq->cmd.flags =3D=3D=
 MMC_RSP_R1B ||
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brq->cmd.flags =3D=
=3D MMC_RSP_R1) &&
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (brq->cmd.resp[0] & R=
1_EXCEPTION_EVENT)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_is_exception_=
event(card,
> EXT_CSD_URGENT_BKOPS))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_c=
ard_set_need_bkops(card);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (status) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_BLK_SUCCESS:
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_BLK_PARTIAL:
> > diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> > index 2517547..fd11a31 100644
> > --- a/drivers/mmc/card/queue.c
> > +++ b/drivers/mmc/card/queue.c
> > @@ -66,6 +66,8 @@ static int mmc_queue_thread(void *d)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irq(q->queue_lock);
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (req || mq->mqrq_prev->req) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_doing_bk=
ops(mq->card))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_i=
nterrupt_bkops(mq->card);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_current_state(TA=
SK_RUNNING);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mq->issue_fn(mq, req=
);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> > @@ -73,6 +75,7 @@ static int mmc_queue_thread(void *d)
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_=
current_state(TASK_RUNNING);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0brea=
k;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_bkops(mq->c=
ard);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up(&mq->thread_sem);
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule();
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0down(&mq->thread_sem=
);
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 4770807..4579b24 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -238,6 +238,50 @@ mmc_start_request(struct mmc_host *host, struc=
t
> mmc_request *mrq)
> > =A0 =A0 =A0 =A0host->ops->request(host, mrq);
> > =A0}
> >
> > +/**
> > + * =A0 =A0 mmc_start_bkops - start BKOPS for supported cards
> > + * =A0 =A0 @card: MMC card to start BKOPS
> > + *
> > + * =A0 =A0 Start background operations whenever requested.
> > + * =A0 =A0 when the urgent BKOPS bit is set in a R1 command respon=
se
> > + * =A0 =A0 then background operations should be started immediatel=
y.
> > +*/
> > +void mmc_start_bkops(struct mmc_card *card)
> > +{
> > + =A0 =A0 =A0 int err;
> > + =A0 =A0 =A0 unsigned long flags;
> > +
> > + =A0 =A0 =A0 BUG_ON(!card);
> > + =A0 =A0 =A0 if (!card->ext_csd.bkops_en || !(card->host->caps2 &
> MMC_CAP2_BKOPS))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* If card is already doing bkops or need for
> > + =A0 =A0 =A0 =A0* bkops flag is not set, then do nothing just
> > + =A0 =A0 =A0 =A0* return
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 if (mmc_card_doing_bkops(card) || !mmc_card_need_bkop=
s(card))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > +
> > + =A0 =A0 =A0 mmc_claim_host(card->host);
> > + =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BKOPS_START, =
1, 0);
> > + =A0 =A0 =A0 if (err) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: error %d starting bko=
ps\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(c=
ard->host), err);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_need_bkops(card);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 spin_lock_irqsave(&card->host->lock, flags);
> > + =A0 =A0 =A0 mmc_card_clr_need_bkops(card);
> > + =A0 =A0 =A0 if (card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LE=
VEL_2)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_doing_bkops(card);
> > + =A0 =A0 =A0 spin_unlock_irqrestore(&card->host->lock, flags);
> > +out:
> > + =A0 =A0 =A0 mmc_release_host(card->host);
> > +}
> > +EXPORT_SYMBOL(mmc_start_bkops);
> > +
> > =A0static void mmc_wait_done(struct mmc_request *mrq)
> > =A0{
> > =A0 =A0 =A0 =A0complete(&mrq->completion);
> > @@ -472,6 +516,67 @@ int mmc_wait_for_cmd(struct mmc_host *host, st=
ruct
> mmc_command *cmd, int retries
> > =A0EXPORT_SYMBOL(mmc_wait_for_cmd);
> >
> > =A0/**
> > + * =A0 =A0 mmc_interrupt_bkops - interrupt ongoing BKOPS
> > + * =A0 =A0 @card: MMC card to check BKOPS
> > + *
> > + * =A0 =A0 Send HPI command to interrupt ongoing background operat=
ions,
> > + * =A0 =A0 to allow rapid servicing of foreground operations,e.g. =
read/
> > + * =A0 =A0 writes. Wait until the card comes out of the programmin=
g state
> > + * =A0 =A0 to avoid errors in servicing read/write requests.
> > + */
> > +int mmc_interrupt_bkops(struct mmc_card *card)
> > +{
> > + =A0 =A0 =A0 int err =3D 0;
> > + =A0 =A0 =A0 unsigned long flags;
> > +
> > + =A0 =A0 =A0 BUG_ON(!card);
> > +
> > + =A0 =A0 =A0 err =3D mmc_interrupt_hpi(card);
> > +
> > + =A0 =A0 =A0 spin_lock_irqsave(&card->host->lock, flags);
> > + =A0 =A0 =A0 mmc_card_clr_doing_bkops(card);
> > + =A0 =A0 =A0 spin_unlock_irqrestore(&card->host->lock, flags);
> > +
> > + =A0 =A0 =A0 return err;
> > +}
> > +EXPORT_SYMBOL(mmc_interrupt_bkops);
> > +
> > +int mmc_read_bkops_status(struct mmc_card *card)
> > +{
> > + =A0 =A0 =A0 int err;
> > + =A0 =A0 =A0 u8 ext_csd[512];
> > +
> > + =A0 =A0 =A0 err =3D mmc_send_ext_csd(card, ext_csd);
> > + =A0 =A0 =A0 if (err)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> > +
> > + =A0 =A0 =A0 card->ext_csd.raw_bkops_status =3D ext_csd[EXT_CSD_BK=
OPS_STATUS];
> > + =A0 =A0 =A0 card->ext_csd.raw_exception_status =3D
> ext_csd[EXT_CSD_EXCEPTION_STATUS];
> > +
> > + =A0 =A0 =A0 return 0;
> > +}
> > +EXPORT_SYMBOL(mmc_read_bkops_status);
> > +
> > +int mmc_is_exception_event(struct mmc_card *card, unsigned int val=
ue)
> > +{
> > + =A0 =A0 =A0 int err;
> > +
> > + =A0 =A0 =A0 err =3D mmc_read_bkops_status(card);
> > + =A0 =A0 =A0 if (err) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Didn't read bkops status =
: %d\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(card->hos=
t), err);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 /* In eMMC 4.41, R1_EXCEPTION_EVENT is URGENT_BKOPS *=
/
> > + =A0 =A0 =A0 if (card->ext_csd.rev =3D=3D 5)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> > +
> > + =A0 =A0 =A0 return (card->ext_csd.raw_exception_status & value) ?=
 1 : 0;
> > +}
> > +EXPORT_SYMBOL(mmc_is_exception_event);
> > +
> > +/**
> > =A0* =A0 =A0 mmc_set_data_timeout - set the timeout for a data comm=
and
> > =A0* =A0 =A0 @data: data phase for command
> > =A0* =A0 =A0 @card: the MMC card associated with the data transfer
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 4af69d0..e132fa8 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -459,6 +459,14 @@ static int mmc_read_ext_csd(struct mmc_card *c=
ard,
> u8 *ext_csd)
> > =A0 =A0 =A0 =A0}
> >
> > =A0 =A0 =A0 =A0if (card->ext_csd.rev >=3D 5) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check whether the eMMC card suppor=
t BKOPS */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & =
0x1) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops =3D=
 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops_e=
n =3D
> ext_csd[EXT_CSD_BKOPS_EN];
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.raw_bko=
ps_status =3D
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_c=
sd[EXT_CSD_BKOPS_STATUS];
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
>=20
> In my understanding, the EXT_CSD_BKOPS_EN should be _updated_by_ the
> host controller to 1 at initialization time, to indicate to the
> device, as per the spec.
> Otherwise, the device would decide that the host doesn't support
> software controlled BKOPS.
EXT_CSD_BKOPS_EN is a onetime programmable register, which is not suita=
ble for driver to touch I think. This can be updated by host controller=
, but should not happened in driver. This register can be configured by=
 some platform firmware or some eMMC FW from vendor. For what driver ne=
eds to do, is just to read this onetime programmable and to know whethe=
r BKOPS is enabled. It is like hardware reset feature. RST_n_FUNCTION i=
s only a onetime programmable register which can indicate whether hardw=
are reset feature is enabled. Driver just needs to read it out and to k=
now whether hardware reset feature can be used. So I agree with Jaehoon=
 Chung's implementation.

BR
Chuanxiao
