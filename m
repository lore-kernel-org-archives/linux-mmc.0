From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/5] MMC cleanup of dev_pm_ops and .owner
Date: Mon, 18 Aug 2014 14:38:06 +0200
Message-ID: <CAPDyKFr5ESzjEd3DUO7aMKN9K_Ytuw8GY-fgEyCM4sCGJAX3NQ@mail.gmail.com>
References: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407860069-12706-1-git-send-email-peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, jarkko.lavinen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, balajitk <balajitk-l0cyMroinI0@public.gmane.org>, Barry Song <baohua-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ian Molton <ian.molton-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Patch Tracking <patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 12 August 2014 18:14, Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> This series cleans up a few platform drivers in how they are declaring there
> dev_pm_ops structs, and gets rid of a few now redundant #else conditions.
>
> Also it removes the .owner field of drivers which use module_platform_driver
> api to register themselves, as this field gets overwritten.
>
> Peter Griffin (5):
>   mmc: remove .owner field for drivers using module_platform_driver
>   mmc: dw_mmc-pci: Remove superflous #else condition on CONFIG_PM_SLEEP
>   mmc: dw_mmc-pltfm: Remove superflous #else condition on
>     CONFIG_PM_SLEEP
>   mmc: sdhci-pci: Use SET_RUNTIME_PM_OPS macro to set runtime pm
>     callbacks
>   mmc: sdhci-acpi.c: Use SET_RUNTIME_PM_OPS macro to set runtime pm
>     callbacks

Thanks! Applied for next!

Kind regards
Uffe

>
>  drivers/mmc/host/dw_mmc-pci.c      |  3 ---
>  drivers/mmc/host/dw_mmc-pltfm.c    |  3 ---
>  drivers/mmc/host/jz4740_mmc.c      |  1 -
>  drivers/mmc/host/moxart-mmc.c      |  1 -
>  drivers/mmc/host/mxcmmc.c          |  1 -
>  drivers/mmc/host/mxs-mmc.c         |  1 -
>  drivers/mmc/host/omap.c            |  1 -
>  drivers/mmc/host/omap_hsmmc.c      |  1 -
>  drivers/mmc/host/pxamci.c          |  1 -
>  drivers/mmc/host/rtsx_pci_sdmmc.c  |  1 -
>  drivers/mmc/host/rtsx_usb_sdmmc.c  |  1 -
>  drivers/mmc/host/s3cmci.c          |  1 -
>  drivers/mmc/host/sdhci-acpi.c      | 11 ++---------
>  drivers/mmc/host/sdhci-bcm-kona.c  |  1 -
>  drivers/mmc/host/sdhci-bcm2835.c   |  1 -
>  drivers/mmc/host/sdhci-cns3xxx.c   |  1 -
>  drivers/mmc/host/sdhci-dove.c      |  1 -
>  drivers/mmc/host/sdhci-esdhc-imx.c |  1 -
>  drivers/mmc/host/sdhci-msm.c       |  1 -
>  drivers/mmc/host/sdhci-of-arasan.c |  1 -
>  drivers/mmc/host/sdhci-of-esdhc.c  |  1 -
>  drivers/mmc/host/sdhci-of-hlwd.c   |  1 -
>  drivers/mmc/host/sdhci-pci.c       | 11 ++---------
>  drivers/mmc/host/sdhci-pxav2.c     |  1 -
>  drivers/mmc/host/sdhci-pxav3.c     |  1 -
>  drivers/mmc/host/sdhci-s3c.c       |  1 -
>  drivers/mmc/host/sdhci-sirf.c      |  1 -
>  drivers/mmc/host/sdhci-spear.c     |  1 -
>  drivers/mmc/host/sdhci-tegra.c     |  1 -
>  drivers/mmc/host/sh_mmcif.c        |  1 -
>  drivers/mmc/host/sh_mobile_sdhi.c  |  1 -
>  drivers/mmc/host/sunxi-mmc.c       |  1 -
>  32 files changed, 4 insertions(+), 52 deletions(-)
>
> --
> 1.9.1
>
