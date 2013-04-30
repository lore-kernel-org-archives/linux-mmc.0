From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 13/13] ARM: dts: am3517: add omap_control_mmc
Date: Tue, 30 Apr 2013 19:33:53 +0530
Message-ID: <1367330633-5941-14-git-send-email-balajitk@ti.com>
References: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com
Cc: Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Add omap-hsmmc-control data to am3517 board.
Update with devconf1 register address, used for loopback clock configuration
in mmc2.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/am3517-evm.dts        |   20 ++++++++++++++++++++
 arch/arm/boot/dts/am3517_mt_ventoux.dts |   20 ++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am3517-evm.dts b/arch/arm/boot/dts/am3517-evm.dts
index 474f760..2775c51 100644
--- a/arch/arm/boot/dts/am3517-evm.dts
+++ b/arch/arm/boot/dts/am3517-evm.dts
@@ -30,3 +30,23 @@
 &i2c3 {
 	clock-frequency = <400000>;
 };
+
+&omap_control_mmc1 {
+	compatible = "ti,omap-hsmmc-control";
+	ctrl-type = <0>;
+};
+
+omap_control_mmc2: omap-hsmmc-control@480022D8 {
+	compatible = "ti,omap-hsmmc-control";
+	reg = <0x480022D8 0x4>;
+	reg-names = "devconf1";
+	ctrl-type = <2>;
+};
+
+&mmc1 {
+	bus-width = <8>;
+};
+
+&mmc2 {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/am3517_mt_ventoux.dts b/arch/arm/boot/dts/am3517_mt_ventoux.dts
index 5eb26d7..2a15345 100644
--- a/arch/arm/boot/dts/am3517_mt_ventoux.dts
+++ b/arch/arm/boot/dts/am3517_mt_ventoux.dts
@@ -25,3 +25,23 @@
 		};
 	};
 };
+
+&omap_control_mmc1 {
+	compatible = "ti,omap-hsmmc-control";
+	ctrl-type = <0>;
+};
+
+omap_control_mmc2: omap-hsmmc-control@480022D8 {
+	compatible = "ti,omap-hsmmc-control";
+	reg = <0x480022D8 0x4>;
+	reg-names = "devconf1";
+	ctrl-type = <2>;
+};
+
+&mmc1 {
+	bus-width = <8>;
+};
+
+&mmc2 {
+	status = "disabled";
+};
-- 
1.7.5.4

