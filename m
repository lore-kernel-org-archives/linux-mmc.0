From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 0/10] mmc: Add support to Marvell Xenon SD Host Controller
Date: Fri, 04 Nov 2016 12:20:02 +0100
Message-ID: <87h97no5jx.fsf@free-electrons.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
        (Gregory CLEMENT's message of "Mon, 31 Oct 2016 12:09:49 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Jack(SH) Zhu" <jmzhu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ryan Gao <ygao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shiwu Zhang <zhangshw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Xueping Liu <xpliu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hilbert Zhang <zzh>
List-Id: linux-mmc@vger.kernel.org

Hi,
 
 On lun., oct. 31 2016, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Hello,
>
> This the second version of the series adding support for the SDHCI
> Xenon controller. It can be currently found on the Armada 37xx and the
> Armada 7K/8K but will be also used in more Marvell SoC (and not only
> the mvebu ones actually).
>
> Some of the remarks had been taking into account since the first
> version, according to Ziji Hu, here are the following chcanges:
> "Changes in V2:
>   rebase on v4.9-rc2.
>   Re-write Xenon bindings. Ajust Xenon DT property naming.
>   Add a new DT property to indicate eMMC card type, instead of using
>   variable card_candidate.
>   Clear quirks SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 in Xenon platform data
>   Add support to HS400 retuning."
>
> I think the main open point which remains is about issuing commands
> from the ->set_ios() callback (in patch 7).
> Ulf, could you comment about it?

A few comments:

- I forgot to add the v2 prefix on the series I hope it won't be too
  annoying, if needed I can re-post the series with the correct title.

- I also forgot to add my Reviewed-by flag on the 7 first patches, I
  will add them back on the v3.

- For the ones who want to get the series using git here is the place
  you can get it here:

repository: git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:MISL-EBU-System-SW/mainline-public.git
branch: sdhci-xenon-v2

Thanks,

Gregory

>
> Thanks,
>
> Gregory
>
> Gregory CLEMENT (3):
>   arm64: dts: marvell: add eMMC support for Armada 37xx
>   arm64: dts: marvell: add sdhci support for Armada 7K/8K
>   arm64: configs: enable SDHCI driver for Xenon
>
> Ziji Hu (7):
>   mmc: sdhci: Export sdhci_set_ios() from sdhci.c
>   mmc: sdhci: Export sdhci_start_signal_voltage_switch() in sdhci.c
>   mmc: sdhci: Export sdhci_execute_tuning() in sdhci.c
>   MAINTAINERS: add entry for Marvell Xenon MMC Host Controller drivers
>   dt: bindings: Add bindings for Marvell Xenon SD Host Controller
>   mmc: sdhci-xenon: Add Marvell Xenon SDHC core functionality
>   mmc: sdhci-xenon: Add support to PHYs of Marvell Xenon SDHC
>
>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt |  161 +-
>  MAINTAINERS                                                   |    7 +-
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts                |    8 +-
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi                  |   11 +-
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts                |    8 +-
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi                 |    9 +-
>  arch/arm64/configs/defconfig                                  |    1 +-
>  drivers/mmc/host/Kconfig                                      |    9 +-
>  drivers/mmc/host/Makefile                                     |    3 +-
>  drivers/mmc/host/sdhci-xenon-phy.c                            | 1181 +++++++-
>  drivers/mmc/host/sdhci-xenon-phy.h                            |  157 +-
>  drivers/mmc/host/sdhci-xenon.c                                |  598 ++++-
>  drivers/mmc/host/sdhci-xenon.h                                |  159 +-
>  drivers/mmc/host/sdhci.c                                      |   11 +-
>  drivers/mmc/host/sdhci.h                                      |    4 +-
>  15 files changed, 2323 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
>  create mode 100644 drivers/mmc/host/sdhci-xenon-phy.c
>  create mode 100644 drivers/mmc/host/sdhci-xenon-phy.h
>  create mode 100644 drivers/mmc/host/sdhci-xenon.c
>  create mode 100644 drivers/mmc/host/sdhci-xenon.h
>
> base-commit: 9fe68cad6e74967b88d0c6aeca7d9cd6b6e91942
> -- 
> git-series 0.8.10

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
