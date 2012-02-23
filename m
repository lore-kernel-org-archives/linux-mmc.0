From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 0/4] omap hsmmc device tree support
Date: Thu, 23 Feb 2012 17:31:26 +0530
Message-ID: <1329998490-27555-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43699 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642Ab2BWMBw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Feb 2012 07:01:52 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, svenkatr@ti.com, linaro-dev@lists.linaro.org, Rajendra Nayak <rnayak@ti.com>

This series adds device tree support for OMAP hsmmc
driver. The series is dependent on a couple other series,
to add TWL regulator DT support[1] and another to clean
the pdev->id usage within the hsmmc driver[2]

all patches including the dependent series can be
found here
git://gitorious.org/omap-pm/linux.git for-dt/regulator

The series is tested on omap4sdp (both external and emmc),
omap4panda amd omap3beagle boards.

Things to do:
-1- Card detect isn't functional and needs twl4030 gpio
to be DT converted.
-2- pbias cell programming is missing and needs an OMAP
control module driver.

[1] http://marc.info/?l=linux-omap&m=132999699905180&w=2
[2] http://marc.info/?l=linux-omap&m=132999646604985&w=2

Rajendra Nayak (4):
  mmc: omap_hsmmc: Convert hsmmc driver to use device tree
  mmc: omap_hsmmc: Avoid a regulator voltage change with dt
  arm/dts: OMAP4: Add mmc controller nodes and board data
  arm/dts: OMAP3: Add mmc controller nodes and board data

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   31 +++++++
 arch/arm/boot/dts/omap3-beagle.dts                 |    6 ++
 arch/arm/boot/dts/omap3.dtsi                       |   26 ++++++
 arch/arm/boot/dts/omap4-panda.dts                  |   10 +++
 arch/arm/boot/dts/omap4-sdp.dts                    |   16 ++++
 arch/arm/boot/dts/omap4.dtsi                       |   31 +++++++
 drivers/mmc/host/omap_hsmmc.c                      |   83 +++++++++++++++++++-
 7 files changed, 202 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt

