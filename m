From: Matt Redfearn <matt.redfearn@imgtec.com>
Subject: [PATCH v7 1/2] mmc: OCTEON: Add DT bindings for OCTEON MMC controller
Date: Wed, 17 Feb 2016 16:12:53 +0000
Message-ID: <1455725574-9947-1-git-send-email-matt.redfearn@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:54991 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423525AbcBQQNB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Feb 2016 11:13:01 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: david.daney@cavium.com, aleksey.makarov@caviumnetworks.com, ulf.hansson@linaro.org, robh@kernel.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org, Chandrakala Chavva <cchavva@caviumnetworks.com>, Aleksey Makarov <aleksey.makarov@auriga.com>, Leonid Rosenboim <lrosenboim@caviumnetworks.com>, Peter Swain <pswain@cavium.com>, Aaron Williams <aaron.williams@cavium.com>, Matt Redfearn <matt.redfearn@imgtec.com>

From: Aleksey Makarov <aleksey.makarov@caviumnetworks.com>

Add Device Tree binding document for Octeon MMC controller. The driver
is in a following patch.

The MMC controller can be connected to up to 4 "slots" which may be
eMMC, MMC or SD card devices. As there is a single controller, each
available slot is represented as a child node of the controller.

This is a similar concept to the atmel-mci driver.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Chandrakala Chavva <cchavva@caviumnetworks.com>
Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Aleksey Makarov <aleksey.makarov@auriga.com>
Signed-off-by: Leonid Rosenboim <lrosenboim@caviumnetworks.com>
Signed-off-by: Peter Swain <pswain@cavium.com>
Signed-off-by: Aaron Williams <aaron.williams@cavium.com>
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---
v7: No changes

v6:
- Split up patch
- Moved device tree fixup to platform code
---
 .../devicetree/bindings/mmc/octeon-mmc.txt         | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/octeon-mmc.txt

diff --git a/Documentation/devicetree/bindings/mmc/octeon-mmc.txt b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
new file mode 100644
index 000000000000..d2c576d9ad65
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/octeon-mmc.txt
@@ -0,0 +1,79 @@
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

