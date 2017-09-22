From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Mark 64 bit dma broken on Tegra186
Date: Fri, 22 Sep 2017 11:45:18 +0200
Message-ID: <CAPDyKFrGMcU5Q=Y8CPinZfqan1NVP4Be-d96FAdV9nEL=N6ohg@mail.gmail.com>
References: <1504900113-8983-1-git-send-email-vdumpa@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1504900113-8983-1-git-send-email-vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krishna Reddy <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 8 September 2017 at 21:48, Krishna Reddy <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> SDHCI controllers on Tegra186 support 40 bit addressing.
> IOVA addresses are 48-bit wide on Tegra186.
> SDHCI host common code sets dma mask as either 32-bit or 64-bit.
> To avoid access issues when SMMU is enabled, disable 64-bit dma.
>
> Signed-off-by: Krishna Reddy <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 0cd6fa80db66..b877c13184c2 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -422,7 +422,15 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
>                   SDHCI_QUIRK_NO_HISPD_BIT |
>                   SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>                   SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                  /* SDHCI controllers on Tegra186 support 40-bit addressing.
> +                   * IOVA addresses are 48-bit wide on Tegra186.
> +                   * With 64-bit dma mask used for SDHCI, accesses can
> +                   * be broken. Disable 64-bit dma, which would fall back
> +                   * to 32-bit dma mask. Ideally 40-bit dma mask would work,
> +                   * But it is not supported as of now.
> +                   */
> +                  SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
>         .ops  = &tegra114_sdhci_ops,
>  };
>
> --
> 2.1.4
>
