From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Fix incorrect switch to HS mode
Date: Tue, 3 Sep 2019 16:51:39 +0200
Message-ID: <CAPDyKFqaNBH3Thwy1O+KXkcsgM2gMrm9zNGYWH8vVP+Y2vSLdA@mail.gmail.com>
References: <20190903115114.33053-1-alcooperx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903115114.33053-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Cooper <alcooperx@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 3 Sep 2019 at 13:51, Al Cooper <alcooperx@gmail.com> wrote:
>
> When switching from any MMC speed mode that requires 1.8v
> (HS200, HS400 and HS400ES) to High Speed (HS) mode, the system
> ends up configured for SDR12 with a 50MHz clock which is an illegal
> mode.
>
> This happens because the SDHCI_CTRL_VDD_180 bit in the
> SDHCI_HOST_CONTROL2 register is left set and when this bit is
> set, the speed mode is controlled by the SDHCI_CTRL_UHS field
> in the SDHCI_HOST_CONTROL2 register. The SDHCI_CTRL_UHS field
> will end up being set to 0 (SDR12) by sdhci_set_uhs_signaling()
> because there is no UHS mode being set.
>
> The fix is to change sdhci_set_uhs_signaling() to set the
> SDHCI_CTRL_UHS field to SDR25 (which is the same as HS) for
> any switch to HS mode.
>
> This was found on a new eMMC controller that does strict checking
> of the speed mode and the corresponding clock rate. It caused the
> switch to HS400 mode to fail because part of the sequence to switch
> to HS400 requires a switch from HS200 to HS before going to HS400.
>
> This fix was suggested by Adrian Hunter
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Should this be applied for fixes and tagged for stable you think?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 61d845fe0b97..068149640ecd 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1858,7 +1858,9 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>                 ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
>         else if (timing == MMC_TIMING_UHS_SDR12)
>                 ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
> -       else if (timing == MMC_TIMING_UHS_SDR25)
> +       else if (timing == MMC_TIMING_SD_HS ||
> +                timing == MMC_TIMING_MMC_HS ||
> +                timing == MMC_TIMING_UHS_SDR25)
>                 ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
>         else if (timing == MMC_TIMING_UHS_SDR50)
>                 ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
> --
> 2.17.1
>
