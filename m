From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: core: Do not set mmc voltage to 1.8V when
 'no-1-8-v' is present
Date: Mon, 15 Jun 2015 14:08:07 +0200
Message-ID: <CAPDyKFq29S3K0sxCkUHO=QO0MqM0PskcjoM62EZysNc19SxP6w@mail.gmail.com>
References: <1434227067-9600-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35400 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbbFOMII (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jun 2015 08:08:08 -0400
Received: by qkhq76 with SMTP id q76so52295198qkh.2
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2015 05:08:08 -0700 (PDT)
In-Reply-To: <1434227067-9600-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Dong Aisheng <aisheng.dong@freescale.com>, kevin.lemoi@savant.com, Otavio Salvador <otavio@ossystems.com.br>, Sascha Hauer <kernel@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

On 13 June 2015 at 22:24, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Since commit 312449efd16bb06 ("mmc: core: Fix sequence for I/O voltage
> in DDR mode for eMMC") the mmc voltage is set to 1.8V inside
> mmc_select_hs_ddr(), even if 'no-1-8-v' property is present.
>
> This causes the following error on a mx6sl board with the 'no-1-8-v'
> property passed in the device tree:
>
> mmc0: power class selection to bus width 8 ddr 4 failed
> mmc0: error -110 whilst initialising MMC card
>
> Fix this problem by only setting the mmc voltage to 1.8V if the
> 'no-1-8-v' property is absent.

What card (eMMC, SD, MMC) and which host driver is being used here?

>
> Reported-by: Kevin Lemoi <kevin.lemoi@savant.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Fix it in the core code instead of doing it inside the sdhci imx code
>
>  drivers/mmc/core/host.c  | 2 ++
>  drivers/mmc/core/mmc.c   | 8 +++++++-
>  include/linux/mmc/host.h | 1 +
>  include/linux/mmc/mmc.h  | 1 +
>  4 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 01fa1ed..736c985 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -527,6 +527,8 @@ int mmc_of_parse(struct mmc_host *host)
>                 host->caps2 |= MMC_CAP2_HS400_1_8V | MMC_CAP2_HS200_1_8V_SDR;
>         if (of_find_property(np, "mmc-hs400-1_2v", &len))
>                 host->caps2 |= MMC_CAP2_HS400_1_2V | MMC_CAP2_HS200_1_2V_SDR;
> +       if (of_find_property(np, "no-1-8-v", &len))
> +               host->caps2 |= MMC_CAP_3_3V_ONLY_DDR;

Do you intend to use 3.3V as the I/O voltage level for an eMMCs
running in DDR mode? Isn't that violation of the eMMC spec?

>
>         host->dsr_req = !of_property_read_u32(np, "dsr", &host->dsr);
>         if (host->dsr_req && (host->dsr & ~0xffff)) {
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index e726903..e76b9af 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -205,6 +205,10 @@ static void mmc_select_card_type(struct mmc_card *card)
>                 avail_type |= EXT_CSD_CARD_TYPE_DDR_1_8V;
>         }
>
> +       if (caps2 & MMC_CAP_3_3V_ONLY_DDR &&
> +           card_type & EXT_CSD_CARD_TYPE_DDR_1_8V)
> +               avail_type |= EXT_CSD_CARD_TYPE_DDR_3_3V_ONLY;
> +
>         if (caps & MMC_CAP_1_2V_DDR &&
>             card_type & EXT_CSD_CARD_TYPE_DDR_1_2V) {
>                 hs_max_dtr = MMC_HIGH_DDR_MAX_DTR;
> @@ -1028,7 +1032,9 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>                 err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
>
>         if (err && (card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_1_8V))
> -               err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
> +               if (!(card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_3_3V_ONLY))
> +                       err = __mmc_set_signal_voltage(host,
> +                                                      MMC_SIGNAL_VOLTAGE_180);
>
>         /* make sure vccq is 3.3v after switching disaster */
>         if (err)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 1369e54..5aa999f 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -289,6 +289,7 @@ struct mmc_host {
>  #define MMC_CAP2_HSX00_1_2V    (MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_HS400_1_2V)
>  #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
>  #define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)    /* No physical write protect pin, assume that card is always read-write */
> +#define MMC_CAP_3_3V_ONLY_DDR  (1 << 19)       /* Only supports 3.3V DDR */
>
>         mmc_pm_flag_t           pm_caps;        /* supported pm features */
>
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 15f2c4a..b3cbd3c 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -380,6 +380,7 @@ struct _mmc_csd {
>  #define EXT_CSD_CARD_TYPE_HS400_1_2V   (1<<7)  /* Card can run at 200MHz DDR, 1.2V */
>  #define EXT_CSD_CARD_TYPE_HS400                (EXT_CSD_CARD_TYPE_HS400_1_8V | \
>                                          EXT_CSD_CARD_TYPE_HS400_1_2V)
> +#define EXT_CSD_CARD_TYPE_DDR_3_3V_ONLY        (1<<8)
>
>  #define EXT_CSD_BUS_WIDTH_1    0       /* Card is in 1 bit mode */
>  #define EXT_CSD_BUS_WIDTH_4    1       /* Card is in 4 bit mode */
> --
> 1.9.1
>

Kind regards
Uffe
