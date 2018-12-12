From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-omap: Workaround errata regarding
 SDR104/HS200 tuning failures (i929)
Date: Wed, 12 Dec 2018 10:19:51 +0100
Message-ID: <CAPDyKFoi+NzS-d8E8oz-h_ab70jY7owwqPXsEoJWnRg6J2zcNA@mail.gmail.com>
References: <20181211142253.23747-1-faiz_abbas@ti.com> <20181211142253.23747-3-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211142253.23747-3-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kishon <kishon@ti.com>, Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-mmc@vger.kernel.org

+ Thermal maintainers

On Tue, 11 Dec 2018 at 15:20, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Errata i929 in certain OMAP5/DRA7XX/AM57XX silicon revisions
> (SPRZ426D - November 2014 - Revised February 2018 [1]) mentions
> unexpected tuning pattern errors. A small failure band may be present
> in the tuning range which may be missed by the current algorithm.
> Furthermore, the failure bands vary with temperature leading to
> different optimum tuning values for different temperatures.
>
> As suggested in the related Application Report (SPRACA9B - October 2017
> - Revised July 2018 [2]), tuning should be done in two stages.
> In stage 1, assign the optimum ratio in the maximum pass window for the
> current temperature. In stage 2, if the chosen value is close to the
> small failure band, move away from it in the appropriate direction.
>
> References:
> [1] http://www.ti.com/lit/pdf/sprz426
> [2] http://www.ti.com/lit/pdf/SPRACA9
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/Kconfig      |  2 +
>  drivers/mmc/host/sdhci-omap.c | 90 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 91 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 5fa580cec831..d8f984483ab0 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -977,6 +977,8 @@ config MMC_SDHCI_XENON
>  config MMC_SDHCI_OMAP
>         tristate "TI SDHCI Controller Support"
>         depends on MMC_SDHCI_PLTFM && OF
> +       select THERMAL
> +       select TI_SOC_THERMAL
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
>           support present in TI's DRA7 SOCs. The controller supports
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index f588ab679cb0..b75c55011fcb 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -27,6 +27,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/sys_soc.h>
> +#include <linux/thermal.h>
>
>  #include "sdhci-pltfm.h"
>
> @@ -286,15 +287,19 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         struct sdhci_host *host = mmc_priv(mmc);
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>         struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
> +       struct thermal_zone_device *thermal_dev;
>         struct device *dev = omap_host->dev;
>         struct mmc_ios *ios = &mmc->ios;
>         u32 start_window = 0, max_window = 0;
> +       bool single_point_failure = false;
>         bool dcrc_was_enabled = false;
>         u8 cur_match, prev_match = 0;
>         u32 length = 0, max_len = 0;
>         u32 phase_delay = 0;
> +       int temperature;
>         int ret = 0;
>         u32 reg;
> +       int i;
>
>         /* clock tuning is not needed for upto 52MHz */
>         if (ios->clock <= 52000000)
> @@ -304,6 +309,16 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         if (ios->timing == MMC_TIMING_UHS_SDR50 && !(reg & CAPA2_TSDR50))
>                 return 0;
>
> +       thermal_dev = thermal_zone_get_zone_by_name("cpu_thermal");

I couldn't find a corresponding call to a put function, like
"thermal_zone_put()" or whatever, which made me realize that the
thermal zone API is incomplete. Or depending on how you put it, it
lacks object reference counting, unless I am missing something.

For example, what happens if the thermal zone becomes unregistered
between this point and when you call thermal_zone_get_temp() a couple
of line below. I assume it's a known problem, but just wanted to point
it out.

> +       if (IS_ERR(thermal_dev)) {
> +               dev_err(dev, "Unable to get thermal zone for tuning\n");
> +               return PTR_ERR(thermal_dev);
> +       }
> +
> +       ret = thermal_zone_get_temp(thermal_dev, &temperature);
> +       if (ret)
> +               return ret;
> +

[...]

Anyway, I have applied this for next, thanks!

Kind regards
Uffe
