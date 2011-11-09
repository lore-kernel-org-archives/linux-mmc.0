From: Per Forlin <per.lkml@gmail.com>
Subject: Re: [PATCH] mmc: core: Kill block requests if card is removed
Date: Wed, 9 Nov 2011 22:47:29 +0100
Message-ID: <CAFEEs1=rbYKv9uWXJ0A-aD5bsUfHEYbBrc98hcB7o+C9b+nvNQ@mail.gmail.com>
References: <1320813119-24383-1-git-send-email-sthumma@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1320813119-24383-1-git-send-email-sthumma@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, adrian.hunter@intel.com, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

Hi Sujit,

On Wed, Nov 9, 2011 at 5:31 AM, Sujit Reddy Thumma
<sthumma@codeaurora.org> wrote:
> Kill block requests when the host knows that the card is
> removed from the slot and is sure that subsequent requests
> are bound to fail. Do this silently so that the block
> layer doesn't output unnecessary error messages.
>
> This patch implements suggestion from Adrian Hunter,
> http://thread.gmane.org/gmane.linux.kernel.mmc/2714/focus=3D3474
>
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> ---
> =A0drivers/mmc/card/queue.c | =A0 =A05 +++++
> =A0drivers/mmc/core/bus.c =A0 | =A0 =A02 ++
> =A0include/linux/mmc/card.h | =A0 =A03 +++
> =A03 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index dcad59c..f8a3298 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -29,6 +29,8 @@
> =A0*/
> =A0static int mmc_prep_request(struct request_queue *q, struct reques=
t *req)
> =A0{
> + =A0 =A0 =A0 struct mmc_queue *mq =3D q->queuedata;
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * We only like normal block requests and discards.
> =A0 =A0 =A0 =A0 */
> @@ -37,6 +39,9 @@ static int mmc_prep_request(struct request_queue *q=
, struct request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return BLKPREP_KILL;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (mq && mq->card && !mmc_card_inserted(mq->card))
I guess the card is not freed until all pending requests have been
flushed? mq->card will be valid as long as the queue is active.

Another way to detect card removal is to subscribe for
"BUS_NOTIFY_DEL_DEVICE" mmc card device.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return BLKPREP_KILL;
> +
> =A0 =A0 =A0 =A0req->cmd_flags |=3D REQ_DONTPREP;
>
> =A0 =A0 =A0 =A0return BLKPREP_OK;
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 46b6e84..ea3be5d 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -308,6 +308,7 @@ int mmc_add_card(struct mmc_card *card)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_card_ddr_mode(card=
) ? "DDR " : "",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type, card->rca);
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 mmc_card_set_inserted(card);
If the card-alloction is freed when the card is removed. Is it
necessary to set this bit for the new allocated card? Or could this be
the same card allocation?

>
> =A0#ifdef CONFIG_DEBUG_FS
> =A0 =A0 =A0 =A0mmc_add_card_debugfs(card);
> @@ -340,6 +341,7 @@ void mmc_remove_card(struct mmc_card *card)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_info("%s: card %04x=
 removed\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_ho=
stname(card->host), card->rca);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->state &=3D ~MMC_STATE_INSERTED;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device_del(&card->dev);
> =A0 =A0 =A0 =A0}
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index b7a8cb1..be4125a 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -209,6 +209,7 @@ struct mmc_card {
> =A0#define MMC_STATE_HIGHSPEED_DDR (1<<4) =A0 =A0 =A0 =A0 /* card is =
in high speed mode */
> =A0#define MMC_STATE_ULTRAHIGHSPEED (1<<5) =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0/* card is in ultra high speed mode */
> =A0#define MMC_CARD_SDXC =A0 =A0 =A0 =A0 =A0(1<<6) =A0 =A0 =A0 =A0 =A0=
/* card is SDXC */
> +#define MMC_STATE_INSERTED =A0 =A0 (1<<7) =A0 =A0 =A0 =A0 =A0/* card=
 present in the slot */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0quirks; =A0 =A0 =A0=
 =A0 /* card quirks */
> =A0#define MMC_QUIRK_LENIENT_FN0 =A0(1<<0) =A0 =A0 =A0 =A0 =A0/* allo=
w SDIO FN0 writes outside of the VS CCCR range */
> =A0#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1) =A0 /* use func->cur_=
blksize */
> @@ -362,6 +363,7 @@ static inline void __maybe_unused remove_quirk(st=
ruct mmc_card *card, int data)
> =A0#define mmc_card_sdio(c) =A0 =A0 =A0 ((c)->type =3D=3D MMC_TYPE_SD=
IO)
>
> =A0#define mmc_card_present(c) =A0 =A0((c)->state & MMC_STATE_PRESENT=
)
> +#define mmc_card_inserted(c) =A0 ((c)->state & MMC_STATE_INSERTED)
> =A0#define mmc_card_readonly(c) =A0 ((c)->state & MMC_STATE_READONLY)
> =A0#define mmc_card_highspeed(c) =A0((c)->state & MMC_STATE_HIGHSPEED=
)
> =A0#define mmc_card_blockaddr(c) =A0((c)->state & MMC_STATE_BLOCKADDR=
)
> @@ -370,6 +372,7 @@ static inline void __maybe_unused remove_quirk(st=
ruct mmc_card *card, int data)
> =A0#define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
>
> =A0#define mmc_card_set_present(c) =A0 =A0 =A0 =A0((c)->state |=3D MM=
C_STATE_PRESENT)
> +#define mmc_card_set_inserted(c) ((c)->state |=3D MMC_STATE_INSERTED=
)
> =A0#define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_READON=
LY)
> =A0#define mmc_card_set_highspeed(c) ((c)->state |=3D MMC_STATE_HIGHS=
PEED)
> =A0#define mmc_card_set_blockaddr(c) ((c)->state |=3D MMC_STATE_BLOCK=
ADDR)
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora F=
orum.
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
