From: Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v7 1/5] mmc: dt-bindings: add ZTE ZX296718 MMC bindings
Date: Mon,  5 Dec 2016 10:29:32 +0800
Message-ID: <1480904976-7081-2-git-send-email-jun.nie@linaro.org>
References: <1480904976-7081-1-git-send-email-jun.nie@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480904976-7081-1-git-send-email-jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, xie.baoyou-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, jason.liu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, chen.chaokai-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, lai.binz-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Document the device-tree binding of ZTE MMC host on
ZX296718 SoC.

Signed-off-by: Jun Nie <jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
