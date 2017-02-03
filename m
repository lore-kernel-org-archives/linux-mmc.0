From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 1/8] dt-bindings: Add binding for brcm,bcm2835-sdhost.
Date: Fri,  3 Feb 2017 13:11:46 +0100
Message-ID: <1486123913-31705-2-git-send-email-kraxel@redhat.com>
References: <1486123913-31705-1-git-send-email-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486123913-31705-1-git-send-email-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>
List-Id: linux-mmc@vger.kernel.org

From: Eric Anholt <eric@anholt.net>

This is the other SD controller on the platform, which can be swapped
to the role of SD card host using pin muxing.

Signed-off-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mmc/brcm,bcm2835-sdhost.txt           | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt

diff --git a/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
new file mode 100644
index 0000000..ac676db
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt
@@ -0,0 +1,24 @@
+Broadcom BCM2835 SDHOST controller
+
+This file documents differences between the core properties described
+by mmc.txt and the properties that represent the BCM2835 controller.
+
+Required properties:
+- compatible: Should be "brcm,bcm2835-sdhost".
+- clocks: The clock feeding the SDHOST controller.
+
+Optional properties:
+- dmas: DMA channels for read and write.
+          See Documentation/devicetree/bindings/dma/dma.txt for details
+
+Example:
+
+sdhost: mmc@7e202000 {
+	compatible = "brcm,bcm2835-sdhost";
+	reg = <0x7e202000 0x100>;
+	interrupts = <2 24>;
+	clocks = <&clocks BCM2835_CLOCK_VPU>;
+	dmas = <&dma 13>,
+	       <&dma 13>;
+	dma-names = "tx", "rx";
+};
-- 
1.8.3.1
