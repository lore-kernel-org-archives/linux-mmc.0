From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sleep notification
Date: Tue, 10 Mar 2015 13:07:44 +0100
Message-ID: <CAPDyKFooK=F88mO+8T0o1WAS=a+NntJszt-fa9+Ddkh_LpJsQg@mail.gmail.com>
References: <1425980197-823-1-git-send-email-avi.shchislowski@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:44653 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbbCJMHp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Mar 2015 08:07:45 -0400
Received: by qcwr17 with SMTP id r17so1033976qcw.11
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2015 05:07:44 -0700 (PDT)
In-Reply-To: <1425980197-823-1-git-send-email-avi.shchislowski@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Avi Shchislowski <avi.shchislowski@sandisk.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Alex Lemberg <Alex.Lemberg@sandisk.com>

On 10 March 2015 at 10:36, Avi Shchislowski
<avi.shchislowski@sandisk.com> wrote:
> This patch is implements the new additional state of
> Power_Off_Notification =E2=80=93 SLEEP_NOTIFICATION.
> Until now, the implementation of Power_Off_Notification
> supported only three modes =E2=80=93 POWERED_ON (0x01),
> POWER_OFF_SHORT (0x02) and POWER_OFF_LONG (0x03).
>
> As part of eMMC5.0 before moving to Sleep state hosts may set the
> POWER_OFF_NOTIFICATION byte to SLEEP_NOTIFICATION (0x04).
> After setting SLEEP_NOTIFICATION, host should wait for
> the busy line to be de-asserted.
> The max timeout allowed for busy line de-assertion defined
> in SLEEP_NOTIFICATION_TIME byte in EXT_CSD [216].
> HPI may interrupt the SLEEP_NOTIFICATION operation.
> In that case POWER_OFF_NOTIFICATION byte will restore to POWERED_ON.

Oh, just great! JEDEC has invented yet another way of how to send a
device to sleep state. I wonder what was wrong with the CMD5 option.

Anyway, thanks for looking into this.

>
> Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
> Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
> ---
>  drivers/mmc/card/block.c |   19 +++++-
>  drivers/mmc/core/core.c  |   16 +++++-
>  drivers/mmc/core/core.h  |    2 +
>  drivers/mmc/core/mmc.c   |  143 ++++++++++++++++++++++++++++++++++++=
+++++++---
>  include/linux/mmc/card.h |    6 ++
>  include/linux/mmc/host.h |    1 +
>  include/linux/mmc/mmc.h  |    2 +
>  7 files changed, 180 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 4409d79..f511ecc3 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -2010,9 +2010,26 @@ static int mmc_blk_issue_rq(struct mmc_queue *=
mq, struct request *req)
>         unsigned long flags;
>         unsigned int cmd_flags =3D req ? req->cmd_flags : 0;
>
> -       if (req && !mq->mqrq_prev->req)
> +       if (unlikely(req && mmc_card_mmc(card) &&
> +               (card->ext_csd.power_off_notification =3D=3D
> +               EXT_CSD_SLEEP_NOTIFICATION))) {
> +               /* restoring the power_off_notification
> +                * field's state to as it was before so
> +                * that the sleep notification will be
> +                * able to resume later
> +                */
> +               card->ext_csd.power_off_notification =3D EXT_CSD_POWE=
R_ON;
> +       }
> +
> +       if (req && !mq->mqrq_prev->req) {
>                 /* claim host only for the first request */
>                 mmc_get_card(card);
> +               if (unlikely(req &&
> +                       mmc_card_doing_sleep_notify(card))) {
> +                       mmc_interrupt_hpi(card);
> +                       mmc_card_clr_sleep_notify(card);
> +               }
> +       }

Both above new added code blocks makes no sense to me. Why does the
mmc block layer need to care about this?

>
>         ret =3D mmc_blk_part_switch(card, md);
>         if (ret) {
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 5bda29b..a090593 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -271,7 +271,8 @@ void mmc_start_bkops(struct mmc_card *card, bool =
from_exception)
>
>         BUG_ON(!card);
>
> -       if (!card->ext_csd.bkops_en || mmc_card_doing_bkops(card))
> +       if (!card->ext_csd.bkops_en || mmc_card_doing_bkops(card) ||
> +               mmc_card_doing_sleep_notify(card))

We can't do BKOPS when the card is suspended (which is when the card
may be put in sleep state), so no need to protect for this.

>                 return;
>
>         err =3D mmc_read_bkops_status(card);
> @@ -2630,6 +2631,19 @@ int mmc_pm_notify(struct notifier_block *notif=
y_block,
>                         err =3D host->bus_ops->pre_suspend(host);
>                 if (!err)
>                         break;
> +               if (host->card && host->bus_ops->suspend) {

Nope, this is the wrong place for this code. You should look into
mmc.c for adding this.

> +                       err =3D mmc_sleep_notify(host->card);
> +                       /* We assume that HPI was sent
> +                        * in case of -ETIMEDOUT error,
> +                        * so suspend flow can be continued
> +                        */
> +                       if (err && err !=3D -ETIMEDOUT) {
> +                               pr_err("%s:sleep notify err=3D%d\n",
> +                                       __func__, err);
> +                               return -EBUSY;
> +                       }
> +                       break;
> +               }
>
>                 /* Calling bus_ops->remove() with a claimed host can =
deadlock */
>                 host->bus_ops->remove(host);
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index d76597c..b6b4431 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -14,6 +14,7 @@
>  #include <linux/delay.h>
>
>  #define MMC_CMD_RETRIES        3
> +#define MMC_SLEEP_NOTIFY_MAX_TIME      0x17
>
>  struct mmc_bus_ops {
>         void (*remove)(struct mmc_host *);
> @@ -33,6 +34,7 @@ void mmc_attach_bus(struct mmc_host *host, const st=
ruct mmc_bus_ops *ops);
>  void mmc_detach_bus(struct mmc_host *host);
>
>  void mmc_init_erase(struct mmc_card *card);
> +int mmc_sleep_notify(struct mmc_card *card);

If we need a separate function to deal with this, it should be static
function within mmc.c.

>
>  void mmc_set_chip_select(struct mmc_host *host, int mode);
>  void mmc_set_clock(struct mmc_host *host, unsigned int hz);
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 02ad792..1d97d24 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -57,6 +57,11 @@ static const unsigned int tacc_mant[] =3D {
>                 __res & __mask;                                      =
   \
>         })
>
> +#define GET_SLEEP_NOTIFY_TIME(value) \
> +       (10 * (1 << (unsigned int)(value)))
> +#define GET_SLEEP_NOTIFY_TIME_MSEC(value) \
> +       (DIV_ROUND_UP(GET_SLEEP_NOTIFY_TIME(value), 1000))
> +
>  /*
>   * Given the decoded CSD structure, decode the raw CID to our CID st=
ructure.
>   */
> @@ -571,6 +576,8 @@ static int mmc_decode_ext_csd(struct mmc_card *ca=
rd, u8 *ext_csd)
>                 card->ext_csd.ffu_capable =3D
>                         (ext_csd[EXT_CSD_SUPPORTED_MODE] & 0x1) &&
>                         !(ext_csd[EXT_CSD_FW_CONFIG] & 0x1);
> +               card->ext_csd.sleep_notify_time =3D
> +                       ext_csd[EXT_CSD_SLEEP_NOTIFICATION_TIME];
>         }
>  out:
>         return err;
> @@ -1468,6 +1475,15 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
>                         card->ext_csd.hpi_en =3D 1;
>         }
>
> +       /* sleep notify enable/disable for eMMC 5.0 and above */
> +       if ((card->ext_csd.rev >=3D 7) &&  card->ext_csd.hpi_en &&

Why depend on ext_csd.hpi_en?

> +                       (card->host->caps2 & MMC_CAP2_SLEEP_NOTIFY) &=
&

Please don't add a new CAP for this. MMC_CAP2_FULL_PWR_CYCLE tells us
if the card can be fully power gated, I think we can use that
instead!?

> +                       card->ext_csd.sleep_notify_time > 0 &&
> +                       card->ext_csd.sleep_notify_time <=3D
> +                               MMC_SLEEP_NOTIFY_MAX_TIME) {
> +               card->can_sleep_notify =3D 1;

Instead of adding "can_sleep_notify", let's just encapsulate similar
code as above in a helper function which tells us if card supports
"sleep notification".

Compare how mmc_can_sleep() is implemented and used.

> +       }
> +
>         /*
>          * If cache size is higher than 0, this indicates
>          * the existence of cache and it can be turned on.
> @@ -1576,6 +1592,33 @@ static int mmc_sleep(struct mmc_host *host)
>         return err;
>  }
>
> +/*
> + * check if device is in program state (busy)
> + */
> +static bool mmc_device_prg_state(struct mmc_card *card)
> +{
> +       int rc;
> +       u32 status;
> +       bool state;
> +
> +       mmc_get_card(card);
> +       rc =3D mmc_send_status(card, &status);
> +       if (rc) {
> +               pr_err("%s: Get card status fail. rc=3D%d\n",
> +                       mmc_hostname(card->host), rc);
> +               state =3D false;
> +               goto out;
> +       }
> +
> +       if (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG)
> +               state =3D  true;
> +       else
> +               state =3D  false;
> +out:
> +       mmc_put_card(card);
> +       return state;
> +}
> +
>  static int mmc_can_poweroff_notify(const struct mmc_card *card)
>  {
>         return card &&
> @@ -1585,22 +1628,108 @@ static int mmc_can_poweroff_notify(const str=
uct mmc_card *card)
>
>  static int mmc_poweroff_notify(struct mmc_card *card, unsigned int n=
otify_type)
>  {
> -       unsigned int timeout =3D card->ext_csd.generic_cmd6_time;
> +       unsigned int timeout_ms =3D card->ext_csd.generic_cmd6_time;

What's reason to do a rename in this patch? If you want that as a
clarification of the code, please do that in a separate patch.

>         int err;
> +       bool use_busy_signal;
>
>         /* Use EXT_CSD_POWER_OFF_SHORT as default notification type. =
*/
>         if (notify_type =3D=3D EXT_CSD_POWER_OFF_LONG)
> -               timeout =3D card->ext_csd.power_off_longtime;
> +               timeout_ms =3D card->ext_csd.power_off_longtime;
> +       else if (notify_type =3D=3D EXT_CSD_SLEEP_NOTIFICATION) {
> +               /* calculate the maximum timeout for the
> +                * switch command when notifying the device
> +                * that it is about to move to sleep */
> +               timeout_ms =3D GET_SLEEP_NOTIFY_TIME_MSEC(
> +                       card->ext_csd.sleep_notify_time);
> +       }
>
> +       /* do not wait on busy signal in case of
> +        * Sleep Notification - to let host get
> +        * another requests

At this point, there should be no other request. Or what am I missing?

> +        */
> +       use_busy_signal =3D (notify_type =3D=3D EXT_CSD_SLEEP_NOTIFIC=
ATION) ?
> +                       false : true;
>         err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                         EXT_CSD_POWER_OFF_NOTIFICATION,
> -                       notify_type, timeout, true, false, false);
> -       if (err)
> +                       notify_type, timeout_ms,
> +                       use_busy_signal, false, false);
> +       if (!err) {
> +               card->ext_csd.power_off_notification =3D notify_type;
> +       } else {
>                 pr_err("%s: Power Off Notification timed out, %u\n",
> -                      mmc_hostname(card->host), timeout);
> +                       mmc_hostname(card->host), timeout_ms);
> +       }
> +
> +       return err;
> +}
>
> -       /* Disable the power off notification after the switch operat=
ion. */
> -       card->ext_csd.power_off_notification =3D EXT_CSD_NO_POWER_NOT=
IFICATION;

Why remove this?

> +int mmc_sleep_notify(struct mmc_card *card)

I don't understand the need for this function. From what scenarios do
we want to invoke it?

> +{
> +       int err =3D 0;
> +       bool is_busy =3D 0;
> +       unsigned long prg_wait =3D 0;
> +
> +       if (!card->can_sleep_notify || !mmc_can_poweroff_notify(card)=
)
> +               return 0;
> +
> +       if (!mmc_card_doing_sleep_notify(card)) {
> +               mmc_get_card(card);
> +               mmc_card_set_sleep_notify(card);
> +               err =3D mmc_poweroff_notify(card,
> +                       EXT_CSD_SLEEP_NOTIFICATION);
> +               mmc_put_card(card);
> +               if (err) {
> +                       pr_err("%s: mmc_poweroff_notify failed with %=
d\n",
> +                              __func__, err);
> +                       goto out;
> +               }
> +
> +               prg_wait =3D jiffies +
> +                       msecs_to_jiffies(GET_SLEEP_NOTIFY_TIME_MSEC(
> +                       card->ext_csd.sleep_notify_time));
> +               }
> +
> +       /*
> +        * Loop will run until:
> +        * 1. Device is no more in Busy state
> +        * 2. Sleep notification is not interrupted by HPI & IO reque=
st
> +        */
> +       do {
> +               /* added some delay to avoid sending card status too =
often */
> +               msleep(20);
> +               err =3D 0;
> +               /* Stop polling in case sleep notification was HPIed =
already */
> +               if (!mmc_card_doing_sleep_notify(card)) {
> +                       is_busy =3D mmc_device_prg_state(card);
> +                       if (is_busy)
> +                               err =3D -EBUSY;
> +                       break;
> +               }
> +               is_busy =3D mmc_device_prg_state(card);
> +               if (is_busy && time_after(jiffies, prg_wait)) {
> +                       /*
> +                        * making sure we are still in busy before
> +                        * sending HPI due to timeout error
> +                        */
> +                       is_busy =3D mmc_device_prg_state(card);
> +                       if (is_busy) {
> +                               if (mmc_card_doing_sleep_notify(card)=
) {
> +                                       card->ext_csd.power_off_notif=
ication =3D
> +                                               EXT_CSD_POWER_ON;
> +                                       mmc_interrupt_hpi(card);
> +                               }
> +                               err =3D -ETIMEDOUT;
> +                               break;
> +                       }
> +               }
> +       } while (is_busy);
> +
> +out:
> +       mmc_card_clr_sleep_notify(card);
> +       if (err) {
> +               pr_err("%s: mmc_poweroff_notify for sleep failed with=
 %d\n",
> +                      mmc_hostname(card->host), err);
> +       }
>
>         return err;
>  }
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 4d69c00..6998344 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -62,6 +62,7 @@ struct mmc_ext_csd {
>         unsigned int            sa_timeout;             /* Units: 100=
ns */
>         unsigned int            generic_cmd6_time;      /* Units: 10m=
s */
>         unsigned int            power_off_longtime;     /* Units: ms =
*/
> +       unsigned int            sleep_notify_time;      /* Units: us =
*/
>         u8                      power_off_notification; /* state */
>         unsigned int            hs_max_dtr;
>         unsigned int            hs200_max_dtr;
> @@ -262,6 +263,7 @@ struct mmc_card {
>  #define MMC_CARD_REMOVED       (1<<4)          /* card has been remo=
ved */
>  #define MMC_STATE_DOING_BKOPS  (1<<5)          /* card is doing BKOP=
S */
>  #define MMC_STATE_SUSPENDED    (1<<6)          /* card is suspended =
*/
> +#define MMC_STATE_SLEEP_NOTIFY (1<<7)          /* card in sleep noti=
fy */

I think MMC_STATE_SUSPENDED should be enough, we don't need another
one specific for SLEEP_NOTIFY.

>         unsigned int            quirks;         /* card quirks */
>  #define MMC_QUIRK_LENIENT_FN0  (1<<0)          /* allow SDIO FN0 wri=
tes outside of the VS CCCR range */
>  #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)   /* use func->cur_blks=
ize */
> @@ -309,6 +311,7 @@ struct mmc_card {
>         struct dentry           *debugfs_root;
>         struct mmc_part part[MMC_NUM_PHY_PARTITION]; /* physical part=
itions */
>         unsigned int    nr_parts;
> +       u8 can_sleep_notify;    /* sleep_notify on/off */

As stated, please remove.

>  };
>
>  /*
> @@ -427,6 +430,7 @@ static inline void __maybe_unused remove_quirk(st=
ruct mmc_card *card, int data)
>  #define mmc_card_removed(c)    ((c) && ((c)->state & MMC_CARD_REMOVE=
D))
>  #define mmc_card_doing_bkops(c)        ((c)->state & MMC_STATE_DOING=
_BKOPS)
>  #define mmc_card_suspended(c)  ((c)->state & MMC_STATE_SUSPENDED)
> +#define mmc_card_doing_sleep_notify(c) ((c)->state & MMC_STATE_SLEEP=
_NOTIFY)
>
>  #define mmc_card_set_present(c)        ((c)->state |=3D MMC_STATE_PR=
ESENT)
>  #define mmc_card_set_readonly(c) ((c)->state |=3D MMC_STATE_READONLY=
)
> @@ -437,6 +441,8 @@ static inline void __maybe_unused remove_quirk(st=
ruct mmc_card *card, int data)
>  #define mmc_card_clr_doing_bkops(c)    ((c)->state &=3D ~MMC_STATE_D=
OING_BKOPS)
>  #define mmc_card_set_suspended(c) ((c)->state |=3D MMC_STATE_SUSPEND=
ED)
>  #define mmc_card_clr_suspended(c) ((c)->state &=3D ~MMC_STATE_SUSPEN=
DED)
> +#define mmc_card_set_sleep_notify(c)   ((c)->state |=3D MMC_STATE_SL=
EEP_NOTIFY)
> +#define mmc_card_clr_sleep_notify(c)   ((c)->state &=3D ~MMC_STATE_S=
LEEP_NOTIFY)
>
>  /*
>   * Quirk add/remove for MMC products.
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 9f32270..4c0542a 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -291,6 +291,7 @@ struct mmc_host {
>                                  MMC_CAP2_HS400_1_2V)
>  #define MMC_CAP2_HSX00_1_2V    (MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_H=
S400_1_2V)
>  #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
> +#define MMC_CAP2_SLEEP_NOTIFY  (1 << 18)       /* sleep notify suppo=
rted */
>
>         mmc_pm_flag_t           pm_caps;        /* supported pm featu=
res */
>
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 49ad7a9..69bda9a 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -314,6 +314,7 @@ struct _mmc_csd {
>  #define EXT_CSD_PWR_CL_52_360          202     /* RO */
>  #define EXT_CSD_PWR_CL_26_360          203     /* RO */
>  #define EXT_CSD_SEC_CNT                        212     /* RO, 4 byte=
s */
> +#define EXT_CSD_SLEEP_NOTIFICATION_TIME        216     /* RO */
>  #define EXT_CSD_S_A_TIMEOUT            217     /* RO */
>  #define EXT_CSD_REL_WR_SEC_C           222     /* RO */
>  #define EXT_CSD_HC_WP_GRP_SIZE         221     /* RO */
> @@ -408,6 +409,7 @@ struct _mmc_csd {
>  #define EXT_CSD_POWER_ON               1
>  #define EXT_CSD_POWER_OFF_SHORT                2
>  #define EXT_CSD_POWER_OFF_LONG         3
> +#define EXT_CSD_SLEEP_NOTIFICATION     4
>
>  #define EXT_CSD_PWR_CL_8BIT_MASK       0xF0    /* 8 bit PWR CLS */
>  #define EXT_CSD_PWR_CL_4BIT_MASK       0x0F    /* 8 bit PWR CLS */
> --
> 1.7.9.5
>

Kind regards
Uffe
