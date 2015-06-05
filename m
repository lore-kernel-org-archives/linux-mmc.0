From: Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2] mmc: enable Enhance Strobe for HS400.
Date: Sat, 6 Jun 2015 03:20:13 +0530
Message-ID: <CALk7dXqVyGubDreAfev4xx7QkoHWzan1DvmNLwpgtqFhZe5NdQ@mail.gmail.com>
References: <1433472602-3851-1-git-send-email-yi.y.sun@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36573 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411AbbFEVuO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2015 17:50:14 -0400
Received: by ieclw1 with SMTP id lw1so66850704iec.3
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jun 2015 14:50:13 -0700 (PDT)
In-Reply-To: <1433472602-3851-1-git-send-email-yi.y.sun@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yi Sun <yi.y.sun@intel.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org

Hi Sun,

Did you get to test this feature on any of the target?



On Fri, Jun 5, 2015 at 8:20 AM, Yi Sun <yi.y.sun@intel.com> wrote:
> Enhance Strobe is defined in v5.1 eMMC spec. This commit
> is to implement it.
>
> Normal Strobe signal for HS400 is only provided during
> Data Out and CRC Response. While Enhance Strobe is enabled,
> Strobe signal is provided during Data Out, CRC Response and
> CMD Response.
>
> While enabling Enhance Strobe, the initialization of HS400
> does not need enabling HS200 and executing tuning anymore.
If enhanced strobe is enabled, what about SDHCI_NEEDS_RETUNING flag ?
In case of CRC error, we do execute tuning, but now after support of
enhanced strobe, how will that be taken care of?


> This simplifies the HS400 initialization process much.
>
> Per spec, there is a STROBE_SUPPORT added in EXT_CSD register
> to indicate that card supports Enhance Strobe or not. If it is
> supported, host can enable this feature by enabling the most
> significant bit of BUS_WIDTH before set HS_TIMING to HS400.
enhanced strobe feature also requires support from host controller
side as well. Dont you think we should provide some ops here for that?
>
> Signed-off-by: Yi Sun <yi.y.sun@intel.com>
> ---
>  drivers/mmc/core/mmc.c   |   61 ++++++++++++++++++++++++++++++++++++++++++----
>  include/linux/mmc/card.h |    1 +
>  include/linux/mmc/mmc.h  |    2 ++
>  3 files changed, 59 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index e519e31..c9ef2de 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -585,6 +585,12 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>                 card->ext_csd.ffu_capable =
>                         (ext_csd[EXT_CSD_SUPPORTED_MODE] & 0x1) &&
>                         !(ext_csd[EXT_CSD_FW_CONFIG] & 0x1);
> +
> +               /* Enhance Strobe is supported since v5.1 which rev should be
> +                * 8 but some eMMC devices can support it with rev 7. So handle
> +                * Enhance Strobe here.
> +                */
> +               card->ext_csd.strobe_support = ext_csd[EXT_CSD_STROBE_SUPPORT];
>         }
>  out:
>         return err;
> @@ -1049,9 +1055,28 @@ static int mmc_select_hs400(struct mmc_card *card)
>         /*
>          * HS400 mode requires 8-bit bus width
>          */
comment not valid?

> -       if (!(card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400 &&
> -             host->ios.bus_width == MMC_BUS_WIDTH_8))
> -               return 0;
> +       if (card->ext_csd.strobe_support) {
> +               if (!(card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400 &&
> +                   host->caps & MMC_CAP_8_BIT_DATA))
> +                       return 0;
> +
> +               /* For Enhance Strobe flow. For non Enhance Strobe, signal
> +                * voltage will not be set.
> +                */
> +               if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_2V)
> +                       err = __mmc_set_signal_voltage(host,
> +                                       MMC_SIGNAL_VOLTAGE_120);
> +
> +               if (err && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_8V)
> +                       err = __mmc_set_signal_voltage(host,
> +                                       MMC_SIGNAL_VOLTAGE_180);
> +               if (err)
> +                       return err;
> +       } else {
> +               if (!(card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400 &&
> +                   host->ios.bus_width == MMC_BUS_WIDTH_8))
> +                       return 0;
> +       }
>
>         /*
>          * Before switching to dual data rate operation for HS400,
> @@ -1072,15 +1097,36 @@ static int mmc_select_hs400(struct mmc_card *card)
>                 return err;
>         }
>
> +       val = EXT_CSD_DDR_BUS_WIDTH_8;
> +       if (card->ext_csd.strobe_support)
> +               val |= EXT_CSD_BUS_WIDTH_STROBE;
>         err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                          EXT_CSD_BUS_WIDTH,
> -                        EXT_CSD_DDR_BUS_WIDTH_8,
> +                        val,
>                          card->ext_csd.generic_cmd6_time);
>         if (err) {
>                 pr_err("%s: switch to bus width for hs400 failed, err:%d\n",
>                         mmc_hostname(host), err);
>                 return err;
>         }
> +       if (card->ext_csd.strobe_support) {
> +               mmc_set_bus_width(host, MMC_BUS_WIDTH_8);
> +               /*
> +                * If controller can't handle bus width test,
> +                * compare ext_csd previously read in 1 bit mode
> +                * against ext_csd at new bus width
> +                */
> +               if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
> +                       err = mmc_compare_ext_csds(card, MMC_BUS_WIDTH_8);
> +               else
> +                       err = mmc_bus_test(card, MMC_BUS_WIDTH_8);
> +
> +               if (err) {
> +                       pr_warn("%s: switch to bus width %d failed\n",
> +                               mmc_hostname(host), MMC_BUS_WIDTH_8);
> +                       return err;
> +               }
> +       }
>
>         val = EXT_CSD_TIMING_HS400 |
>               card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
> @@ -1263,7 +1309,12 @@ static int mmc_select_timing(struct mmc_card *card)
>         if (!mmc_can_ext_csd(card))
>                 goto bus_speed;
>
> -       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
> +       /* For Enhance Strobe HS400 flow */
> +       if (card->ext_csd.strobe_support &&
> +           card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400 &&
> +           card->host->caps & MMC_CAP_8_BIT_DATA)
> +               err = mmc_select_hs400(card);
> +       else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
>                 err = mmc_select_hs200(card);
>         else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
>                 err = mmc_select_hs(card);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 4d3776d..b793b61 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -95,6 +95,7 @@ struct mmc_ext_csd {
>         u8                      raw_partition_support;  /* 160 */
>         u8                      raw_rpmb_size_mult;     /* 168 */
>         u8                      raw_erased_mem_count;   /* 181 */
> +       u8                      strobe_support;         /* 184 */
>         u8                      raw_ext_csd_structure;  /* 194 */
>         u8                      raw_card_type;          /* 196 */
>         u8                      raw_driver_strength;    /* 197 */
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 15f2c4a..a1bb32c 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -297,6 +297,7 @@ struct _mmc_csd {
>  #define EXT_CSD_PART_CONFIG            179     /* R/W */
>  #define EXT_CSD_ERASED_MEM_CONT                181     /* RO */
>  #define EXT_CSD_BUS_WIDTH              183     /* R/W */
> +#define EXT_CSD_STROBE_SUPPORT         184     /* RO */
>  #define EXT_CSD_HS_TIMING              185     /* R/W */
>  #define EXT_CSD_POWER_CLASS            187     /* R/W */
>  #define EXT_CSD_REV                    192     /* RO */
> @@ -386,6 +387,7 @@ struct _mmc_csd {
>  #define EXT_CSD_BUS_WIDTH_8    2       /* Card is in 8 bit mode */
>  #define EXT_CSD_DDR_BUS_WIDTH_4        5       /* Card is in 4 bit DDR mode */
>  #define EXT_CSD_DDR_BUS_WIDTH_8        6       /* Card is in 8 bit DDR mode */
> +#define EXT_CSD_BUS_WIDTH_STROBE       0x80    /* Card is in 8 bit DDR mode */
>
>  #define EXT_CSD_TIMING_BC      0       /* Backwards compatility */
>  #define EXT_CSD_TIMING_HS      1       /* High speed */
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
