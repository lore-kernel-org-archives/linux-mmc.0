From: Balaji T K <balajitk@ti.com>
Subject: [RFC PATCH v3 0/8] mmc: omap_hsmmc: pbias dt and cleanup
Date: Thu, 21 Nov 2013 19:50:19 +0530
Message-ID: <1385043627-30439-1-git-send-email-balajitk@ti.com>
References: <20130613174554.GB1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43131 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090Ab3KUOUl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 21 Nov 2013 09:20:41 -0500
In-Reply-To: <20130613174554.GB1403@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, broonie@kernel.org
Cc: tony@atomide.com, Balaji T K <balajitk@ti.com>

Few cleanups to reduce code indent,
Add pbias_regulator support and adapt omap_hsmmc to use pbias regulator
to configure required voltage on mmc1 pad(SD card) i/o rails on OMAP SoCs.

Balaji T K (8):
  mmc: omap_hsmmc: use devm_regulator API
  mmc: omap_hsmmc: handle vcc and vcc_aux independently
  regulator: add pbias regulator support
  mmc: omap_hsmmc: adapt hsmmc to use pbias regulator
  ARM: dts: add pbias dt node
  ARM: dts: add pbias-supply
  ARM: OMAP: enable SYSCON and REGULATOR_PBIAS in omap2plus_defconfig
  mmc: omap_hsmmc: remove pbias workaround

 .../bindings/regulator/pbias-regulator.txt         |   21 ++
 arch/arm/boot/dts/dra7-evm.dts                     |    1 +
 arch/arm/boot/dts/dra7.dtsi                        |   12 +
 arch/arm/boot/dts/omap2430.dtsi                    |   12 +
 arch/arm/boot/dts/omap3-beagle-xm.dts              |    1 +
 arch/arm/boot/dts/omap3-beagle.dts                 |    1 +
 arch/arm/boot/dts/omap3-devkit8000.dts             |    1 +
 arch/arm/boot/dts/omap3-evm-common.dtsi            |    1 +
 arch/arm/boot/dts/omap3-gta04.dts                  |    1 +
 arch/arm/boot/dts/omap3-igep.dtsi                  |    1 +
 arch/arm/boot/dts/omap3-n900.dts                   |    1 +
 arch/arm/boot/dts/omap3-overo.dtsi                 |    1 +
 arch/arm/boot/dts/omap3-zoom3.dts                  |    1 +
 arch/arm/boot/dts/omap3.dtsi                       |   12 +
 arch/arm/boot/dts/omap3430-sdp.dts                 |    1 +
 arch/arm/boot/dts/omap4-panda-common.dtsi          |    1 +
 arch/arm/boot/dts/omap4-sdp.dts                    |    1 +
 arch/arm/boot/dts/omap4-var-som.dts                |    1 +
 arch/arm/boot/dts/omap4.dtsi                       |   12 +
 arch/arm/boot/dts/omap5-uevm.dts                   |    1 +
 arch/arm/boot/dts/omap5.dtsi                       |   12 +
 arch/arm/configs/omap2plus_defconfig               |    2 +
 drivers/mmc/host/omap_hsmmc.c                      |  113 +++++----
 drivers/regulator/Kconfig                          |    7 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/pbias-regulator.c                |  264 ++++++++++++++++++++
 26 files changed, 434 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/pbias-regulator.txt
 create mode 100644 drivers/regulator/pbias-regulator.c

-- 
1.7.5.4

