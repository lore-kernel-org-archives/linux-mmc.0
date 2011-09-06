From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/2] mmc: core: Add poweroff notify handling feature
Date: Tue, 06 Sep 2011 16:01:42 +0900
Message-ID: <000301cc6c62$d55c42d0$8014c870$%jun@samsung.com>
References: <1315223399-21599-1-git-send-email-girish.shivananjappa@linaro.org>
 <1315223399-21599-3-git-send-email-girish.shivananjappa@linaro.org>
 <CAH9JG2X-nZp0nfmmm93jCuknA56yFWDRYzSobDXFz6wHAea0rg@mail.gmail.com>
 <CAGxe1ZGyPCRHbYhk-7b9Aad76zbVaoORQcLZbu2MT5Yn05sxEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAGxe1ZGyPCRHbYhk-7b9Aad76zbVaoORQcLZbu2MT5Yn05sxEQ@mail.gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Girish K S' <girish.shivananjappa@linaro.org>, 'Kyungmin Park' <kmpark@infradead.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

Hi Girish K S,

I think short type is proper rather than long type by default.
Long type seems to be unacceptable in suspend regarding long timeout.
One question,
Is this patch considered for system power off besides suspend?

Beset regards,
Seungwon Jeon.

Girish K S wrote:
 
> Hi Mr Park,
> 
> On 5 September 2011 18:03, Kyungmin Park <kmpark@infradead.org> wrote:
> > Hi Girish,
> >
> > I think it's still incomplete, does power off short function is called
> > at suspend properly?
> > there are some comments below.
> >
> > Thank you,
> > Kyungmin Park
> >
> > On Mon, Sep 5, 2011 at 8:49 PM, Girish K S
> > <girish.shivananjappa@linaro.org> wrote:
> >> This patch adds the handling of the poweroff notify feature
> >> during powerdown phase.
> >>
> >> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> >> ---
> >>  drivers/mmc/core/core.c  |   29 +++++++++++++++++++++++++++++
> >>  drivers/mmc/core/mmc.c   |    3 +++
> >>  drivers/mmc/host/sdhci.c |   11 +++++++++++
> >>  include/linux/mmc/card.h |   29 +++++++++++++++++++++++++----
> >>  include/linux/mmc/host.h |    7 +++++--
> >>  5 files changed, 73 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >> index a65e1ca..37b09d7 100644
> >> --- a/drivers/mmc/core/core.c
> >> +++ b/drivers/mmc/core/core.c
> >> @@ -1130,9 +1130,38 @@ static void mmc_power_up(struct mmc_host *host)
> >>
> >>  static void mmc_power_off(struct mmc_host *host)
> >>  {
> >> +       struct mmc_card *card = host->card;
> >> +       unsigned int notify_type;
> >> +       unsigned int timeout;
> >> +       int err;
> >> +
> >>        host->ios.clock = 0;
> >>        host->ios.vdd = 0;
> >>
> >> +       if (mmc_card_mmc(card) && mmc_card_powernotify_on(card)) {
> >> +
> >> +               if (host->power_notify_type == MMC_POWEROFF_NOTIFY_SHORT)
> {
> >> +                       notify_type = EXT_CSD_POWER_OFF_SHORT;
> >> +                       timeout = card->ext_csd.generic_cmd6_time;
> >> +                       mmc_card_set_powernotify_short(card);
> >> +               } else {
> >> +                       notify_type = EXT_CSD_POWER_OFF_LONG;
> >> +                       timeout = card->ext_csd.power_off_longtime;
> >> +                       mmc_card_set_powernotify_long(card);
> >> +               }
> >> +
> >> +               err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> >> +                               EXT_CSD_POWER_OFF_NOTIFICATION,
> >> +                               notify_type, timeout);
> >> +
> >> +               if (err && err != -EBADMSG)
> >> +                       printk(KERN_ERR "Device failed to respond "
> >> +                                       "within %d poweroff time."
> >> +                                       "forcefully powering down"
> >> +                                       "the device\n", timeout);
> >> +
> >> +               mmc_card_set_powernotify_off(card);
> >> +       }
> >>        /*
> >>         * Reset ocr mask to be the highest possible voltage supported
> for
> >>         * this mmc host. This value will be used at next power up.
> >> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> >> index 2f06b37..b369c6f 100644
> >> --- a/drivers/mmc/core/mmc.c
> >> +++ b/drivers/mmc/core/mmc.c
> >> @@ -720,8 +720,11 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
> >>                                EXT_CSD_POWER_OFF_NOTIFICATION,
> >>                                EXT_CSD_POWER_ON,
> >>                                card->ext_csd.generic_cmd6_time);
> >> +
> >>                if (err && err != -EBADMSG)
> >>                        goto free_card;
> >> +
> >> +               mmc_card_set_powernotify_on(card);
> >>        }
> >>
> >>        /*
> >> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >> index 0e02cc1..a24a31b 100644
> >> --- a/drivers/mmc/host/sdhci.c
> >> +++ b/drivers/mmc/host/sdhci.c
> >> @@ -2566,6 +2566,17 @@ int sdhci_add_host(struct sdhci_host *host)
> >>        if (caps[1] & SDHCI_DRIVER_TYPE_D)
> >>                mmc->caps |= MMC_CAP_DRIVER_TYPE_D;
> >>
> >> +       if (mmc->caps == MMC_CAP_POWER_OFF_NOTIFY) {
> > It should be if (mmc->caps & MMC_CAP_POWER_OFF_NOTIFY) {
> >> +               /*
> >> +                * If Notify capability is enabled and
> >> +                * platform data is not initialised, set default to
> >> +                * long power off notify timeout value
> >> +                */
> >> +               if (mmc->power_notify_type == MMC_POWEROFF_NOTIFY_NONE)
> >> +                       mmc->power_notify_type = MMC_POWEROFF_NOTIFY_LONG;
> >> +       } else {
> >> +               mmc->power_notify_type = MMC_POWEROFF_NOTIFY_NONE;
> >> +       }
> > What's the goal of these statements?
>  the goal of the statement is to set the notification type to a default
> value.
> if host doesnt have the capability then notification type is none.
> If the host supports the capability and the notification type (whether
> the short or long is not set), then default is long type.
> >>        /* Initial value for re-tuning timer count */
> >>        host->tuning_count = (caps[1] & SDHCI_RETUNING_TIMER_COUNT_MASK)
> >>
> >>                              SDHCI_RETUNING_TIMER_COUNT_SHIFT;
> >> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> >> index 2bf2843..d40b7b3 100644
> >> --- a/include/linux/mmc/card.h
> >> +++ b/include/linux/mmc/card.h
> >> @@ -179,7 +179,12 @@ struct mmc_card {
> >>  #define MMC_STATE_HIGHSPEED_DDR (1<<4)         /* card is in high speed
> mode */
> >>  #define MMC_STATE_ULTRAHIGHSPEED (1<<5)                /* card is in
> ultra high speed mode */
> >>  #define MMC_CARD_SDXC          (1<<6)          /* card is SDXC */
> >> -       unsigned int            quirks;         /* card quirks */
> >> +       unsigned int    poweroff_notify_state;/*eMMC4.5 notify
> feature  */
> >> +#define MMC_NO_POWER_NITOFICATION      0
> >> +#define MMC_POWERED_ON         1
> >> +#define MMC_POWEROFF_SHORT     2
> >> +#define MMC_POWEROFF_LONG      3
> >> +       unsigned int            quirks;         /* card quirks */
> > Don't modify the meaning-less change
> sorry my mistake.
> >>  #define MMC_QUIRK_LENIENT_FN0  (1<<0)          /* allow SDIO FN0 writes
> outside of the VS CCCR range */
> >>  #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)   /* use func-
> >cur_blksize */
> >>                                                /* for byte mode */
> >> @@ -192,9 +197,9 @@ struct mmc_card {
> >>  #define MMC_QUIRK_BLK_NO_CMD23 (1<<7)          /* Avoid CMD23 for
> regular multiblock */
> >>
> >>        unsigned int            erase_size;     /* erase size in sectors */
> >> -       unsigned int            erase_shift;    /* if erase unit is power
> 2 */
> >> -       unsigned int            pref_erase;     /* in sectors */
> >> -       u8                      erased_byte;    /* value of erased bytes */
> >> +       unsigned int            erase_shift;    /* if erase unit is power
> 2 */
> >> +       unsigned int            pref_erase;     /* in sectors */
> >> +       u8                      erased_byte;    /* value of erased bytes */
> > ditto
> >>
> >>        u32                     raw_cid[4];     /* raw card CID */
> >>        u32                     raw_csd[4];     /* raw card CSD */
> >> @@ -325,6 +330,22 @@ static inline void __maybe_unused
> remove_quirk(struct mmc_card *card, int data)
> >>  #define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
> >>  #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
> >>
> >> +#define mmc_card_powernotify_on(c)             \
> >> +               ((c)->poweroff_notify_state == MMC_POWERED_ON)
> >> +#define mmc_card_powernotify_short(c)  \
> >> +               ((c)->poweroff_notify_state == MMC_POWEROFF_SHORT)
> >> +#define mmc_card_powernotify_long(c)   \
> >> +               ((c)->poweroff_notify_state == MMC_POWEROFF_LONG)
> >> +
> >> +#define mmc_card_set_powernotify_off(c)        \
> >> +               ((c)->poweroff_notify_state = MMC_NO_POWER_NITOFICATION)
> > Typo, NOTIFICATION
> >> +#define mmc_card_set_powernotify_on(c) \
> >> +               ((c)->poweroff_notify_state = MMC_POWERED_ON)
> >> +#define mmc_card_set_powernotify_short(c)      \
> >> +               ((c)->poweroff_notify_state = MMC_POWEROFF_SHORT)
> >> +#define mmc_card_set_powernotify_long(c)       \
> >> +               ((c)->poweroff_notify_state = MMC_POWEROFF_LONG)
> > What's the purpose the these defines? it's not used at patches.
> These macros have been used in the mmc_power_off function. Before
> calling the mmc_switch command
> in mmc_power_off its required to know whether the card has enabled the
> POWER_ON_NOTIFICATION byte
> in the extended csd register. mmc_switch has to be called only if
> POWER_ON_NOTIFICATION == POWER_ON
> so these macros have been defined to set the state variable in cards
> context.
> i will delete the remaining unused macros.
> >> +
> >>  /*
> >>  * Quirk add/remove for MMC products.
> >>  */
> >> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> >> index 21c85e1..354752a 100644
> >> --- a/include/linux/mmc/host.h
> >> +++ b/include/linux/mmc/host.h
> >> @@ -229,10 +229,13 @@ struct mmc_host {
> >>  #define MMC_CAP_MAX_CURRENT_600        (1 << 28)       /* Host max
> current limit is 600mA */
> >>  #define MMC_CAP_MAX_CURRENT_800        (1 << 29)       /* Host max
> current limit is 800mA */
> >>  #define MMC_CAP_CMD23          (1 << 30)       /* CMD23 supported. */
> >> -#define MMC_CAP_POWER_OFF_NOTIFY    (1 << 31)/*NOtify poweroff
> supported */
> >> +#define MMC_CAP_POWER_OFF_NOTIFY    (1 << 31)/*Notify poweroff
> supported */
> > Please update the #1 patch first
> sure
> >>
> >>        mmc_pm_flag_t           pm_caps;        /* supported pm features */
> >> -
> >> +#define MMC_POWEROFF_NOTIFY_NONE       0
> >> +#define MMC_POWEROFF_NOTIFY_SHORT      1
> >> +#define MMC_POWEROFF_NOTIFY_LONG       2
> > You already define the similar, please make one defines
> ok will make the necessary change
> >> +#define MMC_NO_POWER_NITOFICATION      0
> >> +#define MMC_POWERED_ON         1
> >> +#define MMC_POWEROFF_SHORT     2
> >> +#define MMC_POWEROFF_LONG      3
> >> +       unsigned int            power_notify_type;
> >>  #ifdef CONFIG_MMC_CLKGATE
> >>        int                     clk_requests;   /* internal reference
> counter */
> >>        unsigned int            clk_delay;      /* number of MCI clk hold
> cycles */
> >> --
> >> 1.7.1
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
