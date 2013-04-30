From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 12/13] ARM: dts: omap5: Add omap control mmc data
Date: Tue, 30 Apr 2013 19:33:52 +0530
Message-ID: <1367330633-5941-13-git-send-email-balajitk@ti.com>
References: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com
Cc: Balaji T K <balajitk@ti.com>
List-Id: linux-mmc@vger.kernel.org

Add omap-hsmmc-control data to omap5.
Update with pbias register address, used for pbias dual volt i/o cells
in mmc1.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 790bb2a..d480b9f 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -289,6 +289,13 @@
 			clock-frequency = <48000000>;
 		};
 
+		omap_control_mmc1: omap-hsmmc-control@4a002E00 {
+			compatible = "ti,omap-hsmmc-control";
+			reg = <0x4a002E00 0x4>;
+			reg-names = "pbias";
+			ctrl-type = <7>;
+		};
+
 		mmc1: mmc@4809c000 {
 			compatible = "ti,omap4-hsmmc";
 			reg = <0x4809c000 0x400>;
@@ -296,6 +303,7 @@
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
 			ti,needs-special-reset;
+			ctrl-module = <&omap_control_mmc1>;
 		};
 
 		mmc2: mmc@480b4000 {
-- 
1.7.5.4

