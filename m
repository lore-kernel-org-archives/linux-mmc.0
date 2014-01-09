From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v8 0/7] mmc: omap_hsmmc: pbias dt and cleanup
Date: Thu, 9 Jan 2014 20:20:55 +0530
Message-ID: <1389279062-32291-1-git-send-email-balajitk@ti.com>
References: <1387560955-6547-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49150 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751367AbaAIOvY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jan 2014 09:51:24 -0500
In-Reply-To: <1387560955-6547-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, chris@printf.net, broonie@kernel.org, tony@atomide.com
Cc: mark.rutland@arm.com, Balaji T K <balajitk@ti.com>

Few cleanups to reduce code indent,
Add pbias_regulator support and adapt omap_hsmmc to use pbias regulator
to configure required voltage on mmc1 pad(SD card) i/o rails on OMAP SoCs.

Balaji T K (7):
  mmc: omap_hsmmc: use devm_regulator API
  mmc: omap_hsmmc: handle vcc and vcc_aux independently
  regulator: add pbias regulator support
  mmc: omap_hsmmc: adapt hsmmc to use pbias regulator
  ARM: dts: add pbias dt node
  ARM: OMAP: enable SYSCON and REGULATOR_PBIAS in omap2plus_defconfig
  mmc: omap_hsmmc: remove pbias workaround

 .../bindings/regulator/pbias-regulator.txt         |   27 ++
 arch/arm/boot/dts/dra7.dtsi                        |   18 ++
 arch/arm/boot/dts/omap2430.dtsi                    |   18 ++
 arch/arm/boot/dts/omap3.dtsi                       |   18 ++
 arch/arm/boot/dts/omap4.dtsi                       |   18 ++
 arch/arm/boot/dts/omap5.dtsi                       |   18 ++
 arch/arm/configs/omap2plus_defconfig               |    2 +
 drivers/mmc/host/omap_hsmmc.c                      |  113 +++++----
 drivers/regulator/Kconfig                          |    9 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/pbias-regulator.c                |  261 ++++++++++++++++++++
 11 files changed, 454 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/pbias-regulator.txt
 create mode 100644 drivers/regulator/pbias-regulator.c

-- 
1.7.5.4

