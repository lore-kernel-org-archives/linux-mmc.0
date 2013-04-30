From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH v2] mmc: core: Fix select power class after resume
Date: Tue, 30 Apr 2013 10:40:20 +0530
Message-ID: <CAGxe1ZEaw-efL1icZyYOz8VZFeXW7m3c1dFDZ9NAXfSzAUEYgA@mail.gmail.com>
References: <1366727227-29848-1-git-send-email-fredrik.soderstedt@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:58955 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254Ab3D3FKX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Apr 2013 01:10:23 -0400
Received: by mail-bk0-f47.google.com with SMTP id ji1so48592bkc.34
        for <linux-mmc@vger.kernel.org>; Mon, 29 Apr 2013 22:10:21 -0700 (PDT)
In-Reply-To: <1366727227-29848-1-git-send-email-fredrik.soderstedt@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>

Hi,

On 23 April 2013 19:57, Fredrik Soderstedt
<fredrik.soderstedt@stericsson.com> wrote:
>
> Use the saved values in card->ext_csd when selecting power class.
> By doing this the power class will be selected even if mmc_init_card
> is called with oldcard != NULL, which is the case after a suspend/resume.
>
> Today ext_csd is NULL if mmc_init_card is called with oldcard != NULL
> and power class will not be selected.
>
> According to the eMMC specification the POWER_CLASS value is reset after
> power failure, H/W reset assertion and any CMD0 reset.
>
> CC: Girish K S <girish.shivananjappa@linaro.org>
> Signed-off-by: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>
> ---
>
> Changes since v1:
> - Fix typo from card->ext_csd.raw_pwr_cl_52_360 to
> card->ext_csd.raw_pwr_cl_ddr_52_360
>
>  drivers/mmc/core/mmc.c   | 74
> ++++++++++++++++++++++++++++++++----------------
>  include/linux/mmc/card.h | 10 ++++++-
>  2 files changed, 59 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 0cbd1ef..d6d957e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -461,6 +461,24 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8
> *ext_csd)
>                  */
>                 card->ext_csd.boot_ro_lock = ext_csd[EXT_CSD_BOOT_WP];
>                 card->ext_csd.boot_ro_lockable = true;
> +
> +               /* Save power class values */
> +               card->ext_csd.raw_pwr_cl_52_195 =
> +                       ext_csd[EXT_CSD_PWR_CL_52_195];
> +               card->ext_csd.raw_pwr_cl_26_195 =
> +                       ext_csd[EXT_CSD_PWR_CL_26_195];
> +               card->ext_csd.raw_pwr_cl_52_360 =
> +                       ext_csd[EXT_CSD_PWR_CL_52_360];
> +               card->ext_csd.raw_pwr_cl_26_360 =
> +                       ext_csd[EXT_CSD_PWR_CL_26_360];
> +               card->ext_csd.raw_pwr_cl_200_195 =
> +                       ext_csd[EXT_CSD_PWR_CL_200_195];
> +               card->ext_csd.raw_pwr_cl_200_360 =
> +                       ext_csd[EXT_CSD_PWR_CL_200_360];
> +               card->ext_csd.raw_pwr_cl_ddr_52_195 =
> +                       ext_csd[EXT_CSD_PWR_CL_DDR_52_195];
> +               card->ext_csd.raw_pwr_cl_ddr_52_360 =
> +                       ext_csd[EXT_CSD_PWR_CL_DDR_52_360];
>         }
>
>         if (card->ext_csd.rev >= 5) {
> @@ -607,7 +625,23 @@ static int mmc_compare_ext_csds(struct mmc_card
> *card, unsigned bus_width)
>                 (card->ext_csd.raw_sectors[2] ==
>                         bw_ext_csd[EXT_CSD_SEC_CNT + 2]) &&
>                 (card->ext_csd.raw_sectors[3] ==
> -                       bw_ext_csd[EXT_CSD_SEC_CNT + 3]));
> +                       bw_ext_csd[EXT_CSD_SEC_CNT + 3]) &&
> +               (card->ext_csd.raw_pwr_cl_52_195 ==
> +                       bw_ext_csd[EXT_CSD_PWR_CL_52_195]) &&
> +               (card->ext_csd.raw_pwr_cl_26_195 ==
> +                       bw_ext_csd[EXT_CSD_PWR_CL_26_195]) &&
> +               (card->ext_csd.raw_pwr_cl_52_360 ==
> +                       bw_ext_csd[EXT_CSD_PWR_CL_52_360]) &&
> +               (card->ext_csd.raw_pwr_cl_26_360 ==
> +                       bw_ext_csd[EXT_CSD_PWR_CL_26_360]) &&
> +               (card->ext_csd.raw_pwr_cl_200_195 ==
> +                       bw_ext_csd[EXT_CSD_PWR_CL_200_195]) &&
> +               (card->ext_csd.raw_pwr_cl_200_360 ==
> +                       bw_ext_csd[EXT_CSD_PWR_CL_200_360]) &&
> +               (card->ext_csd.raw_pwr_cl_ddr_52_195 ==
> +                       bw_ext_csd[EXT_CSD_PWR_CL_DDR_52_195]) &&
> +               (card->ext_csd.raw_pwr_cl_ddr_52_360 ==
> +                       bw_ext_csd[EXT_CSD_PWR_CL_DDR_52_360]));
>         if (err)
>                 err = -EINVAL;
>
> @@ -676,11 +710,10 @@ static struct device_type mmc_type = {
>   * mmc_switch command.
>   */
>  static int mmc_select_powerclass(struct mmc_card *card,
> -               unsigned int bus_width, u8 *ext_csd)
> +               unsigned int bus_width)
>  {
>         int err = 0;
> -       unsigned int pwrclass_val;
> -       unsigned int index = 0;
> +       unsigned int pwrclass_val = 0;
>         struct mmc_host *host;
>
>         BUG_ON(!card);
> @@ -688,9 +721,6 @@ static int mmc_select_powerclass(struct mmc_card
> *card,
>         host = card->host;
>         BUG_ON(!host);
>
> -       if (ext_csd == NULL)
> -               return 0;
> -
>         /* Power class selection is supported for versions >= 4.0 */
>         if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
>                 return 0;
> @@ -702,13 +732,13 @@ static int mmc_select_powerclass(struct mmc_card
> *card,
>         switch (1 << host->ios.vdd) {
>         case MMC_VDD_165_195:
>                 if (host->ios.clock <= 26000000)
> -                       index = EXT_CSD_PWR_CL_26_195;
> +                       pwrclass_val = card->ext_csd.raw_pwr_cl_26_195;
>                 else if (host->ios.clock <= 52000000)
> -                       index = (bus_width <= EXT_CSD_BUS_WIDTH_8) ?
> -                               EXT_CSD_PWR_CL_52_195 :
> -                               EXT_CSD_PWR_CL_DDR_52_195;
> +                       pwrclass_val = (bus_width <= EXT_CSD_BUS_WIDTH_8)
> ?
> +                               card->ext_csd.raw_pwr_cl_52_195 :
> +                               card->ext_csd.raw_pwr_cl_ddr_52_195;
>                 else if (host->ios.clock <= 200000000)
> -                       index = EXT_CSD_PWR_CL_200_195;
> +                       pwrclass_val = card->ext_csd.raw_pwr_cl_200_195;
>                 break;
>         case MMC_VDD_27_28:
>         case MMC_VDD_28_29:
> @@ -720,13 +750,13 @@ static int mmc_select_powerclass(struct mmc_card
> *card,
>         case MMC_VDD_34_35:
>         case MMC_VDD_35_36:
>                 if (host->ios.clock <= 26000000)
> -                       index = EXT_CSD_PWR_CL_26_360;
> +                       pwrclass_val = card->ext_csd.raw_pwr_cl_26_360;
>                 else if (host->ios.clock <= 52000000)
> -                       index = (bus_width <= EXT_CSD_BUS_WIDTH_8) ?
> -                               EXT_CSD_PWR_CL_52_360 :
> -                               EXT_CSD_PWR_CL_DDR_52_360;
> +                       pwrclass_val = (bus_width <= EXT_CSD_BUS_WIDTH_8)
> ?
> +                               card->ext_csd.raw_pwr_cl_52_360 :
> +                               card->ext_csd.raw_pwr_cl_ddr_52_360;
>                 else if (host->ios.clock <= 200000000)
> -                       index = EXT_CSD_PWR_CL_200_360;
> +                       pwrclass_val = card->ext_csd.raw_pwr_cl_200_360;
>                 break;
>         default:
>                 pr_warning("%s: Voltage range not supported "
> @@ -734,8 +764,6 @@ static int mmc_select_powerclass(struct mmc_card
> *card,
>                 return -EINVAL;
>         }
>
> -       pwrclass_val = ext_csd[index];
> -
>         if (bus_width & (EXT_CSD_BUS_WIDTH_8 | EXT_CSD_DDR_BUS_WIDTH_8))
>                 pwrclass_val = (pwrclass_val & EXT_CSD_PWR_CL_8BIT_MASK)
> >>
>                                 EXT_CSD_PWR_CL_8BIT_SHIFT;
> @@ -1131,7 +1159,7 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
>
>                 ext_csd_bits = (bus_width == MMC_BUS_WIDTH_8) ?
>                                 EXT_CSD_BUS_WIDTH_8 : EXT_CSD_BUS_WIDTH_4;
> -               err = mmc_select_powerclass(card, ext_csd_bits, ext_csd);
> +               err = mmc_select_powerclass(card, ext_csd_bits);
>                 if (err)
>                         pr_warning("%s: power class selection to bus width
> %d"
>                                    " failed\n", mmc_hostname(card->host),
> @@ -1164,8 +1192,7 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
>                         bus_width = bus_widths[idx];
>                         if (bus_width == MMC_BUS_WIDTH_1)
>                                 ddr = 0; /* no DDR for 1-bit width */
> -                       err = mmc_select_powerclass(card,
> ext_csd_bits[idx][0],
> -                                                   ext_csd);
> +                       err = mmc_select_powerclass(card,
> ext_csd_bits[idx][0]);
>                         if (err)
>                                 pr_warning("%s: power class selection to "
>                                            "bus width %d failed\n",
> @@ -1195,8 +1222,7 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
>                 }
>
>                 if (!err && ddr) {
> -                       err = mmc_select_powerclass(card,
> ext_csd_bits[idx][1],
> -                                                   ext_csd);
> +                       err = mmc_select_powerclass(card,
> ext_csd_bits[idx][1]);
>                         if (err)
>                                 pr_warning("%s: power class selection to "
>                                            "bus width %d ddr %d failed\n",
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index f31725b..6a98f32 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -94,7 +94,11 @@ struct mmc_ext_csd {
>         u8                      raw_ext_csd_structure;  /* 194 */
>         u8                      raw_card_type;          /* 196 */
>         u8                      out_of_int_time;        /* 198 */
> -       u8                      raw_s_a_timeout;                /* 217 */
> +       u8                      raw_pwr_cl_52_195;      /* 200 */
> +       u8                      raw_pwr_cl_26_195;      /* 201 */
> +       u8                      raw_pwr_cl_52_360;      /* 202 */
> +       u8                      raw_pwr_cl_26_360;      /* 203 */
> +       u8                      raw_s_a_timeout;        /* 217 */
>         u8                      raw_hc_erase_gap_size;  /* 221 */
>         u8                      raw_erase_timeout_mult; /* 223 */
>         u8                      raw_hc_erase_grp_size;  /* 224 */
> @@ -102,6 +106,10 @@ struct mmc_ext_csd {
>         u8                      raw_sec_erase_mult;     /* 230 */
>         u8                      raw_sec_feature_support;/* 231 */
>         u8                      raw_trim_mult;          /* 232 */
> +       u8                      raw_pwr_cl_200_195;     /* 236 */
> +       u8                      raw_pwr_cl_200_360;     /* 237 */
> +       u8                      raw_pwr_cl_ddr_52_195;  /* 238 */
> +       u8                      raw_pwr_cl_ddr_52_360;  /* 239 */
>         u8                      raw_bkops_status;       /* 246 */
>         u8                      raw_sectors[4];         /* 212 - 4 bytes
> */
>
Looks good.

Acked By: Girish K S <girish.shivananjappa@linaro.org>
> --
> 1.8.2.1
>
