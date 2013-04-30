From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 09/13] ARM: dts: omap3: Add omap control mmc data
Date: Tue, 30 Apr 2013 19:33:49 +0530
Message-ID: <1367330633-5941-10-git-send-email-balajitk@ti.com>
References: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58093 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760729Ab3D3OEH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Apr 2013 10:04:07 -0400
In-Reply-To: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com
Cc: Balaji T K <balajitk@ti.com>

Add omap-hsmmc-control data to omap3.
Update with pbias and devconf0 register address for mmc1.
Update with devconf1 register address for mmc2

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1acc261..c5c7d17 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -218,15 +218,32 @@
 			ti,spi-num-cs = <1>;
 		};
 
+		omap_control_mmc1: omap-hsmmc-control@48002520 {
+			compatible = "ti,omap-hsmmc-control";
+			reg = <0x48002520 0x4>,
+			      <0x48002274 0x4>;
+			reg-names = "pbias", "devconf0";
+			ctrl-type = <3>;
+		};
+
 		mmc1: mmc@4809c000 {
 			compatible = "ti,omap3-hsmmc";
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
+			ctrl-module = <&omap_control_mmc1>;
+		};
+
+		omap_control_mmc2: omap-hsmmc-control@480022D8 {
+			compatible = "ti,omap-hsmmc-control";
+			reg = <0x480022D8 0x4>;
+			reg-names = "devconf1";
+			ctrl-type = <2>;
 		};
 
 		mmc2: mmc@480b4000 {
 			compatible = "ti,omap3-hsmmc";
 			ti,hwmods = "mmc2";
+			ctrl-module = <&omap_control_mmc2>;
 		};
 
 		mmc3: mmc@480ad000 {
-- 
1.7.5.4

