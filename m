From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 0/10] mmc: Add support to Marvell Xenon SD Host Controller
Date: Mon, 31 Oct 2016 12:09:49 +0100
Message-ID: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from up.free-electrons.com ([163.172.77.33]:50732 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935562AbcJaLKI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Oct 2016 07:10:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Ziji Hu <huziji@marvell.com>, "Jack(SH) Zhu" <jmzhu@marvell.com>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Shiwu Zhang <zhangshw@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>, Xueping Liu <xpliu@marvell.com>, Hilbert Zhang <zzhang@marvell.com>

Hello,

This the second version of the series adding support for the SDHCI
Xenon controller. It can be currently found on the Armada 37xx and the
Armada 7K/8K but will be also used in more Marvell SoC (and not only
the mvebu ones actually).

Some of the remarks had been taking into account since the first
version, according to Ziji Hu, here are the following chcanges:
"Changes in V2:
  rebase on v4.9-rc2.
  Re-write Xenon bindings. Ajust Xenon DT property naming.
  Add a new DT property to indicate eMMC card type, instead of using
  variable card_candidate.
  Clear quirks SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 in Xenon platform data
  Add support to HS400 retuning."

I think the main open point which remains is about issuing commands
from the ->set_ios() callback (in patch 7).
Ulf, could you comment about it?

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

 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt |  161 +-
 MAINTAINERS                                                   |    7 +-
 arch/arm64/boot/dts/marvell/armada-3720-db.dts                |    8 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi                  |   11 +-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts                |    8 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi                 |    9 +-
 arch/arm64/configs/defconfig                                  |    1 +-
 drivers/mmc/host/Kconfig                                      |    9 +-
 drivers/mmc/host/Makefile                                     |    3 +-
 drivers/mmc/host/sdhci-xenon-phy.c                            | 1181 +++++++-
 drivers/mmc/host/sdhci-xenon-phy.h                            |  157 +-
 drivers/mmc/host/sdhci-xenon.c                                |  598 ++++-
 drivers/mmc/host/sdhci-xenon.h                                |  159 +-
 drivers/mmc/host/sdhci.c                                      |   11 +-
 drivers/mmc/host/sdhci.h                                      |    4 +-
 15 files changed, 2323 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.txt
 create mode 100644 drivers/mmc/host/sdhci-xenon-phy.c
 create mode 100644 drivers/mmc/host/sdhci-xenon-phy.h
 create mode 100644 drivers/mmc/host/sdhci-xenon.c
 create mode 100644 drivers/mmc/host/sdhci-xenon.h

base-commit: 9fe68cad6e74967b88d0c6aeca7d9cd6b6e91942
-- 
git-series 0.8.10
