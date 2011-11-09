From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH] mmc: core: Kill block requests if card is removed
Date: Wed, 9 Nov 2011 21:53:53 +0100
Message-ID: <CAFEEs1nPe3=TFwdf8rbPk6AtWzMdfaKR=-Rv0OVJhnANX=3fUQ@mail.gmail.com>
References: <1320813119-24383-1-git-send-email-sthumma@codeaurora.org>
	<4EBA4940.6030808@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <4EBA4940.6030808@intel.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Sujit Reddy Thumma <sthumma@codeaurora.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On Wed, Nov 9, 2011 at 10:34 AM, Adrian Hunter <adrian.hunter@intel.com=
> wrote:
> On 09/11/11 06:31, Sujit Reddy Thumma wrote:
>> Kill block requests when the host knows that the card is
>> removed from the slot and is sure that subsequent requests
>> are bound to fail. Do this silently so that the block
>> layer doesn't output unnecessary error messages.
>>
>> This patch implements suggestion from Adrian Hunter,
>> http://thread.gmane.org/gmane.linux.kernel.mmc/2714/focus=3D3474
>>
>> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
>> ---
>
>
> It is safer to have zero initialisations so I suggest inverting
> the meaning of the state bit i.e.
>
> #define MMC_STATE_CARD_GONE =A0 =A0 (1<<7) =A0 =A0 =A0 =A0 =A0/* card=
 removed from the slot */
>
>
> Also it would be nice is a request did not start if the card is
> gone. =A0For the non-async case, that is easy:
>
As far as I understand Sujit's patch it will stop new requests from
being issued, blk_fetch_request(q) returns NULL.

> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 5278ffb..91d7721 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -259,7 +259,7 @@ static void mmc_wait_for_req_done(struct mmc_host=
 *host,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wait_for_completion(&mrq->completion);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd =3D mrq->cmd;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cmd->error || !cmd->retries)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cmd->error || !cmd->retries || mmc=
_card_gone(host->card))
host->card will be NULL
static void mmc_remove(struct mmc_host *host)
{
	BUG_ON(!host);
	BUG_ON(!host->card);

	mmc_remove_card(host->card);
	host->card =3D NULL;
}
card is not freed until later.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_debug("%s: req failed (CMD%u): %d, =
retrying...\n",
> @@ -374,6 +374,10 @@ EXPORT_SYMBOL(mmc_start_req);
> =A0*/
> =A0void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *m=
rq)
> =A0{
> + =A0 =A0 =A0 if (mmc_card_gone(host->card)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mrq->cmd->error =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0__mmc_start_req(host, mrq);
> =A0 =A0 =A0 =A0mmc_wait_for_req_done(host, mrq);
> =A0}
>
>
>
> The async case is harder...
>
I can help out with the non-async code if we go for your proposal.

>
>> =A0drivers/mmc/card/queue.c | =A0 =A05 +++++
>> =A0drivers/mmc/core/bus.c =A0 | =A0 =A02 ++
>> =A0include/linux/mmc/card.h | =A0 =A03 +++
>> =A03 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
>> index dcad59c..f8a3298 100644
>> --- a/drivers/mmc/card/queue.c
>> +++ b/drivers/mmc/card/queue.c
>> @@ -29,6 +29,8 @@
>> =A0 */
>> =A0static int mmc_prep_request(struct request_queue *q, struct reque=
st *req)
>> =A0{
>> + =A0 =A0 struct mmc_queue *mq =3D q->queuedata;
>> +
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* We only like normal block requests and discards.
>> =A0 =A0 =A0 =A0*/
>> @@ -37,6 +39,9 @@ static int mmc_prep_request(struct request_queue *=
q, struct request *req)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return BLKPREP_KILL;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (mq && mq->card && !mmc_card_inserted(mq->card))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return BLKPREP_KILL;
>> +
>> =A0 =A0 =A0 req->cmd_flags |=3D REQ_DONTPREP;
>>
>> =A0 =A0 =A0 return BLKPREP_OK;
>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> index 46b6e84..ea3be5d 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -308,6 +308,7 @@ int mmc_add_card(struct mmc_card *card)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_card_ddr_mode(card) =
? "DDR " : "",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type, card->rca);
>> =A0 =A0 =A0 }
>> + =A0 =A0 mmc_card_set_inserted(card);
>>
>> =A0#ifdef CONFIG_DEBUG_FS
>> =A0 =A0 =A0 mmc_add_card_debugfs(card);
>> @@ -340,6 +341,7 @@ void mmc_remove_card(struct mmc_card *card)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: card %04x r=
emoved\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host=
name(card->host), card->rca);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 card->state &=3D ~MMC_STATE_INSERTED;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_del(&card->dev);
>> =A0 =A0 =A0 }
>>
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index b7a8cb1..be4125a 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -209,6 +209,7 @@ struct mmc_card {
>> =A0#define MMC_STATE_HIGHSPEED_DDR (1<<4) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 /* card is in high speed mode */
>> =A0#define MMC_STATE_ULTRAHIGHSPEED (1<<5) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
/* card is in ultra high speed mode */
>> =A0#define MMC_CARD_SDXC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<6) =A0 =A0=
 =A0 =A0 =A0/* card is SDXC */
>> +#define MMC_STATE_INSERTED =A0 (1<<7) =A0 =A0 =A0 =A0 =A0/* card pr=
esent in the slot */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0 =A0 =
=A0 /* card quirks */
>> =A0#define MMC_QUIRK_LENIENT_FN0 =A0 =A0 =A0 =A0(1<<0) =A0 =A0 =A0 =A0=
 =A0/* allow SDIO FN0 writes outside of the VS CCCR range */
>> =A0#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) /* use func->cur_blk=
size */
>> @@ -362,6 +363,7 @@ static inline void __maybe_unused remove_quirk(s=
truct mmc_card *card, int data)
>> =A0#define mmc_card_sdio(c) =A0 =A0 ((c)->type =3D=3D MMC_TYPE_SDIO)
>>
>> =A0#define mmc_card_present(c) =A0((c)->state & MMC_STATE_PRESENT)
>> +#define mmc_card_inserted(c) ((c)->state & MMC_STATE_INSERTED)
>> =A0#define mmc_card_readonly(c) ((c)->state & MMC_STATE_READONLY)
>> =A0#define mmc_card_highspeed(c) =A0 =A0 =A0 =A0((c)->state & MMC_ST=
ATE_HIGHSPEED)
>> =A0#define mmc_card_blockaddr(c) =A0 =A0 =A0 =A0((c)->state & MMC_ST=
ATE_BLOCKADDR)
>> @@ -370,6 +372,7 @@ static inline void __maybe_unused remove_quirk(s=
truct mmc_card *card, int data)
>> =A0#define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
>>
>> =A0#define mmc_card_set_present(c) =A0 =A0 =A0((c)->state |=3D MMC_S=
TATE_PRESENT)
>> +#define mmc_card_set_inserted(c) ((c)->state |=3D MMC_STATE_INSERTE=
D)
>> =A0#define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_READO=
NLY)
>> =A0#define mmc_card_set_highspeed(c) ((c)->state |=3D MMC_STATE_HIGH=
SPEED)
>> =A0#define mmc_card_set_blockaddr(c) ((c)->state |=3D MMC_STATE_BLOC=
KADDR)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
