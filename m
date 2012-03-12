From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 3/4] arm/dts: OMAP4: Add mmc controller nodes and board data
Date: Mon, 12 Mar 2012 20:32:39 +0530
Message-ID: <1331564560-23276-4-git-send-email-rnayak@ti.com>
References: <1331564560-23276-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46943 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755712Ab2CLPDW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 Mar 2012 11:03:22 -0400
In-Reply-To: <1331564560-23276-1-git-send-email-rnayak@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robherring2@gmail.com, grant.likely@secretlab.ca, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balajitk@ti.com, svenkatr@ti.com, linaro-dev@lists.linaro.org, Rajendra Nayak <rnayak@ti.com>

Add omap mmc related device tree data for OMAP4.
Currenly limited to only omap4-panda and omap4-sdp
boards.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |   22 ++++++++++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts   |   24 ++++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi      |   31 +++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 29646dc..ea6f5bb 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -52,3 +52,25 @@
 &i2c4 {
 	clock-frequency = <400000>;
 };
+
+&mmc1 {
+	vmmc-supply = <&vmmc>;
+	ti,bus-width = <8>;
+};
+
+&mmc2 {
+	status = "disable";
+};
+
+&mmc3 {
+	status = "disable";
+};
+
+&mmc4 {
+	status = "disable";
+};
+
+&mmc5 {
+	ti,non-removable;
+	ti,bus-width = <4>;
+};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 01db8b7..852657a 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -70,3 +70,27 @@
 		reg = <0x1e>;
 	};
 };
+
+&mmc1 {
+	vmmc-supply = <&vmmc>;
+	ti,bus-width = <8>;
+};
+
+&mmc2 {
+	vmmc-supply = <&vaux1>;
+	ti,bus-width = <8>;
+	ti,non-removable;
+};
+
+&mmc3 {
+	status = "disable";
+};
+
+&mmc4 {
+	status = "disable";
+};
+
+&mmc5 {
+	ti,bus-width = <4>;
+	ti,non-removable;
+};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 29f4589..9226543 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -155,5 +155,36 @@
 			#size-cells = <0>;
 			ti,hwmods = "i2c4";
 		};
+
+		mmc1: mmc@1 {
+			compatible = "ti,omap4-hsmmc";
+			ti,hwmods = "mmc1";
+			ti,dual-volt;
+			ti,needs-special-reset;
+		};
+
+		mmc2: mmc@2 {
+			compatible = "ti,omap4-hsmmc";
+			ti,hwmods = "mmc2";
+			ti,needs-special-reset;
+		};
+
+		mmc3: mmc@3 {
+			compatible = "ti,omap4-hsmmc";
+			ti,hwmods = "mmc3";
+			ti,needs-special-reset;
+		};
+
+		mmc4: mmc@4 {
+			compatible = "ti,omap4-hsmmc";
+			ti,hwmods = "mmc4";
+			ti,needs-special-reset;
+		};
+
+		mmc5: mmc@5 {
+			compatible = "ti,omap4-hsmmc";
+			ti,hwmods = "mmc5";
+			ti,needs-special-reset;
+		};
 	};
 };
-- 
1.7.1

