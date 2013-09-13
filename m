From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 0/3] mmc: omap_hsmmc: get rid of ti,non-removable
Date: Fri, 13 Sep 2013 15:39:43 +0530
Message-ID: <cover.1379066249.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56384 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755311Ab3IMKKQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 13 Sep 2013 06:10:16 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Benoit Cousson <bcousson@baylibre.com>
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Device Tree Mailing List <devicetree@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>, Linux MMC Mailing List <linux-mmc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>

Get rid of TI specific binding ti,non-removable in favour of the
generic binding present for the same purpose.

This patch set does not support the old binding anymore. So, yes,
it does introduce an ABI breakage. IMHO, it is not really worth
supporting both bindings ATM since DT-usage in OMAP is still very
nascent and almost always DTB and uImage are upgraded together.

The series applies to Koen's series titled "ARM: dts: Beaglebone MMC fixes"

The patch set is tested on Bone Black, but I could not get the eMMC
to detect on my board with or without this patch set. The removable
MMC/SD works though.

Sekhar Nori (3):
  mmc: omap_hsmmc: remove TI specific DT binding for non removable
    cards
  ARM: OMAP2+: DT: start using generic binding for non-removable mmc
    cards
  ARM: OMAP2+: BBB DT: mark eMMC as non removable

 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt |    5 ++---
 arch/arm/boot/dts/am335x-boneblack.dts                  |    1 +
 arch/arm/boot/dts/omap4-panda-common.dtsi               |    2 +-
 arch/arm/boot/dts/omap4-sdp.dts                         |    4 ++--
 arch/arm/boot/dts/omap4-var-som.dts                     |    2 +-
 arch/arm/boot/dts/omap5-uevm.dts                        |    4 ++--
 drivers/mmc/host/omap_hsmmc.c                           |    2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

-- 
1.7.10.1

