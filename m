From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v8 4/5] mmc: dt-bindings: add ZTE ZX296718 MMC bindings
Date: Thu, 22 Dec 2016 12:57:36 +0800
Message-ID: <1482382657-16681-5-git-send-email-jun.nie@linaro.org>
References: <1482382657-16681-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35069 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932987AbcLVE6h (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2016 23:58:37 -0500
Received: by mail-pf0-f177.google.com with SMTP id i88so37684270pfk.2
        for <linux-mmc@vger.kernel.org>; Wed, 21 Dec 2016 20:58:00 -0800 (PST)
In-Reply-To: <1482382657-16681-1-git-send-email-jun.nie@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, shawn.guo@linaro.org, xie.baoyou@zte.com.cn, devicetree@vger.kernel.org
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, chen.chaokai@zte.com.cn, lai.binz@zte.com.cn, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

Document the device-tree binding of ZTE MMC host on
ZX296718 SoC.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 .../devicetree/bindings/mmc/zx-dw-mshc.txt         | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt

diff --git a/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
new file mode 100644
index 0000000..eaade0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
@@ -0,0 +1,33 @@
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

