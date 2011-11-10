From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH] mmc: core: Kill block requests if card is removed
Date: Thu, 10 Nov 2011 15:20:28 +0100
Message-ID: <CAFEEs1nFkWv5x1RbJ923JJk9C3A3XX84k+=RT1+rd9S1rau99A@mail.gmail.com>
References: <1320813119-24383-1-git-send-email-sthumma@codeaurora.org>
	<4EBA4940.6030808@intel.com>
	<CAFEEs1nPe3=TFwdf8rbPk6AtWzMdfaKR=-Rv0OVJhnANX=3fUQ@mail.gmail.com>
	<4EBB4CEA.1050901@codeaurora.org>
	<4EBB9AE1.2060909@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <4EBB9AE1.2060909@intel.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Sujit Reddy Thumma <sthumma@codeaurora.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Nov 10, 2011 at 10:35 AM, Adrian Hunter <adrian.hunter@intel.co=
m> wrote:
> On 10/11/11 06:02, Sujit Reddy Thumma wrote:
>> Hi,
>>> Hi Adrian,
>>>
>>> On Wed, Nov 9, 2011 at 10:34 AM, Adrian Hunter<adrian.hunter@intel.=
com>
>>> wrote:
>>>> On 09/11/11 06:31, Sujit Reddy Thumma wrote:
>>>>> Kill block requests when the host knows that the card is
>>>>> removed from the slot and is sure that subsequent requests
>>>>> are bound to fail. Do this silently so that the block
>>>>> layer doesn't output unnecessary error messages.
>>>>>
>>>>> This patch implements suggestion from Adrian Hunter,
>>>>> http://thread.gmane.org/gmane.linux.kernel.mmc/2714/focus=3D3474
>>>>>
>>>>> Signed-off-by: Sujit Reddy Thumma<sthumma@codeaurora.org>
>>>>> ---
>>>>
>>>>
>>>> It is safer to have zero initialisations so I suggest inverting
>>>> the meaning of the state bit i.e.
>>
>> Makes sense. Will take care in V2.
>>
>>>>
>>>> #define MMC_STATE_CARD_GONE =A0 =A0 (1<<7) =A0 =A0 =A0 =A0 =A0/* c=
ard removed from the
>>>> slot */
>>>>
>>>>
>>>> Also it would be nice is a request did not start if the card is
>>>> gone. =A0For the non-async case, that is easy:
>>>>
>>> As far as I understand Sujit's patch it will stop new requests from
>>> being issued, blk_fetch_request(q) returns NULL.
>>
>> Yes, Per you are right. The ongoing requests will fail at the contro=
ller
>> driver layer and only the new requests coming to MMC queue layer wil=
l be
>> blocked.
>>
>> Adrian's suggestion is to stop all the requests reaching host contro=
ller
>> layer by mmc core. This seems to be a good approach but the problem =
here is
>> the host driver should inform mmc core that card is gone.
>>
>> Adrian, do you agree if we need to change all the host drivers to se=
t the
>> MMC_STATE_CARD_GONE flag as soon as the card detect irq handler dete=
cts the
>> card as removed?
>
> Typically a card detect interrupt queues a rescan which in turn will =
have
> to wait to claim the host. =A0In the meantime, in the async case, the=
 block
> driver will not release the host until the queue is empty.
Here is a patch that let async-mmc release host and reclaim it in case =
of error.
When the host is released mmc_rescan will claim the host and run.
--------------------------------
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index cf73877..8952e63 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1209,6 +1209,28 @@ static int mmc_blk_cmd_err(struct mmc_blk_data
*md, struct mmc_card *card,
 	return ret;
 }

+/*
+ * This function should be called to resend a request after failure.
+ * Prepares and starts the request.
+ */
+static inline struct mmc_async_req *mmc_blk_resend(struct mmc_card *ca=
rd,
+						   struct mmc_queue *mq,
+						   struct mmc_queue_req *mqrq,
+						   int disable_multi,
+						   struct mmc_async_req *areq)
+{
+	/*
+	 * Release host after failure in case the host is needed
+	 * by someone else. For instance, if the card is removed the
+	 * worker thread needs to claim the host in order to do mmc_rescan.
+	 */
+	mmc_release_host(card->host);
+	mmc_claim_host(card->host);
+
+	mmc_blk_rw_rq_prep(mqrq, card, disable_multi, mq);
+	return mmc_start_req(card->host, areq, NULL);
+}
+
 static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *r=
qc)
 {
 	struct mmc_blk_data *md =3D mq->data;
@@ -1308,14 +1330,14 @@ static int mmc_blk_issue_rw_rq(struct
mmc_queue *mq, struct request *rqc)
 			break;
 		}

-		if (ret) {
+		if (ret)
 			/*
 			 * In case of a incomplete request
 			 * prepare it again and resend.
 			 */
-			mmc_blk_rw_rq_prep(mq_rq, card, disable_multi, mq);
-			mmc_start_req(card->host, &mq_rq->mmc_active, NULL);
-		}
+			mmc_blk_prep_start(card, mq, mq_rq, disable_multi,
+					   &mq_rq->mmc_active);
+
 	} while (ret);

 	return 1;
@@ -1327,10 +1349,9 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
*mq, struct request *rqc)
 	spin_unlock_irq(&md->lock);

  start_new_req:
-	if (rqc) {
-		mmc_blk_rw_rq_prep(mq->mqrq_cur, card, 0, mq);
-		mmc_start_req(card->host, &mq->mqrq_cur->mmc_active, NULL);
-	}
+	if (rqc)
+		mmc_blk_prep_start(card, mq, mq->mqrq_cur, 0,
+				   &mq->mqrq_cur->mmc_active);

 	return 0;
 }
-------------------------------------


>=A0The block
> driver will see errors and will use a send status command which will =
fail
> so the request will be aborted, but the next request will be started
> anyway.
>
> There are two problems:
>
> 1. When do we reliably know that the card has really gone?
>
> At present, the detect method for SD and MMC is just the send status
> command, which is what the block driver is doing i.e. if the block
> driver sees send status fail, after an errored request, and the
> card is removable, then it is very likely the card has gone.
>
> At present, it is not considered that the host controller driver
> knows whether the card is really gone - just that it might be.
>
> Setting a MMC_STATE_CARD_GONE flag early may be a little complicated.
> e.g. mmc_detect_change() flags that the card may be gone. =A0After an
> error, if the "card may be gone" flag is set a new bus method could
> be called that just does send status. =A0If that fails, then the
> MMC_STATE_CARD_GONE flag is set. =A0Any calls to the detect method
> must first check the MMC_STATE_CARD_GONE flag so that, once gone,
> a card can not come back.
>
> Maybe you can think of something simpler.
>
> 2. How can new requests be prevented from starting once the card
> is gone?
>
> Using BLKPREP_KILL will do that for all but the request that has been
> prepared already (i.e. async case) if the MMC_STATE_CARD_GONE flag is=
 set
> early enough.
>
> Maybe blocking requests at a lower level is not needed.
>
>
>>
>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index 5278ffb..91d7721 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -259,7 +259,7 @@ static void mmc_wait_for_req_done(struct mmc_h=
ost *host,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_for_completion(&mrq->completi=
on);
>>>>
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd =3D mrq->cmd;
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cmd->error || !cmd->retries)
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cmd->error || !cmd->retries ||
>>>> mmc_card_gone(host->card))
>>> host->card will be NULL
>>
>> Yes, the host->card will be NULL for some requests. Will take care o=
f it.
>>
>>> static void mmc_remove(struct mmc_host *host)
>>> {
>>> =A0 =A0 BUG_ON(!host);
>>> =A0 =A0 BUG_ON(!host->card);
>>>
>>> =A0 =A0 mmc_remove_card(host->card);
>>> =A0 =A0 host->card =3D NULL;
>>> }
>>> card is not freed until later.
>>>
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>>
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: req failed (CMD%u): =
%d, retrying...\n",
>>>> @@ -374,6 +374,10 @@ EXPORT_SYMBOL(mmc_start_req);
>>>> =A0 */
>>>> =A0 void mmc_wait_for_req(struct mmc_host *host, struct mmc_reques=
t *mrq)
>>>> =A0 {
>>>> + =A0 =A0 =A0 if (mmc_card_gone(host->card)) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mrq->cmd->error =3D -ENODEV;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>>> + =A0 =A0 =A0 }
>>
>> Looks good. Just for clarification, some host controller drivers ret=
urn
>> -ENOMEDIUM in host->ops->request() when they see the card is gone. D=
o you
>> think we can remove this now from host controller drivers?
>
> I see include/linux/mmc/core.h has specified the use of -ENOMEDIUM so=
 that
> should be used.
>
>>
>>
>>>> =A0 =A0 =A0 =A0 __mmc_start_req(host, mrq);
>>>> =A0 =A0 =A0 =A0 mmc_wait_for_req_done(host, mrq);
>>>> =A0 }
>>>>
>>>>
>>>>
>>>> The async case is harder...
>>>>
>>> I can help out with the non-async code if we go for your proposal.
>>
>> I will check the possibilities.
>>
>>>
>>>>
>>>>> =A0 drivers/mmc/card/queue.c | =A0 =A05 +++++
>>>>> =A0 drivers/mmc/core/bus.c =A0 | =A0 =A02 ++
>>>>> =A0 include/linux/mmc/card.h | =A0 =A03 +++
>>>>> =A0 3 files changed, 10 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>>>>> index dcad59c..f8a3298 100644
>>>>> --- a/drivers/mmc/card/queue.c
>>>>> +++ b/drivers/mmc/card/queue.c
>>>>> @@ -29,6 +29,8 @@
>>>>> =A0 =A0*/
>>>>> =A0 static int mmc_prep_request(struct request_queue *q, struct r=
equest *req)
>>>>> =A0 {
>>>>> + =A0 =A0 struct mmc_queue *mq =3D q->queuedata;
>>>>> +
>>>>> =A0 =A0 =A0 =A0/*
>>>>> =A0 =A0 =A0 =A0 * We only like normal block requests and discards=
=2E
>>>>> =A0 =A0 =A0 =A0 */
>>>>> @@ -37,6 +39,9 @@ static int mmc_prep_request(struct request_queu=
e *q,
>>>>> struct request *req)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return BLKPREP_KILL;
>>>>> =A0 =A0 =A0 =A0}
>>>>>
>>>>> + =A0 =A0 if (mq&& =A0mq->card&& =A0!mmc_card_inserted(mq->card))
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 return BLKPREP_KILL;
>>>>> +
>>>>> =A0 =A0 =A0 =A0req->cmd_flags |=3D REQ_DONTPREP;
>>>>>
>>>>> =A0 =A0 =A0 =A0return BLKPREP_OK;
>>>>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>>>>> index 46b6e84..ea3be5d 100644
>>>>> --- a/drivers/mmc/core/bus.c
>>>>> +++ b/drivers/mmc/core/bus.c
>>>>> @@ -308,6 +308,7 @@ int mmc_add_card(struct mmc_card *card)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_card_ddr_mode(=
card) ? "DDR " : "",
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type, card->rca);
>>>>> =A0 =A0 =A0 =A0}
>>>>> + =A0 =A0 mmc_card_set_inserted(card);
>>>>>
>>>>> =A0 #ifdef CONFIG_DEBUG_FS
>>>>> =A0 =A0 =A0 =A0mmc_add_card_debugfs(card);
>>>>> @@ -340,6 +341,7 @@ void mmc_remove_card(struct mmc_card *card)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_info("%s: card =
%04x removed\n",
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mm=
c_hostname(card->host), card->rca);
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 card->state&=3D ~MMC_STATE_INSERTED;
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_del(&card->dev);
>>>>> =A0 =A0 =A0 =A0}
>>>>>
>>>>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>>>>> index b7a8cb1..be4125a 100644
>>>>> --- a/include/linux/mmc/card.h
>>>>> +++ b/include/linux/mmc/card.h
>>>>> @@ -209,6 +209,7 @@ struct mmc_card {
>>>>> =A0 #define MMC_STATE_HIGHSPEED_DDR (1<<4) =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /* card is in
>>>>> high speed mode */
>>>>> =A0 #define MMC_STATE_ULTRAHIGHSPEED (1<<5) =A0 =A0 =A0 =A0 =A0 =A0=
 =A0/* card is in
>>>>> ultra high speed mode */
>>>>> =A0 #define MMC_CARD_SDXC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<6) =A0=
 =A0 =A0 =A0 =A0/* card is SDXC */
>>>>> +#define MMC_STATE_INSERTED =A0 (1<<7) =A0 =A0 =A0 =A0 =A0/* card=
 present in the
>>>>> slot */
>>>>> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0=
 =A0 =A0 /* card quirks */
>>>>> =A0 #define MMC_QUIRK_LENIENT_FN0 =A0 =A0 =A0 =A0(1<<0) =A0 =A0 =A0=
 =A0 =A0/* allow SDIO FN0
>>>>> writes outside of the VS CCCR range */
>>>>> =A0 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) /* use func->cur=
_blksize */
>>>>> @@ -362,6 +363,7 @@ static inline void __maybe_unused
>>>>> remove_quirk(struct mmc_card *card, int data)
>>>>> =A0 #define mmc_card_sdio(c) =A0 =A0 ((c)->type =3D=3D MMC_TYPE_S=
DIO)
>>>>>
>>>>> =A0 #define mmc_card_present(c) =A0((c)->state& =A0MMC_STATE_PRES=
ENT)
>>>>> +#define mmc_card_inserted(c) ((c)->state& =A0MMC_STATE_INSERTED)
>>>>> =A0 #define mmc_card_readonly(c) ((c)->state& =A0MMC_STATE_READON=
LY)
>>>>> =A0 #define mmc_card_highspeed(c) =A0 =A0 =A0 =A0((c)->state& =A0=
MMC_STATE_HIGHSPEED)
>>>>> =A0 #define mmc_card_blockaddr(c) =A0 =A0 =A0 =A0((c)->state& =A0=
MMC_STATE_BLOCKADDR)
>>>>> @@ -370,6 +372,7 @@ static inline void __maybe_unused
>>>>> remove_quirk(struct mmc_card *card, int data)
>>>>> =A0 #define mmc_card_ext_capacity(c) ((c)->state& =A0MMC_CARD_SDX=
C)
>>>>>
>>>>> =A0 #define mmc_card_set_present(c) =A0 =A0 =A0((c)->state |=3D M=
MC_STATE_PRESENT)
>>>>> +#define mmc_card_set_inserted(c) ((c)->state |=3D MMC_STATE_INSE=
RTED)
>>>>> =A0 #define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_R=
EADONLY)
>>>>> =A0 #define mmc_card_set_highspeed(c) ((c)->state |=3D MMC_STATE_=
HIGHSPEED)
>>>>> =A0 #define mmc_card_set_blockaddr(c) ((c)->state |=3D MMC_STATE_=
BLOCKADDR)
>>>>
>>
>>
>
>
