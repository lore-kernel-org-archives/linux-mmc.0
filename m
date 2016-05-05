From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v2 3/6] mmc: core: implement enhanced strobe support
Date: Thu, 5 May 2016 10:16:31 +0800
Message-ID: <58a0a7b5-5cf2-3c34-9613-d22e01a0f2ab@rock-chips.com>
References: <1461897751-28810-1-git-send-email-shawn.lin@rock-chips.com>
 <1461898029-28944-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFogNjwNs+fKPaah_X=AfSgtXUwefzon+ZQ2a2Va5Om5Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFogNjwNs+fKPaah_X=AfSgtXUwefzon+ZQ2a2Va5Om5Nw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 2016/5/4 20:02, Ulf Hansson wrote:
> On 29 April 2016 at 04:47, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>> Controllers use data strobe line to latch data from devices
>> under hs400 mode, but not for cmd line. So since emmc 5.1, JEDEC
>> introduces enhanced strobe mode for latching cmd response from
>> emmc devices to host controllers. This new feature is optional,
>> so it depends both on device's cap and host's cap to decide
>> whether to use it or not.
>>
>> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>> ---
>>
>> Changes in v2: None
>>
>>  drivers/mmc/core/bus.c   |  3 +-
>>  drivers/mmc/core/mmc.c   | 77 ++++++++++++++++++++++++++++++++++++++++++++----
>>  include/linux/mmc/card.h |  1 +
>>  include/linux/mmc/host.h | 12 ++++++++
>>  include/linux/mmc/mmc.h  |  3 ++
>>  5 files changed, 89 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> index 4bc48f1..7e94b9d 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -332,12 +332,13 @@ int mmc_add_card(struct mmc_card *card)
>>                         mmc_card_ddr52(card) ? "DDR " : "",
>>                         type);
>>         } else {
>> -               pr_info("%s: new %s%s%s%s%s card at address %04x\n",
>> +               pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
>>                         mmc_hostname(card->host),
>>                         mmc_card_uhs(card) ? "ultra high speed " :
>>                         (mmc_card_hs(card) ? "high speed " : ""),
>>                         mmc_card_hs400(card) ? "HS400 " :
>>                         (mmc_card_hs200(card) ? "HS200 " : ""),
>> +                       mmc_card_hs400es(card) ? "Enhanced strobe" : "",
>
> I am not sure this informations should be printed. It's still and
> HS400 card, there is no performance impact, right?

Just as Adrain said, a significant behaviour for hs400es is that
it doesn't need tuning/re-tune stuff. So I prone to keep it here.

>
>>                         mmc_card_ddr52(card) ? "DDR " : "",
>>                         uhs_bus_speed_mode, type, card->rca);
>>         }
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 28b477d..f45ed10 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -235,6 +235,12 @@ static void mmc_select_card_type(struct mmc_card *card)
>>                 avail_type |= EXT_CSD_CARD_TYPE_HS400_1_2V;
>>         }
>>
>> +       if ((caps2 & MMC_CAP2_HS400_ENHANCED_STROBE) &&
>> +           card->ext_csd.strobe_support &&
>> +           ((card_type & EXT_CSD_CARD_TYPE_HS400_1_2V) ||
>> +            (card_type & EXT_CSD_CARD_TYPE_HS400_1_8V)))
>> +               avail_type |= EXT_CSD_CARD_TYPE_HS400ES;
>> +
>>         card->ext_csd.hs_max_dtr = hs_max_dtr;
>>         card->ext_csd.hs200_max_dtr = hs200_max_dtr;
>>         card->mmc_avail_type = avail_type;
>> @@ -383,6 +389,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>>                         mmc_card_set_blockaddr(card);
>>         }
>>
>> +       card->ext_csd.strobe_support = ext_csd[EXT_CSD_STROBE_SUPPORT];
>>         card->ext_csd.raw_card_type = ext_csd[EXT_CSD_CARD_TYPE];
>>         mmc_select_card_type(card);
>>
>> @@ -1062,9 +1069,10 @@ static int mmc_select_hs400(struct mmc_card *card)
>>         u8 val;
>>
>>         /*
>> -        * HS400 mode requires 8-bit bus width
>> +        * HS400(ES) mode requires 8-bit bus width
>>          */
>> -       if (!(card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400 &&
>> +       if (!(((card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400) ||
>> +               (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)) &&
>>               host->ios.bus_width == MMC_BUS_WIDTH_8))
>>                 return 0;
>>
>> @@ -1097,9 +1105,26 @@ static int mmc_select_hs400(struct mmc_card *card)
>>         }
>>
>>         /* Switch card to DDR */
>> +       val = EXT_CSD_DDR_BUS_WIDTH_8;
>> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES) {
>> +               val |= EXT_CSD_BUS_WIDTH_STROBE;
>> +               /*
>> +               * Make sure we are in non-enhanced strobe mode before we
>> +               * actually enable it in ext_csd.
>> +               */
>> +               if (host->ops->prepare_enhanced_strobe)
>> +                       err = host->ops->prepare_enhanced_strobe(host, false);
>
> 1) I suggest we rename the callback to "hs400_enhanced_strobe".

Aha, personal taste?
I'm ok for whatever the name to be :)

>
> 2) I think this might be is a bit late to deal with restoring enhanced
> strobe to off. Perhaps we should do that in mmc_set_initial_state()
> instead!?
>

Good idea.

>> +
>> +               if (err) {
>> +                       pr_err("%s: unprepare_enhanced strobe failed, err:%d\n",
>
> Maybe pr_dbg instead?
>
> /s/unprepare_enhanced strobe/Disable hs400 es

ok, most of the failure in mmc_init_card use
pr_warn/dbg.

So will fix it.

>
>> +                               mmc_hostname(host), err);
>> +                       return err;
>> +               }
>> +       }
>> +
>>         err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>                          EXT_CSD_BUS_WIDTH,
>> -                        EXT_CSD_DDR_BUS_WIDTH_8,
>> +                        val,
>>                          card->ext_csd.generic_cmd6_time);
>>         if (err) {
>>                 pr_err("%s: switch to bus width for hs400 failed, err:%d\n",
>> @@ -1124,6 +1149,35 @@ static int mmc_select_hs400(struct mmc_card *card)
>>         mmc_set_timing(host, MMC_TIMING_MMC_HS400);
>>         mmc_set_bus_speed(card);
>>
>> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES) {
>> +               /* Controller enable enhanced strobe function */
>> +               if (host->ops->prepare_enhanced_strobe)
>> +                       err = host->ops->prepare_enhanced_strobe(host, true);
>> +
>> +               if (err) {
>> +                       pr_err("%s: prepare enhanced strobe failed, err:%d\n",
>
> Maybe pr_dbg/warn instead?
>
> /s/prepare enhanced strobe/Enable hs400 es
>
>> +                               mmc_hostname(host), err);
>> +                       return err;
>> +               }
>> +
>> +               /*
>> +                * After switching to hs400 enhanced strobe mode, we expect to
>> +                * verify whether it works or not. If controller can't handle
>> +                * bus width test, compare ext_csd previously read in 1 bit mode
>> +                * against ext_csd at new bus width
>> +                */
>
> Is this according to spec? If so, we should probably state that here.
> If not, further explanation for *why* we do this is needed.

It's NOT from spec. Just like switch bus width, enabling enhanced strobe
brings different IO-interface timing, so I add this check to make sure
both the device and host to be ok under hs400es, otherwise we show
hs400es successfully but failing to read superblock later if mounted.

So check it in advanced is probably sane?

>
>> +               if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
>> +                       err = mmc_compare_ext_csds(card, MMC_BUS_WIDTH_8);
>> +               else
>> +                       err = mmc_bus_test(card, MMC_BUS_WIDTH_8);
>> +
>> +               if (err) {
>> +                       pr_warn("%s: switch to enhanced strobe failed\n",
>> +                               mmc_hostname(host));
>> +                       return err;
>> +               }
>> +       }
>> +
>>         if (!send_status) {
>>                 err = mmc_switch_status(card);
>>                 if (err)
>> @@ -1297,7 +1351,8 @@ err:
>>  }
>>
>>  /*
>> - * Activate High Speed or HS200 mode if supported.
>> + * Activate High Speed or HS200 mode if supported. For HS400
>> + * with enhanced strobe mode, we should activate High Speed.
>>   */
>>  static int mmc_select_timing(struct mmc_card *card)
>>  {
>> @@ -1306,7 +1361,9 @@ static int mmc_select_timing(struct mmc_card *card)
>>         if (!mmc_can_ext_csd(card))
>>                 goto bus_speed;
>>
>> -       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
>> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)
>> +               err = mmc_select_hs(card);
>> +       else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
>>                 err = mmc_select_hs200(card);
>>         else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
>>                 err = mmc_select_hs(card);
>> @@ -1578,7 +1635,15 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>         } else if (mmc_card_hs(card)) {
>>                 /* Select the desired bus width optionally */
>>                 err = mmc_select_bus_width(card);
>> -               if (!IS_ERR_VALUE(err)) {
>> +               if (IS_ERR_VALUE(err))
>> +                       goto free_card;
>
> This is going to change the behaviour, as earlier switching the bus
> width was optional. See the comment a few lines above and the
> implementation of mmc_select_bus_width().

Sorry, but I cannot see any behavioural change for bus width.
before swithing to HS400, we should make sure it's in 8-bit mode.

Before this change, the path seems to be:
(1) select_timing : hs200 --> mmc_select_hs200 -> mmc_select_bus_width
		    hs --> mmc_select_hs
(2) mmc_card_hs200 -> tuning --> mmc_select_hs400
     mmc_card_hs -> mmc_select_bus_width -> mmc_select_hs_ddr

Now the behaviour should be:
(1) select_timing : hs400es -> mmc_select_hs
		    hs200 --> mmc_select_hs200 -> mmc_select_bus_width
		    hs --> mmc_select_hs
(2) mmc_card_hs200 -> tuning --> mmc_select_hs400
     mmc_card_hs -> mmc_select_bus_width |-> mmc_select_hs_ddr
					|-> mmc_select_hs400

did I miss something?

Thanks.

>
>> +
>> +               if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES) {
>> +                       /* Directly from HS to HS400-ES */
>> +                       err = mmc_select_hs400(card);
>> +                       if (err)
>> +                               goto free_card;
>> +               } else {
>>                         err = mmc_select_hs_ddr(card);
>>                         if (err)
>>                                 goto free_card;
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index eb0151b..22defc2 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -95,6 +95,7 @@ struct mmc_ext_csd {
>>         u8                      raw_partition_support;  /* 160 */
>>         u8                      raw_rpmb_size_mult;     /* 168 */
>>         u8                      raw_erased_mem_count;   /* 181 */
>> +       u8                      strobe_support;         /* 184 */
>>         u8                      raw_ext_csd_structure;  /* 194 */
>>         u8                      raw_card_type;          /* 196 */
>>         u8                      raw_driver_strength;    /* 197 */
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 11e89d3..19de56c 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -19,6 +19,7 @@
>>
>>  #include <linux/mmc/core.h>
>>  #include <linux/mmc/card.h>
>> +#include <linux/mmc/mmc.h>
>>  #include <linux/mmc/pm.h>
>>
>>  struct mmc_ios {
>> @@ -143,6 +144,8 @@ struct mmc_host_ops {
>>
>>         /* Prepare HS400 target operating frequency depending host driver */
>>         int     (*prepare_hs400_tuning)(struct mmc_host *host, struct mmc_ios *ios);
>> +       /* Prepare enhanced strobe depending host driver */
>> +       int     (*prepare_enhanced_strobe)(struct mmc_host *host, bool enable);
>>         int     (*select_drive_strength)(struct mmc_card *card,
>>                                          unsigned int max_dtr, int host_drv,
>>                                          int card_drv, int *drv_type);
>> @@ -518,6 +521,15 @@ static inline bool mmc_card_hs400(struct mmc_card *card)
>>         return card->host->ios.timing == MMC_TIMING_MMC_HS400;
>>  }
>>
>> +static inline bool mmc_card_hs400es(struct mmc_card *card)
>> +{
>> +       if (mmc_card_hs400(card) &&
>> +           (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES))
>> +               return 1;
>> +
>> +       return 0;
>> +}
>> +
>>  void mmc_retune_timer_stop(struct mmc_host *host);
>>
>>  static inline void mmc_retune_needed(struct mmc_host *host)
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index 15f2c4a..c376209 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -297,6 +297,7 @@ struct _mmc_csd {
>>  #define EXT_CSD_PART_CONFIG            179     /* R/W */
>>  #define EXT_CSD_ERASED_MEM_CONT                181     /* RO */
>>  #define EXT_CSD_BUS_WIDTH              183     /* R/W */
>> +#define EXT_CSD_STROBE_SUPPORT         184     /* RO */
>>  #define EXT_CSD_HS_TIMING              185     /* R/W */
>>  #define EXT_CSD_POWER_CLASS            187     /* R/W */
>>  #define EXT_CSD_REV                    192     /* RO */
>> @@ -380,12 +381,14 @@ struct _mmc_csd {
>>  #define EXT_CSD_CARD_TYPE_HS400_1_2V   (1<<7)  /* Card can run at 200MHz DDR, 1.2V */
>>  #define EXT_CSD_CARD_TYPE_HS400                (EXT_CSD_CARD_TYPE_HS400_1_8V | \
>>                                          EXT_CSD_CARD_TYPE_HS400_1_2V)
>> +#define EXT_CSD_CARD_TYPE_HS400ES      (1<<8)  /* Card can run at HS400ES */
>>
>>  #define EXT_CSD_BUS_WIDTH_1    0       /* Card is in 1 bit mode */
>>  #define EXT_CSD_BUS_WIDTH_4    1       /* Card is in 4 bit mode */
>>  #define EXT_CSD_BUS_WIDTH_8    2       /* Card is in 8 bit mode */
>>  #define EXT_CSD_DDR_BUS_WIDTH_4        5       /* Card is in 4 bit DDR mode */
>>  #define EXT_CSD_DDR_BUS_WIDTH_8        6       /* Card is in 8 bit DDR mode */
>> +#define EXT_CSD_BUS_WIDTH_STROBE BIT(7)        /* Enhanced strobe mode */
>>
>>  #define EXT_CSD_TIMING_BC      0       /* Backwards compatility */
>>  #define EXT_CSD_TIMING_HS      1       /* High speed */
>> --
>> 2.3.7
>>
>>
>
> Kind regards
> Uffe
>
>
>


-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
