From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 00/12]  Add SDHCI Xenon driver
Date: Thu,  9 Jun 2016 09:10:06 +0200
Message-ID: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:46205 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161213AbcFIHL2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2016 03:11:28 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Romain Perier <romain.perier@free-electrons.com>, Omri Itach <omrii@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Shadi Ammouri <shadi@marvell.com>

Hello,

This series adds support for the SDHCI Xenon controller which can be
found on the Armada 37xx and the Armada 7K/8K.

This series currently only enables the support on the Armada 37xx SoCs
and boards. More tests are needed to enable it on the A7K/A8K.

Following the new trend for the MMC subsystem, instead of introducing
new quirks for this controller we extend the mmc/sdhci framework by
adding callbacks when needed.

Thanks,

Gregory

Gregory CLEMENT (7):
  mmc: sdhci_f_sdh30: restrict voltage_switch() callback to the 1.8V
    case
  mmc: tegra: restrict the voltage_switch() callback to the 1.8V case
  mmc: core: export the alive operation
  dt-bindings: mmc: Add Xenon description
  arm64: dts: marvell: add eMMC support for Armada 37xx
  arm64: dts: marvell: add SDIO support for Armada 37xx
  arm64: defconfig: Add Xenon sdhci

Marcin Wojtas (1):
  mmc: sdhci: add init_card callback to sdhci

Victor Gu (4):
  mmc: sdhci: call voltage_switch callback also for the 3.3V case
  mmc: sdhci: add a pre voltage switch callback function
  mmc: sdhci: add delay adjust feature including phy reset
  mmc: sdhci-xenon: add initial Xenon eMMC driver

 .../devicetree/bindings/mmc/sdhci-xenon.txt        |   27 +
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |   12 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   17 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/mmc/core/core.c                            |    7 +
 drivers/mmc/host/Kconfig                           |   10 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/sdhci-tegra.c                     |    4 +
 drivers/mmc/host/sdhci-xenon.c                     | 1164 ++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |   20 +
 drivers/mmc/host/sdhci.h                           |    3 +
 drivers/mmc/host/sdhci_f_sdh30.c                   |    4 +
 include/linux/mmc/card.h                           |    1 +
 13 files changed, 1271 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-xenon.txt
 create mode 100644 drivers/mmc/host/sdhci-xenon.c

-- 
2.5.0

