From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: sdhci-esdhc-imx: get rid of support_vsel
Date: Mon, 2 Jul 2018 16:36:38 +0200
Message-ID: <CAPDyKFqazWbHfn=poZcbDXddsUVk3=Mz5m6-K-6wC7FD6O1jLw@mail.gmail.com>
References: <20180628081331.13051-1-stefan@agner.ch> <20180628081331.13051-2-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180628081331.13051-2-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>, Russell King <rmk+kernel@armlinux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 28 June 2018 at 10:13, Stefan Agner <stefan@agner.ch> wrote:
> The field support_vsel is currently only used in the device tree
> case. Get rid of it. No change in behavior.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c          | 8 ++------
>  include/linux/platform_data/mmc-esdhc-imx.h | 2 --
>  2 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 6f444731754d..20a420b765b3 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1145,18 +1145,14 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>                              &boarddata->tuning_start_tap);
>
>         if (of_find_property(np, "no-1-8-v", NULL))
> -               boarddata->support_vsel = false;
> -       else
> -               boarddata->support_vsel = true;
> +               host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>
>         if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
>                 boarddata->delay_line = 0;
>
>         mmc_of_parse_voltage(np, &host->ocr_mask);
>
> -       /* sdr50 and sdr104 need work on 1.8v signal voltage */
> -       if ((boarddata->support_vsel) && esdhc_is_usdhc(imx_data) &&
> -           !IS_ERR(imx_data->pins_default)) {
> +       if (esdhc_is_usdhc(imx_data) && !IS_ERR(imx_data->pins_default)) {
>                 imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
>                                                 ESDHC_PINCTRL_STATE_100MHZ);
>                 imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
> diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
> index 7daa78a2f342..640dec8b5b0c 100644
> --- a/include/linux/platform_data/mmc-esdhc-imx.h
> +++ b/include/linux/platform_data/mmc-esdhc-imx.h
> @@ -34,7 +34,6 @@ enum cd_types {
>   * @cd_gpio:   gpio for card_detect interrupt
>   * @wp_type:   type of write_protect method (see wp_types enum above)
>   * @cd_type:   type of card_detect method (see cd_types enum above)
> - * @support_vsel:  indicate it supports 1.8v switching
>   */
>
>  struct esdhc_platform_data {
> @@ -43,7 +42,6 @@ struct esdhc_platform_data {
>         enum wp_types wp_type;
>         enum cd_types cd_type;
>         int max_bus_width;
> -       bool support_vsel;
>         unsigned int delay_line;
>         unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
>         unsigned int tuning_start_tap;  /* The start delay cell point in tuning procedure */
> --
> 2.18.0
>
