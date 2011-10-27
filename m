From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] mmc: support BKOPS feature for eMMC
Date: Thu, 27 Oct 2011 21:56:57 +0900
Message-ID: <CAH9JG2XxiYmNY684e+uZaSnJs43n+9n8r9q-wiUSjE-3P1BhhQ@mail.gmail.com>
References: <4EA93C08.9030009@samsung.com>
	<5D8008F58939784290FAB48F549751984E2334B1C6@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:40862 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522Ab1J0M47 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2011 08:56:59 -0400
Received: by vcge1 with SMTP id e1so2372262vcg.19
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2011 05:56:58 -0700 (PDT)
In-Reply-To: <5D8008F58939784290FAB48F549751984E2334B1C6@shsmsx502.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Hanumath Prasad <hanumath.prasad@stericsson.com>

Hi,

On Thu, Oct 27, 2011 at 8:37 PM, Dong, Chuanxiao
<chuanxiao.dong@intel.com> wrote:
>
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org
>> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Jaehoon Chung
>> Sent: Thursday, October 27, 2011 7:10 PM
>> To: linux-mmc
>> Cc: Chris Ball; Kyungmin Park; Hanumath Prasad
>> Subject: [PATCH] mmc: support BKOPS feature for eMMC
>>
>> Background operation(BKOPS) is one of eMMC's features.
>>
>> If set the URGENT_BKOPS in response, we can notify that card nedd th=
e BKOPS.
>> And all I/O request is done, then run background operation.
>> If request read/write operation during BKOPS, issue HPI interrupt.
>>
>> If you want to use this feature, should be set MMC_CAP2_BKOPS.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> CC: Hanumath Prasad <hanumath.prasad@stericsson.com>
>> ---
>> =A0drivers/mmc/card/block.c =A0 | =A0 13 +++++++-
>> =A0drivers/mmc/card/queue.c =A0 | =A0 =A01 +
>> =A0drivers/mmc/core/core.c =A0 =A0| =A0 77
>> ++++++++++++++++++++++++++++++++++++++++++++
>> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0 21 ++++++++++++
>> =A0drivers/mmc/core/mmc_ops.c | =A0 =A04 ++
>> =A0include/linux/mmc/card.h =A0 | =A0 11 ++++++
>> =A0include/linux/mmc/core.h =A0 | =A0 =A02 +
>> =A0include/linux/mmc/host.h =A0 | =A0 =A01 +
>> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 =A04 ++
>> =A09 files changed, 133 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 4fd5723..edbed7a 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1185,14 +1185,25 @@ static int mmc_blk_issue_rw_rq(struct mmc_qu=
eue
>> *mq, struct request *rqc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 type =3D rq_data_dir(req) =3D=3D READ ? =
MMC_BLK_READ : MMC_BLK_WRITE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_queue_bounce_post(mq_rq);
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_doing_bkops(card)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_interrupt_bkops(ca=
rd))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto cmd_a=
bort;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (status) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BLK_SUCCESS:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BLK_PARTIAL:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check BKOPS urgency f=
rom each R1 response
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_mmc(card) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (brq->cmd.=
resp[0] & R1_URGENT_BKOPS))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_s=
et_need_bkops(card);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* A block was success=
fully transferred.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_reset_success(md=
, type);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&md->lock);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D __blk_end_reques=
t(req, 0,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 brq->data.bytes_xfered);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&md->loc=
k);
>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>> index dcad59c..31e5eca 100644
>> --- a/drivers/mmc/card/queue.c
>> +++ b/drivers/mmc/card/queue.c
>> @@ -68,6 +68,7 @@ static int mmc_queue_thread(void *d)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_curr=
ent_state(TASK_RUNNING);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_bkops(mq->card);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&mq->thread_sem);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 down(&mq->thread_sem);
> Maybe put mmc_interrupt_bkops(card) here is better, I think.
>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 5278ffb..7ef270d 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -238,6 +238,50 @@ mmc_start_request(struct mmc_host *host, struct
>> mmc_request *mrq)
>> =A0 =A0 =A0 host->ops->request(host, mrq);
>> =A0}
>>
>> +/**
>> + * =A0 mmc_start_bkops - start BKOPS for supported cards
>> + * =A0 @card: MMC card to start BKOPS
>> + *
>> + * =A0 Start background operations whenever requested.
>> + * =A0 when the urgent BKOPS bit is set in a R1 command response
>> + * =A0 then background operations should be started immediately.
>> +*/
>> +void mmc_start_bkops(struct mmc_card *card)
>> +{
>> + =A0 =A0 int err;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 if ((!card || !card->ext_csd.bkops_en) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(card->host->caps2 & MMC_=
CAP2_BKOPS))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* If card is already doing bkops or need for
>> + =A0 =A0 =A0* bkops flag is not set, then do nothing just
>> + =A0 =A0 =A0* return
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (mmc_card_doing_bkops(card)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || !mmc_card_need_bkops(ca=
rd))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 mmc_claim_host(card->host);
>> + =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BKOPS_START, 1, 0)=
;
>> + =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("error %d starting bkops\n", er=
r);
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_need_bkops(card);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 }
>> + =A0 =A0 spin_lock_irqsave(&card->host->lock, flags);
>> + =A0 =A0 mmc_card_clr_need_bkops(card);
>> + =A0 =A0 mmc_card_set_doing_bkops(card);
>> + =A0 =A0 spin_unlock_irqrestore(&card->host->lock, flags);
>> +out:
>> + =A0 =A0 mmc_release_host(card->host);
>> +}
>> +EXPORT_SYMBOL(mmc_start_bkops);
>> +
>> +
>> =A0static void mmc_wait_done(struct mmc_request *mrq)
>> =A0{
>> =A0 =A0 =A0 complete(&mrq->completion);
>> @@ -466,6 +510,39 @@ int mmc_wait_for_cmd(struct mmc_host *host, str=
uct
>> mmc_command *cmd, int retries
>> =A0EXPORT_SYMBOL(mmc_wait_for_cmd);
>>
>> =A0/**
>> + * =A0 mmc_interrupt_bkops - interrupt ongoing BKOPS
>> + * =A0 @card: MMC card to check BKOPS
>> + *
>> + * =A0 Send HPI command to interrupt ongoing background operations,
>> + * =A0 to allow rapid servicing of foreground operations,e.g. read/
>> + * =A0 writes. Wait until the card comes out of the programming sta=
te
>> + * =A0 to avoid errors in servicing read/write requests.
>> + */
>> +int mmc_interrupt_bkops(struct mmc_card *card)
>> +{
>> + =A0 =A0 int err;
>> + =A0 =A0 unsigned long flags;
>> + =A0 =A0 u32 status;
>> +
>> + =A0 =A0 BUG_ON(!card);
>> +
>> + =A0 =A0 /* send HPI to interrupt BKOPS. */
>> + =A0 =A0 err =3D mmc_send_hpi_cmd(card, &status);
> What will be happened if eMMC card only support BKOPS but not support=
 HPI?

Basically v4.41 and v4.5 doesn't mentioned the BKOPS timeout so if
there's no HPI command, it should wait until BKOPS is done. It seems
to be shown system hang.
>
>> + =A0 =A0 if (err || R1_CURRENT_STATE(status) =3D=3D 7) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_status(ca=
rd, &status);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } while (R1_CURRENT_STATE(status) =3D=3D 7=
);
>> + =A0 =A0 }
>> + =A0 =A0 spin_lock_irqsave(&card->host->lock, flags);
>> + =A0 =A0 mmc_card_clr_doing_bkops(card);
>> + =A0 =A0 spin_unlock_irqrestore(&card->host->lock, flags);
>> + =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL(mmc_interrupt_bkops);
>> +
>> +/**
>> =A0 * =A0 mmc_set_data_timeout - set the timeout for a data command
>> =A0 * =A0 @data: data phase for command
>> =A0 * =A0 @card: the MMC card associated with the data transfer
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 3627044..b16db45 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -448,6 +448,10 @@ static int mmc_read_ext_csd(struct mmc_card *ca=
rd, u8
>> *ext_csd)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 if (card->ext_csd.rev >=3D 5) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* check whether the eMMC card support BKO=
PS */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops =3D 1;
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check whether the eMMC card supports =
HPI */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1)=
 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hpi =3D 1;
>> @@ -909,6 +913,23 @@ static int mmc_init_card(struct mmc_host *host,=
 u32 ocr,
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 /*
>> + =A0 =A0 =A0* enable BKOPS feature (if supported)
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (card->ext_csd.bkops) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_N=
ORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BKOPS_EN, 1, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Enabling B=
KOPS failed\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostna=
me(card->host));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops_en =3D=
 1;
>> + =A0 =A0 }
> Just found this bit is one time programmable, so that is to say this =
bit is not suitable for driver to change.
You mean require the BKOPS_EN_FORCE config if user want to use at kerne=
l?
>
>> +
>> + =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Enable HPI feature (if supported)
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 if (card->ext_csd.hpi) {
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index 007863e..7653e33 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -398,6 +398,10 @@ int mmc_switch(struct mmc_card *card, u8 set, u=
8 index,
>> u8 value,
>> =A0 =A0 =A0 if (err)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>>
>> + =A0 =A0 /* No need to check card status in case of BKOPS switch*/
>> + =A0 =A0 if (index =3D=3D EXT_CSD_BKOPS_START)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> =A0 =A0 =A0 /* Must check status to be sure of no errors */
>> =A0 =A0 =A0 do {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_status(card, &status);
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index 6e04e10..f4abb7c 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -71,6 +71,8 @@ struct mmc_ext_csd {
>> =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hpi_en; =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 /* HPI enablebit */
>> =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hpi; =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* HPI support bit */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0hpi_cmd; =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* cmd used as HPI */
>> + =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bkops; =A0 =A0=
 =A0 =A0 =A0/* background support bit */
>> + =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bkops_en; =A0 =
=A0 =A0 /* background enable bit */
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_partit=
ion_support; =A0/* 160 */
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_erased=
_mem_count; =A0 /* 181 */
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_ext_cs=
d_structure; =A0/* 194 */
>> @@ -206,6 +208,8 @@ struct mmc_card {
>> =A0#define MMC_STATE_HIGHSPEED_DDR (1<<4) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 /* card is in high speed mode
>> */
>> =A0#define MMC_STATE_ULTRAHIGHSPEED (1<<5) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
/* card is in ultra high speed
>> mode */
>> =A0#define MMC_CARD_SDXC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<6) =A0 =A0=
 =A0 =A0 =A0/* card is SDXC */
>> +#define MMC_STATE_NEED_BKOPS (1<<7) =A0 =A0 =A0 =A0 =A0/* card need=
 to do BKOPS */
>> +#define MMC_STATE_DOING_BKOPS =A0 =A0 =A0 =A0(1<<8) =A0 =A0 =A0 =A0=
 =A0/* card is doing BKOPS */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0 =A0 =
=A0 /* card quirks */
>> =A0#define MMC_QUIRK_LENIENT_FN0 =A0 =A0 =A0 =A0(1<<0) =A0 =A0 =A0 =A0=
 =A0/* allow SDIO FN0 writes
>> outside of the VS CCCR range */
>> =A0#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) /* use func->cur_blk=
size
>> */
>> @@ -365,6 +369,8 @@ static inline void __maybe_unused remove_quirk(s=
truct
>> mmc_card *card, int data)
>> =A0#define mmc_card_ddr_mode(c) ((c)->state & MMC_STATE_HIGHSPEED_DD=
R)
>> =A0#define mmc_sd_card_uhs(c) ((c)->state & MMC_STATE_ULTRAHIGHSPEED=
)
>> =A0#define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
>> +#define mmc_card_need_bkops(c) =A0 =A0 =A0 ((c)->state & MMC_STATE_=
NEED_BKOPS)
>> +#define mmc_card_doing_bkops(c) =A0 =A0 =A0((c)->state & MMC_STATE_=
DOING_BKOPS)
>>
>> =A0#define mmc_card_set_present(c) =A0 =A0 =A0((c)->state |=3D MMC_S=
TATE_PRESENT)
>> =A0#define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_READO=
NLY)
>> @@ -373,6 +379,11 @@ static inline void __maybe_unused remove_quirk(=
struct
>> mmc_card *card, int data)
>> =A0#define mmc_card_set_ddr_mode(c) ((c)->state |=3D
>> MMC_STATE_HIGHSPEED_DDR)
>> =A0#define mmc_sd_card_set_uhs(c) ((c)->state |=3D MMC_STATE_ULTRAHI=
GHSPEED)
>> =A0#define mmc_card_set_ext_capacity(c) ((c)->state |=3D MMC_CARD_SD=
XC)
>> +#define mmc_card_set_need_bkops(c) =A0 ((c)->state |=3D
>> MMC_STATE_NEED_BKOPS)
>> +#define mmc_card_set_doing_bkops(c) =A0((c)->state |=3D
>> MMC_STATE_DOING_BKOPS)
>> +
>> +#define mmc_card_clr_need_bkops(c) =A0 ((c)->state &=3D ~MMC_STATE_=
NEED_BKOPS)
>> +#define mmc_card_clr_doing_bkops(c) =A0((c)->state &=3D
>> ~MMC_STATE_DOING_BKOPS)
>>
>> =A0/*
>> =A0 * Quirk add/remove for MMC products.
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>> index 174a844..600a177 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -134,6 +134,7 @@ struct mmc_host;
>> =A0struct mmc_card;
>> =A0struct mmc_async_req;
>>
>> +extern int mmc_interrupt_bkops(struct mmc_card *);
>> =A0extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0struct mmc_async_req *, int *);
>> =A0extern int mmc_interrupt_hpi(struct mmc_card *);
>> @@ -163,6 +164,7 @@ extern int mmc_can_sanitize(struct mmc_card *car=
d);
>> =A0extern int mmc_can_secure_erase_trim(struct mmc_card *card);
>> =A0extern int mmc_erase_group_aligned(struct mmc_card *card, unsigne=
d int from,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u=
nsigned int nr);
>> +extern void mmc_start_bkops(struct mmc_card *card);
>> =A0extern unsigned int mmc_calc_max_discard(struct mmc_card *card);
>>
>> =A0extern int mmc_set_blocklen(struct mmc_card *card, unsigned int b=
locklen);
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index a3ac9c4..692e5f6 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -242,6 +242,7 @@ struct mmc_host {
>> =A0#define MMC_CAP2_CACHE_CTRL =A0(1 << 1) =A0 =A0 =A0 =A0/* Allow c=
ache control */
>> =A0#define MMC_CAP2_POWEROFF_NOTIFY (1 << 2) =A0 =A0/* Notify powero=
ff supported
>> */
>> =A0#define MMC_CAP2_NO_MULTI_READ =A0 =A0 =A0 (1 << 3) =A0 =A0 =A0 =A0=
/* Multiblock reads don't
>> work */
>> +#define MMC_CAP2_BKOPS =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 4) =A0 =A0=
 =A0 =A0/* BKOPS supported */
>>
>> =A0 =A0 =A0 mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0 =A0=
/* supported pm features */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0power_notify_type;
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index 0e71356..283b848 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -138,6 +138,7 @@ static inline bool mmc_op_multi(u32 opcode)
>> =A0#define R1_CURRENT_STATE(x) =A0((x & 0x00001E00) >> 9) /* sx, b (=
4 bits) */
>> =A0#define R1_READY_FOR_DATA =A0 =A0(1 << 8) =A0 =A0 =A0 =A0/* sx, a=
 */
>> =A0#define R1_SWITCH_ERROR =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7) =A0 =A0=
 =A0 =A0/* sx, c */
>> +#define R1_URGENT_BKOPS =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 6) =A0 =A0=
 =A0 =A0/* sx, a */
>> =A0#define R1_APP_CMD =A0 =A0 =A0 =A0 =A0 (1 << 5) =A0 =A0 =A0 =A0/*=
 sr, c */
>>
>> =A0#define R1_STATE_IDLE =A0 =A0 =A0 =A00
>> @@ -278,6 +279,8 @@ struct _mmc_csd {
>> =A0#define EXT_CSD_PARTITION_SUPPORT =A0 =A0160 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_HPI_MGMT =A0 =A0 =A0 =A0 =A0 =A0 161 =A0 =A0 /* R=
/W */
>> =A0#define EXT_CSD_RST_N_FUNCTION =A0 =A0 =A0 =A0 =A0 =A0 =A0 162 =A0=
 =A0 /* R/W */
>> +#define EXT_CSD_BKOPS_EN =A0 =A0 =A0 =A0 =A0 =A0 163 =A0 =A0 /* R/W=
 */
>> +#define EXT_CSD_BKOPS_START =A0 =A0 =A0 =A0 =A0164 =A0 =A0 /* W */
>> =A0#define EXT_CSD_SANITIZE_START =A0 =A0 =A0 =A0 =A0 =A0 =A0 165 =A0=
 =A0 /* W */
>> =A0#define EXT_CSD_WR_REL_PARAM =A0 =A0 =A0 =A0 166 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_ERASE_GROUP_DEF =A0 =A0 =A0 =A0 =A0 =A0 =A0175 =A0=
 =A0 /* R/W */
>> @@ -313,6 +316,7 @@ struct _mmc_csd {
>> =A0#define EXT_CSD_POWER_OFF_LONG_TIME =A0247 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_GENERIC_CMD6_TIME =A0 =A0248 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_CACHE_SIZE =A0 =A0 =A0 =A0 =A0 249 =A0 =A0 /* RO,=
 4 bytes */
>> +#define EXT_CSD_BKOPS_SUPPORT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0502 =A0=
 =A0 /* RO */
>> =A0#define EXT_CSD_HPI_FEATURES =A0 =A0 =A0 =A0 503 =A0 =A0 /* RO */
>>
>> =A0/*
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
