From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v7 0/7] mmc: omap_hsmmc: pbias dt and cleanup
Date: Fri, 20 Dec 2013 23:05:48 +0530
Message-ID: <1387560955-6547-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45815 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756625Ab3LTRgG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 Dec 2013 12:36:06 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org, tony@atomide.com
Cc: Balaji T K <balajitk@ti.com>

Balaji T K (7):
  mmc: omap_hsmmc: use devm_regulator API
  mmc: omap_hsmmc: handle vcc and vcc_aux independently
  regulator: add pbias regulator support
  mmc: omap_hsmmc: adapt hsmmc to use pbias regulator
  ARM: dts: add pbias dt node
  ARM: OMAP: enable SYSCON and REGULATOR_PBIAS in omap2plus_defconfig
  mmc: omap_hsmmc: remove pbias workaround

 .../bindings/regulator/pbias-regulator.txt         |   16 ++
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
 11 files changed, 443 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/pbias-regulator.txt
 create mode 100644 drivers/regulator/pbias-regulator.c

-- 
1.7.5.4

