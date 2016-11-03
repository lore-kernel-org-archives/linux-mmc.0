From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v3 1/5] mmc: dt-bindings: add ZTE ZX296718 MMC bindings
Date: Thu,  3 Nov 2016 21:31:37 +0800
Message-ID: <1478179901-25645-2-git-send-email-jun.nie@linaro.org>
References: <1478179901-25645-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34565 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753137AbcKCNcC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2016 09:32:02 -0400
Received: by mail-pf0-f179.google.com with SMTP id n85so32051623pfi.1
        for <linux-mmc@vger.kernel.org>; Thu, 03 Nov 2016 06:32:02 -0700 (PDT)
In-Reply-To: <1478179901-25645-1-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

Document the device-tree binding of ZTE MMC host on
ZX296718 SoC.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 .../devicetree/bindings/mmc/zx-dw-mshc.txt         | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
new file mode 100644
index 0000000..5e1e16d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
@@ -0,0 +1,34 @@
+* ZTE specific extensions to the Synopsys Designware Mobile Storage
+  Host Controller
+
+The Synopsys designware mobile storage host controller is used to interface
+a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
+differences between the core Synopsys dw mshc controller properties described
+by synopsys-dw-mshc.txt and the properties used by the ZTE specific
+extensions to the Synopsys Designware Mobile Storage Host Controller.
+
+Required Properties:
+
+* compatible: should be
+	- "zte,zx296718-dw-mshc": for ZX SoCs
+
+Example:
+
+	mmc1: mmc@1110000 {
+		compatible = "zte,zx296718-dw-mshc";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x01110000 0x1000>;
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+		fifo-depth = <32>;
+		data-addr = <0x200>;
+		fifo-watermark-aligned;
+		bus-width = <4>;
+		clock-frequency = <50000000>;
+		clocks = <&topcrm SD0_AHB>, <&topcrm SD0_WCLK>;
+		clock-names = "biu", "ciu";
+		num-slots = <1>;
+		max-frequency = <50000000>;
+		cap-sdio-irq;
+		cap-sd-highspeed;
+		status = "disabled";
-- 
1.9.1

