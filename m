From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH v2] mmc: support BKOPS feature for eMMC
Date: Fri, 11 Nov 2011 08:55:11 +0100
Message-ID: <CAFEEs1mKBUqi8HJK3unRh7KMraethMATTTf8Fn6WB2L+ZUqO9g@mail.gmail.com>
References: <4EB11B6B.2010909@samsung.com>
	<CAFEEs1=yF3u-xL6OnEMTfqYx6HgOaePYkhC7iOJi-=z9TjPfmw@mail.gmail.com>
	<CAELcNGQEm073tFsmSgbKzBfx=oYjZDX=EdbgWQOMZEBscsobTw@mail.gmail.com>
	<CAFEEs1==cJ_dYDgesAZcs+E=-jj7-hwwssbAsE4a9AdmED8k3A@mail.gmail.com>
	<CAELcNGTddwX6HtR5vJ+wQChyN5a=mU3Wbd5Hg_EqY72xR7k8dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34899 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab1KKHzM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Nov 2011 02:55:12 -0500
Received: by vws1 with SMTP id 1so3187555vws.19
        for <linux-mmc@vger.kernel.org>; Thu, 10 Nov 2011 23:55:11 -0800 (PST)
In-Reply-To: <CAELcNGTddwX6HtR5vJ+wQChyN5a=mU3Wbd5Hg_EqY72xR7k8dA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jae hoon Chung <jh80.chung@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, svenkatr@ti.com, chuanxiao.dong@intel.com

On Fri, Nov 11, 2011 at 7:24 AM, Jae hoon Chung <jh80.chung@gmail.com> =
wrote:
> Hi per.
>
> 2011/11/8 Per Forlin <per.lkml@gmail.com>:
>> Hi Jaehoon,
>>
>> On Tue, Nov 8, 2011 at 1:43 PM, Jae hoon Chung <jh80.chung@gmail.com=
> wrote:
>>> Hi Per.
>>>
>>> 2011/11/5 Per Forlin <per.lkml@gmail.com>:
>>>> Hi Jaehoon,
>>>>
>>>> On Wed, Nov 2, 2011 at 11:28 AM, Jaehoon Chung <jh80.chung@samsung=
=2Ecom> wrote:
>>>>> Enable eMMC background operations (BKOPS) feature.
>>>>>
>>>>> If URGENT_BKOPS is set after a response, note that BKOPS
>>>>> are required. After all I/O requests are finished, run
>>>>> BKOPS if required. Should read/write operations be requested
>>>>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>>>>> and then service the request.
>>>>>
>>>>> If you want to enable this feature, set MMC_CAP2_BKOPS.
>>>>>
>>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>>> CC: Hanumath Prasad <hanumath.prasad@stericsson.com>
>>>>>
>>>>> ---
>>>>> Changelog V2:
>>>>> =A0 =A0 =A0 =A0- Use EXCEPTION_STATUS instead of URGENT_BKOPS
>>>>> =A0 =A0 =A0 =A0- Add function to check Exception_status(for eMMC4=
=2E5)
>>>>> =A0 =A0 =A0 =A0- remove unnecessary code.
>>>>>
>>>>> =A0drivers/mmc/card/block.c =A0 | =A0 =A09 +++++
>>>>> =A0drivers/mmc/card/queue.c =A0 | =A0 =A04 ++
>>>>> =A0drivers/mmc/core/core.c =A0 =A0| =A0 87 ++++++++++++++++++++++=
++++++++++++++++++++++
>>>>> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0 =A09 ++++-
>>>>> =A0drivers/mmc/core/mmc_ops.c | =A0 =A04 ++
>>>>> =A0include/linux/mmc/card.h =A0 | =A0 12 ++++++
>>>>> =A0include/linux/mmc/core.h =A0 | =A0 =A03 ++
>>>>> =A0include/linux/mmc/host.h =A0 | =A0 =A01 +
>>>>> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 14 +++++++
>>>>> =A09 files changed, 142 insertions(+), 1 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>>>> index a1cb21f..fbfb405 100644
>>>>> --- a/drivers/mmc/card/block.c
>>>>> +++ b/drivers/mmc/card/block.c
>>>>> @@ -1192,6 +1192,15 @@ static int mmc_blk_issue_rw_rq(struct mmc_=
queue *mq, struct request *rqc)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_BLK_SUCCESS:
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_BLK_PARTIAL:
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check BKOPS ur=
gency from each R1 response
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_mmc(ca=
rd) &&
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (br=
q->cmd.resp[0] & R1_EXCEPTION_EVENT)) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if =
(mmc_is_exception_event(card,
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_URGENT_BKOPS))
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 mmc_card_set_need_bkops(card);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * A block was suc=
cessfully transferred.
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_blk_reset_succ=
ess(md, type);
>>>>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>>>>> index dcad59c..20bb4a5 100644
>>>>> --- a/drivers/mmc/card/queue.c
>>>>> +++ b/drivers/mmc/card/queue.c
>>>>> @@ -61,6 +61,9 @@ static int mmc_queue_thread(void *d)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irq(q->queue_lock);
>>>>>
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (req || mq->mqrq_prev->req) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_doing_=
bkops(mq->card))
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc=
_interrupt_bkops(mq->card);
>>>>> +
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_current_state(=
TASK_RUNNING);
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mq->issue_fn(mq, r=
eq);
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>>>>> @@ -68,6 +71,7 @@ static int mmc_queue_thread(void *d)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0se=
t_current_state(TASK_RUNNING);
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0br=
eak;
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_bkops(mq-=
>card);
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up(&mq->thread_sem=
);
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule();
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0down(&mq->thread_s=
em);
>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>> index 5278ffb..41ea923 100644
>>>>> --- a/drivers/mmc/core/core.c
>>>>> +++ b/drivers/mmc/core/core.c
>>>>> @@ -238,6 +238,50 @@ mmc_start_request(struct mmc_host *host, str=
uct mmc_request *mrq)
>>>>> =A0 =A0 =A0 =A0host->ops->request(host, mrq);
>>>>> =A0}
>>>>>
>>>>> +/**
>>>>> + * =A0 =A0 mmc_start_bkops - start BKOPS for supported cards
>>>>> + * =A0 =A0 @card: MMC card to start BKOPS
>>>>> + *
>>>>> + * =A0 =A0 Start background operations whenever requested.
>>>>> + * =A0 =A0 when the urgent BKOPS bit is set in a R1 command resp=
onse
>>>>> + * =A0 =A0 then background operations should be started immediat=
ely.
>>>>> +*/
>>>>> +void mmc_start_bkops(struct mmc_card *card)
>>>>> +{
>>>>> + =A0 =A0 =A0 int err;
>>>>> + =A0 =A0 =A0 unsigned long flags;
>>>>> +
>>>>
>>>>> + =A0 =A0 =A0 card->host->caps2 |=3D MMC_CAP2_BKOPS;
>>>> I guess this should be set by the host driver?
>>> You're right...it's my mistake...i will remove this..
>>>>
>>>>> + =A0 =A0 =A0 if ((!card || !card->ext_csd.bkops_en) &&
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(card->host->caps2=
 & MMC_CAP2_BKOPS))
>>>> I don't really understand this. If card is NULL it will seg-fault.
>>>>
>>>> Do you mean:
>>>> if (!card)
>>>> =A0return
>>>>
>>>> if (!card->ext_csd.bkops_en ||
>>>> =A0 !(card->host->caps2 & MMC_CAP2_BKOPS))
>>>> =A0 =A0return
>>>>
>>>> Do you really need to check card !=3D NULL? Consider BUG_ON
>>> Maybe if (!card && !card->ext_csd.bkops_en) is correctly...i think.=
=2E.
>> If card is NULL it will seg-fault.
>> Did you mean: if (card && !card->ext_csd.bkops_en)
>>
>> I would suggest.
>> # return if card is NULL
>> if (!card)
>> =A0return
>>
>> # if card is set, check the values.
>> if (!card->ext_csd.bkops_en ||
>> =A0 !(card->host->caps2 & MMC_CAP2_BKOPS))
>> =A0 return
>>
> You're right...i will use BUGON()...and modify for ext_bkops_en check=
ing
>>
>>>>
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>>> +
>>>>> + =A0 =A0 =A0 /*
>>>>> + =A0 =A0 =A0 =A0* If card is already doing bkops or need for
>>>>> + =A0 =A0 =A0 =A0* bkops flag is not set, then do nothing just
>>>>> + =A0 =A0 =A0 =A0* return
>>>>> + =A0 =A0 =A0 =A0*/
>>>>> + =A0 =A0 =A0 if (mmc_card_doing_bkops(card)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || !mmc_card_need_b=
kops(card))
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>>> +
>>>>> + =A0 =A0 =A0 mmc_claim_host(card->host);
>>>>> + =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BKOPS_START=
, 1, 0);
>>>>> + =A0 =A0 =A0 if (err) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("error %d starting bkops=
\n", err);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_need_bkops(card);
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>>>> + =A0 =A0 =A0 }
>>>>> + =A0 =A0 =A0 spin_lock_irqsave(&card->host->lock, flags);
>>>>> + =A0 =A0 =A0 mmc_card_clr_need_bkops(card);
>>>>> + =A0 =A0 =A0 mmc_card_set_doing_bkops(card);
>>>>> + =A0 =A0 =A0 spin_unlock_irqrestore(&card->host->lock, flags);
>>>>> +out:
>>>>> + =A0 =A0 =A0 mmc_release_host(card->host);
>>>>> +}
>>>>> +EXPORT_SYMBOL(mmc_start_bkops);
>>>>> +
>>>>> =A0static void mmc_wait_done(struct mmc_request *mrq)
>>>>> =A0{
>>>>> =A0 =A0 =A0 =A0complete(&mrq->completion);
>>>>> @@ -466,6 +510,49 @@ int mmc_wait_for_cmd(struct mmc_host *host, =
struct mmc_command *cmd, int retries
>>>>> =A0EXPORT_SYMBOL(mmc_wait_for_cmd);
>>>>>
>>>>> =A0/**
>>>>> + * =A0 =A0 mmc_interrupt_bkops - interrupt ongoing BKOPS
>>>>> + * =A0 =A0 @card: MMC card to check BKOPS
>>>>> + *
>>>>> + * =A0 =A0 Send HPI command to interrupt ongoing background oper=
ations,
>>>>> + * =A0 =A0 to allow rapid servicing of foreground operations,e.g=
=2E read/
>>>>> + * =A0 =A0 writes. Wait until the card comes out of the programm=
ing state
>>>>> + * =A0 =A0 to avoid errors in servicing read/write requests.
>>>>> + */
>>>>> +int mmc_interrupt_bkops(struct mmc_card *card)
>>>>> +{
>>>>> + =A0 =A0 =A0 int err =3D 0;
>>>>> + =A0 =A0 =A0 unsigned long flags;
>>>>> +
>>>>> + =A0 =A0 =A0 BUG_ON(!card);
>>>>> +
>>>>> + =A0 =A0 =A0 err =3D mmc_interrupt_hpi(card);
>>>>> +
>>>>> + =A0 =A0 =A0 spin_lock_irqsave(&card->host->lock, flags);
>>>>> + =A0 =A0 =A0 mmc_card_clr_doing_bkops(card);
>>>>> + =A0 =A0 =A0 spin_unlock_irqrestore(&card->host->lock, flags);
>>>>> +
>>>>> + =A0 =A0 =A0 return err;
>>>>> +}
>>>>> +EXPORT_SYMBOL(mmc_interrupt_bkops);
>>>>> +
>>>>> +int mmc_is_exception_event(struct mmc_card *card, unsigned int v=
alue)
>>>>> +{
>>>>> + =A0 =A0 =A0 int err;
>>>>> + =A0 =A0 =A0 u8 ext_csd[512];
>>>>> +
>>>>> + =A0 =A0 =A0 /* In eMMC 4.41, R1_EXCEPTION_EVENT is URGENT_BKOPS=
 */
>>>>> + =A0 =A0 =A0 if (card->ext_csd.rev =3D=3D 5)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>>>>> +
>>>>> + =A0 =A0 =A0 err =3D mmc_send_ext_csd(card, ext_csd);
>>>>> + =A0 =A0 =A0 if (err)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>>>>> +
>>>>> + =A0 =A0 =A0 return (ext_csd[EXT_CSD_EXCEPTION_STATUS] & value) =
? 1 : 0;
>>>>> +}
>>>>> +EXPORT_SYMBOL(mmc_is_exception_event);
>>>>> +
>>>>> +/**
>>>>> =A0* =A0 =A0 mmc_set_data_timeout - set the timeout for a data co=
mmand
>>>>> =A0* =A0 =A0 @data: data phase for command
>>>>> =A0* =A0 =A0 @card: the MMC card associated with the data transfe=
r
>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>> index 3627044..af40fbb 100644
>>>>> --- a/drivers/mmc/core/mmc.c
>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>> @@ -448,6 +448,14 @@ static int mmc_read_ext_csd(struct mmc_card =
*card, u8 *ext_csd)
>>>>> =A0 =A0 =A0 =A0}
>>>>>
>>>>> =A0 =A0 =A0 =A0if (card->ext_csd.rev >=3D 5) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check whether the eMMC card supp=
ort BKOPS */
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_BKOPS_SUPPORT] =
& 0x1) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops=
 =3D 1;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops=
_en =3D 1;
>>>> What if the card has not enabled bkops? This bit could be unset.
>>>> card->ext_csd.bkops_en =3D ext_csd[EXT_CSD_BKOPS_EN];
>>> When card is supported the bkops, bkops_en bit is set by default...
>>>
>> How do you know if the bkops_en is really enabled in th ext_csd?
>> It could be unset in the ext_csd, right?
>
> In emmc4.5 spec, if card is supported the bkops, bkops_en is set by d=
efault.
If bkops_en is set by default it should be in the the ext_csd too, righ=
t?
It should be safer to trust the value of ext_csd[EXT_CSD_BKOPS_EN] in
this case I think.

Regards,
Per
