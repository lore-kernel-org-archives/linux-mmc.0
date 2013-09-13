From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/3] ARM: OMAP2+: DT: start using generic binding for non-removable mmc cards
Date: Fri, 13 Sep 2013 15:39:45 +0530
Message-ID: <d00c20b1ffe0c393e606e834cac6a31a68f6794d.1379066249.git.nsekhar@ti.com>
References: <cover.1379066249.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1379066249.git.nsekhar-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Linux MMC Mailing List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The TI specific binding for non-removable cards is now gone.
The driver supports the generic binding, start using it.

Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4-panda-common.dtsi |    2 +-
 arch/arm/boot/dts/omap4-sdp.dts           |    4 ++--
 arch/arm/boot/dts/omap4-var-som.dts       |    2 +-
 arch/arm/boot/dts/omap5-uevm.dts          |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index faa95b5..8dcefc0 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -314,7 +314,7 @@
 };
 
 &mmc5 {
-	ti,non-removable;
+	non-removable;
 	bus-width = <4>;
 };
 
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 7951b4e..ecce3f5 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -408,7 +408,7 @@
 &mmc2 {
 	vmmc-supply = <&vaux1>;
 	bus-width = <8>;
-	ti,non-removable;
+	non-removable;
 };
 
 &mmc3 {
@@ -421,7 +421,7 @@
 
 &mmc5 {
 	bus-width = <4>;
-	ti,non-removable;
+	non-removable;
 };
 
 &emif1 {
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
index 65d7b60..67d6ed7 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -242,12 +242,12 @@
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
1.7.10.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
