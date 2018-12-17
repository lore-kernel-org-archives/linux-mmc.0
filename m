From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V1] mmc: tegra: Fix for SDMMC pads autocal parsing from dt
Date: Mon, 17 Dec 2018 09:07:28 +0100
Message-ID: <CAPDyKFppX9wxUyBycNLTinP8nNVV9wt5M70XWODVZmeVAvAVHw@mail.gmail.com>
References: <1544732743-11106-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544732743-11106-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 13 Dec 2018 at 21:25, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Some of the SDMMC pads auto calibration values parsed from
> devicetree are assigned incorrectly. This patch fixes it.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Applied for fixes and added a fixes tag, thanks!

Fixes: 51b77c8ea784 ("mmc: tegra: Program pad autocal offsets from dt")

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-tegra.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 7b95d088fdef..e6ace31e2a41 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -510,25 +510,25 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-up-offset-3v3-timeout",
> -                       &autocal->pull_up_3v3);
> +                       &autocal->pull_up_3v3_timeout);
>         if (err)
>                 autocal->pull_up_3v3_timeout = 0;
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-down-offset-3v3-timeout",
> -                       &autocal->pull_down_3v3);
> +                       &autocal->pull_down_3v3_timeout);
>         if (err)
>                 autocal->pull_down_3v3_timeout = 0;
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-up-offset-1v8-timeout",
> -                       &autocal->pull_up_1v8);
> +                       &autocal->pull_up_1v8_timeout);
>         if (err)
>                 autocal->pull_up_1v8_timeout = 0;
>
>         err = device_property_read_u32(host->mmc->parent,
>                         "nvidia,pad-autocal-pull-down-offset-1v8-timeout",
> -                       &autocal->pull_down_1v8);
> +                       &autocal->pull_down_1v8_timeout);
>         if (err)
>                 autocal->pull_down_1v8_timeout = 0;
>
> --
> 2.7.4
>
