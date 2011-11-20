From: "Konstantin Dorfman" <kdorfman@codeaurora.org>
Subject: Re: [PATCH v3] mmc: support BKOPS feature for eMMC
Date: Sun, 20 Nov 2011 18:12:19 +0200 (IST)
Message-ID: <b1420856d6d04502786262d58234f78c.squirrel@www.codeaurora.org>
References: <4EC45A39.5030706@samsung.com>
    <000301cca539$c3bdb350$4b3919f0$@org>
    <CAFEEs1=f+CG6g7eu84g6kG5tueqfV1rukzb3gX5-dZWmuO0s_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:45666 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387Ab1KTQMT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Nov 2011 11:12:19 -0500
In-Reply-To: <CAFEEs1=f+CG6g7eu84g6kG5tueqfV1rukzb3gX5-dZWmuO0s_A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: Konstantin Dorfman <kdorfman@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, svenkatr@ti.com

Hello Per,

> On Thu, Nov 17, 2011 at 4:01 PM, Konstantin Dorfman
> <kdorfman@codeaurora.org> wrote:
>> Hello Jaenhoon,
>>
>> I have a few suggestions regarding the situation when Host starts BK=
OPS:
>>
>> 1) Host should start BKOPS (based on BKOPS_STATUS or URGENT_BKOPS ev=
ent)
>> when going to mmc_sleep, which means that the bus is in idle state (=
this
>> also covers the case in mmc_queue_thread, because in this case no I/=
O
>> request exists). It seems like checking the status periodically in
>> addition
>> to mmc_suspend is not needed. Since if the device was in idle and we
>> performed a single BKOPS then there is no point in performing anothe=
r
>> BKOPS
>> unless there was actually another I/O request.
>>
>> 2) Also this implies an answer to the question about need to interru=
pt
>> BKOPS
>> before powering off card - the answer is no.
> By the answer no you mean there is no risk of data corruption if
> cutting power in the middle of a BKOPS. When the card is powered up
> next time it will verify that bkops is in a defined state, and do
> recovery if necessary. An interesting comment I got from Sebastian is
> if this recovery mechanism affects card boot time.
> The question is: May the card boot up slower (due to recovery) next
> time if BKOPS was ongoing at power off?
> I assume this recovery time should be insignificant, but I don't know=
 for
> sure.
>
Let me explain proposed flow:
The only trigger to start BKOPS command should be mmc_power_off() funct=
ion,
just before sending POWER_OFF_NOTIFICATION[34] and only when BKOPS is n=
eeded
(by needed I understand situation, when URGENT_BKOPS event arrived or
BKOPS_STATUS 0x2 or 0x3).
The flow will wait till BKOPS successfully completed and than continue =
to
powering off the card. Power off will never occur in the middle of BKOP=
S.
Also do not need to start BKOPS when mmc_queue_thread() is in IDLE stat=
e
(no requests exists), because in such case power off should be done to =
card.

>> 3) Based on statistical data we have (day long test) it looks like w=
e do
>> not
>> need to do any preventive BKOPS caused by BKOPS_STATUS less than
>> critical
>> (0x3).
> I proposed this "preventive action" but at that time I didn't have an=
y
> data to back it up with. I've run some day long tests and what I coul=
d
> see is when BKOPS_LEVEL goes from 0 to 1, it goes back to 0 without
> having to start BKOPS. Can you confirm this with your tests as well?
> One explanation I got for this is that level of 1 only means the eMMC
> internal cache is fragmented and not the actual memory.
We have such data from card vendors, but I plan to do similar tests to
confirm.
I will update about the results.

Thanks,
Kostya

>
> Thanks,
> Per
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org
>> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Jaehoon Chung
>> Sent: Thursday, November 17, 2011 2:50 AM
>> To: linux-mmc
>> Cc: Chris Ball; Kyungmin Park; Hanumath Prasad; Per Forlin; Sebastia=
n
>> Rasmussen; Dong, Chuanxiao; svenkatr@ti.com
>> Subject: [PATCH v3] mmc: support BKOPS feature for eMMC
>>
>> Enable eMMC background operations (BKOPS) feature.
>>
>> If URGENT_BKOPS is set after a response, note that BKOPS
>> are required. After all I/O requests are finished, run
>> BKOPS if required. Should read/write operations be requested
>> during BKOPS, first issue HPI to interrupt the ongoing BKOPS
>> and then service the request.
>>
>> If you want to enable this feature, set MMC_CAP2_BKOPS.
>>
>> Future considerations
>> =A0* Check BKOPS_LEVEL=3D1 and start BKOPS in a preventive manner.
>> =A0* Interrupt ongoing BKOPS before powering off the card.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> CC: Hanumath Prasad <hanumath.prasad@stericsson.com>
>> ---
>> Changelog V3:
>> =A0 =A0 =A0 =A0- move the bkops setting's location in mmc_blk_issue_=
rw_rq
>> =A0 =A0 =A0 =A0- modify condition checking
>> =A0 =A0 =A0 =A0- bkops_en is assigned ext_csd[EXT_CSD_BKOPS_EN] inst=
ead of "1"
>> =A0 =A0 =A0 =A0- remove the unused code
>> =A0 =A0 =A0 =A0- change pr_debug instead of pr_warn in mmc_send_hpi_=
cmd
>> =A0 =A0 =A0 =A0- Add the Future consideration suggested by Per
>>
>> Changelog V2:
>> =A0 =A0 =A0 =A0- Use EXCEPTION_STATUS instead of URGENT_BKOPS
>> =A0 =A0 =A0 =A0- Add function to check Exception_status(for eMMC4.5)
>> =A0 =A0 =A0 =A0- remove unnecessary code.
>>
>> =A0drivers/mmc/card/block.c =A0 | =A0 10 +++++
>> =A0drivers/mmc/card/queue.c =A0 | =A0 =A04 ++
>> =A0drivers/mmc/core/core.c =A0 =A0| =A0 87
>> ++++++++++++++++++++++++++++++++++++++++++++
>> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0 =A08 ++++
>> =A0drivers/mmc/core/mmc_ops.c | =A0 =A06 +++-
>> =A0include/linux/mmc/card.h =A0 | =A0 12 ++++++
>> =A0include/linux/mmc/core.h =A0 | =A0 =A03 ++
>> =A0include/linux/mmc/host.h =A0 | =A0 =A01 +
>> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 14 +++++++
>> =A09 files changed, 144 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index c80bb6d..9d19ebb 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -1188,6 +1188,16 @@ static int mmc_blk_issue_rw_rq(struct mmc_que=
ue
>> *mq,
>> struct request *rqc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type =3D rq_data_dir(req) =3D=3D READ=
 ? MMC_BLK_READ :
>> MMC_BLK_WRITE;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_queue_bounce_post(mq_rq);
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check BKOPS urgency from each R1 =
response
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_mmc(card) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (brq->cmd.resp[0] & R1=
_EXCEPTION_EVENT)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_is_exception_e=
vent(card,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_URGENT_BKOPS))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_ca=
rd_set_need_bkops(card);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (status) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_BLK_SUCCESS:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_BLK_PARTIAL:
>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>> index dcad59c..20bb4a5 100644
>> --- a/drivers/mmc/card/queue.c
>> +++ b/drivers/mmc/card/queue.c
>> @@ -61,6 +61,9 @@ static int mmc_queue_thread(void *d)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irq(q->queue_lock);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (req || mq->mqrq_prev->req) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_card_doing_bko=
ps(mq->card))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_in=
terrupt_bkops(mq->card);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_current_state(TAS=
K_RUNNING);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mq->issue_fn(mq, req)=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>> @@ -68,6 +71,7 @@ static int mmc_queue_thread(void *d)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_c=
urrent_state(TASK_RUNNING);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_start_bkops(mq->ca=
rd);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up(&mq->thread_sem);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0schedule();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0down(&mq->thread_sem)=
;
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 7ee2e07..2d2f1d5 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -238,6 +238,50 @@ mmc_start_request(struct mmc_host *host, struct
>> mmc_request *mrq)
>> =A0 =A0 =A0 =A0host->ops->request(host, mrq);
>> =A0}
>>
>> +/**
>> + * =A0 =A0 mmc_start_bkops - start BKOPS for supported cards
>> + * =A0 =A0 @card: MMC card to start BKOPS
>> + *
>> + * =A0 =A0 Start background operations whenever requested.
>> + * =A0 =A0 when the urgent BKOPS bit is set in a R1 command respons=
e
>> + * =A0 =A0 then background operations should be started immediately=
=2E
>> +*/
>> +void mmc_start_bkops(struct mmc_card *card)
>> +{
>> + =A0 =A0 =A0 int err;
>> + =A0 =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 =A0 BUG_ON(!card);
>> + =A0 =A0 =A0 if ((!card->ext_csd.bkops_en) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(card->host->caps2 & =
MMC_CAP2_BKOPS))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* If card is already doing bkops or need for
>> + =A0 =A0 =A0 =A0* bkops flag is not set, then do nothing just
>> + =A0 =A0 =A0 =A0* return
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (mmc_card_doing_bkops(card)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || !mmc_card_need_bkop=
s(card))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 =A0 mmc_claim_host(card->host);
>> + =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BKOPS_START, 1=
, 0);
>> + =A0 =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("error %d starting bkops\n"=
, err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_clr_need_bkops(card);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 spin_lock_irqsave(&card->host->lock, flags);
>> + =A0 =A0 =A0 mmc_card_clr_need_bkops(card);
>> + =A0 =A0 =A0 mmc_card_set_doing_bkops(card);
>> + =A0 =A0 =A0 spin_unlock_irqrestore(&card->host->lock, flags);
>> +out:
>> + =A0 =A0 =A0 mmc_release_host(card->host);
>> +}
>> +EXPORT_SYMBOL(mmc_start_bkops);
>> +
>> =A0static void mmc_wait_done(struct mmc_request *mrq)
>> =A0{
>> =A0 =A0 =A0 =A0complete(&mrq->completion);
>> @@ -466,6 +510,49 @@ int mmc_wait_for_cmd(struct mmc_host *host, str=
uct
>> mmc_command *cmd, int retries
>> =A0EXPORT_SYMBOL(mmc_wait_for_cmd);
>>
>> =A0/**
>> + * =A0 =A0 mmc_interrupt_bkops - interrupt ongoing BKOPS
>> + * =A0 =A0 @card: MMC card to check BKOPS
>> + *
>> + * =A0 =A0 Send HPI command to interrupt ongoing background operati=
ons,
>> + * =A0 =A0 to allow rapid servicing of foreground operations,e.g. r=
ead/
>> + * =A0 =A0 writes. Wait until the card comes out of the programming=
 state
>> + * =A0 =A0 to avoid errors in servicing read/write requests.
>> + */
>> +int mmc_interrupt_bkops(struct mmc_card *card)
>> +{
>> + =A0 =A0 =A0 int err =3D 0;
>> + =A0 =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 =A0 BUG_ON(!card);
>> +
>> + =A0 =A0 =A0 err =3D mmc_interrupt_hpi(card);
>> +
>> + =A0 =A0 =A0 spin_lock_irqsave(&card->host->lock, flags);
>> + =A0 =A0 =A0 mmc_card_clr_doing_bkops(card);
>> + =A0 =A0 =A0 spin_unlock_irqrestore(&card->host->lock, flags);
>> +
>> + =A0 =A0 =A0 return err;
>> +}
>> +EXPORT_SYMBOL(mmc_interrupt_bkops);
>> +
>> +int mmc_is_exception_event(struct mmc_card *card, unsigned int valu=
e)
>> +{
>> + =A0 =A0 =A0 int err;
>> + =A0 =A0 =A0 u8 ext_csd[512];
>> +
>> + =A0 =A0 =A0 /* In eMMC 4.41, R1_EXCEPTION_EVENT is URGENT_BKOPS */
>> + =A0 =A0 =A0 if (card->ext_csd.rev =3D=3D 5)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> +
>> + =A0 =A0 =A0 err =3D mmc_send_ext_csd(card, ext_csd);
>> + =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> +
>> + =A0 =A0 =A0 return (ext_csd[EXT_CSD_EXCEPTION_STATUS] & value) ? 1=
 : 0;
>> +}
>> +EXPORT_SYMBOL(mmc_is_exception_event);
>> +
>> +/**
>> =A0* =A0 =A0 mmc_set_data_timeout - set the timeout for a data comma=
nd
>> =A0* =A0 =A0 @data: data phase for command
>> =A0* =A0 =A0 @card: the MMC card associated with the data transfer
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index a1223bd..514ad0f 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -448,6 +448,14 @@ static int mmc_read_ext_csd(struct mmc_card *ca=
rd,
>> u8
>> *ext_csd)
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0if (card->ext_csd.rev >=3D 5) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check whether the eMMC card support=
 BKOPS */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0=
x1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops =3D=
 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.bkops_en=
 =3D
>> ext_csd[EXT_CSD_BKOPS_EN];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.raw_bkop=
s_status =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_cs=
d[EXT_CSD_BKOPS_STATUS];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* check whether the eMMC card suppor=
ts HPI */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ext_csd[EXT_CSD_HPI_FEATURES] & 0=
x1) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.hpi =3D=
 1;
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index 007863e..2e397d5 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -398,6 +398,10 @@ int mmc_switch(struct mmc_card *card, u8 set, u=
8
>> index,
>> u8 value,
>> =A0 =A0 =A0 =A0if (err)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>>
>> + =A0 =A0 =A0 /* No need to check card status in case of BKOPS switc=
h*/
>> + =A0 =A0 =A0 if (index =3D=3D EXT_CSD_BKOPS_START)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> =A0 =A0 =A0 =A0/* Must check status to be sure of no errors */
>> =A0 =A0 =A0 =A0do {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_send_status(card, &status=
);
>> @@ -568,7 +572,7 @@ int mmc_send_hpi_cmd(struct mmc_card *card, u32
>> *status)
>>
>> =A0 =A0 =A0 =A0err =3D mmc_wait_for_cmd(card->host, &cmd, 0);
>> =A0 =A0 =A0 =A0if (err) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("%s: error %d interrupting ope=
ration. "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: error %d interrupting op=
eration. "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"HPI command response=
 %#x\n",
>> mmc_hostname(card->host),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err, cmd.resp[0]);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index 534974c..3c983d7 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -70,6 +70,8 @@ struct mmc_ext_csd {
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0cache_size; =A0 =A0=
 =A0 =A0 =A0 =A0 /* Units: KB */
>> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hpi_en; =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* HPI enablebit
>> */
>> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hpi; =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* HPI support
>> bit
>> */
>> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bkops; =A0=
 =A0 =A0 =A0 =A0/* background support
>> bit */
>> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bkops_en; =
=A0 =A0 =A0 /* background enable bit
>> */
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0hpi_cmd; =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0/* cmd used as
>> HPI
>> */
>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_par=
tition_support; =A0/* 160 */
>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_era=
sed_mem_count; =A0 /* 181 */
>> @@ -84,6 +86,7 @@ struct mmc_ext_csd {
>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_sec=
_erase_mult; =A0 =A0 /* 230 */
>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_sec=
_feature_support;/* 231 */
>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_tri=
m_mult; =A0 =A0 =A0 =A0 =A0/* 232 */
>> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_bkop=
s_status; =A0 =A0 =A0 /* 246 */
>> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0raw_sec=
tors[4]; =A0 =A0 =A0 =A0 /* 212 - 4 bytes
>> */
>>
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0feature_support;
>> @@ -209,6 +212,8 @@ struct mmc_card {
>> =A0#define MMC_STATE_HIGHSPEED_DDR (1<<4) =A0 =A0 =A0 =A0 /* card is=
 in high speed
>> mode */
>> =A0#define MMC_STATE_ULTRAHIGHSPEED (1<<5) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0/* card is in
>> ultra
>> high speed mode */
>> =A0#define MMC_CARD_SDXC =A0 =A0 =A0 =A0 =A0(1<<6) =A0 =A0 =A0 =A0 =A0=
/* card is SDXC */
>> +#define MMC_STATE_NEED_BKOPS =A0 (1<<7) =A0 =A0 =A0 =A0 =A0/* card =
need to do BKOPS
>> */
>> +#define MMC_STATE_DOING_BKOPS =A0(1<<8) =A0 =A0 =A0 =A0 =A0/* card =
is doing BKOPS
>> */
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0 =A0=
 =A0 /* card quirks */
>> =A0#define MMC_QUIRK_LENIENT_FN0 =A0(1<<0) =A0 =A0 =A0 =A0 =A0/* all=
ow SDIO FN0 writes
>> outside of the VS CCCR range */
>> =A0#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) =A0 /* use func->cur=
_blksize
>> */
>> @@ -370,6 +375,8 @@ static inline void __maybe_unused
>> remove_quirk(struct
>> mmc_card *card, int data)
>> =A0#define mmc_card_uhs(c) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((c)->stat=
e &
>> MMC_STATE_ULTRAHIGHSPEED)
>> =A0#define mmc_sd_card_uhs(c) =A0 =A0 ((c)->state & MMC_STATE_ULTRAH=
IGHSPEED)
>> =A0#define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
>> +#define mmc_card_need_bkops(c) ((c)->state & MMC_STATE_NEED_BKOPS)
>> +#define mmc_card_doing_bkops(c) =A0 =A0 =A0 =A0((c)->state &
>> MMC_STATE_DOING_BKOPS)
>>
>> =A0#define mmc_card_set_present(c) =A0 =A0 =A0 =A0((c)->state |=3D
>> MMC_STATE_PRESENT)
>> =A0#define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_READO=
NLY)
>> @@ -379,6 +386,11 @@ static inline void __maybe_unused
>> remove_quirk(struct
>> mmc_card *card, int data)
>> =A0#define mmc_card_set_uhs(c) ((c)->state |=3D MMC_STATE_ULTRAHIGHS=
PEED)
>> =A0#define mmc_sd_card_set_uhs(c) ((c)->state |=3D MMC_STATE_ULTRAHI=
GHSPEED)
>> =A0#define mmc_card_set_ext_capacity(c) ((c)->state |=3D MMC_CARD_SD=
XC)
>> +#define mmc_card_set_need_bkops(c) =A0 =A0 ((c)->state |=3D
>> MMC_STATE_NEED_BKOPS)
>> +#define mmc_card_set_doing_bkops(c) =A0 =A0((c)->state |=3D
>> MMC_STATE_DOING_BKOPS)
>> +
>> +#define mmc_card_clr_need_bkops(c) =A0 =A0 ((c)->state &=3D
>> ~MMC_STATE_NEED_BKOPS)
>> +#define mmc_card_clr_doing_bkops(c) =A0 =A0((c)->state &=3D
>> ~MMC_STATE_DOING_BKOPS)
>>
>> =A0/*
>> =A0* Quirk add/remove for MMC products.
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>> index 174a844..f6b997a 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -134,6 +134,8 @@ struct mmc_host;
>> =A0struct mmc_card;
>> =A0struct mmc_async_req;
>>
>> +extern int mmc_interrupt_bkops(struct mmc_card *);
>> +extern int mmc_is_exception_event(struct mmc_card *, unsigned int);
>> =A0extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 struct mmc_async_req *, int
>> *);
>> =A0extern int mmc_interrupt_hpi(struct mmc_card *);
>> @@ -163,6 +165,7 @@ extern int mmc_can_sanitize(struct mmc_card *car=
d);
>> =A0extern int mmc_can_secure_erase_trim(struct mmc_card *card);
>> =A0extern int mmc_erase_group_aligned(struct mmc_card *card, unsigne=
d int
>> from,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
unsigned int nr);
>> +extern void mmc_start_bkops(struct mmc_card *card);
>> =A0extern unsigned int mmc_calc_max_discard(struct mmc_card *card);
>>
>> =A0extern int mmc_set_blocklen(struct mmc_card *card, unsigned int
>> blocklen);
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 706f722..4629e84 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -242,6 +242,7 @@ struct mmc_host {
>> =A0#define MMC_CAP2_CACHE_CTRL =A0 =A0(1 << 1) =A0 =A0 =A0 =A0/* All=
ow cache control
>> */
>> =A0#define MMC_CAP2_POWEROFF_NOTIFY (1 << 2) =A0 =A0 =A0/* Notify po=
weroff
>> supported
>> */
>> =A0#define MMC_CAP2_NO_MULTI_READ (1 << 3) =A0 =A0 =A0 =A0/* Multibl=
ock reads
>> don't
>> work */
>> +#define MMC_CAP2_BKOPS =A0 =A0 =A0 =A0 (1 << 4) =A0 =A0 =A0 =A0/* B=
KOPS supported */
>>
>> =A0 =A0 =A0 =A0mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0=
 =A0/* supported pm features
>> */
>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0power_notify_type;
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index 0e71356..20b1420 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -138,6 +138,7 @@ static inline bool mmc_op_multi(u32 opcode)
>> =A0#define R1_CURRENT_STATE(x) =A0 =A0((x & 0x00001E00) >> 9) /* sx,=
 b (4
>> bits) */
>> =A0#define R1_READY_FOR_DATA =A0 =A0 =A0(1 << 8) =A0 =A0 =A0 =A0/* s=
x, a */
>> =A0#define R1_SWITCH_ERROR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 7) =A0=
 =A0 =A0 =A0/* sx, c */
>> +#define R1_EXCEPTION_EVENT =A0 =A0 (1 << 6) =A0 =A0 =A0 =A0/* sx, a=
 */
>> =A0#define R1_APP_CMD =A0 =A0 =A0 =A0 =A0 =A0 (1 << 5) =A0 =A0 =A0 =A0=
/* sr, c */
>>
>> =A0#define R1_STATE_IDLE =A00
>> @@ -273,11 +274,14 @@ struct _mmc_csd {
>> =A0#define EXT_CSD_FLUSH_CACHE =A0 =A0 =A0 =A0 =A0 =A032 =A0 =A0 =A0=
/* W */
>> =A0#define EXT_CSD_CACHE_CTRL =A0 =A0 =A0 =A0 =A0 =A0 33 =A0 =A0 =A0=
/* R/W */
>> =A0#define EXT_CSD_POWER_OFF_NOTIFICATION 34 =A0 =A0 =A0/* R/W */
>> +#define EXT_CSD_EXCEPTION_STATUS =A0 =A0 =A0 54 =A0 =A0 =A0/* RO */
>> =A0#define EXT_CSD_GP_SIZE_MULT =A0 =A0 =A0 =A0 =A0 143 =A0 =A0 /* R=
/W */
>> =A0#define EXT_CSD_PARTITION_ATTRIBUTE =A0 =A0156 =A0 =A0 /* R/W */
>> =A0#define EXT_CSD_PARTITION_SUPPORT =A0 =A0 =A0160 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_HPI_MGMT =A0 =A0 =A0 =A0 =A0 =A0 =A0 161 =A0 =A0 =
/* R/W */
>> =A0#define EXT_CSD_RST_N_FUNCTION =A0 =A0 =A0 =A0 162 =A0 =A0 /* R/W=
 */
>> +#define EXT_CSD_BKOPS_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 163 =A0 =A0 /*=
 R/W */
>> +#define EXT_CSD_BKOPS_START =A0 =A0 =A0 =A0 =A0 =A0164 =A0 =A0 /* W=
 */
>> =A0#define EXT_CSD_SANITIZE_START =A0 =A0 =A0 =A0 165 =A0 =A0 /* W *=
/
>> =A0#define EXT_CSD_WR_REL_PARAM =A0 =A0 =A0 =A0 =A0 166 =A0 =A0 /* R=
O */
>> =A0#define EXT_CSD_ERASE_GROUP_DEF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A017=
5 =A0 =A0 /* R/W */
>> @@ -310,9 +314,11 @@ struct _mmc_csd {
>> =A0#define EXT_CSD_PWR_CL_200_360 =A0 =A0 =A0 =A0 237 =A0 =A0 /* RO =
*/
>> =A0#define EXT_CSD_PWR_CL_DDR_52_195 =A0 =A0 =A0238 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_PWR_CL_DDR_52_360 =A0 =A0 =A0239 =A0 =A0 /* RO */
>> +#define EXT_CSD_BKOPS_STATUS =A0 =A0 =A0 =A0 =A0 246 =A0 =A0 /* RO =
*/
>> =A0#define EXT_CSD_POWER_OFF_LONG_TIME =A0 =A0247 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_GENERIC_CMD6_TIME =A0 =A0 =A0248 =A0 =A0 /* RO */
>> =A0#define EXT_CSD_CACHE_SIZE =A0 =A0 =A0 =A0 =A0 =A0 249 =A0 =A0 /*=
 RO, 4 bytes */
>> +#define EXT_CSD_BKOPS_SUPPORT =A0 =A0 =A0 =A0 =A0502 =A0 =A0 /* RO =
*/
>> =A0#define EXT_CSD_HPI_FEATURES =A0 =A0 =A0 =A0 =A0 503 =A0 =A0 /* R=
O */
>>
>> =A0/*
>> @@ -373,4 +379,12 @@ struct _mmc_csd {
>> =A0#define MMC_SWITCH_MODE_CLEAR_BITS =A0 =A0 0x02 =A0 =A0/* Clear b=
its which are
>> 1 in
>> value */
>> =A0#define MMC_SWITCH_MODE_WRITE_BYTE =A0 =A0 0x03 =A0 =A0/* Set tar=
get to value
>> */
>>
>> +/*
>> + * EXCEPTION_EVENT_STATUS field (eMMC4.5)
>> + */
>> +#define EXT_CSD_URGENT_BKOPS =A0 =A0 =A0 =A0 =A0 BIT(0)
>> +#define EXT_CSD_DYNCAP_NEEDED =A0 =A0 =A0 =A0 =A0BIT(1)
>> +#define EXT_CSD_SYSPOOL_EXHAUSTED =A0 =A0 =A0BIT(2)
>> +#define EXT_CSD_PACKED_FAILURE =A0 =A0 =A0 =A0 BIT(3)
>> +
>> =A0#endif /* LINUX_MMC_MMC_H */
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


