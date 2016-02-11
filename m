From: Matt Redfearn <matt.redfearn-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v6 1/3] mmc: OCTEON: Add DT bindings for OCTEON MMC controller
Date: Thu, 11 Feb 2016 16:26:14 +0000
Message-ID: <1455207976-2262-1-git-send-email-matt.redfearn@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, aleksey.makarov-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chandrakala Chavva <cchavva-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Aleksey Makarov <aleksey.makarov-tx70/tkNEWbQT0dZR+AlfA@public.gmane.org>, Leonid Rosenboim <lrosenboim-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Peter Swain <pswain-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Aaron Williams <aaron.williams-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Matt Redfearn <matt.redfearn-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Aleksey Makarov <aleksey.makarov-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>

Add Device Tree binding document for Octeon MMC controller. The driver
is in a following patch.

The MMC controller can be connected to up to 4 "slots" which may be
eMMC, MMC or SD card devices. As there is a single controller, each
available slot is represented as a child node of the controller.

This is a similar concept to the atmel-mci driver.

Tested-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Signed-off-by: Chandrakala Chavva <cchavva-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Signed-off-by: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Aleksey Makarov <aleksey.makarov-tx70/tkNEWbQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Leonid Rosenboim <lrosenboim-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Signed-off-by: Peter Swain <pswain-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Aaron Williams <aaron.williams-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Matt Redfearn <matt.redfearn-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
---
Changes since v6:
- Split up patch
- Moved device tree fixup to platform code
---
 .../devicetree/bindings/mmc/octeon-mmc.txt         | 80 ++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/octeon-mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/octeon-mmc.txt b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
new file mode 100644
index 000000000000..a1b20753172f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
@@ -0,0 +1,80 @@
+* OCTEON SD/MMC Host Controller
+
+This controller is present on some members of the Cavium OCTEON SoC
+family, provide an interface for eMMC, MMC and SD devices.  There is a
+single controller that may have several "slots" connected.  These
+slots appear as children of the main controller node.
+The DMA engine is an integral part of the controller block.
+
+1) MMC node
+
+Required properties:
+- compatible : Should be "cavium,octeon-6130-mmc" or "cavium,octeon-7890-mmc"
+- reg : Two entries:
+	1) The base address of the MMC controller register bank.
+	2) The base address of the MMC DMA engine register bank.
+- interrupts :
+	For "cavium,octeon-6130-mmc": two entries:
+	1) The MMC controller interrupt line.
+	2) The MMC DMA engine interrupt line.
+	For "cavium,octeon-7890-mmc": nine entries:
+	1) The next block transfer of a multiblock transfer has completed (BUF_DONE)
+	2) Operation completed successfully (CMD_DONE).
+	3) DMA transfer completed successfully (DMA_DONE).
+	4) Operation encountered an error (CMD_ERR).
+	5) DMA transfer encountered an error (DMA_ERR).
+	6) Switch operation completed successfully (SWITCH_DONE).
+	7) Switch operation encountered an error (SWITCH_ERR).
+	8) Internal DMA engine request completion interrupt (DONE).
+	9) Internal DMA FIFO underflow (FIFO).
+- #address-cells : Must be <1>
+- #size-cells : Must be <0>
+
+The node contains child nodes for each slot that the platform uses.
+
+Example:
+mmc@1180000002000 {
+	compatible = "cavium,octeon-6130-mmc";
+	reg = <0x11800 0x00002000 0x0 0x100>,
+		<0x11800 0x00000168 0x0 0x20>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	/* EMM irq, DMA irq */
+	interrupts = <1 19>, <0 63>;
+
+	[ child node definitions...]
+};
+
+
+2) Slot nodes
+Properties in mmc.txt apply to each slot node that the platform uses.
+
+Required properties:
+- reg : The slot number.
+
+Optional properties:
+- cavium,cmd-clk-skew : the amount of delay (in pS) past the clock edge
+	to sample the command pin.
+- cavium,dat-clk-skew : the amount of delay (in pS) past the clock edge
+	to sample the data pin.
+
+Example:
+	mmc@1180000002000 {
+		compatible = "cavium,octeon-6130-mmc";
+		reg = <0x11800 0x00002000 0x0 0x100>,
+		      <0x11800 0x00000168 0x0 0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		/* EMM irq, DMA irq */
+		interrupts = <1 19>, <0 63>;
+
+		/* The board only has a single MMC slot */
+		mmc-slot@0 {
+			reg = <0>;
+			max-frequency = <20000000>;
+			bus-width = <8>;
+			vmmc-supply = <&reg_vmmc3>;
+			cd-gpios = <&gpio 9 0>;
+			wp-gpios = <&gpio 10 0>;
+		};
+	};
-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
