From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: Fix Kconfig warnings on keystone_defconfig
Date: Mon, 14 Jan 2019 12:44:53 +0100
Message-ID: <CAPDyKFr9e2MvhU2HTAEaKydfQ5=0hB-Qmcw5FUw=T7z0XDYKFA@mail.gmail.com>
References: <20190109124312.10154-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109124312.10154-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Keerthy <j-keerthy@ti.com>, Eduardo Valentin <edubezval@gmail.com>, Olof Johansson <olof@lixom.net>
List-Id: linux-mmc@vger.kernel.org

On Wed, 9 Jan 2019 at 13:40, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> Commit 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding
> SDR104/HS200 tuning failures (i929)") added a select on TI_SOC_THERMAL
> for the driver to get temperature for tuning.
>
> However, this causes the following warning on keystone_defconfig because
> keystone does not support TI_SOC_THERMAL:
>
> "WARNING: unmet direct dependencies detected for TI_SOC_THERMAL"
>
> Fix this by changing the select to imply.
>
> Fixes: 961de0a856e3 ("mmc: sdhci-omap: Workaround errata regarding
> SDR104/HS200 tuning failures (i929)")
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index e26b8145efb3..bc61eefcb695 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -978,7 +978,7 @@ config MMC_SDHCI_OMAP
>         tristate "TI SDHCI Controller Support"
>         depends on MMC_SDHCI_PLTFM && OF
>         select THERMAL
> -       select TI_SOC_THERMAL
> +       imply TI_SOC_THERMAL
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
>           support present in TI's DRA7 SOCs. The controller supports
> --
> 2.19.2
>
