From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 00/16] mmc: sdhci-omap: Add UHS/HS200 mode support
Date: Wed, 14 Feb 2018 11:38:13 +0100
Message-ID: <CAPDyKFrh5-p4hDtG5eSbU4rX4+q4ZMsW1APOKSZh=wAASmoQKg@mail.gmail.com>
References: <20180205125029.21570-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180205125029.21570-1-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 5 February 2018 at 13:50, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:
> Add UHS/HS200 mode support in sdhci-omap. The programming sequence
> for voltage switching, tuning is followed from AM572x TRM
> http://www.ti.com/lit/ug/spruhz6i/spruhz6i.pdf
> (Similar to all AM57x/DRA7x SoCs). The patch series also implements
> workaround for errata published in
> http://www.ti.com/lit/er/sprz429k/sprz429k.pdf.
>
> It also includes a pdata-quirk patch since both pdata-quirks and
> sdhci-omap uses struct sdhci_omap_platform_data.
>
> The dt patches enabling UHS/HS200 will follow this series.
>
> Changes from v1:
> *) Only poll on DAT0 and DATI for card_busy status
> *) Cleanup iodelay patch as suggested by Tony.
> *) Added quirk to disable HW timeout
> *) Use the existing data timer but program a relatively accurate
>    SW timeout value (Impacts all platforms)
> *) Fix a bug in sdhci which was using data_timer for non data line
>    commands
>
> I've tested on dra72-evm, dra7xx-evm, dra71-evm, am572x-idk, am571x-idk
> dra76-evm, am57xx-evm and k2g-evm.
>
> I've also pushed the series (along with dt) to
> https://github.com/kishon/linux-wip.git sdhci_uhs_v2
>
> Kishon Vijay Abraham I (16):
>   mmc: sdhci-omap: Update 'power_mode' outside sdhci_omap_init_74_clocks
>   mmc: sdhci-omap: Add card_busy host ops
>   mmc: sdhci-omap: Add custom set_uhs_signaling sdhci_host ops
>   mmc: sdhci-omap: Add tuning support
>   mmc: sdhci-omap: Workaround for Errata i802
>   mmc: sdhci_omap: Add support to set IODELAY values
>   mmc: sdhci_omap: Fix sdhci-omap quirks
>   mmc: sdhci-omap: Add support to override f_max and iodelay from pdata
>   mmc: sdhci: Add quirk to disable HW timeout
>   mmc: sdhci: Fix to use data_timer only for data line commands
>   mmc: sdhci: Program a relatively accurate SW timeout value
>   mmc: sdhci-omap: Workaround for Errata i834
>   dt-bindings: sdhci-omap: Add K2G specific binding
>   mmc: sdhci-omap: Add support for MMC/SD controller in k2g SoC
>   mmc: sdhci-omap: Add SPDX identifier
>   ARM: OMAP2+: Use sdhci-omap specific pdata-quirks for MMC/SD on DRA74x
>     EVM
>
>  .../devicetree/bindings/mmc/sdhci-omap.txt         |   2 +
>  arch/arm/mach-omap2/pdata-quirks.c                 |  34 +-
>  drivers/mmc/host/sdhci-omap.c                      | 430 +++++++++++++++++++--
>  drivers/mmc/host/sdhci.c                           |  62 ++-
>  drivers/mmc/host/sdhci.h                           |  17 +
>  include/linux/platform_data/sdhci-omap.h           |  22 ++
>  6 files changed, 518 insertions(+), 49 deletions(-)
>  create mode 100644 include/linux/platform_data/sdhci-omap.h
>
> --
> 2.11.0
>

To move forward and while waiting for Adrian to come back, I have
applied patch 1 -> 7 for next.

Thanks and kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
