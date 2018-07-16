From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: tegra: prevent HS200 on Tegra 3
Date: Mon, 16 Jul 2018 12:11:14 +0200
Message-ID: <CAPDyKFq=zPvoCHUbeCSCdZAj7BWkuJxe9xRruwhkV1WK8WA61w@mail.gmail.com>
References: <20180712073904.4705-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180712073904.4705-1-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 12 July 2018 at 09:39, Stefan Agner <stefan@agner.ch> wrote:
> The stack assumes that SDHC controller which support SD3.0 (SDR104) do
> support HS200. This is not the case for Tegra 3, which does support SD
> 3.0
> but only supports eMMC spec 4.41.
>
> Use SDHCI_QUIRK2_BROKEN_HS200 to indicate that the controller does not
> support HS200.
>
> Note that commit 156e14b126ff ("mmc: sdhci: fix caps2 for HS200") added
> the tie between SD3.0 (SDR104) and HS200. I don't think that this is
> necessarly true. It is fully legitimate to support SD3.0 and not support
> HS200. The quirk naming suggests something is broken in the controller,
> but this is not the case: The controller simply does not support HS200.
>
> Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Thanks, applied all three patches for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 970d38f68939..137df06b9b6e 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -334,7 +334,8 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
>                   SDHCI_QUIRK_NO_HISPD_BIT |
>                   SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>                   SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                  SDHCI_QUIRK2_BROKEN_HS200,
>         .ops  = &tegra_sdhci_ops,
>  };
>
> --
> 2.18.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
