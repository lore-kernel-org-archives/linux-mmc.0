From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 4/4] mmc: core: Implement mmc_partial_init during resume
Date: Tue, 21 Feb 2017 11:51:02 +0100
Message-ID: <CAPDyKFpkPstmPKbs5y2+uiP+sc_pN9F8ZGhyXK4U02c97pvChw@mail.gmail.com>
References: <1487577792-12510-1-git-send-email-riteshh@codeaurora.org> <1487577792-12510-5-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1487577792-12510-5-git-send-email-riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Georgi Djakov <georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alex Lemberg <alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>, Mateusz Nowak <mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yuliy Izrailov <Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>, Asutosh Das <asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Griego <david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sahitya Tummala <stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Venkat Gopalakrishnan <venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Pramod Gurav <pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Talel
List-Id: linux-mmc@vger.kernel.org

On 20 February 2017 at 09:03, Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote=
:
> This patch adds mmc_partial_init functionality
> combining with CMD5 awake feature to reduce resume
> latency for emmc.
>
> This is not enabled for HS400 mode, since tuning
> in HS400 is required to be done in HS200 timing.
>
> Signed-off-by: Talel Shenhar <tatias-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Maya Erez <merez-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Asutosh Das <asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/mmc/core/core.c  |  13 +++++
>  drivers/mmc/core/core.h  |   1 +
>  drivers/mmc/core/mmc.c   | 134 +++++++++++++++++++++++++++++++++++++++++=
+++++-
>  include/linux/mmc/card.h |   3 ++
>  include/linux/mmc/host.h |   1 +
>  5 files changed, 150 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 926e0fd..4bbe3eb 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1197,6 +1197,19 @@ void mmc_set_bus_width(struct mmc_host *host, unsi=
gned int width)
>         mmc_set_ios(host);
>  }
>
> +void mmc_set_init_state(struct mmc_host *host)
> +{
> +       host->ios.bus_mode =3D host->cached_ios.bus_mode;
> +       host->ios.bus_width =3D host->cached_ios.bus_width;
> +       host->ios.timing =3D host->cached_ios.timing;

Is this really sufficient? Isn't there more to restore from the cached ios?

> +       if (host->card &&
> +           host->card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES &&
> +           host->cached_ios.timing =3D=3D MMC_TIMING_MMC_HS400)
> +               host->ios.enhanced_strobe =3D true;

Why don't you check the cached value for enhanced_strobe instead?

> +
> +       mmc_set_ios(host);
> +}
> +
>  /*
>   * Set initial state after a power cycle or a hw_reset.
>   */
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 55f543f..9476a89 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -58,6 +58,7 @@ int mmc_select_drive_strength(struct mmc_card *card, un=
signed int max_dtr,
>  void mmc_power_off(struct mmc_host *host);
>  void mmc_power_cycle(struct mmc_host *host, u32 ocr);
>  void mmc_set_initial_state(struct mmc_host *host);
> +void mmc_set_init_state(struct mmc_host *host);
>
>  static inline void mmc_delay(unsigned int ms)
>  {
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 83bcc86..f7c244c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1827,6 +1827,28 @@ static int mmc_can_sleep(struct mmc_card *card)
>         return (card && card->ext_csd.rev >=3D 3);
>  }
>
> +static int mmc_can_sleepawake_mode(struct mmc_host *host)
> +{
> +       /*
> +        * Disabled for HS400 mode since it requires tuning
> +        * to be done in HS200 timing and then switching
> +        * to HS400 mode.
> +        */
> +       switch (host->cached_ios.timing) {
> +       case MMC_TIMING_MMC_HS400:
> +               if (!(host->card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS40=
0ES))
> +                       return 0;

I don't get this? Could you elaborate why this case doesn=E2=80=99t work?

> +       default:
> +               return 1;
> +       }
> +}
> +
> +static int mmc_can_sleepawake(struct mmc_host *host)
> +{
> +       return (host && host->caps2 & MMC_CAP2_SLEEP_AWAKE &&

As I stated in the response to the cover letter, we could check for
MMC_CAP2_FULL_PWR_CYCLE instead.

Although, the problem with that would be if the host/soc supports a
full power cycle, but still doesn't set MMC_CAP2_FULL_PWR_CYCLE. If
that is the case, you shouldn't be using CMD5 to wake up the card from
sleep as it won't work.

This complexity, is one of the reasons to why we so far have chosen to
use CMD0 to wakeup the card from sleep. Because we know it is *always*
going to work.

I guess if we implement a fallback method of using CMD0 when CMD5
fails, perhaps that would be acceptable...

However, trying out CMD5 first and thus spend time on this
re-initialization sequence, then finding out that it fails will of
course be a waste of time.

> +               mmc_can_sleep(host->card) && mmc_can_sleepawake_mode(host=
));
> +}
> +
>  static int mmc_sleepawake(struct mmc_host *host, bool sleep)
>  {
>         struct mmc_command cmd =3D {};
> @@ -1964,6 +1986,100 @@ static void mmc_detect(struct mmc_host *host)
>         }
>  }
>
> +static int mmc_cache_card_ext_csd(struct mmc_host *host)
> +{
> +       int err;
> +       u8 *ext_csd;
> +       struct mmc_card *card =3D host->card;
> +
> +       err =3D mmc_get_ext_csd(card, &ext_csd);
> +       if (err || !ext_csd) {
> +               pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /* only cache read/write fields that the sw changes */
> +       card->ext_csd.raw_ext_csd_cache_ctrl =3D ext_csd[EXT_CSD_CACHE_CT=
RL];
> +       card->ext_csd.raw_ext_csd_bus_width =3D ext_csd[EXT_CSD_BUS_WIDTH=
];
> +       card->ext_csd.raw_ext_csd_hs_timing =3D ext_csd[EXT_CSD_HS_TIMING=
];
> +       kfree(ext_csd);
> +       return 0;
> +}
> +
> +static int mmc_test_awake_ext_csd(struct mmc_host *host)
> +{
> +       int err;
> +       u8 *ext_csd;
> +       struct mmc_card *card =3D host->card;
> +
> +       return 0;
> +       err =3D mmc_get_ext_csd(card, &ext_csd);
> +       if (err) {
> +               pr_err("%s: %s: mmc_get_ext_csd failed (%d)\n",
> +                      mmc_hostname(host), __func__, err);
> +               return err;
> +       }
> +
> +       /* only compare read/write fields that the sw changes */
> +       pr_debug("%s: %s: type(cached:current) cache_ctrl(%d:%d) bus_widt=
h (%d:%d) timing(%d:%d)\n",
> +                mmc_hostname(host), __func__,
> +                card->ext_csd.raw_ext_csd_cache_ctrl,
> +                ext_csd[EXT_CSD_CACHE_CTRL],
> +                card->ext_csd.raw_ext_csd_bus_width,
> +                ext_csd[EXT_CSD_BUS_WIDTH],
> +                card->ext_csd.raw_ext_csd_hs_timing,
> +                ext_csd[EXT_CSD_HS_TIMING]);
> +
> +       err =3D !((card->ext_csd.raw_ext_csd_cache_ctrl =3D=3D
> +                       ext_csd[EXT_CSD_CACHE_CTRL]) &&
> +               (card->ext_csd.raw_ext_csd_bus_width =3D=3D
> +                       ext_csd[EXT_CSD_BUS_WIDTH]) &&
> +               (card->ext_csd.raw_ext_csd_hs_timing =3D=3D
> +                       ext_csd[EXT_CSD_HS_TIMING]));
> +
> +       kfree(ext_csd);
> +       return err;
> +}
> +
> +static int mmc_partial_init(struct mmc_host *host)
> +{
> +       int err =3D 0;
> +       struct mmc_card *card =3D host->card;
> +
> +       mmc_set_init_state(host);
> +       mmc_set_clock(host, host->cached_ios.clock);
> +       if (mmc_card_hs400(card)) {
> +               if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES) {
> +                       if (host->ops->hs400_enhanced_strobe)
> +                               host->ops->hs400_enhanced_strobe(host,
> +                                                                &host->i=
os);
> +               }
> +       } else if (mmc_card_hs200(card)) {
> +               err =3D mmc_hs200_tuning(card);
> +               if (err)
> +                       pr_warn("%s: %s: tuning execution failed (%d)\n",
> +                               mmc_hostname(host), __func__, err);
> +       }
> +
> +       /*
> +        * The ext_csd is read to make sure the card did not went through
> +        * Power-failure during sleep period.
> +        * A subset of the W/E_P, W/C_P register will be tested. In case
> +        * these registers values are different from the values that were
> +        * cached during suspend, we will conclude that a Power-failure o=
ccurred
> +        * and will do full initialization sequence.
> +        */
> +       err =3D mmc_test_awake_ext_csd(host);

If the card is power cycled (in other words, VCCQ is powered off) the
card won't respond properly on a CMD5 to wakeup from sleep.

Then, why do we need to validate the EXT_CSD? I don't get it.


> +       if (err) {
> +               pr_err("%s: %s: fail on ext_csd read (%d)\n",
> +                      mmc_hostname(host), __func__, err);
> +               goto out;
> +       }
> +out:
> +       return err;
> +}
> +
>  static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>  {
>         int err =3D 0;
> @@ -1988,7 +2104,11 @@ static int _mmc_suspend(struct mmc_host *host, boo=
l is_suspend)
>         if (mmc_can_poweroff_notify(host->card) &&
>                 ((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
>                 err =3D mmc_poweroff_notify(host->card, notify_type);
> -       else if (mmc_can_sleep(host->card))
> +       else if (mmc_can_sleepawake(host)) {
> +               memcpy(&host->cached_ios, &host->ios, sizeof(host->cached=
_ios));
> +               mmc_cache_card_ext_csd(host);
> +               err =3D mmc_sleep(host);
> +       } else if (mmc_can_sleep(host->card))
>                 err =3D mmc_sleep(host);
>         else if (!mmc_host_is_spi(host))
>                 err =3D mmc_deselect_cards(host);

So, __mmc_suspend() calls mmc_power_off() which resets the ios
settings and power off the card.

Then in _mmc_resume() you restore those settings, which seems like it
could work....


> @@ -2032,7 +2152,17 @@ static int _mmc_resume(struct mmc_host *host)
>                 goto out;
>
>         mmc_power_up(host, host->card->ocr);
> -       err =3D mmc_init_card(host, host->card->ocr, host->card);
> +       if (mmc_can_sleepawake(host)) {
> +               err =3D mmc_awake(host);

... however this looks suspiciously wrong. Should you really send a
CMD5 to wakeup the card without first restoring the cached ios
settings?

> +               if (!err)
> +                       err =3D mmc_partial_init(host);
> +               if (err)
> +                       pr_err("%s: awake failed (%d), fallback to full i=
nit\n",
> +                              mmc_hostname(host), err);
> +       }
> +       if (err || !mmc_can_sleepawake(host))
> +               err =3D mmc_init_card(host, host->card->ocr, host->card);
> +
>         mmc_card_clr_suspended(host->card);
>
>  out:
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 77e61e0..9aa2c97 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -93,11 +93,14 @@ struct mmc_ext_csd {
>         unsigned int            cmdq_depth;     /* Command Queue depth */
>  #define MMC_FIRMWARE_LEN 8
>         u8                      fwrev[MMC_FIRMWARE_LEN];  /* FW version *=
/
> +       u8                      raw_ext_csd_cache_ctrl; /* 33 */
>         u8                      raw_exception_status;   /* 54 */
>         u8                      raw_partition_support;  /* 160 */
>         u8                      raw_rpmb_size_mult;     /* 168 */
>         u8                      raw_erased_mem_count;   /* 181 */
> +       u8                      raw_ext_csd_bus_width;  /* 183 */
>         u8                      strobe_support;         /* 184 */
> +       u8                      raw_ext_csd_hs_timing;  /* 185 */
>         u8                      raw_ext_csd_structure;  /* 194 */
>         u8                      raw_card_type;          /* 196 */
>         u8                      raw_driver_strength;    /* 197 */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index df7882b..c89407c 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -320,6 +320,7 @@ struct mmc_host {
>         spinlock_t              lock;           /* lock for claim and bus=
 ops */
>
>         struct mmc_ios          ios;            /* current io bus setting=
s */
> +       struct mmc_ios          cached_ios;
>
>         /* group bitfields together to minimize padding */
>         unsigned int            use_spi_crc:1;
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project.
>

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
