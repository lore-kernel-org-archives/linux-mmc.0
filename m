From: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 3/7] mmc: sdhci-pxav3: Extend binding with SDIO3 conf reg for the Armada 38x
Date: Wed, 21 Jan 2015 10:32:02 +0100
Message-ID: <1421832726-21656-4-git-send-email-gregory.clement@free-electrons.com>
References: <1421832726-21656-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421832726-21656-1-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The SDHCI unit used on the Armada 38x needs using an extra register to
do specific clock adjustments in order to support the SDR50 and DDR50
modes. This patch extends the binding to allow using this register.

Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-pxa.txt | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
index 4dd6deb90719..3d1b449d6097 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
@@ -9,9 +9,13 @@ Required properties:
 - reg:
   * for "mrvl,pxav2-mmc" and "mrvl,pxav3-mmc", one register area for
     the SDHCI registers.
-  * for "marvell,armada-380-sdhci", two register areas. The first one
-    for the SDHCI registers themselves, and the second one for the
-    AXI/Mbus bridge registers of the SDHCI unit.
+
+  * for "marvell,armada-380-sdhci", three register areas. The first
+    one for the SDHCI registers themselves, the second one for the
+    AXI/Mbus bridge registers of the SDHCI unit, the third one for the
+    SDIO3 Configuration register
+- reg names: should be "sdhci", "mbus", "conf-sdio3". only mandatory
+  for "marvell,armada-380-sdhci"
 - clocks: Array of clocks required for SDHCI; requires at least one for
     I/O clock.
 - clock-names: Array of names corresponding to clocks property; shall be
@@ -35,7 +39,10 @@ sdhci@d4280800 {
 
 sdhci@d8000 {
 	compatible = "marvell,armada-380-sdhci";
-	reg = <0xd8000 0x1000>, <0xdc000 0x100>;
+	reg-names = "sdhci", "mbus", "conf-sdio3";
+	reg = <0xd8000 0x1000>,
+		<0xdc000 0x100>;
+		<0x18454 0x4>;
 	interrupts = <0 25 0x4>;
 	clocks = <&gateclk 17>;
 	clock-names = "io";
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
