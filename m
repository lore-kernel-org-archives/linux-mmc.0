From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-esdhc-imx: disable clocks before
 changing frequency
Date: Mon, 16 Jul 2018 12:11:20 +0200
Message-ID: <CAPDyKFrwn--7=jRzSrQ2ZDgn1NL8C2ckYgtneH45b8ejNn-e0w@mail.gmail.com>
References: <20180712080650.13878-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180712080650.13878-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 12 July 2018 at 10:06, Stefan Agner <stefan@agner.ch> wrote:
> In the uSDHC case (e.g. i.MX 6) clocks only get disabled if frequency
> is set to 0. However, it could be that the stack asks for a frequency
> change while clocks are on. In that case the function clears the
> divider registers (by clearing ESDHC_CLOCK_MASK) while the clock is
> enabled! This causes a short period of time where the clock is
> undivided (on a i.MX 6DL a clock of 196MHz has been measured).
>
> For older IP variants the driver disables clock by clearing some bits
> in ESDHC_SYSTEM_CONTROL.
>
> Make sure to disable card clock before changing frequency for uSDHC
> IP variants too.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 85fd5a8b0b6d..acacd8481473 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -708,14 +708,14 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>         int div = 1;
>         u32 temp, val;
>
> +       if (esdhc_is_usdhc(imx_data)) {
> +               val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> +               writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> +                       host->ioaddr + ESDHC_VENDOR_SPEC);
> +       }
> +
>         if (clock == 0) {
>                 host->mmc->actual_clock = 0;
> -
> -               if (esdhc_is_usdhc(imx_data)) {
> -                       val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
> -                       writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> -                                       host->ioaddr + ESDHC_VENDOR_SPEC);
> -               }
>                 return;
>         }
>
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
