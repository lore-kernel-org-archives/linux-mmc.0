From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/4] dt: bindings: mmc: Add sdio function
 subnode documentation
Date: Sat, 31 May 2014 21:03:32 +0200
Message-ID: <1401563014-13856-3-git-send-email-hdegoede@redhat.com>
References: <1401563014-13856-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBFGPVCOAKGQEKD3NRZA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
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

From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

While SDIO devices are runtime probable they sometimes need nonprobable
additional information on embedded systems, like an additional gpio
interrupt or a clock. This binding describes how to add child nodes to the
devicetree to supply this information.

Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
[hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org: Updated the bindings to put the sdio functions inside
 slot subnodes]
Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 49 +++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 44c9e53..2903775 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -81,6 +81,27 @@ if a property is specified at both the host and the slot level the slot
 level takes precedence.
 
 
+Use of Function subnodes
+------------------------
+
+On embedded systems the cards connected to a host may need additional
+properties. These can be specified in subnodes to the slot subnodes, with
+the card / SDIO-function identified by the standard 'reg' property.
+Note that the use of slot subnodes is mandatory in this case.
+Which information exactly can be specified depends on the bindings for the
+SDIO function driver for the node, as specified by the compatible string.
+
+Required slot subnode properties when using function subnodes:
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
 Examples
 --------
 
@@ -118,3 +139,31 @@ mmc0: mmc@f0008000 {
 		bus-width = <4>;
 	};
 };
+
+Example with sdio function subnodes:
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
+	mmc3_slot0: mmc3_slot@0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0>;
+
+		brcmf: bcrmf@1 {
+			reg = <1>;
+			compatible = "brcm,bcm43xx-fmac";
+			interrupt-parent = <&pio>;
+			interrupts = <10 8>; /* PH10 / EINT10 */
+			interrupt-names = "host-wake";
+		};
+	};
+};
-- 
2.0.0
