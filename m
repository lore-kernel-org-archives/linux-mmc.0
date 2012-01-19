From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH v6] mmc: support BKOPS feature for eMMC
Date: Thu, 19 Jan 2012 23:22:22 +0900
Message-ID: <CAELcNGQ0n8DXqSCurkyE_q+_C_=X1avHH94g2+eQkptdiX9C_Q@mail.gmail.com>
References: <4F17AA38.3000901@samsung.com>
	<4F17EEBF.2060401@intel.com>
	<4F17FF7D.9090909@samsung.com>
	<4F180202.1030206@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33210 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab2ASOWZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2012 09:22:25 -0500
Received: by bkas6 with SMTP id s6so3806391bka.19
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2012 06:22:24 -0800 (PST)
In-Reply-To: <4F180202.1030206@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Konstantin Dorfman <kdorfman@codeaurora.org>

2012/1/19 Adrian Hunter <adrian.hunter@intel.com>:
> On 19/01/12 13:33, Jaehoon Chung wrote:
>> Hi Adrian.
>>
>> On 01/19/2012 07:21 PM, Adrian Hunter wrote:
>>
>>> On 19/01/12 07:29, Jaehoon Chung wrote:
>>>> Enable eMMC background operations (BKOPS) feature.
>>>>
>>>> If URGENT_BKOPS is set after a response, note that BKOPS
>>>> are required. After all I/O requests are finished, run
>>>> BKOPS if required. Should read/write operations be requested
>>>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>>>> and then service the request.
>>>
>>> This still does not seem to address my earlier comment which was:
>>>
>>> The main problem with bkops is:
>>>
>>> =A0 =A0 =A0If the status is at level 3 ("critical"), some operation=
s
>>> =A0 =A0 =A0may extend beyond their original timeouts due to mainten=
ance
>>> =A0 =A0 =A0operations which cannot be delayed anymore.
>>>
>>> This means:
>>>
>>> =A0 =A0 =A01. at level 3 either bkops are run or the timeout of the=
 next
>>> =A0 =A0 =A0(data?) operation is extended
>>>
>>> =A0 =A0 =A02. at level 3 either the bkops must not be interrupted o=
r the
>>> =A0 =A0 =A0level must be rechecked after interruption and bkops run=
 again
>>> =A0 =A0 =A0if the level is still 3, or the timeout of the next (dat=
a?)
>>> =A0 =A0 =A0operation is extended
>>>
>>
>> This patch didn't issue the HPI when bkops-status is level2-3
>> (URGENT_BKOPS case).
>> I didn't understand that must be recheck?? it's case of using HPI..?
>> If HPI didn't issue,though must be recheck bkops status?
>> And level-1 control should be considered for future-work.
>> I will also modify the patch comment..it's confused something.
>
> 1. Say there are 2 write requests queued and after the first write re=
quest
> the bkops level is 3. =A0That means the 2nd write request may timeout=
 because
> the normal timeout rules do not apply.
>
> Thus:
> =A0 =A0 =A0 =A01. at level 3 either bkops are run or the timeout of t=
he next
> =A0 =A0 =A0 =A0(data?) operation is extended
>
> 2. Say you are running bkops because the level was 3 and a write requ=
est
> arrives. =A0You use HPI to interrupt the bkops, but the bkops level m=
ay still
> be 3, so the write request may timeout. =A0Hence:
>
> =A0 =A0 =A0 =A02. at level 3 either the bkops must not be interrupted=
 or the
> =A0 =A0 =A0 =A0level must be rechecked after interruption and bkops r=
un again
> =A0 =A0 =A0 =A0if the level is still 3, or the timeout of the next (d=
ata?)
> =A0 =A0 =A0 =A0operation is extended
Right...may still be level-3..if use the HPI.

Hmm...
if my understanding is right, it's problem about next request when
running urgnet-bkops.
I will consider your comment...and more thinking for these problem.
Then i will resend the patch..:)

Thanks a lot..Adrian..

Best regards,
Jaehoon Chung
>
>>
>> Thanks,
>> Jaehoon Chung
>>
>>>>
>>>> If you want to enable this feature, set MMC_CAP2_BKOPS.
>>>> And if you want to set the BKOPS_EN bit in ext_csd register,
>>>> use the MMC_CAP2_INIT_BKOPS.
>>>>
>>>> Future considerations
>>>> =A0* Check BKOPS_LEVEL=3D1 and start BKOPS in a preventive manner.
>>>> =A0* Interrupt ongoing BKOPS before powering off the card.
>>>> =A0* How get BKOPS_STATUS value.(periodically send ext_csd command=
?)
>>>>
>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>> ---
>>>> Changelog V6:
>>>> =A0 =A0 - Add the flag of check-bkops-status.
>>>> =A0 =A0 =A0 (For fixing async_req problem)
>>>> =A0 =A0 - Add the capability for MMC_CAP2_INIT_BKOPS.
>>>> =A0 =A0 =A0 (When unset the bkops_en bit in ext_csd register)
>>>> =A0 =A0 - modify the wrong condition.
>>>> Changelog V5:
>>>> =A0 =A0 - Rebase based on the latest mmc-next.
>>>> =A0 =A0 - modify codes based-on Chris's comment
>>>> Changelog V4:
>>>> =A0 =A0 - Add mmc_read_bkops_status
>>>> =A0 =A0 - When URGENT_BKOPS(level2-3), didn't use HPI command.
>>>> =A0 =A0 - In mmc_switch(), use R1B/R1 according to level.
>>>> Changelog V3:
>>>> =A0 =A0 - move the bkops setting's location in mmc_blk_issue_rw_rq
>>>> =A0 =A0 - modify condition checking
>>>> =A0 =A0 - bkops_en is assigned ext_csd[EXT_CSD_BKOPS_EN] instead o=
f "1"
>>>> =A0 =A0 - remove the unused code
>>>> =A0 =A0 - change pr_debug instead of pr_warn in mmc_send_hpi_cmd
>>>> =A0 =A0 - Add the Future consideration suggested by Per
>>>> Changelog V2:
>>>> =A0 =A0 - Use EXCEPTION_STATUS instead of URGENT_BKOPS
>>>> =A0 =A0 - Add function to check Exception_status(for eMMC4.5)
>>>>
>>>> =A0drivers/mmc/card/block.c =A0 | =A0 =A07 +++
>>>> =A0drivers/mmc/card/queue.c =A0 | =A0 =A03 +
>>>> =A0drivers/mmc/core/core.c =A0 =A0| =A0116 +++++++++++++++++++++++=
+++++++++++++++++++++
>>>> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0 18 +++++++
>>>> =A0drivers/mmc/core/mmc_ops.c | =A0 11 ++++-
>>>> =A0include/linux/mmc/card.h =A0 | =A0 20 ++++++++
>>>> =A0include/linux/mmc/core.h =A0 | =A0 =A04 ++
>>>> =A0include/linux/mmc/host.h =A0 | =A0 =A03 +
>>>> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 19 +++++++
>>>> =A09 files changed, 200 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>>>> index 176b78e..743b977 100644
>>>> --- a/drivers/mmc/card/block.c
>>>> +++ b/drivers/mmc/card/block.c
>>>> @@ -1284,6 +1284,13 @@ static int mmc_blk_issue_rw_rq(struct mmc_q=
ueue *mq, struct request *rqc)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 type =3D rq_data_dir(req) =3D=3D READ ? MM=
C_BLK_READ : MMC_BLK_WRITE;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 mmc_queue_bounce_post(mq_rq);
>>>>
>>>> + =A0 =A0 =A0 =A0 =A0 /*
>>>> + =A0 =A0 =A0 =A0 =A0 =A0* Check BKOPS urgency from each R1 respon=
se
>>>> + =A0 =A0 =A0 =A0 =A0 =A0*/
>>>> + =A0 =A0 =A0 =A0 =A0 if (mmc_card_mmc(card) &&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (brq->cmd.resp[0] & R1_EXCEP=
TION_EVENT))
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set=
_check_bkops(card);
>>>> +
>>>> =A0 =A0 =A0 =A0 =A0 =A0 switch (status) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BLK_SUCCESS:
>>>> =A0 =A0 =A0 =A0 =A0 =A0 case MMC_BLK_PARTIAL:
>>>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>>>> index 2517547..fd11a31 100644
>>>> --- a/drivers/mmc/card/queue.c
>>>> +++ b/drivers/mmc/card/queue.c
>>>> @@ -66,6 +66,8 @@ static int mmc_queue_thread(void *d)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(q->queue_lock);
>>>>
>>>> =A0 =A0 =A0 =A0 =A0 =A0 if (req || mq->mqrq_prev->req) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_doing_bkops(mq-=
>card))
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_interrup=
t_bkops(mq->card);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_current_state(TASK_RUN=
NING);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->issue_fn(mq, req);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 } else {
>>>> @@ -73,6 +75,7 @@ static int mmc_queue_thread(void *d)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_curren=
t_state(TASK_RUNNING);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_bkops(mq->card);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&mq->thread_sem);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule();
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 down(&mq->thread_sem);
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index bec0bf2..9cfb356 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -238,6 +238,59 @@ mmc_start_request(struct mmc_host *host, stru=
ct mmc_request *mrq)
>>>> =A0 =A0 host->ops->request(host, mrq);
>>>> =A0}
>>>>
>>>> +/**
>>>> + * mmc_start_bkops - start BKOPS for supported cards
>>>> + * @card: MMC card to start BKOPS
>>>> + *
>>>> + * Start background operations whenever requested.
>>>> + * when the urgent BKOPS bit is set in a R1 command response
>>>> + * then background operations should be started immediately.
>>>> +*/
>>>> +void mmc_start_bkops(struct mmc_card *card)
>>>> +{
>>>> + =A0 int err;
>>>> + =A0 unsigned long flags;
>>>> +
>>>> + =A0 BUG_ON(!card);
>>>> + =A0 if (!card->ext_csd.bkops_en || !(card->host->caps2 & MMC_CAP=
2_BKOPS))
>>>> + =A0 =A0 =A0 =A0 =A0 return;
>>>> +
>>>> + =A0 if (mmc_card_check_bkops(card)) {
>>>> + =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&card->host->lock, flags);
>>>> + =A0 =A0 =A0 =A0 =A0 mmc_card_clr_check_bkops(card);
>>>> + =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&card->host->lock, fl=
ags);
>>>> + =A0 =A0 =A0 =A0 =A0 if (mmc_is_exception_event(card, EXT_CSD_URG=
ENT_BKOPS))
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_set_need_bkops(card=
);
>>>> + =A0 }
>>>> +
>>>> + =A0 /*
>>>> + =A0 =A0* If card is already doing bkops or need for
>>>> + =A0 =A0* bkops flag is not set, then do nothing just
>>>> + =A0 =A0* return
>>>> + =A0 =A0*/
>>>> + =A0 if (mmc_card_doing_bkops(card) || !mmc_card_need_bkops(card)=
)
>>>> + =A0 =A0 =A0 =A0 =A0 return;
>>>> +
>>>> + =A0 mmc_claim_host(card->host);
>>>> + =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BKOPS_START, 1, 0);
>>>> + =A0 if (err) {
>>>> + =A0 =A0 =A0 =A0 =A0 pr_warning("%s: error %d starting bkops\n",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(card->ho=
st), err);
>>>> + =A0 =A0 =A0 =A0 =A0 mmc_card_clr_need_bkops(card);
>>>> + =A0 =A0 =A0 =A0 =A0 goto out;
>>>> + =A0 }
>>>> +
>>>> + =A0 spin_lock_irqsave(&card->host->lock, flags);
>>>> + =A0 mmc_card_clr_need_bkops(card);
>>>> + =A0 if (card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL_2)
>>>> + =A0 =A0 =A0 =A0 =A0 mmc_card_set_doing_bkops(card);
>>>> + =A0 spin_unlock_irqrestore(&card->host->lock, flags);
>>>> +out:
>>>> + =A0 mmc_release_host(card->host);
>>>> +}
>>>> +EXPORT_SYMBOL(mmc_start_bkops);
>>>> +
>>>> =A0static void mmc_wait_done(struct mmc_request *mrq)
>>>> =A0{
>>>> =A0 =A0 complete(&mrq->completion);
>>>> @@ -472,6 +525,69 @@ int mmc_wait_for_cmd(struct mmc_host *host, s=
truct mmc_command *cmd, int retries
>>>> =A0EXPORT_SYMBOL(mmc_wait_for_cmd);
>>>>
>>>> =A0/**
>>>> + * mmc_interrupt_bkops - interrupt ongoing BKOPS
>>>> + * @card: MMC card to check BKOPS
>>>> + *
>>>> + * Send HPI command to interrupt ongoing background operations,
>>>> + * to allow rapid servicing of foreground operations,e.g. read/
>>>> + * writes. Wait until the card comes out of the programming state
>>>> + * to avoid errors in servicing read/write requests.
>>>> + */
>>>> +int mmc_interrupt_bkops(struct mmc_card *card)
>>>> +{
>>>> + =A0 int err =3D 0;
>>>> + =A0 unsigned long flags;
>>>> +
>>>> + =A0 BUG_ON(!card);
>>>> +
>>>> + =A0 err =3D mmc_interrupt_hpi(card);
>>>> +
>>>> + =A0 spin_lock_irqsave(&card->host->lock, flags);
>>>> + =A0 mmc_card_clr_doing_bkops(card);
>>>> + =A0 spin_unlock_irqrestore(&card->host->lock, flags);
>>>> +
>>>> + =A0 return err;
>>>> +}
>>>> +EXPORT_SYMBOL(mmc_interrupt_bkops);
>>>> +
>>>> +int mmc_read_bkops_status(struct mmc_card *card)
>>>> +{
>>>> + =A0 int err;
>>>> + =A0 u8 ext_csd[512];
>>>> +
>>>> + =A0 mmc_claim_host(card->host);
>>>> + =A0 err =3D mmc_send_ext_csd(card, ext_csd);
>>>> + =A0 mmc_release_host(card->host);
>>>> + =A0 if (err)
>>>> + =A0 =A0 =A0 =A0 =A0 return err;
>>>> +
>>>> + =A0 card->ext_csd.raw_bkops_status =3D ext_csd[EXT_CSD_BKOPS_STA=
TUS];
>>>> + =A0 card->ext_csd.raw_exception_status =3D ext_csd[EXT_CSD_EXCEP=
TION_STATUS];
>>>> +
>>>> + =A0 return 0;
>>>> +}
>>>> +EXPORT_SYMBOL(mmc_read_bkops_status);
>>>> +
>>>> +int mmc_is_exception_event(struct mmc_card *card, unsigned int va=
lue)
>>>> +{
>>>> + =A0 int err;
>>>> +
>>>> + =A0 err =3D mmc_read_bkops_status(card);
>>>> + =A0 if (err) {
>>>> + =A0 =A0 =A0 =A0 =A0 pr_err("%s: Didn't read bkops status : %d\n"=
,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(card->host), err=
);
>>>> + =A0 =A0 =A0 =A0 =A0 return 0;
>>>> + =A0 }
>>>> +
>>>> + =A0 /* In eMMC 4.41, R1_EXCEPTION_EVENT is URGENT_BKOPS */
>>>> + =A0 if (card->ext_csd.rev =3D=3D 5)
>>>> + =A0 =A0 =A0 =A0 =A0 return 1;
>>>> +
>>>> + =A0 return (card->ext_csd.raw_exception_status & value) ? 1 : 0;
>>>> +}
>>>> +EXPORT_SYMBOL(mmc_is_exception_event);
>>>> +
>>>> +/**
>>>> =A0 * mmc_set_data_timeout - set the timeout for a data command
>>>> =A0 * @data: data phase for command
>>>> =A0 * @card: the MMC card associated with the data transfer
>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>> index dc03291..7ca2315 100644
>>>> --- a/drivers/mmc/core/mmc.c
>>>> +++ b/drivers/mmc/core/mmc.c
>>>> @@ -480,6 +480,24 @@ static int mmc_read_ext_csd(struct mmc_card *=
card, u8 *ext_csd)
>>>> =A0 =A0 }
>>>>
>>>> =A0 =A0 if (card->ext_csd.rev >=3D 5) {
>>>> + =A0 =A0 =A0 =A0 =A0 /* check whether the eMMC card support BKOPS=
 */
>>>> + =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops =3D 1;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops_en =3D e=
xt_csd[EXT_CSD_BKOPS_EN];
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.raw_bkops_stat=
us =3D
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_=
CSD_BKOPS_STATUS];
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!card->ext_csd.bkops_en =
&&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->host->=
caps2 & MMC_CAP2_INIT_BKOPS) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_=
switch(card, EXT_CSD_CMD_SET_NORMAL,
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 EXT_CSD_BKOPS_EN, 1, 0);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 pr_warning("%s: Enabling BKOPS failed\n",
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host));
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 card->ext_csd.bkops_en =3D 1;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>> + =A0 =A0 =A0 =A0 =A0 }
>>>> +
>>>> =A0 =A0 =A0 =A0 =A0 =A0 /* check whether the eMMC card supports HP=
I */
>>>> =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hpi =3D 1;
>>>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops=
=2Ec
>>>> index 4d41fa9..109d0f0 100644
>>>> --- a/drivers/mmc/core/mmc_ops.c
>>>> +++ b/drivers/mmc/core/mmc_ops.c
>>>> @@ -392,13 +392,22 @@ int mmc_switch(struct mmc_card *card, u8 set=
, u8 index, u8 value,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 (index << 16) |
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 (value << 8) |
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 set;
>>>> - =A0 cmd.flags =3D MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>>>> + =A0 cmd.flags =3D MMC_CMD_AC;
>>>> + =A0 if (index =3D=3D EXT_CSD_BKOPS_START &&
>>>> + =A0 =A0 =A0 card->ext_csd.raw_bkops_status < EXT_CSD_BKOPS_LEVEL=
_2)
>>>> + =A0 =A0 =A0 =A0 =A0 cmd.flags |=3D MMC_RSP_SPI_R1 | MMC_RSP_R1;
>>>> + =A0 else
>>>> + =A0 =A0 =A0 =A0 =A0 cmd.flags |=3D MMC_RSP_SPI_R1B | MMC_RSP_R1B=
;
>>>> =A0 =A0 cmd.cmd_timeout_ms =3D timeout_ms;
>>>>
>>>> =A0 =A0 err =3D mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES=
);
>>>> =A0 =A0 if (err)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 return err;
>>>>
>>>> + =A0 /* No need to check card status in case of BKOPS switch*/
>>>> + =A0 if (index =3D=3D EXT_CSD_BKOPS_START)
>>>> + =A0 =A0 =A0 =A0 =A0 return 0;
>>>> +
>>>> =A0 =A0 /* Must check status to be sure of no errors */
>>>> =A0 =A0 do {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_send_status(card, &status);
>>>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>>>> index f9a0663..d87f58c 100644
>>>> --- a/include/linux/mmc/card.h
>>>> +++ b/include/linux/mmc/card.h
>>>> @@ -71,10 +71,13 @@ struct mmc_ext_csd {
>>>> =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hpi_en; =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* HPI enablebit */
>>>> =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hpi; =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* HPI support bit */
>>>> =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0hpi_cmd; =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0/* cmd used as HPI */
>>>> + =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bkops; =A0 =A0 =A0=
 =A0 =A0/* background support bit */
>>>> + =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bkops_en; =A0 =A0=
 =A0 /* background enable bit */
>>>> =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0data_sector_size; =A0 =
=A0 =A0 /* 512 bytes or 4KB */
>>>> =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0data_tag_unit_size; =A0=
 =A0 /* DATA TAG UNIT size */
>>>> =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0boot_ro_lock; =A0 =A0 =
=A0 =A0 =A0 /* ro lock support */
>>>> =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0boot_ro_lockab=
le;
>>>> + =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_exception_=
status; =A0 /* 53 */
>>>> =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_partitio=
n_support; =A0/* 160 */
>>>> =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_erased_m=
em_count; =A0 /* 181 */
>>>> =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_ext_csd_=
structure; =A0/* 194 */
>>>> @@ -88,6 +91,7 @@ struct mmc_ext_csd {
>>>> =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_sec_eras=
e_mult; =A0 =A0 /* 230 */
>>>> =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_sec_feat=
ure_support;/* 231 */
>>>> =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_trim_mul=
t; =A0 =A0 =A0 =A0 =A0/* 232 */
>>>> + =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_bkops_stat=
us; =A0 =A0 =A0 /* 246 */
>>>> =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_sectors[=
4]; =A0 =A0 =A0 =A0 /* 212 - 4 bytes */
>>>>
>>>> =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0feature_support;
>>>> @@ -219,6 +223,10 @@ struct mmc_card {
>>>> =A0#define MMC_CARD_SDXC =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<6) =A0 =A0=
 =A0 =A0 =A0/* card is SDXC */
>>>> =A0#define MMC_CARD_REMOVED =A0 (1<<7) =A0 =A0 =A0 =A0 =A0/* card =
has been removed */
>>>> =A0#define MMC_STATE_HIGHSPEED_200 =A0 =A0(1<<8) =A0 =A0 =A0 =A0 =A0=
/* card is in HS200 mode */
>>>> +#define MMC_STATE_NEED_BKOPS =A0 =A0 =A0 (1<<9) =A0 =A0 =A0 =A0 =A0=
/* card need to do BKOPS */
>>>> +#define MMC_STATE_DOING_BKOPS =A0 =A0 =A0(1<<10) =A0 =A0 =A0 =A0 =
/* card is doing BKOPS */
>>>> +#define MMC_STATE_CHECK_BKOPS =A0 =A0 =A0(1<<11) =A0 =A0 =A0 =A0 =
/* card need to check BKOPS */
>>>> +
>>>> =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0 =A0 =A0=
 /* card quirks */
>>>> =A0#define MMC_QUIRK_LENIENT_FN0 =A0 =A0 =A0(1<<0) =A0 =A0 =A0 =A0=
 =A0/* allow SDIO FN0 writes outside of the VS CCCR range */
>>>> =A0#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) =A0 =A0 =A0 /* use=
 func->cur_blksize */
>>>> @@ -384,6 +392,10 @@ static inline void __maybe_unused remove_quir=
k(struct mmc_card *card, int data)
>>>> =A0#define mmc_sd_card_uhs(c) ((c)->state & MMC_STATE_ULTRAHIGHSPE=
ED)
>>>> =A0#define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
>>>> =A0#define mmc_card_removed(c) =A0 =A0 =A0 =A0((c) && ((c)->state =
& MMC_CARD_REMOVED))
>>>> +#define mmc_card_need_bkops(c) =A0 =A0 ((c)->state & MMC_STATE_NE=
ED_BKOPS)
>>>> +#define mmc_card_doing_bkops(c) =A0 =A0((c)->state & MMC_STATE_DO=
ING_BKOPS)
>>>> +#define mmc_card_check_bkops(c) ((c)->state & MMC_STATE_CHECK_BKO=
PS)
>>>> +
>>>>
>>>> =A0#define mmc_card_set_present(c) =A0 =A0((c)->state |=3D MMC_STA=
TE_PRESENT)
>>>> =A0#define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_REA=
DONLY)
>>>> @@ -395,6 +407,14 @@ static inline void __maybe_unused remove_quir=
k(struct mmc_card *card, int data)
>>>> =A0#define mmc_sd_card_set_uhs(c) ((c)->state |=3D MMC_STATE_ULTRA=
HIGHSPEED)
>>>> =A0#define mmc_card_set_ext_capacity(c) ((c)->state |=3D MMC_CARD_=
SDXC)
>>>> =A0#define mmc_card_set_removed(c) ((c)->state |=3D MMC_CARD_REMOV=
ED)
>>>> +#define mmc_card_set_need_bkops(c) ((c)->state |=3D MMC_STATE_NEE=
D_BKOPS)
>>>> +#define mmc_card_set_doing_bkops(c) =A0 =A0 =A0 =A0((c)->state |=3D=
 MMC_STATE_DOING_BKOPS)
>>>> +#define mmc_card_set_check_bkops(c) ((c)->state |=3D MMC_STATE_CH=
ECK_BKOPS)
>>>> +
>>>> +#define mmc_card_clr_need_bkops(c) ((c)->state &=3D ~MMC_STATE_NE=
ED_BKOPS)
>>>> +#define mmc_card_clr_doing_bkops(c) =A0 =A0 =A0 =A0((c)->state &=3D=
 ~MMC_STATE_DOING_BKOPS)
>>>> +#define mmc_card_clr_check_bkops(c) ((c)->state &=3D ~MMC_STATE_C=
HECK_BKOPS)
>>>> +
>>>>
>>>> =A0/*
>>>> =A0 * Quirk add/remove for MMC products.
>>>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>>>> index 87a976c..45357c7 100644
>>>> --- a/include/linux/mmc/core.h
>>>> +++ b/include/linux/mmc/core.h
>>>> @@ -134,6 +134,9 @@ struct mmc_host;
>>>> =A0struct mmc_card;
>>>> =A0struct mmc_async_req;
>>>>
>>>> +extern int mmc_interrupt_bkops(struct mmc_card *);
>>>> +extern int mmc_read_bkops_status(struct mmc_card *);
>>>> +extern int mmc_is_exception_event(struct mmc_card *, unsigned int=
);
>>>> =A0extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0struct mmc_async_req *, int *);
>>>> =A0extern int mmc_interrupt_hpi(struct mmc_card *);
>>>> @@ -163,6 +166,7 @@ extern int mmc_can_sanitize(struct mmc_card *c=
ard);
>>>> =A0extern int mmc_can_secure_erase_trim(struct mmc_card *card);
>>>> =A0extern int mmc_erase_group_aligned(struct mmc_card *card, unsig=
ned int from,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uns=
igned int nr);
>>>> +extern void mmc_start_bkops(struct mmc_card *card);
>>>> =A0extern unsigned int mmc_calc_max_discard(struct mmc_card *card)=
;
>>>>
>>>> =A0extern int mmc_set_blocklen(struct mmc_card *card, unsigned int=
 blocklen);
>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>> index dd13e05..8432e6a 100644
>>>> --- a/include/linux/mmc/host.h
>>>> +++ b/include/linux/mmc/host.h
>>>> @@ -257,6 +257,9 @@ struct mmc_host {
>>>> =A0#define MMC_CAP2_HS200_1_2V_SDR =A0 =A0(1 << 6) =A0 =A0 =A0 =A0=
/* can support */
>>>> =A0#define MMC_CAP2_HS200 =A0 =A0 =A0 =A0 =A0 =A0 (MMC_CAP2_HS200_=
1_8V_SDR | \
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_CAP=
2_HS200_1_2V_SDR)
>>>> +#define MMC_CAP2_BKOPS =A0 =A0 =A0 =A0 =A0 =A0 (1 << 7) =A0 =A0 =A0=
 =A0/* BKOPS supported */
>>>> +#define MMC_CAP2_INIT_BKOPS =A0 =A0 =A0 =A0(1 << 8) =A0 =A0 =A0 =A0=
/* Need to set BKOPS_EN */
>>>> +
>>>>
>>>> =A0 =A0 mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0 =A0=
/* supported pm features */
>>>> =A0 =A0 unsigned int =A0 =A0 =A0 =A0power_notify_type;
>>>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>>>> index b822a2c..9760c70 100644
>>>> --- a/include/linux/mmc/mmc.h
>>>> +++ b/include/linux/mmc/mmc.h
>>>> @@ -139,6 +139,7 @@ static inline bool mmc_op_multi(u32 opcode)
>>>> =A0#define R1_CURRENT_STATE(x) =A0 =A0 =A0 =A0((x & 0x00001E00) >>=
 9) /* sx, b (4 bits) */
>>>> =A0#define R1_READY_FOR_DATA =A0(1 << 8) =A0 =A0 =A0 =A0/* sx, a *=
/
>>>> =A0#define R1_SWITCH_ERROR =A0 =A0 =A0 =A0 =A0 =A0(1 << 7) =A0 =A0=
 =A0 =A0/* sx, c */
>>>> +#define R1_EXCEPTION_EVENT (1 << 6) =A0 =A0 =A0 =A0/* sx, a */
>>>> =A0#define R1_APP_CMD =A0 =A0 =A0 =A0 (1 << 5) =A0 =A0 =A0 =A0/* s=
r, c */
>>>>
>>>> =A0#define R1_STATE_IDLE =A0 =A0 =A00
>>>> @@ -274,12 +275,15 @@ struct _mmc_csd {
>>>> =A0#define EXT_CSD_FLUSH_CACHE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A032 =A0=
 =A0 =A0/* W */
>>>> =A0#define EXT_CSD_CACHE_CTRL =A0 =A0 =A0 =A0 33 =A0 =A0 =A0/* R/W=
 */
>>>> =A0#define EXT_CSD_POWER_OFF_NOTIFICATION =A0 =A0 34 =A0 =A0 =A0/*=
 R/W */
>>>> +#define EXT_CSD_EXCEPTION_STATUS =A0 54 =A0 =A0 =A0/* RO */
>>>> =A0#define EXT_CSD_DATA_SECTOR_SIZE =A0 61 =A0 =A0 =A0/* R */
>>>> =A0#define EXT_CSD_GP_SIZE_MULT =A0 =A0 =A0 =A0 =A0 =A0 =A0 143 =A0=
 =A0 /* R/W */
>>>> =A0#define EXT_CSD_PARTITION_ATTRIBUTE =A0 =A0 =A0 =A0156 =A0 =A0 =
/* R/W */
>>>> =A0#define EXT_CSD_PARTITION_SUPPORT =A0160 =A0 =A0 /* RO */
>>>> =A0#define EXT_CSD_HPI_MGMT =A0 =A0 =A0 =A0 =A0 161 =A0 =A0 /* R/W=
 */
>>>> =A0#define EXT_CSD_RST_N_FUNCTION =A0 =A0 =A0 =A0 =A0 =A0 162 =A0 =
=A0 /* R/W */
>>>> +#define EXT_CSD_BKOPS_EN =A0 =A0 =A0 =A0 =A0 163 =A0 =A0 /* R/W *=
/
>>>> +#define EXT_CSD_BKOPS_START =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0164 =A0=
 =A0 /* W */
>>>> =A0#define EXT_CSD_SANITIZE_START =A0 =A0 =A0 =A0 =A0 =A0 165 =A0 =
=A0 /* W */
>>>> =A0#define EXT_CSD_WR_REL_PARAM =A0 =A0 =A0 =A0 =A0 =A0 =A0 166 =A0=
 =A0 /* RO */
>>>> =A0#define EXT_CSD_BOOT_WP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
173 =A0 =A0 /* R/W */
>>>> @@ -313,11 +317,13 @@ struct _mmc_csd {
>>>> =A0#define EXT_CSD_PWR_CL_200_360 =A0 =A0 =A0 =A0 =A0 =A0 237 =A0 =
=A0 /* RO */
>>>> =A0#define EXT_CSD_PWR_CL_DDR_52_195 =A0238 =A0 =A0 /* RO */
>>>> =A0#define EXT_CSD_PWR_CL_DDR_52_360 =A0239 =A0 =A0 /* RO */
>>>> +#define EXT_CSD_BKOPS_STATUS =A0 =A0 =A0 =A0 =A0 =A0 =A0 246 =A0 =
=A0 /* RO */
>>>> =A0#define EXT_CSD_POWER_OFF_LONG_TIME =A0 =A0 =A0 =A0247 =A0 =A0 =
/* RO */
>>>> =A0#define EXT_CSD_GENERIC_CMD6_TIME =A0248 =A0 =A0 /* RO */
>>>> =A0#define EXT_CSD_CACHE_SIZE =A0 =A0 =A0 =A0 249 =A0 =A0 /* RO, 4=
 bytes */
>>>> =A0#define EXT_CSD_TAG_UNIT_SIZE =A0 =A0 =A0 =A0 =A0 =A0 =A0498 =A0=
 =A0 /* RO */
>>>> =A0#define EXT_CSD_DATA_TAG_SUPPORT =A0 499 =A0 =A0 /* RO */
>>>> +#define EXT_CSD_BKOPS_SUPPORT =A0 =A0 =A0 =A0 =A0 =A0 =A0502 =A0 =
=A0 /* RO */
>>>> =A0#define EXT_CSD_HPI_FEATURES =A0 =A0 =A0 =A0 =A0 =A0 =A0 503 =A0=
 =A0 /* RO */
>>>>
>>>> =A0/*
>>>> @@ -446,4 +452,17 @@ struct _mmc_csd {
>>>> =A0#define MMC_SWITCH_MODE_CLEAR_BITS 0x02 =A0 =A0/* Clear bits wh=
ich are 1 in value */
>>>> =A0#define MMC_SWITCH_MODE_WRITE_BYTE 0x03 =A0 =A0/* Set target to=
 value */
>>>>
>>>> +/*
>>>> + * BKOPS status level
>>>> + */
>>>> +#define EXT_CSD_BKOPS_LEVEL_2 =A0 =A0 =A0 =A0 =A0 =A0 =A00x2
>>>> +
>>>> +/*
>>>> + * EXCEPTION_EVENT_STATUS field (eMMC4.5)
>>>> + */
>>>> +#define EXT_CSD_URGENT_BKOPS =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)
>>>> +#define EXT_CSD_DYNCAP_NEEDED =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(1)
>>>> +#define EXT_CSD_SYSPOOL_EXHAUSTED =A0BIT(2)
>>>> +#define EXT_CSD_PACKED_FAILURE =A0 =A0 =A0 =A0 =A0 =A0 BIT(3)
>>>> +
>>>> =A0#endif /* LINUX_MMC_MMC_H */
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
