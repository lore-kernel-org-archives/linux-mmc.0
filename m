From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 1/2] dt: bindings: mmc: Add sdio function
 subnode documentation
Date: Tue,  3 Jun 2014 10:11:28 +0200
Message-ID: <1401783089-18065-2-git-send-email-hdegoede@redhat.com>
References: <1401783089-18065-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBPEGW2OAKGQEZTHPKUQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1401783089-18065-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

While SDIO devices are runtime probable they sometimes need nonprobable
additional information on embedded systems, like an additional gpio
interrupt or a clock. This binding describes how to add child nodes to the
devicetree to supply this information.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
[hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org: Documented the need for #address- and #size-cells]
[hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org: Added a real world example]
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 48 ++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 9dce540..79b222f 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -60,7 +60,31 @@ Optional SDIO properties:
 - keep-power-in-suspend: Preserves card power during a suspend/resume cycle
 - enable-sdio-wakeup: Enables wake up of host system on SDIO IRQ assertion
 
-Example:
+
+Use of Function subnodes
+------------------------
+
+On embedded systems the cards connected to a host may need additional
+properties. These can be specified in subnodes to the host controller node.
+The subnodes are identified by the standard 'reg' property.
+Which information exactly can be specified depends on the bindings for the
+SDIO function driver for the subnode, as specified by the compatible string.
+
+Required host node properties when using function subnodes:
+- #address-cells: should be one. The cell is the slot id.
+- #size-cells: should be zero.
+
+Required function subnode properties:
+- compatible: name of SDIO function following generic names recommended practice
+- reg: Must contain the SDIO function number of the function this subnode
+       describes. A value of 0 denotes the memory SD function, values from
+       1 to 7 denote the SDIO functions.
+
+
+Examples
+--------
+
+Basic example:
 
 sdhci@ab000000 {
 	compatible = "sdhci";
@@ -74,3 +98,25 @@ sdhci@ab000000 {
 	keep-power-in-suspend;
 	enable-sdio-wakeup;
 }
+
+Example with sdio function subnode:
+
+mmc3: mmc@01c12000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc3_pins_a>;
+	vmmc-supply = <&reg_vmmc3>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	brcmf: bcrmf@1 {
+		reg = <1>;
+		compatible = "brcm,bcm43xx-fmac";
+		interrupt-parent = <&pio>;
+		interrupts = <10 8>; /* PH10 / EINT10 */
+		interrupt-names = "host-wake";
+	};
+};
-- 
2.0.0
