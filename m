From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Disable UHS-I modes for tegra30
Date: Tue, 10 May 2016 08:25:28 +0200
Message-ID: <CAPDyKFpJAdwkWzC0yqdv5mdzBQiMf=8JXYc9r8kCdXCOQsgmXw@mail.gmail.com>
References: <1462806903-13860-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462806903-13860-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 9 May 2016 at 17:15, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> Support for SD cards is not working on the Tegra30 Beaver board and on
> boot the following error message is seen if an SD card is present:
>
>  mmc0: error -110 whilst initialising SD card
>
> In addition to this, Tegra30 is also randomly hanging during system
> suspend when entering and is caused by the Tegra SDHCI driver. Similar
> issues have been seen on the Tegra124 Jetson TK1 and are linked to the
> UHS-I tuning sequence. Disabling the UHS-I modes for Tegra30 fixes SD
> card support and prevents any hangs from occurring when entering system
> suspend. Therefore, disable the UHS-I modes for Tegra30 for now until
> we can correct the tuning sequence for Tegra.
>
> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Perhaps we should add a fixes/stable tag as well?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index bcc0de47fe7e..24c33aee8e7c 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -347,10 +347,6 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
>
>  static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
>         .pdata = &sdhci_tegra30_pdata,
> -       .nvquirks = NVQUIRK_ENABLE_SDHCI_SPEC_300 |
> -                   NVQUIRK_ENABLE_SDR50 |
> -                   NVQUIRK_ENABLE_SDR104 |
> -                   NVQUIRK_HAS_PADCALIB,
>  };
>
>  static const struct sdhci_ops tegra114_sdhci_ops = {
> --
> 2.1.4
>
