From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 2/6] ARM: dts: OMAP4/5: start using generic binding for non-removable mmc cards
Date: Wed, 16 Oct 2013 20:48:23 +0530
Message-ID: <1381936707-10336-3-git-send-email-balajitk@ti.com>
References: <1381936707-10336-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59672 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759319Ab3JPPTR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Oct 2013 11:19:17 -0400
In-Reply-To: <1381936707-10336-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, uri.y@variscite.com, Sekhar Nori <nsekhar@ti.com>, Balaji T K <balajitk@ti.com>

From: Sekhar Nori <nsekhar@ti.com>

start using generic non-removable dt binding

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/omap4-var-som.dts |    2 +-
 arch/arm/boot/dts/omap5-uevm.dts    |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-var-som.dts b/arch/arm/boot/dts/omap4-var-som.dts
index b41269e..b25b9ad 100644
--- a/arch/arm/boot/dts/omap4-var-som.dts
+++ b/arch/arm/boot/dts/omap4-var-som.dts
@@ -76,7 +76,7 @@
 &mmc1 {
 	vmmc-supply = <&vmmc>;
 	ti,bus-width = <8>;
-	ti,non-removable;
+	non-removable;
 };
 
 &mmc2 {
diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index d784b3a..55aecf5 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -220,12 +220,12 @@
 &mmc2 {
 	vmmc-supply = <&vmmcsd_fixed>;
 	bus-width = <8>;
-	ti,non-removable;
+	non-removable;
 };
 
 &mmc3 {
 	bus-width = <4>;
-	ti,non-removable;
+	non-removable;
 };
 
 &mmc4 {
-- 
1.7.5.4

