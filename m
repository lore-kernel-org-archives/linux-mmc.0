From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v5 1/5] mmc: dt-bindings: add ZTE ZX296718 MMC bindings
Date: Tue,  8 Nov 2016 09:24:54 +0800
Message-ID: <1478568298-18380-2-git-send-email-jun.nie@linaro.org>
References: <1478568298-18380-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33966 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbcKHBZ1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2016 20:25:27 -0500
Received: by mail-pf0-f170.google.com with SMTP id n85so98504034pfi.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2016 17:25:27 -0800 (PST)
In-Reply-To: <1478568298-18380-1-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

Document the device-tree binding of ZTE MMC host on
ZX296718 SoC.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 .../devicetree/bindings/mmc/zx-dw-mshc.txt         | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
new file mode 100644
index 0000000..c175c4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
@@ -0,0 +1,35 @@
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
+	};
-- 
1.9.1

