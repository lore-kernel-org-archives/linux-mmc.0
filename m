From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 08/13] Documentation: dt: mmc: omap hsmmc
Date: Tue, 30 Apr 2013 19:33:48 +0530
Message-ID: <1367330633-5941-9-git-send-email-balajitk@ti.com>
References: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58090 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760723Ab3D3OEH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Apr 2013 10:04:07 -0400
In-Reply-To: <1367330633-5941-1-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, b-cousson@ti.com
Cc: Balaji T K <balajitk@ti.com>

Update ti-omap-hsmmc devicetree documentation with omap-hsmmc-control binding
information for MMC1/MMC2 in different OMAP SoCs.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   34 ++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index ed271fc..f0468e8 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -31,3 +31,37 @@ Example:
 		vmmc-supply = <&vmmc>; /* phandle to regulator node */
 		ti,non-removable;
 	};
+
+OMAP HSMMC CONTROL
+
+Required properties:
+- compatible: Should be "ti,omap-hsmmc-control"
+- reg : Address and length of the register set for the device. It contains
+ the address of "pbias" and/or "prog_io1" and/or "ctrl_mmc1" and/or "devconf1"
+ and/or "devconf0"
+- reg-names: The names of the register addresses corresponding to the registers
+ filled in "reg".
+- ti,ctrl-type: This is used to differentiate mmc1, mmc2 on different
+ omap SOCs like 2430, omap3, omap3630, omap4, omap5.
+ MMC1 pbias programming is same for omap2430 and omap3 but differs across
+ omap3,4,5.
+ Should be "0" for no control mmc module configuration
+ Should be "1" for MMC1 on OMAP2430 for MMC1 pbias, loopback
+  and speed mode configuration
+ Should be "2" for MMC2 on OMAP2430, OMAP3 for loopback clock configuration
+ Should be "3" for MMC1 on OMAP3430 for MMC1 pbias, loopback
+  and speed mode configuration
+ Should be "4" for MMC1 on OMAP3630 for MMC1 pbias, loopback
+  and speed mode configuration
+ Should be "5" for MMC1 on OMAP4 for MMC1 pbias configuration
+ Should be "6" for MMC2 on OMAP4 for loopback clock configuration
+ Should be "7" for MMC1 on OMAP5 for MMC1 pbias configuration
+
+Example:
+omap_control_mmc1: omap-hsmmc-control@4A100600 {
+	compatible = "ti,omap-hsmmc-control";
+	reg = <0x4A100600 0x4>,
+	      <0x4A100628 0x4>;
+	reg-names = "pbias", "mmc1";
+	ctrl-type = <5>;
+};
-- 
1.7.5.4

