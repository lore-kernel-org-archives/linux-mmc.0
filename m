From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 3/6] ARM: dts: am335x-boneblack: mark eMMC as non removable
Date: Wed, 16 Oct 2013 20:48:24 +0530
Message-ID: <1381936707-10336-4-git-send-email-balajitk@ti.com>
References: <1381936707-10336-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42844 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759668Ab3JPPTU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Oct 2013 11:19:20 -0400
In-Reply-To: <1381936707-10336-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, uri.y@variscite.com, Sekhar Nori <nsekhar@ti.com>, Balaji T K <balajitk@ti.com>

From: Sekhar Nori <nsekhar@ti.com>

Mark the eMMC module on BeagleBone black as non removable.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/am335x-boneblack.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 6b71ad9..2e189cd 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -25,6 +25,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_pins>;
 	bus-width = <8>;
+	non-removable;
 	status = "okay";
 	ti,vcc-aux-disable-is-sleep;
 };
-- 
1.7.5.4

