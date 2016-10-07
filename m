From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 0/10] mmc: Add support to Marvell Xenon SD Host Controller
Date: Fri,  7 Oct 2016 17:22:46 +0200
Message-ID: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Jack(SH) Zhu" <jmzhu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ryan Gao <ygao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shiwu Zhang <zhangshw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Xueping Liu <xpliu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Hilbert Zhang <zzhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hello,

This series adds support for the SDHCI Xenon controller which can be
currently found on the Armada 37xx and the Armada 7K/8K but will be
also used in more Marvell SoC (and not only the mvebu ones actually).

A few months ago a series has been sent to support this controller:
http://lists.infradead.org/pipermail/linux-arm-kernel/2016-June/434925.html

However, since this first version, the engineer team in charge of this
controller wished to have a better involvement in the mainline support
of the driver. This new series is the result the Marvell development
with the aim of supporting more feature that only the ones needed for
the Armada 3720 SoC.

About the hardware and the driver itself, according to Ziji Hu:
"Marvell Xenon SDHC is widely used in Marvell products.
It supports SD/SDIO/eMMC.
It conforms to SD Physical Layer Specification Version 3.01 and
is designed according to the guidelines provided in the SD Host
Controller Standard Specification Version 3.00.
Xenon SDHC IP contains PHY. There are tree types of Xenon PHY in use.
Each Xenon SDHC only contain one type of PHY."

Thanks,

Gregory

Gregory CLEMENT (3):
  arm64: dts: marvell: add eMMC support for Armada 37xx
  arm64: dts: marvell: add sdhci support for Armada 7K/8K
  arm64: configs: enable SDHCI driver for Xenon

Ziji Hu (7):
  mmc: sdhci: Export sdhci_set_ios() from sdhci.c
  mmc: sdhci: Export sdhci_start_signal_voltage_switch() in sdhci.c
  mmc: sdhci: Export sdhci_execute_tuning() in sdhci.c
  MAINTAINERS: add entry for Marvell Xenon MMC Host Controller drivers
  dt: bindings: Add bindings for Marvell Xenon SD Host Controller
  mmc: sdhci-xenon: Add Marvell Xenon SDHC core functionality
  mmc: sdhci-xenon: Add support to PHYs of Marvell Xenon SDHC

 Documentation/devicetree/bindings/mmc/marvell,sdhci-xenon.txt |  164 +-
 MAINTAINERS                                                   |    8 +-
 arch/arm64/boot/dts/marvell/armada-3720-db.dts                |    7 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi                  |   11 +-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts                |    7 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi                 |    9 +-
 arch/arm64/configs/defconfig                                  |    1 +-
 drivers/mmc/host/Kconfig                                      |    9 +-
 drivers/mmc/host/Makefile                                     |    3 +-
 drivers/mmc/host/sdhci-xenon-phy.c                            | 1141 +++++++-
 drivers/mmc/host/sdhci-xenon-phy.h                            |  157 +-
 drivers/mmc/host/sdhci-xenon.c                                |  603 ++++-
 drivers/mmc/host/sdhci-xenon.h                                |  151 +-
 drivers/mmc/host/sdhci.c                                      |   11 +-
 drivers/mmc/host/sdhci.h                                      |    4 +-
 15 files changed, 2282 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,sdhci-xenon.txt
 create mode 100644 drivers/mmc/host/sdhci-xenon-phy.c
 create mode 100644 drivers/mmc/host/sdhci-xenon-phy.h
 create mode 100644 drivers/mmc/host/sdhci-xenon.c
 create mode 100644 drivers/mmc/host/sdhci-xenon.h

base-commit: 32b7d4a95f79deb8b73e8b303a54dfdef4a3d845
-- 
git-series 0.8.10
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
