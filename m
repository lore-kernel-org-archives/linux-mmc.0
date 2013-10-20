From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 3/6] ARM: dts: am335x-boneblack: mark eMMC as non removable
Date: Mon, 21 Oct 2013 00:19:56 +0530
Message-ID: <1382294999-18790-4-git-send-email-balajitk@ti.com>
References: <1381936707-10336-1-git-send-email-balajitk@ti.com>
 <1382294999-18790-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48745 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547Ab3JTSub (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 20 Oct 2013 14:50:31 -0400
In-Reply-To: <1382294999-18790-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, uri.y@variscite.com, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Balaji T K <balajitk@ti.com>

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

