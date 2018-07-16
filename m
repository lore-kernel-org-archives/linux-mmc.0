From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-esdhc-imx: fix indent
Date: Mon, 16 Jul 2018 12:11:24 +0200
Message-ID: <CAPDyKFqyQ_6NQmaw2rTGEO6eR5GfFAf2aTqsJZVbU5MW49WN0w@mail.gmail.com>
References: <20180712080725.14250-1-stefan@agner.ch> <20180712080725.14250-2-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180712080725.14250-2-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Fabio Estevam <fabio.estevam@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 12 July 2018 at 10:07, Stefan Agner <stefan@agner.ch> wrote:
> Fix indent. This also makes disable/enable clock blocks look
> alike.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index acacd8481473..aa48f4b2541a 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -761,7 +761,7 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
>         if (esdhc_is_usdhc(imx_data)) {
>                 val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
>                 writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
> -               host->ioaddr + ESDHC_VENDOR_SPEC);
> +                       host->ioaddr + ESDHC_VENDOR_SPEC);
>         }
>
>         mdelay(1);
> --
> 2.18.0
>
