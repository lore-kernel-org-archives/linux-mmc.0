From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 11/13] ARM: dts: omap4: Add omap control mmc data
Date: Tue, 30 Apr 2013 19:33:51 +0530
Message-ID: <1367330633-5941-12-git-send-email-balajitk@ti.com>
References: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com
Cc: Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Add omap-hsmmc-control data to omap4.
Update with pbias register address for configuration of pbias dual volt
i/o cells in mmc1 and control_mmc1 register address for i/o strength
configuration

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 739bb79..7f1d0c1 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -292,6 +292,14 @@
 			ti,spi-num-cs = <1>;
 		};
 
+		omap_control_mmc1: omap-hsmmc-control@4A100600 {
+			compatible = "ti,omap-hsmmc-control";
+			reg = <0x4A100600 0x4>,
+			      <0x4A100628 0x4>;
+			reg-names = "pbias", "mmc1";
+			ctrl-type = <5>;
+		};
+
 		mmc1: mmc@4809c000 {
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x4809c000 0x400>;
@@ -299,6 +307,7 @@
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
 			ti,needs-special-reset;
+			ctrl-module = <&omap_control_mmc1>;
 		};
 
 		mmc2: mmc@480b4000 {
-- 
1.7.5.4

