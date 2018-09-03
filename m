From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: tegra: Implement periodic pad calibration
Date: Mon, 3 Sep 2018 08:14:21 +0200
Message-ID: <CAPDyKFpVaxttnTZPPZFPn4yvQET_=WcA5TyW2rSbyVEeZOuFVw@mail.gmail.com>
References: <1534757013-4524-1-git-send-email-avienamo@nvidia.com> <1534757013-4524-3-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534757013-4524-3-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-tegra@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 20 August 2018 at 11:23, Aapo Vienamo <avienamo@nvidia.com> wrote:
> Rerun the pad calibration procedure before sdhci_request() if
> the 100 ms recalibration interval has been exceeded.
>
> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 94624ec..ef18a0c 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -30,6 +30,7 @@
>  #include <linux/mmc/mmc.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/ktime.h>
>
>  #include "sdhci-pltfm.h"
>
> @@ -122,6 +123,7 @@ struct sdhci_tegra {
>         struct pinctrl_state *pinctrl_state_1v8;
>
>         struct sdhci_tegra_autocal_offsets autocal_offsets;
> +       ktime_t last_calib;
>
>         u32 default_tap;
>         u32 default_trim;
> @@ -533,6 +535,22 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>                 autocal->pull_down_hs400 = autocal->pull_down_1v8;
>  }
>
> +static void tegra_sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +       ktime_t since_calib = ktime_sub(ktime_get(), tegra_host->last_calib);
> +
> +       /* 100 ms calibration interval is specified in the TRM */
> +       if (ktime_to_ms(since_calib) > 100) {
> +               tegra_sdhci_pad_autocalib(host);
> +               tegra_host->last_calib = ktime_get();
> +       }
> +
> +       sdhci_request(mmc, mrq);
> +}
> +
>  static void tegra_sdhci_parse_tap_and_trim(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1014,6 +1032,10 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
>                                 sdhci_tegra_start_signal_voltage_switch;
>         }
>
> +       /* Hook to periodically rerun pad calibration */
> +       if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
> +               host->mmc_host_ops.request = tegra_sdhci_request;
> +
>         host->mmc_host_ops.hs400_enhanced_strobe =
>                         tegra_sdhci_hs400_enhanced_strobe;
>
> --
> 2.7.4
>
