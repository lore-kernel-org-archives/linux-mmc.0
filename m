From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 2/6] ARM: dts: OMAP4/5: start using generic binding for non-removable mmc cards
Date: Mon, 21 Oct 2013 00:19:55 +0530
Message-ID: <1382294999-18790-3-git-send-email-balajitk@ti.com>
References: <1381936707-10336-1-git-send-email-balajitk@ti.com>
 <1382294999-18790-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1382294999-18790-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, uri.y@variscite.com, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

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
index e06a04a..eb9d913 100644
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

