From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: fix HS400 timing issue
Date: Mon, 14 Jan 2019 12:42:56 +0100
Message-ID: <CAPDyKFqMJaBKzhD-HEsDXkP=rJXXQMLns_8=eQFtL9mnfJ+xOw@mail.gmail.com>
References: <20181227112750.446-1-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181227112750.446-1-haibo.chen@nxp.com>
Sender: stable-owner@vger.kernel.org
To: BOUGH CHEN <haibo.chen@nxp.com>
Cc: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 27 Dec 2018 at 12:20, BOUGH CHEN <haibo.chen@nxp.com> wrote:
>
> Now tuning reset will be done when the timing is MMC_TIMING_LEGACY/
> MMC_TIMING_MMC_HS/MMC_TIMING_SD_HS. But for timing MMC_TIMING_MMC_HS,
> we can not do tuning reset, otherwise HS400 timing is not right.
>
> Here is the process of init HS400, first finish tuning in HS200 mode,
> then switch to HS mode and 8 bit DDR mode, finally switch to HS400
> mode. If we do tuning reset in HS mode, this will cause HS400 mode
> lost the tuning setting, which will cause CRC error.
>
> This fix commit d9370424c948 ("mmc: sdhci-esdhc-imx: reset tuning
> circuit when power on mmc card").
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Cc: stable@vger.kernel.org # v4.12+

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index d0d319398a54..984cc1a788cb 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -979,6 +979,7 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>         case MMC_TIMING_UHS_SDR25:
>         case MMC_TIMING_UHS_SDR50:
>         case MMC_TIMING_UHS_SDR104:
> +       case MMC_TIMING_MMC_HS:
>         case MMC_TIMING_MMC_HS200:
>                 writel(m, host->ioaddr + ESDHC_MIX_CTRL);
>                 break;
> --
> 2.17.1
>
