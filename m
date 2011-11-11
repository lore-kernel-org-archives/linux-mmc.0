From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH v2] mmc: support BKOPS feature for eMMC
Date: Fri, 11 Nov 2011 15:24:32 +0900
Message-ID: <CAELcNGTddwX6HtR5vJ+wQChyN5a=mU3Wbd5Hg_EqY72xR7k8dA@mail.gmail.com>
References: <4EB11B6B.2010909@samsung.com>
	<CAFEEs1=yF3u-xL6OnEMTfqYx6HgOaePYkhC7iOJi-=z9TjPfmw@mail.gmail.com>
	<CAELcNGQEm073tFsmSgbKzBfx=oYjZDX=EdbgWQOMZEBscsobTw@mail.gmail.com>
	<CAFEEs1==cJ_dYDgesAZcs+E=-jj7-hwwssbAsE4a9AdmED8k3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54919 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468Ab1KKGYe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Nov 2011 01:24:34 -0500
Received: by eye27 with SMTP id 27so3118297eye.19
        for <linux-mmc@vger.kernel.org>; Thu, 10 Nov 2011 22:24:33 -0800 (PST)
In-Reply-To: <CAFEEs1==cJ_dYDgesAZcs+E=-jj7-hwwssbAsE4a9AdmED8k3A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, svenkatr@ti.com, chuanxiao.dong@intel.com

Hi per.

2011/11/8 Per Forlin <per.lkml@gmail.com>:
> Hi Jaehoon,
>
> On Tue, Nov 8, 2011 at 1:43 PM, Jae hoon Chung <jh80.chung@gmail.com>=
 wrote:
>> Hi Per.
>>
>> 2011/11/5 Per Forlin <per.lkml@gmail.com>:
>>> Hi Jaehoon,
>>>
>>> On Wed, Nov 2, 2011 at 11:28 AM, Jaehoon Chung <jh80.chung@samsung.=
com> wrote:
>>>> Enable eMMC background operations (BKOPS) feature.
>>>>
>>>> If URGENT_BKOPS is set after a response, note that BKOPS
>>>> are required. After all I/O requests are finished, run
>>>> BKOPS if required. Should read/write operations be requested
>>>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>>>> and then service the request.
>>>>
>>>> If you want to enable this feature, set MMC_CAP2_BKOPS.
>>>>
>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>> CC: Hanumath Prasad <hanumath.prasad@stericsson.com>
>>>>
>>>> ---
>>>> Changelog V2:
>>>> =A0 =A0 =A0 =A0- Use EXCEPTION_STATUS instead of URGENT_BKOPS
>>>> =A0 =A0 =A0 =A0- Add function to check Exception_status(for eMMC4.=
5)
>>>> =A0 =A0 =A0 =A0- remove unnecessary code.
>>>>
>>>> =A0drivers/mmc/card/block.c =A0 | =A0 =A09 +++++
>>>> =A0drivers/mmc/card/queue.c =A0 | =A0 =A04 ++
>>>> =A0drivers/mmc/core/core.c =A0 =A0| =A0 87 +++++++++++++++++++++++=
+++++++++++++++++++++
>>>> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0 =A09 ++++-
>>>> =A0drivers/mmc/core/mmc_ops.c | =A0 =A04 ++
>>>> =A0include/linux/mmc/card.h =A0 | =A0 12 ++++++
>>>> =A0include/linux/mmc/core.h =A0 | =A0 =A03 ++
>>>> =A0include/linux/mmc/host.h =A0 | =A0 =A01 +
>>>> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 14 +++++++
>>>> =A09 files changed, 142 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>>> index a1cb21f..fbfb405 100644
>>>> --- a/drivers/mmc/card/block.c
>>>> +++ b/drivers/mmc/card/block.c
>>>> @@ -1192,6 +1192,15 @@ static int mmc_blk_issue_rw_rq(struct mmc_q=
ueue *mq, struct request *rqc)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_BLK_SUCCESS:
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_BLK_PARTIAL:
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check BKOPS urg=
ency from each R1 response
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_mmc(car=
d) &&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (brq=
->cmd.resp[0] & R1_EXCEPTION_EVENT)) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (=
mmc_is_exception_event(card,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_URGENT_BKOPS))
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 mmc_card_set_need_bkops(card);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * A block was succ=
essfully transferred.
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_blk_reset_succe=
ss(md, type);
>>>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>>>> index dcad59c..20bb4a5 100644
>>>> --- a/drivers/mmc/card/queue.c
>>>> +++ b/drivers/mmc/card/queue.c
>>>> @@ -61,6 +61,9 @@ static int mmc_queue_thread(void *d)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irq(q->queue_lock);
>>>>
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (req || mq->mqrq_prev->req) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_doing_b=
kops(mq->card))
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_=
interrupt_bkops(mq->card);
>>>> +
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_current_state(T=
ASK_RUNNING);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mq->issue_fn(mq, re=
q);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>>>> @@ -68,6 +71,7 @@ static int mmc_queue_thread(void *d)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set=
_current_state(TASK_RUNNING);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bre=
ak;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_bkops(mq->=
card);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up(&mq->thread_sem)=
;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule();
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0down(&mq->thread_se=
m);
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index 5278ffb..41ea923 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -238,6 +238,50 @@ mmc_start_request(struct mmc_host *host, stru=
ct mmc_request *mrq)
>>>> =A0 =A0 =A0 =A0host->ops->request(host, mrq);
>>>> =A0}
>>>>
>>>> +/**
>>>> + * =A0 =A0 mmc_start_bkops - start BKOPS for supported cards
>>>> + * =A0 =A0 @card: MMC card to start BKOPS
>>>> + *
>>>> + * =A0 =A0 Start background operations whenever requested.
>>>> + * =A0 =A0 when the urgent BKOPS bit is set in a R1 command respo=
nse
>>>> + * =A0 =A0 then background operations should be started immediate=
ly.
>>>> +*/
>>>> +void mmc_start_bkops(struct mmc_card *card)
>>>> +{
>>>> + =A0 =A0 =A0 int err;
>>>> + =A0 =A0 =A0 unsigned long flags;
>>>> +
>>>
>>>> + =A0 =A0 =A0 card->host->caps2 |=3D MMC_CAP2_BKOPS;
>>> I guess this should be set by the host driver?
>> You're right...it's my mistake...i will remove this..
>>>
>>>> + =A0 =A0 =A0 if ((!card || !card->ext_csd.bkops_en) &&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(card->host->caps2 =
& MMC_CAP2_BKOPS))
>>> I don't really understand this. If card is NULL it will seg-fault.
>>>
>>> Do you mean:
>>> if (!card)
>>> =A0return
>>>
>>> if (!card->ext_csd.bkops_en ||
>>> =A0 !(card->host->caps2 & MMC_CAP2_BKOPS))
>>> =A0 =A0return
>>>
>>> Do you really need to check card !=3D NULL? Consider BUG_ON
>> Maybe if (!card && !card->ext_csd.bkops_en) is correctly...i think..=
=2E
> If card is NULL it will seg-fault.
> Did you mean: if (card && !card->ext_csd.bkops_en)
>
> I would suggest.
> # return if card is NULL
> if (!card)
> =A0return
>
> # if card is set, check the values.
> if (!card->ext_csd.bkops_en ||
> =A0 !(card->host->caps2 & MMC_CAP2_BKOPS))
> =A0 return
>
You're right...i will use BUGON()...and modify for ext_bkops_en checkin=
g
>
>>>
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>> +
>>>> + =A0 =A0 =A0 /*
>>>> + =A0 =A0 =A0 =A0* If card is already doing bkops or need for
>>>> + =A0 =A0 =A0 =A0* bkops flag is not set, then do nothing just
>>>> + =A0 =A0 =A0 =A0* return
>>>> + =A0 =A0 =A0 =A0*/
>>>> + =A0 =A0 =A0 if (mmc_card_doing_bkops(card)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || !mmc_card_need_bk=
ops(card))
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>> +
>>>> + =A0 =A0 =A0 mmc_claim_host(card->host);
>>>> + =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BKOPS_START,=
 1, 0);
>>>> + =A0 =A0 =A0 if (err) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("error %d starting bkops\=
n", err);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_need_bkops(card);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>> + =A0 =A0 =A0 }
>>>> + =A0 =A0 =A0 spin_lock_irqsave(&card->host->lock, flags);
>>>> + =A0 =A0 =A0 mmc_card_clr_need_bkops(card);
>>>> + =A0 =A0 =A0 mmc_card_set_doing_bkops(card);
>>>> + =A0 =A0 =A0 spin_unlock_irqrestore(&card->host->lock, flags);
>>>> +out:
>>>> + =A0 =A0 =A0 mmc_release_host(card->host);
>>>> +}
>>>> +EXPORT_SYMBOL(mmc_start_bkops);
>>>> +
>>>> =A0static void mmc_wait_done(struct mmc_request *mrq)
>>>> =A0{
>>>> =A0 =A0 =A0 =A0complete(&mrq->completion);
>>>> @@ -466,6 +510,49 @@ int mmc_wait_for_cmd(struct mmc_host *host, s=
truct mmc_command *cmd, int retries
>>>> =A0EXPORT_SYMBOL(mmc_wait_for_cmd);
>>>>
>>>> =A0/**
>>>> + * =A0 =A0 mmc_interrupt_bkops - interrupt ongoing BKOPS
>>>> + * =A0 =A0 @card: MMC card to check BKOPS
>>>> + *
>>>> + * =A0 =A0 Send HPI command to interrupt ongoing background opera=
tions,
>>>> + * =A0 =A0 to allow rapid servicing of foreground operations,e.g.=
 read/
>>>> + * =A0 =A0 writes. Wait until the card comes out of the programmi=
ng state
>>>> + * =A0 =A0 to avoid errors in servicing read/write requests.
>>>> + */
>>>> +int mmc_interrupt_bkops(struct mmc_card *card)
>>>> +{
>>>> + =A0 =A0 =A0 int err =3D 0;
>>>> + =A0 =A0 =A0 unsigned long flags;
>>>> +
>>>> + =A0 =A0 =A0 BUG_ON(!card);
>>>> +
>>>> + =A0 =A0 =A0 err =3D mmc_interrupt_hpi(card);
>>>> +
>>>> + =A0 =A0 =A0 spin_lock_irqsave(&card->host->lock, flags);
>>>> + =A0 =A0 =A0 mmc_card_clr_doing_bkops(card);
>>>> + =A0 =A0 =A0 spin_unlock_irqrestore(&card->host->lock, flags);
>>>> +
>>>> + =A0 =A0 =A0 return err;
>>>> +}
>>>> +EXPORT_SYMBOL(mmc_interrupt_bkops);
>>>> +
>>>> +int mmc_is_exception_event(struct mmc_card *card, unsigned int va=
lue)
>>>> +{
>>>> + =A0 =A0 =A0 int err;
>>>> + =A0 =A0 =A0 u8 ext_csd[512];
>>>> +
>>>> + =A0 =A0 =A0 /* In eMMC 4.41, R1_EXCEPTION_EVENT is URGENT_BKOPS =
*/
>>>> + =A0 =A0 =A0 if (card->ext_csd.rev =3D=3D 5)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>>>> +
>>>> + =A0 =A0 =A0 err =3D mmc_send_ext_csd(card, ext_csd);
>>>> + =A0 =A0 =A0 if (err)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>>>> +
>>>> + =A0 =A0 =A0 return (ext_csd[EXT_CSD_EXCEPTION_STATUS] & value) ?=
 1 : 0;
>>>> +}
>>>> +EXPORT_SYMBOL(mmc_is_exception_event);
>>>> +
>>>> +/**
>>>> =A0* =A0 =A0 mmc_set_data_timeout - set the timeout for a data com=
mand
>>>> =A0* =A0 =A0 @data: data phase for command
>>>> =A0* =A0 =A0 @card: the MMC card associated with the data transfer
>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>> index 3627044..af40fbb 100644
>>>> --- a/drivers/mmc/core/mmc.c
>>>> +++ b/drivers/mmc/core/mmc.c
>>>> @@ -448,6 +448,14 @@ static int mmc_read_ext_csd(struct mmc_card *=
card, u8 *ext_csd)
>>>> =A0 =A0 =A0 =A0}
>>>>
>>>> =A0 =A0 =A0 =A0if (card->ext_csd.rev >=3D 5) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check whether the eMMC card suppo=
rt BKOPS */
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_BKOPS_SUPPORT] &=
 0x1) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops =
=3D 1;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops_=
en =3D 1;
>>> What if the card has not enabled bkops? This bit could be unset.
>>> card->ext_csd.bkops_en =3D ext_csd[EXT_CSD_BKOPS_EN];
>> When card is supported the bkops, bkops_en bit is set by default...
>>
> How do you know if the bkops_en is really enabled in th ext_csd?
> It could be unset in the ext_csd, right?

In emmc4.5 spec, if card is supported the bkops, bkops_en is set by def=
ault.
So i didn't assign ext_csd[EXT_CSD_BKOPS_EN], because maybe should be
set by defalut
when is supported the bkops. if i think wrong, plz let me know.

Best Regards,
Jaehoon Chung
>
>>>
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.raw_bk=
ops_status =3D
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_=
csd[EXT_CSD_BKOPS_STATUS];
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>> +
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* check whether the eMMC card supp=
orts HPI */
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ext_csd[EXT_CSD_HPI_FEATURES] &=
 0x1) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.hpi =3D=
 1;
>>>> @@ -498,7 +506,6 @@ static inline void mmc_free_ext_csd(u8 *ext_cs=
d)
>>>> =A0 =A0 =A0 =A0kfree(ext_csd);
>>>> =A0}
>>>>
>>>> -
>>>> =A0static int mmc_compare_ext_csds(struct mmc_card *card, unsigned=
 bus_width)
>>>> =A0{
>>>> =A0 =A0 =A0 =A0u8 *bw_ext_csd;
>>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops=
=2Ec
>>>> index 007863e..7653e33 100644
>>>> --- a/drivers/mmc/core/mmc_ops.c
>>>> +++ b/drivers/mmc/core/mmc_ops.c
>>>> @@ -398,6 +398,10 @@ int mmc_switch(struct mmc_card *card, u8 set,=
 u8 index, u8 value,
>>>> =A0 =A0 =A0 =A0if (err)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>>>>
>>>> + =A0 =A0 =A0 /* No need to check card status in case of BKOPS swi=
tch*/
>>>> + =A0 =A0 =A0 if (index =3D=3D EXT_CSD_BKOPS_START)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>>> +
>>>> =A0 =A0 =A0 =A0/* Must check status to be sure of no errors */
>>>> =A0 =A0 =A0 =A0do {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_send_status(card, &stat=
us);
>>>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>>>> index 415f2db..34740c5 100644
>>>> --- a/include/linux/mmc/card.h
>>>> +++ b/include/linux/mmc/card.h
>>>> @@ -71,6 +71,8 @@ struct mmc_ext_csd {
>>>> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hpi_en;=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* HPI enablebit */
>>>> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hpi; =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* HPI support bit */
>>>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0hpi_cmd; =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0/* cmd used as HPI */
>>>> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bkops; =A0=
 =A0 =A0 =A0 =A0/* background support bit */
>>>> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bkops_en=
; =A0 =A0 =A0 /* background enable bit */
>>>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_p=
artition_support; =A0/* 160 */
>>>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_e=
rased_mem_count; =A0 /* 181 */
>>>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_e=
xt_csd_structure; =A0/* 194 */
>>>> @@ -84,6 +86,7 @@ struct mmc_ext_csd {
>>>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_s=
ec_erase_mult; =A0 =A0 /* 230 */
>>>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_s=
ec_feature_support;/* 231 */
>>>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_t=
rim_mult; =A0 =A0 =A0 =A0 =A0/* 232 */
>>>> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_bk=
ops_status; =A0 =A0 =A0 /* 246 */
>>>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_s=
ectors[4]; =A0 =A0 =A0 =A0 /* 212 - 4 bytes */
>>>>
>>>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0feature_support=
;
>>>> @@ -206,6 +209,8 @@ struct mmc_card {
>>>> =A0#define MMC_STATE_HIGHSPEED_DDR (1<<4) =A0 =A0 =A0 =A0 /* card =
is in high speed mode */
>>>> =A0#define MMC_STATE_ULTRAHIGHSPEED (1<<5) =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0/* card is in ultra high speed mode */
>>>> =A0#define MMC_CARD_SDXC =A0 =A0 =A0 =A0 =A0(1<<6) =A0 =A0 =A0 =A0=
 =A0/* card is SDXC */
>>>> +#define MMC_STATE_NEED_BKOPS =A0 (1<<7) =A0 =A0 =A0 =A0 =A0/* car=
d need to do BKOPS */
>>>> +#define MMC_STATE_DOING_BKOPS =A0(1<<8) =A0 =A0 =A0 =A0 =A0/* car=
d is doing BKOPS */
>>>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0=
 =A0 =A0 /* card quirks */
>>>> =A0#define MMC_QUIRK_LENIENT_FN0 =A0(1<<0) =A0 =A0 =A0 =A0 =A0/* a=
llow SDIO FN0 writes outside of the VS CCCR range */
>>>> =A0#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) =A0 /* use func->c=
ur_blksize */
>>>> @@ -365,6 +370,8 @@ static inline void __maybe_unused remove_quirk=
(struct mmc_card *card, int data)
>>>> =A0#define mmc_card_ddr_mode(c) =A0 ((c)->state & MMC_STATE_HIGHSP=
EED_DDR)
>>>> =A0#define mmc_sd_card_uhs(c) ((c)->state & MMC_STATE_ULTRAHIGHSPE=
ED)
>>>> =A0#define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
>>>> +#define mmc_card_need_bkops(c) ((c)->state & MMC_STATE_NEED_BKOPS=
)
>>>> +#define mmc_card_doing_bkops(c) =A0 =A0 =A0 =A0((c)->state & MMC_=
STATE_DOING_BKOPS)
>>>>
>>>> =A0#define mmc_card_set_present(c) =A0 =A0 =A0 =A0((c)->state |=3D=
 MMC_STATE_PRESENT)
>>>> =A0#define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_REA=
DONLY)
>>>> @@ -373,6 +380,11 @@ static inline void __maybe_unused remove_quir=
k(struct mmc_card *card, int data)
>>>> =A0#define mmc_card_set_ddr_mode(c) ((c)->state |=3D MMC_STATE_HIG=
HSPEED_DDR)
>>>> =A0#define mmc_sd_card_set_uhs(c) ((c)->state |=3D MMC_STATE_ULTRA=
HIGHSPEED)
>>>> =A0#define mmc_card_set_ext_capacity(c) ((c)->state |=3D MMC_CARD_=
SDXC)
>>>> +#define mmc_card_set_need_bkops(c) =A0 =A0 ((c)->state |=3D MMC_S=
TATE_NEED_BKOPS)
>>>> +#define mmc_card_set_doing_bkops(c) =A0 =A0((c)->state |=3D MMC_S=
TATE_DOING_BKOPS)
>>>> +
>>>> +#define mmc_card_clr_need_bkops(c) =A0 =A0 ((c)->state &=3D ~MMC_=
STATE_NEED_BKOPS)
>>>> +#define mmc_card_clr_doing_bkops(c) =A0 =A0((c)->state &=3D ~MMC_=
STATE_DOING_BKOPS)
>>>>
>>>> =A0/*
>>>> =A0* Quirk add/remove for MMC products.
>>>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>>>> index 174a844..f6b997a 100644
>>>> --- a/include/linux/mmc/core.h
>>>> +++ b/include/linux/mmc/core.h
>>>> @@ -134,6 +134,8 @@ struct mmc_host;
>>>> =A0struct mmc_card;
>>>> =A0struct mmc_async_req;
>>>>
>>>> +extern int mmc_interrupt_bkops(struct mmc_card *);
>>>> +extern int mmc_is_exception_event(struct mmc_card *, unsigned int=
);
>>>> =A0extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 struct mmc_async_req *, int *);
>>>> =A0extern int mmc_interrupt_hpi(struct mmc_card *);
>>>> @@ -163,6 +165,7 @@ extern int mmc_can_sanitize(struct mmc_card *c=
ard);
>>>> =A0extern int mmc_can_secure_erase_trim(struct mmc_card *card);
>>>> =A0extern int mmc_erase_group_aligned(struct mmc_card *card, unsig=
ned int from,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 unsigned int nr);
>>>> +extern void mmc_start_bkops(struct mmc_card *card);
>>>> =A0extern unsigned int mmc_calc_max_discard(struct mmc_card *card)=
;
>>>>
>>>> =A0extern int mmc_set_blocklen(struct mmc_card *card, unsigned int=
 blocklen);
>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>> index a3ac9c4..692e5f6 100644
>>>> --- a/include/linux/mmc/host.h
>>>> +++ b/include/linux/mmc/host.h
>>>> @@ -242,6 +242,7 @@ struct mmc_host {
>>>> =A0#define MMC_CAP2_CACHE_CTRL =A0 =A0(1 << 1) =A0 =A0 =A0 =A0/* A=
llow cache control */
>>>> =A0#define MMC_CAP2_POWEROFF_NOTIFY (1 << 2) =A0 =A0 =A0/* Notify =
poweroff supported */
>>>> =A0#define MMC_CAP2_NO_MULTI_READ (1 << 3) =A0 =A0 =A0 =A0/* Multi=
block reads don't work */
>>>> +#define MMC_CAP2_BKOPS =A0 =A0 =A0 =A0 (1 << 4) =A0 =A0 =A0 =A0/*=
 BKOPS supported */
>>>>
>>>> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =
=A0 =A0/* supported pm features */
>>>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0power_notify_type;
>>>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>>>> index 0e71356..20b1420 100644
>>>> --- a/include/linux/mmc/mmc.h
>>>> +++ b/include/linux/mmc/mmc.h
>>>> @@ -138,6 +138,7 @@ static inline bool mmc_op_multi(u32 opcode)
>>>> =A0#define R1_CURRENT_STATE(x) =A0 =A0((x & 0x00001E00) >> 9) /* s=
x, b (4 bits) */
>>>> =A0#define R1_READY_FOR_DATA =A0 =A0 =A0(1 << 8) =A0 =A0 =A0 =A0/*=
 sx, a */
>>>> =A0#define R1_SWITCH_ERROR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7)=
 =A0 =A0 =A0 =A0/* sx, c */
>>>> +#define R1_EXCEPTION_EVENT =A0 =A0 (1 << 6) =A0 =A0 =A0 =A0/* sx,=
 a */
>>>> =A0#define R1_APP_CMD =A0 =A0 =A0 =A0 =A0 =A0 (1 << 5) =A0 =A0 =A0=
 =A0/* sr, c */
>>>>
>>>> =A0#define R1_STATE_IDLE =A00
>>>> @@ -273,11 +274,14 @@ struct _mmc_csd {
>>>> =A0#define EXT_CSD_FLUSH_CACHE =A0 =A0 =A0 =A0 =A0 =A032 =A0 =A0 =A0=
/* W */
>>>> =A0#define EXT_CSD_CACHE_CTRL =A0 =A0 =A0 =A0 =A0 =A0 33 =A0 =A0 =A0=
/* R/W */
>>>> =A0#define EXT_CSD_POWER_OFF_NOTIFICATION 34 =A0 =A0 =A0/* R/W */
>>>> +#define EXT_CSD_EXCEPTION_STATUS =A0 =A0 =A0 54 =A0 =A0 =A0/* RO =
*/
>>>> =A0#define EXT_CSD_GP_SIZE_MULT =A0 =A0 =A0 =A0 =A0 143 =A0 =A0 /*=
 R/W */
>>>> =A0#define EXT_CSD_PARTITION_ATTRIBUTE =A0 =A0156 =A0 =A0 /* R/W *=
/
>>>> =A0#define EXT_CSD_PARTITION_SUPPORT =A0 =A0 =A0160 =A0 =A0 /* RO =
*/
>>>> =A0#define EXT_CSD_HPI_MGMT =A0 =A0 =A0 =A0 =A0 =A0 =A0 161 =A0 =A0=
 /* R/W */
>>>> =A0#define EXT_CSD_RST_N_FUNCTION =A0 =A0 =A0 =A0 162 =A0 =A0 /* R=
/W */
>>>> +#define EXT_CSD_BKOPS_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 163 =A0 =A0 =
/* R/W */
>>>> +#define EXT_CSD_BKOPS_START =A0 =A0 =A0 =A0 =A0 =A0164 =A0 =A0 /*=
 W */
>>>> =A0#define EXT_CSD_SANITIZE_START =A0 =A0 =A0 =A0 165 =A0 =A0 /* W=
 */
>>>> =A0#define EXT_CSD_WR_REL_PARAM =A0 =A0 =A0 =A0 =A0 166 =A0 =A0 /*=
 RO */
>>>> =A0#define EXT_CSD_ERASE_GROUP_DEF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
175 =A0 =A0 /* R/W */
>>>> @@ -310,9 +314,11 @@ struct _mmc_csd {
>>>> =A0#define EXT_CSD_PWR_CL_200_360 =A0 =A0 =A0 =A0 237 =A0 =A0 /* R=
O */
>>>> =A0#define EXT_CSD_PWR_CL_DDR_52_195 =A0 =A0 =A0238 =A0 =A0 /* RO =
*/
>>>> =A0#define EXT_CSD_PWR_CL_DDR_52_360 =A0 =A0 =A0239 =A0 =A0 /* RO =
*/
>>>> +#define EXT_CSD_BKOPS_STATUS =A0 =A0 =A0 =A0 =A0 246 =A0 =A0 /* R=
O */
>>>> =A0#define EXT_CSD_POWER_OFF_LONG_TIME =A0 =A0247 =A0 =A0 /* RO */
>>>> =A0#define EXT_CSD_GENERIC_CMD6_TIME =A0 =A0 =A0248 =A0 =A0 /* RO =
*/
>>>> =A0#define EXT_CSD_CACHE_SIZE =A0 =A0 =A0 =A0 =A0 =A0 249 =A0 =A0 =
/* RO, 4 bytes */
>>>> +#define EXT_CSD_BKOPS_SUPPORT =A0 =A0 =A0 =A0 =A0502 =A0 =A0 /* R=
O */
>>>> =A0#define EXT_CSD_HPI_FEATURES =A0 =A0 =A0 =A0 =A0 503 =A0 =A0 /*=
 RO */
>>>>
>>>> =A0/*
>>>> @@ -373,4 +379,12 @@ struct _mmc_csd {
>>>> =A0#define MMC_SWITCH_MODE_CLEAR_BITS =A0 =A0 0x02 =A0 =A0/* Clear=
 bits which are 1 in value */
>>>> =A0#define MMC_SWITCH_MODE_WRITE_BYTE =A0 =A0 0x03 =A0 =A0/* Set t=
arget to value */
>>>>
>>>> +/*
>>>> + * EXCEPTION_EVENT_STATUS field (eMMC4.5)
>>>> + */
>>>> +#define EXT_CSD_URGENT_BKOPS =A0 =A0 =A0 =A0 =A0 BIT(0)
>>>> +#define EXT_CSD_DYNCAP_NEEDED =A0 =A0 =A0 =A0 =A0BIT(1)
>>>> +#define EXT_CSD_SYSPOOL_EXHAUSTED =A0 =A0 =A0BIT(2)
>>>> +#define EXT_CSD_PACKED_FAILURE =A0 =A0 =A0 =A0 BIT(3)
>>>> +
>>>> =A0#endif /* LINUX_MMC_MMC_H */
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>>>
>>>
>>> Regards,
>>> Per
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>
>
