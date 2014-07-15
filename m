From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 01/11] mmc: sh_mmcif: Document DT bindings
Date: Wed, 16 Jul 2014 00:45:11 +0200
Message-ID: <1405464321-4723-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:54048 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbaGOWpV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jul 2014 18:45:21 -0400
In-Reply-To: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian.molton@codethink.co.uk>, devicetree@vger.kernel.org

The sh-mmcif driver implements DT support but the bindings are not
documented. Document them.

Cc: devicetree@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../devicetree/bindings/mmc/renesas,mmcif.txt      | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/renesas,mmcif.txt

diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
new file mode 100644
index 0000000..299081f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
@@ -0,0 +1,32 @@
+* Renesas Multi Media Card Interface (MMCIF) Controller
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the MMCIF device.
+
+
+Required properties:
+
+- compatible: must contain one of the following
+	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
+	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
+	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
+	- "renesas,sh-mmcif" for the generic MMCIF
+
+- clocks: reference to the functional clock
+
+- dmas: reference to the DMA channels, one per channel name listed in the
+  dma-names property.
+- dma-names: must contain "tx" for the transmit DMA channel and "rx" for the
+  receive DMA channel.
+
+
+Example: R8A7790 (R-Car H2) MMCIF0
+
+	mmcif0: mmc@ee200000 {
+		compatible = "renesas,mmcif-r8a7790", "renesas,sh-mmcif";
+		reg = <0 0xee200000 0 0x80>;
+		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_MMCIF0>;
+		dmas = <&dmac0 0xd1>, <&dmac0 0xd2>;
+		dma-names = "tx", "rx";
+	};
-- 
1.8.5.5

