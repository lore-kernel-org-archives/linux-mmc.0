From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v12 3/9] mmc: cavium: Add MMC platform driver for Octeon SOCs
Date: Fri, 17 Mar 2017 14:35:34 +0100
Message-ID: <CAPDyKFqTf7qGMb5b-ZEdYJUrF-kr-kzLO-mR_N5Xx06eohgtCQ@mail.gmail.com>
References: <20170310132507.32025-1-jglauber@cavium.com> <20170310132507.32025-4-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:34759 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdCQNfg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Mar 2017 09:35:36 -0400
Received: by mail-ua0-f180.google.com with SMTP id f54so44038059uaa.1
        for <linux-mmc@vger.kernel.org>; Fri, 17 Mar 2017 06:35:35 -0700 (PDT)
In-Reply-To: <20170310132507.32025-4-jglauber@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>

On 10 March 2017 at 14:25, Jan Glauber <jglauber@cavium.com> wrote:
> Add a platform driver for Octeon MIPS SOCs.
>
> Signed-off-by: Jan Glauber <jglauber@cavium.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> ---
>  drivers/mmc/host/Kconfig               |  10 ++
>  drivers/mmc/host/Makefile              |   2 +
>  drivers/mmc/host/cavium-pltfm-octeon.c | 183 +++++++++++++++++++++++++++++++++
>  3 files changed, 195 insertions(+)
>  create mode 100644 drivers/mmc/host/cavium-pltfm-octeon.c

Please rename the file to cavium-octeon.c

>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index f08691a..68cc811 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -622,6 +622,16 @@ config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
>         help
>           If you say yes here SD-Cards may work on the EZkit.
>
> +config MMC_CAVIUM_OCTEON
> +       tristate "Cavium OCTEON SD/MMC Card Interface support"
> +       depends on CAVIUM_OCTEON_SOC
> +       help
> +         This selects Cavium OCTEON SD/MMC card Interface.
> +         If you have an OCTEON board with a Multimedia Card slot,
> +         say Y or M here.
> +
> +         If unsure, say N.
> +

Adding more new cavium variants becomes a bit messy in this approach.
May I suggest something similar we are using for SDHCI mmc driver.
That is:

For the core mmc cavium driver:
config MMC_CAVIUM (to build cavium-mmc.o)
I would also appreciate to rename that file to cavium.c
This also means you need to export the functions you provide from the
header cavium-mmc.h (rename to cavium.h)

For the octeon variant:
config MMC_CAVIUM_OCTEON (to build cavium-octeon.o)
depends on MMC_CAVIUM && CAVIUM_OCTEON_SOC

>  config MMC_DW
>         tristate "Synopsys DesignWare Memory Card Interface"
>         depends on HAS_DMA
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 6d548c4..c7f0ccf 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -42,6 +42,8 @@ obj-$(CONFIG_MMC_SDHI)                += sh_mobile_sdhi.o
>  obj-$(CONFIG_MMC_CB710)                += cb710-mmc.o
>  obj-$(CONFIG_MMC_VIA_SDMMC)    += via-sdmmc.o
>  obj-$(CONFIG_SDH_BFIN)         += bfin_sdh.o
> +octeon-mmc-objs := cavium-mmc.o cavium-pltfm-octeon.o
> +obj-$(CONFIG_MMC_CAVIUM_OCTEON) += octeon-mmc.o

By changing according to above, we get two build objects instead of
two. Nice an clean.

>  obj-$(CONFIG_MMC_DW)           += dw_mmc.o
>  obj-$(CONFIG_MMC_DW_PLTFM)     += dw_mmc-pltfm.o
>  obj-$(CONFIG_MMC_DW_EXYNOS)    += dw_mmc-exynos.o
> diff --git a/drivers/mmc/host/cavium-pltfm-octeon.c b/drivers/mmc/host/cavium-pltfm-octeon.c
> new file mode 100644
> index 0000000..e83d143

[...]

Changing the name of the files, may also lead to that you perhaps want
to change the prefix of the functions.

Otherwise this looks good to me.

Kind regards
Uffe
