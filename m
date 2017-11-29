From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Send SLEEP_NOTIFICATION for eMMC 5.x device
Date: Wed, 29 Nov 2017 15:07:12 +0100
Message-ID: <CAPDyKFozbQR8MBKrN1CTnQ_G=_5v_FFd4YqGZVX9LjnwqZ=jEQ@mail.gmail.com>
References: <20171118010634.1111-1-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:43782 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752098AbdK2OHN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Nov 2017 09:07:13 -0500
Received: by mail-io0-f195.google.com with SMTP id s37so3769951ioe.10
        for <linux-mmc@vger.kernel.org>; Wed, 29 Nov 2017 06:07:13 -0800 (PST)
In-Reply-To: <20171118010634.1111-1-gwendal@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, Chris Ball <cjb@laptop.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Thierry Escande <thierry.escande@collabora.com>

On 18 November 2017 at 02:06, Gwendal Grignou <gwendal@chromium.org> wrote:
> eMMC 5.0 spec introduces a new power off notification, SLEEP_NOTIFICATION,
> the host may send before issuing the sleep commamd.
>
> Some eMMC expect the SLEEP_NOTIFICATION for optimal performance:
> It is recommended by Sandisk for its iNAND 7232 to empty the iNAND
> SmartTLC buffer, See "Emptying the iNAND SmartSLC buffer" of datasheet.
> Hynix eMMC also resume faster when SLEEP_NOTIFICATION is sent before
> going to sleep.
>
> SLEEP_NOTIFICATION PON can theoretically take a long time, iNAND sleep
> notification timeout is set to 83.88s. But it has to be sent just before
> CMD5, otherwise newer commands may make it moot.

I think this change log needs some more clarification. At least for my
understanding.

Once SLEEP_NOTIFICATION was introduced, it became *mandatory* to first
set POWER_OFF_NOTIFICATION to SLEEP_NOTIFICATION (in case we earlier
have set POWER_OFF_NOTIFICATION byte to POWERED_ON), before putting
the device into sleep using a CMD5. My point is, the above changelog
seems to state that it *is not mandatory*, but optional. What is
really the case here, do you know?

Some additional comments below.

>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> There were several attempts to add SLEEP_NOTIFICATION, here is another try.
> For refrence:
>  http://thread.gmane.org/gmane.linux.kernel.mmc/23471 [1/2034]
>  http://www.spinics.net/lists/linux-mmc/msg31344.html [6/2015]
>  https://patchwork.kernel.org/patch/9360633/ [10/2016]
>
>
>  drivers/mmc/core/mmc.c   | 46 +++++++++++++++++++++++++++++++++++++---------
>  include/linux/mmc/card.h |  3 ++-
>  include/linux/mmc/mmc.h  |  2 ++
>  3 files changed, 41 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 36217ad5e9b1..00ee7dd5ba07 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -633,6 +633,13 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>                         ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_A];
>                 card->ext_csd.device_life_time_est_typ_b =
>                         ext_csd[EXT_CSD_DEVICE_LIFE_TIME_EST_TYP_B];
> +
> +               if (ext_csd[EXT_CSD_SLEEP_NOTIFICATION_TIME] == 0 ||
> +                   ext_csd[EXT_CSD_SLEEP_NOTIFICATION_TIME] >= 0x18)
> +                       card->ext_csd.sleep_notification_time = 0;
> +               else
> +                       card->ext_csd.sleep_notification_time =
> +                               max((10 << ext_csd[EXT_CSD_SLEEP_NOTIFICATION_TIME]) / 1000, 1);
>         }
>
>         /* eMMC v5.1 or later */
> @@ -652,6 +659,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>                                  card->ext_csd.cmdq_depth);
>                 }
>         }
> +

White space.

>  out:
>         return err;
>  }
> @@ -1865,18 +1873,34 @@ static int mmc_can_poweroff_notify(const struct mmc_card *card)
>                 (card->ext_csd.power_off_notification == EXT_CSD_POWER_ON);
>  }
>
> +static int mmc_can_sleep_notify(const struct mmc_card *card)
> +{
> +       return mmc_can_poweroff_notify(card) &&
> +               (card->ext_csd.sleep_notification_time > 0);
> +}
> +
>  static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
>  {
> -       unsigned int timeout = card->ext_csd.generic_cmd6_time;
> +       unsigned int timeout;
> +       bool use_busy_signal = true;
>         int err;
>
> -       /* Use EXT_CSD_POWER_OFF_SHORT as default notification type. */
> -       if (notify_type == EXT_CSD_POWER_OFF_LONG)
> +       switch (notify_type) {
> +       case EXT_CSD_POWER_OFF_LONG:
>                 timeout = card->ext_csd.power_off_longtime;
> +               break;
> +       case EXT_CSD_SLEEP_NOTIFICATION:
> +               timeout = card->ext_csd.sleep_notification_time;
> +               use_busy_signal = false;

This is wrong.

If you set use_busy_signal to false, it means that we don't care about
waiting for the card to stop signaling busy on DAT0 after setting
EXT_CSD_SLEEP_NOTIFICATION. This then becomes a violation of the eMMC
spec, because we must not issue a CMD5 before the card have stopped
signaling busy.

I realize that for those devices that don't support
MMC_CAP_WAIT_WHILE_BUSY or have the ->card_busy() callback
implemented, the consequence may be that mmc_poll_for_busy() may call
mmc_delay() with a very big timeout. This could be a big problem, I
guess.

> +               break;
> +       default:
> +               /* Use EXT_CSD_POWER_OFF_SHORT as default notification type. */
> +               timeout = card->ext_csd.generic_cmd6_time;
> +       }
>
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                         EXT_CSD_POWER_OFF_NOTIFICATION,
> -                       notify_type, timeout, 0, true, false, false);
> +                       notify_type, timeout, 0, use_busy_signal, false, false);
>         if (err)
>                 pr_err("%s: Power Off Notification timed out, %u\n",
>                        mmc_hostname(card->host), timeout);
> @@ -1952,13 +1976,17 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>                 goto out;
>
>         if (mmc_can_poweroff_notify(host->card) &&
> -               ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
> +               ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend)) {
>                 err = mmc_poweroff_notify(host->card, notify_type);
> -       else if (mmc_can_sleep(host->card))
> -               err = mmc_sleep(host);
> -       else if (!mmc_host_is_spi(host))
> +       } else if (mmc_can_sleep(host->card)) {
> +               if (mmc_can_sleep_notify(host->card))
> +                       err = mmc_poweroff_notify(host->card,
> +                                       EXT_CSD_SLEEP_NOTIFICATION);
> +               if (!err)
> +                       err = mmc_sleep(host);
> +       } else if (!mmc_host_is_spi(host)) {
>                 err = mmc_deselect_cards(host);
> -
> +       }
>         if (!err) {
>                 mmc_power_off(host);
>                 mmc_card_set_suspended(host->card);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 279b39008a33..5af3661bd98a 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -59,8 +59,9 @@ struct mmc_ext_csd {
>         u8                      packed_event_en;
>         unsigned int            part_time;              /* Units: ms */
>         unsigned int            sa_timeout;             /* Units: 100ns */
> -       unsigned int            generic_cmd6_time;      /* Units: 10ms */
> +       unsigned int            generic_cmd6_time;      /* Units: ms */

White space - or perhaps make it a separate change.

>         unsigned int            power_off_longtime;     /* Units: ms */
> +       unsigned int            sleep_notification_time; /* Units: ms */
>         u8                      power_off_notification; /* state */
>         unsigned int            hs_max_dtr;
>         unsigned int            hs200_max_dtr;
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 3ffc27aaeeaf..901e124dee72 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -277,6 +277,7 @@ static inline bool mmc_op_multi(u32 opcode)
>  #define EXT_CSD_PWR_CL_52_360          202     /* RO */
>  #define EXT_CSD_PWR_CL_26_360          203     /* RO */
>  #define EXT_CSD_SEC_CNT                        212     /* RO, 4 bytes */
> +#define EXT_CSD_SLEEP_NOTIFICATION_TIME        216     /* RO */
>  #define EXT_CSD_S_A_TIMEOUT            217     /* RO */
>  #define EXT_CSD_REL_WR_SEC_C           222     /* RO */
>  #define EXT_CSD_HC_WP_GRP_SIZE         221     /* RO */
> @@ -379,6 +380,7 @@ static inline bool mmc_op_multi(u32 opcode)
>  #define EXT_CSD_POWER_ON               1
>  #define EXT_CSD_POWER_OFF_SHORT                2
>  #define EXT_CSD_POWER_OFF_LONG         3
> +#define EXT_CSD_SLEEP_NOTIFICATION     4
>
>  #define EXT_CSD_PWR_CL_8BIT_MASK       0xF0    /* 8 bit PWR CLS */
>  #define EXT_CSD_PWR_CL_4BIT_MASK       0x0F    /* 8 bit PWR CLS */
> --
> 2.15.0.448.gf294e3d99a-goog
>

Kind regards
Uffe
