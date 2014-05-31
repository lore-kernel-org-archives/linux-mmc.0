From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 1/4] dt: bindings: mmc: Document the practice
 of using subnodes for slots
Date: Sat, 31 May 2014 21:03:31 +0200
Message-ID: <1401563014-13856-2-git-send-email-hdegoede@redhat.com>
References: <1401563014-13856-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBEOPVCOAKGQEBRMP4AI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1401563014-13856-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The following existing MMC host controller bindings use slot subnodes:

Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt

This commit documents this practice in the standard mmc bindings documentation.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 46 ++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 9dce540..44c9e53 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -60,7 +60,31 @@ Optional SDIO properties:
 - keep-power-in-suspend: Preserves card power during a suspend/resume cycle
 - enable-sdio-wakeup: Enables wake up of host system on SDIO IRQ assertion
 
-Example:
+
+Use of slot subnodes
+--------------------
+
+Some hosts have multiple MMC slots connected to a single MMC host, in this
+case each slot gets its own subnode representing the slot:
+
+Required host node properties when using slots:
+- #address-cells: should be one. The cell is the slot id.
+- #size-cells: should be zero.
+
+Required slot subnode properties:
+- reg: Must contain the MMC host slot number of the slot this subnode
+       describes. Slot numbers start at 0.
+
+Optional slot subnode properties:
+Any of the optional host node properties can be used inside a slot node too,
+if a property is specified at both the host and the slot level the slot
+level takes precedence.
+
+
+Examples
+--------
+
+Basic example:
 
 sdhci@ab000000 {
 	compatible = "sdhci";
@@ -74,3 +98,23 @@ sdhci@ab000000 {
 	keep-power-in-suspend;
 	enable-sdio-wakeup;
 }
+
+Example with slot subnodes:
+
+mmc0: mmc@f0008000 {
+	compatible = "atmel,hsmci";
+	reg = <0xf0008000 0x600>;
+	interrupts = <12 4>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	slot@0 {
+		reg = <0>;
+		bus-width = <4>;
+		cd-gpios = <&pioD 15 0>
+		cd-inverted;
+	};
+	slot@1 {
+		reg = <1>;
+		bus-width = <4>;
+	};
+};
-- 
2.0.0
