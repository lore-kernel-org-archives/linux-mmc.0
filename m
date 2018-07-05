From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: allow 1.8V modes without
 100/200MHz pinctrl states
Date: Thu, 5 Jul 2018 15:10:02 +0200
Message-ID: <CAPDyKFou773HgPzE29Ynr2MVFcaOhb=+uXBrjL+1H8iWx4jdQw@mail.gmail.com>
References: <20180704150745.21003-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180704150745.21003-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>, Russell King <rmk+kernel@armlinux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 4 July 2018 at 17:07, Stefan Agner <stefan@agner.ch> wrote:
> If pinctrl nodes for 100/200MHz are missing, the controller should
> not select any mode which need signal frequencies 100MHz or higher.
> To prevent such speed modes the driver currently uses the quirk flag
> SDHCI_QUIRK2_NO_1_8_V. This works nicely for SD cards since 1.8V
> signaling is required for all faster modes and slower modes use 3.3V
> signaling only.
>
> However, there are eMMC modes which use 1.8V signaling and run below
> 100MHz, e.g. DDR52 at 1.8V. With using SDHCI_QUIRK2_NO_1_8_V this
> mode is prevented. When using a fixed 1.8V regulator as vqmmc-supply
> the stack has no valid mode to use. In this tenuous situation the
> kernel continuously prints voltage switching errors:
>   mmc1: Switching to 3.3V signalling voltage failed
>
> Avoid using SDHCI_QUIRK2_NO_1_8_V and prevent faster modes by
> altering the SDHCI capability register. With that the stack is able
> to select 1.8V modes even if no faster pinctrl states are available:
>   # cat /sys/kernel/debug/mmc1/ios
>   ...
>   timing spec:    8 (mmc DDR52)
>   signal voltage: 1 (1.80 V)
>   ...
>
> Link: http://lkml.kernel.org/r/20180628081331.13051-1-stefan@agner.ch
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Thanks, applied for next! Let's see if this turns out okay, then let's
make it a fix and add a stable tag.

BTW, would you mind looking up the commit it fixes? Or if there is a
certain stable release we should target.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 20a420b765b3..e96d969ab2c3 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -312,6 +312,15 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
>
>                         if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
>                                 val |= SDHCI_SUPPORT_HS400;
> +
> +                       /*
> +                        * Do not advertise faster UHS modes if there are no
> +                        * pinctrl states for 100MHz/200MHz.
> +                        */
> +                       if (IS_ERR_OR_NULL(imx_data->pins_100mhz) ||
> +                           IS_ERR_OR_NULL(imx_data->pins_200mhz))
> +                               val &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50
> +                                        | SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_HS400);
>                 }
>         }
>
> @@ -1157,18 +1166,6 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>                                                 ESDHC_PINCTRL_STATE_100MHZ);
>                 imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
>                                                 ESDHC_PINCTRL_STATE_200MHZ);
> -               if (IS_ERR(imx_data->pins_100mhz) ||
> -                               IS_ERR(imx_data->pins_200mhz)) {
> -                       dev_warn(mmc_dev(host->mmc),
> -                               "could not get ultra high speed state, work on normal mode\n");
> -                       /*
> -                        * fall back to not supporting uhs by specifying no
> -                        * 1.8v quirk
> -                        */
> -                       host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> -               }
> -       } else {
> -               host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>         }
>
>         /* call to generic mmc_of_parse to support additional capabilities */
> --
> 2.18.0
>
