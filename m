From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: Fixup broken suspend and eMMC4.5 power off notify
Date: Fri, 14 Sep 2012 13:55:54 +0530
Message-ID: <CAGxe1ZFJhc-c8rS0KGdfTvejs27jjpz7T4Z2AVwoB-=7QOMemg@mail.gmail.com>
References: <1347528053-8521-1-git-send-email-ulf.hansson@stericsson.com>
	<CAGxe1ZF5hBoV5seKYDnwCNgk0ff1+wcie1RgEX19MFGAnNYebg@mail.gmail.com>
	<CAGxe1ZF6FDTxrbmBkzzSqhP8TPjA_7MbZPukaAeSzs8KOu1m2g@mail.gmail.com>
	<CAPDyKFotCTKX9O3KYtr3ZtAqaoCaNuHWDYfP23=+z11=_7XQOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:38242 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759284Ab2INIZ4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Sep 2012 04:25:56 -0400
Received: by vcbfo13 with SMTP id fo13so3566162vcb.19
        for <linux-mmc@vger.kernel.org>; Fri, 14 Sep 2012 01:25:55 -0700 (PDT)
In-Reply-To: <CAPDyKFotCTKX9O3KYtr3ZtAqaoCaNuHWDYfP23=+z11=_7XQOA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Saugata Das <saugata.das@linaro.org>, Asutosh Das <asutoshd@codeaurora.org>

On 14 September 2012 12:37, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Hi Girish,
>
> I should also have stated that this patch has not been tested with an
> eMMC 4.5 device, thus the power off notification is not fully tested.
> Unfortunate I don't have such a device available right now. What I did
> test was that patch must not break anything and tested that the
> suspend/resume sequence is fixed for eMMC with sleep support. I also
> tested this with MMC_CAP2_POWEROFF_NOTIFY enabled.
>
> Are you able to help out in testing with a eMMC 4.5 device with
> POWER_OFF_NOTIFY support?
I am also facing the same  problem. The board that i used earlier to
upstream 4.5 patches is not functioning. Thats the reason for the
delay in upstreaming or sending the patch. Once i get it repaired i ll
definitely do it.
It would be helpful if somebody in the list can do this in the mean time.
>
> Kind regards
> Ulf Hansson
>
> On 14 September 2012 08:38, Girish K S <girish.shivananjappa@linaro.org> wrote:
>> On 14 September 2012 10:38, Girish K S <girish.shivananjappa@linaro.org> wrote:
>>> HI Ulf,
>>> You had Acked the rework patch mailed by Saugata. But this patch
>>> doesnt look same like the one sent by saugata.
>> Sorry Ulf
>> I saw your and Saugata mail after replying to this.
>> Pls ignore this
>>>
>>> On 13 September 2012 14:50, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>>>
>>>> This patch fixup the broken suspend sequence for eMMC
>>>> with sleep support. Additionally it reworks the eMMC4.5
>>>> Power Off Notification feature so it fits together with
>>>> the existing sleep feature.
>>>>
>>>> The CMD0 based re-initialization of the eMMC at resume
>>>> is re-introduced to maintain compatiblity for devices
>>>> using sleep.
>>>>
>>>> A host shall use MMC_CAP2_POWEROFF_NOTIFY to enable the
>>>> Power Off Notification feature. We might be able to
>>>> remove this cap later on, if we think that Power Off
>>>> Notification always is preferred over sleep, even if the
>>>> host is not able to cut the eMMC VCCQ power.
>>>>
>>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>>>> CC: Girish K S <girish.shivananjappa@linaro.org>
>>>> CC: Asutosh Das <asutoshd@codeaurora.org>
>>>> ---
>>>>  drivers/mmc/core/core.c   |   62 ---------------------------------------------
>>>>  drivers/mmc/core/mmc.c    |   46 +++++++++++++++++++++++++--------
>>>>  drivers/mmc/host/dw_mmc.c |    5 ----
>>>>  drivers/mmc/host/sdhci.c  |    9 -------
>>>>  include/linux/mmc/card.h  |   10 +-------
>>>>  include/linux/mmc/host.h  |    4 ---
>>>>  6 files changed, 36 insertions(+), 100 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index af2c4d2..2765097 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -1134,48 +1134,6 @@ void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
>>>>         mmc_host_clk_release(host);
>>>>  }
>>>>
>>>> -static void mmc_poweroff_notify(struct mmc_host *host)
>>>> -{
>>>> -       struct mmc_card *card;
>>>> -       unsigned int timeout;
>>>> -       unsigned int notify_type = EXT_CSD_NO_POWER_NOTIFICATION;
>>>> -       int err = 0;
>>>> -
>>>> -       card = host->card;
>>>> -       mmc_claim_host(host);
>>>> -
>>>> -       /*
>>>> -        * Send power notify command only if card
>>>> -        * is mmc and notify state is powered ON
>>>> -        */
>>>> -       if (card && mmc_card_mmc(card) &&
>>>> -           (card->poweroff_notify_state == MMC_POWERED_ON)) {
>>>> -
>>>> -               if (host->power_notify_type == MMC_HOST_PW_NOTIFY_SHORT) {
>>>> -                       notify_type = EXT_CSD_POWER_OFF_SHORT;
>>>> -                       timeout = card->ext_csd.generic_cmd6_time;
>>>> -                       card->poweroff_notify_state = MMC_POWEROFF_SHORT;
>>>> -               } else {
>>>> -                       notify_type = EXT_CSD_POWER_OFF_LONG;
>>>> -                       timeout = card->ext_csd.power_off_longtime;
>>>> -                       card->poweroff_notify_state = MMC_POWEROFF_LONG;
>>>> -               }
>>>> -
>>>> -               err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>>> -                                EXT_CSD_POWER_OFF_NOTIFICATION,
>>>> -                                notify_type, timeout);
>>>> -
>>>> -               if (err && err != -EBADMSG)
>>>> -                       pr_err("Device failed to respond within %d poweroff "
>>>> -                              "time. Forcefully powering down the device\n",
>>>> -                              timeout);
>>>> -
>>>> -               /* Set the card state to no notification after the poweroff */
>>>> -               card->poweroff_notify_state = MMC_NO_POWER_NOTIFICATION;
>>>> -       }
>>>> -       mmc_release_host(host);
>>>> -}
>>>> -
>>>>  /*
>>>>   * Apply power to the MMC stack.  This is a two-stage process.
>>>>   * First, we enable power to the card without the clock running.
>>>> @@ -1238,8 +1196,6 @@ static void mmc_power_up(struct mmc_host *host)
>>>>
>>>>  void mmc_power_off(struct mmc_host *host)
>>>>  {
>>>> -       int err = 0;
>>>> -
>>>>         if (host->ios.power_mode == MMC_POWER_OFF)
>>>>                 return;
>>>>
>>>> @@ -1248,22 +1204,6 @@ void mmc_power_off(struct mmc_host *host)
>>>>         host->ios.clock = 0;
>>>>         host->ios.vdd = 0;
>>>>
>>>> -       /*
>>>> -        * For eMMC 4.5 device send AWAKE command before
>>>> -        * POWER_OFF_NOTIFY command, because in sleep state
>>>> -        * eMMC 4.5 devices respond to only RESET and AWAKE cmd
>>>> -        */
>>>> -       if (host->card && mmc_card_is_sleep(host->card) &&
>>>> -           host->bus_ops->resume) {
>>>> -               err = host->bus_ops->resume(host);
>>>> -
>>>> -               if (!err)
>>>> -                       mmc_poweroff_notify(host);
>>>> -               else
>>>> -                       pr_warning("%s: error %d during resume "
>>>> -                                  "(continue with poweroff sequence)\n",
>>>> -                                  mmc_hostname(host), err);
>>>> -       }
>>>>
>>>>         /*
>>>>          * Reset ocr mask to be the highest possible voltage supported for
>>>> @@ -2425,7 +2365,6 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>>>>
>>>>                 spin_lock_irqsave(&host->lock, flags);
>>>>                 host->rescan_disable = 1;
>>>> -               host->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
>>>>                 spin_unlock_irqrestore(&host->lock, flags);
>>>>                 cancel_delayed_work_sync(&host->detect);
>>>>
>>>> @@ -2449,7 +2388,6 @@ int mmc_pm_notify(struct notifier_block *notify_block,
>>>>
>>>>                 spin_lock_irqsave(&host->lock, flags);
>>>>                 host->rescan_disable = 0;
>>>> -               host->power_notify_type = MMC_HOST_PW_NOTIFY_LONG;
>>>>                 spin_unlock_irqrestore(&host->lock, flags);
>>>>                 mmc_detect_change(host, 0);
>>>>
>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>> index 396b258..9607c35 100644
>>>> --- a/drivers/mmc/core/mmc.c
>>>> +++ b/drivers/mmc/core/mmc.c
>>>> @@ -996,7 +996,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>>>                  * so check for success and update the flag
>>>>                  */
>>>>                 if (!err)
>>>> -                       card->poweroff_notify_state = MMC_POWERED_ON;
>>>> +                       card->ext_csd.power_off_notification = EXT_CSD_POWER_ON;
>>>>         }
>>>>
>>>>         /*
>>>> @@ -1262,6 +1262,35 @@ err:
>>>>         return err;
>>>>  }
>>>>
>>>> +static int mmc_can_poweroff_notify(const struct mmc_card *card)
>>>> +{
>>>> +       return card &&
>>>> +               mmc_card_mmc(card) &&
>>>> +               (card->ext_csd.power_off_notification == EXT_CSD_POWER_ON);
>>>> +}
>>>> +
>>>> +static int mmc_poweroff_notify(struct mmc_card *card, unsigned int notify_type)
>>>> +{
>>>> +       unsigned int timeout = card->ext_csd.generic_cmd6_time;
>>>> +       int err;
>>>> +
>>>> +       /* Use EXT_CSD_POWER_OFF_SHORT as default notification type. */
>>>> +       if (notify_type == EXT_CSD_POWER_OFF_LONG)
>>>> +               timeout = card->ext_csd.power_off_longtime;
>>>> +
>>>> +       err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>>> +                        EXT_CSD_POWER_OFF_NOTIFICATION,
>>>> +                        notify_type, timeout);
>>>> +       if (err)
>>>> +               pr_err("%s: Power Off Notification timed out, %u\n",
>>>> +                      mmc_hostname(card->host), timeout);
>>>> +
>>>> +       /* Disable the power off notification after the switch operation. */
>>>> +       card->ext_csd.power_off_notification = EXT_CSD_NO_POWER_NOTIFICATION;
>>>> +
>>>> +       return err;
>>>> +}
>>>> +
>>>>  /*
>>>>   * Host is being removed. Free up the current card.
>>>>   */
>>>> @@ -1322,11 +1351,11 @@ static int mmc_suspend(struct mmc_host *host)
>>>>         BUG_ON(!host->card);
>>>>
>>>>         mmc_claim_host(host);
>>>> -       if (mmc_card_can_sleep(host)) {
>>>> +       if (mmc_can_poweroff_notify(host->card))
>>>> +               err = mmc_poweroff_notify(host->card, EXT_CSD_POWER_OFF_SHORT);
>>>> +       else if (mmc_card_can_sleep(host))
>>>>                 err = mmc_card_sleep(host);
>>>> -               if (!err)
>>>> -                       mmc_card_set_sleep(host->card);
>>>> -       } else if (!mmc_host_is_spi(host))
>>>> +       else if (!mmc_host_is_spi(host))
>>>>                 err = mmc_deselect_cards(host);
>>>>         host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
>>>>         mmc_release_host(host);
>>>> @@ -1348,11 +1377,7 @@ static int mmc_resume(struct mmc_host *host)
>>>>         BUG_ON(!host->card);
>>>>
>>>>         mmc_claim_host(host);
>>>> -       if (mmc_card_is_sleep(host->card)) {
>>>> -               err = mmc_card_awake(host);
>>>> -               mmc_card_clr_sleep(host->card);
>>>> -       } else
>>>> -               err = mmc_init_card(host, host->ocr, host->card);
>>>> +       err = mmc_init_card(host, host->ocr, host->card);
>>>>         mmc_release_host(host);
>>>>
>>>>         return err;
>>>> @@ -1363,7 +1388,6 @@ static int mmc_power_restore(struct mmc_host *host)
>>>>         int ret;
>>>>
>>>>         host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
>>>> -       mmc_card_clr_sleep(host->card);
>>>>         mmc_claim_host(host);
>>>>         ret = mmc_init_card(host, host->ocr, host->card);
>>>>         mmc_release_host(host);
>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>> index 36f98c0..7ef4f8a 100644
>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>> @@ -1810,11 +1810,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>>>         if (host->pdata->quirks & DW_MCI_QUIRK_HIGHSPEED)
>>>>                 mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>>>>
>>>> -       if (mmc->caps2 & MMC_CAP2_POWEROFF_NOTIFY)
>>>> -               mmc->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
>>>> -       else
>>>> -               mmc->power_notify_type = MMC_HOST_PW_NOTIFY_NONE;
>>>> -
>>>>         if (host->pdata->blk_settings) {
>>>>                 mmc->max_segs = host->pdata->blk_settings->max_segs;
>>>>                 mmc->max_blk_size = host->pdata->blk_settings->max_blk_size;
>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>> index d98b199..6035094 100644
>>>> --- a/drivers/mmc/host/sdhci.c
>>>> +++ b/drivers/mmc/host/sdhci.c
>>>> @@ -2878,15 +2878,6 @@ int sdhci_add_host(struct sdhci_host *host)
>>>>         if (caps[1] & SDHCI_DRIVER_TYPE_D)
>>>>                 mmc->caps |= MMC_CAP_DRIVER_TYPE_D;
>>>>
>>>> -       /*
>>>> -        * If Power Off Notify capability is enabled by the host,
>>>> -        * set notify to short power off notify timeout value.
>>>> -        */
>>>> -       if (mmc->caps2 & MMC_CAP2_POWEROFF_NOTIFY)
>>>> -               mmc->power_notify_type = MMC_HOST_PW_NOTIFY_SHORT;
>>>> -       else
>>>> -               mmc->power_notify_type = MMC_HOST_PW_NOTIFY_NONE;
>>>> -
>>>>         /* Initial value for re-tuning timer count */
>>>>         host->tuning_count = (caps[1] & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
>>>>                               SDHCI_RETUNING_TIMER_COUNT_SHIFT;
>>>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>>>> index 4b27f9f..90f655b 100644
>>>> --- a/include/linux/mmc/card.h
>>>> +++ b/include/linux/mmc/card.h
>>>> @@ -57,6 +57,7 @@ struct mmc_ext_csd {
>>>>         unsigned int            sa_timeout;             /* Units: 100ns */
>>>>         unsigned int            generic_cmd6_time;      /* Units: 10ms */
>>>>         unsigned int            power_off_longtime;     /* Units: ms */
>>>> +       u8                      power_off_notification; /* state */
>>>>         unsigned int            hs_max_dtr;
>>>>  #define MMC_HIGH_26_MAX_DTR    26000000
>>>>  #define MMC_HIGH_52_MAX_DTR    52000000
>>>> @@ -225,7 +226,6 @@ struct mmc_card {
>>>>  #define MMC_CARD_SDXC          (1<<6)          /* card is SDXC */
>>>>  #define MMC_CARD_REMOVED       (1<<7)          /* card has been removed */
>>>>  #define MMC_STATE_HIGHSPEED_200        (1<<8)          /* card is in HS200 mode */
>>>> -#define MMC_STATE_SLEEP                (1<<9)          /* card is in sleep state */
>>>>         unsigned int            quirks;         /* card quirks */
>>>>  #define MMC_QUIRK_LENIENT_FN0  (1<<0)          /* allow SDIO FN0 writes outside of the VS CCCR range */
>>>>  #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)   /* use func->cur_blksize */
>>>> @@ -241,11 +241,6 @@ struct mmc_card {
>>>>  #define MMC_QUIRK_LONG_READ_TIME (1<<9)                /* Data read time > CSD says */
>>>>  #define MMC_QUIRK_SEC_ERASE_TRIM_BROKEN (1<<10)        /* Skip secure for erase/trim */
>>>>                                                 /* byte mode */
>>>> -       unsigned int    poweroff_notify_state;  /* eMMC4.5 notify feature */
>>>> -#define MMC_NO_POWER_NOTIFICATION      0
>>>> -#define MMC_POWERED_ON                 1
>>>> -#define MMC_POWEROFF_SHORT             2
>>>> -#define MMC_POWEROFF_LONG              3
>>>>
>>>>         unsigned int            erase_size;     /* erase size in sectors */
>>>>         unsigned int            erase_shift;    /* if erase unit is power 2 */
>>>> @@ -392,7 +387,6 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
>>>>  #define mmc_sd_card_uhs(c)     ((c)->state & MMC_STATE_ULTRAHIGHSPEED)
>>>>  #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
>>>>  #define mmc_card_removed(c)    ((c) && ((c)->state & MMC_CARD_REMOVED))
>>>> -#define mmc_card_is_sleep(c)   ((c)->state & MMC_STATE_SLEEP)
>>>>
>>>>  #define mmc_card_set_present(c)        ((c)->state |= MMC_STATE_PRESENT)
>>>>  #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
>>>> @@ -404,9 +398,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
>>>>  #define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
>>>>  #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
>>>>  #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
>>>> -#define mmc_card_set_sleep(c)  ((c)->state |= MMC_STATE_SLEEP)
>>>>
>>>> -#define mmc_card_clr_sleep(c)  ((c)->state &= ~MMC_STATE_SLEEP)
>>>>  /*
>>>>   * Quirk add/remove for MMC products.
>>>>   */
>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>> index d5d9bd4..7abb0e1 100644
>>>> --- a/include/linux/mmc/host.h
>>>> +++ b/include/linux/mmc/host.h
>>>> @@ -259,10 +259,6 @@ struct mmc_host {
>>>>  #define MMC_CAP2_RO_ACTIVE_HIGH        (1 << 11)       /* Write-protect signal active high */
>>>>
>>>>         mmc_pm_flag_t           pm_caps;        /* supported pm features */
>>>> -       unsigned int        power_notify_type;
>>>> -#define MMC_HOST_PW_NOTIFY_NONE                0
>>>> -#define MMC_HOST_PW_NOTIFY_SHORT       1
>>>> -#define MMC_HOST_PW_NOTIFY_LONG                2
>>>>
>>>>  #ifdef CONFIG_MMC_CLKGATE
>>>>         int                     clk_requests;   /* internal reference counter */
>>>> --
>>>> 1.7.10
>>>>
