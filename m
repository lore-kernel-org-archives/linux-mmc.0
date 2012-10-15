From: Tony Prisk <linux@prisktech.co.nz>
Subject: [RFC PATCH 1/2] MMC: DTS: Add binding for Wondermedia WM8505 SDHC
Date: Mon, 15 Oct 2012 21:24:52 +1300
Message-ID: <1350289493-30533-2-git-send-email-linux@prisktech.co.nz>
References: <1350289493-30533-1-git-send-email-linux@prisktech.co.nz>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from server.prisktech.co.nz ([115.188.14.127]:65158 "EHLO
	server.prisktech.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab2JOIdd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Oct 2012 04:33:33 -0400
In-Reply-To: <1350289493-30533-1-git-send-email-linux@prisktech.co.nz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Tony Prisk <linux@prisktech.co.nz>

Binding documentation for WMT SD/MMC Host Controller found on
Wondermedia 8xxx series SoCs.

Based on mmc.txt binding with additional properties.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 .../devicetree/bindings/mmc/vt8500-sdmmc.txt       |   24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/vt8500-sdmmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/vt8500-sdmmc.txt b/Documentation/devicetree/bindings/mmc/vt8500-sdmmc.txt
new file mode 100644
index 0000000..69a817e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/vt8500-sdmmc.txt
@@ -0,0 +1,24 @@
+* Wondermedia WM8505/WM8650 SD/MMC Host Controller
+
+Required properties:
+- compatible: Should be "wm,wm8505-sdhc".
+- reg: Memory for sdhc controller.
+- interrupts: Two interrupts are required - regular irq and dma irq.
+- clocks: pHandle to clock for controller.
+- bus-width: <1>,<4> or <8> data lines connected
+
+Optional properties:
+- sdon-inverted: SD_ON bit is inverted on the controller
+- cd-inverted: CD bit is inverted on the controller
+
+Examples:
+
+sdhc@d800a000 {
+	compatible = "wm,wm8505-sdhc";
+	reg = <0xd800a000 0x1000>;
+	interrupts = <20 21>;
+	clocks = <&sdhc>;
+	bus-width = <4>;
+	sdon-inverted;
+};
+
-- 
1.7.9.5

