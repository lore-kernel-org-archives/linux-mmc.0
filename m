From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 3/4] ARM: dts: berlin: add the SDHCI nodes for the BG2Q
Date: Wed, 16 Apr 2014 14:40:10 +0200
Message-ID: <1397652011-21284-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397652011-21284-1-git-send-email-antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org
Cc: =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Add the SDHCI nodes for the Marvell Berlin BG2Q, using the berlin-sdhci
driver.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 arch/arm/boot/dts/berlin2q.dtsi | 40 +++++++++++++++++++++++++++++++++=
+++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin=
2q.dtsi
index 5925e6a16749..8f897d461460 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -67,6 +67,14 @@
 		clock-div =3D <3>;
 	};
=20
+	sdio1clk: sdio1clk {
+		compatible =3D "fixed-factor-clock";
+		#clock-cells =3D <0>;
+		clocks =3D <&syspll>;
+		clock-mult =3D <1>;
+		clock-div =3D <4>;
+	};
+
 	soc {
 		compatible =3D "simple-bus";
 		#address-cells =3D <1>;
@@ -75,6 +83,38 @@
 		ranges =3D <0 0xf7000000 0x1000000>;
 		interrupt-parent =3D <&gic>;
=20
+		sdhci0: sdhci@ab0000 {
+			compatible =3D "marvell,berlin2q-sdhci";
+			reg =3D <0xab0000 0x200>;
+			clocks =3D <&sdio1clk>;
+			interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+			keep-power-in-suspend;
+			enable-sdio-wakeup;
+			broken-cd;
+			status =3D "disabled";
+		};
+
+		sdhci1: sdhci@ab0800 {
+			compatible =3D "marvell,berlin2q-sdhci";
+			reg =3D <0xab0800 0x200>;
+			clocks =3D <&sdio1clk>;
+			interrupts =3D <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			keep-power-in-suspend;
+			enable-sdio-wakeup;
+			status =3D "disabled";
+		};
+
+		sdhci2: sdhci@ab1000 {
+			compatible =3D "marvell,berlin2q-sdhci";
+			reg =3D <0xab1000 0x200>;
+			interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&sdio1clk>;
+			keep-power-in-suspend;
+			enable-sdio-wakeup;
+			broken-cd;
+			status =3D "disabled";
+		};
+
 		l2: l2-cache-controller@ac0000 {
 			compatible =3D "arm,pl310-cache";
 			reg =3D <0xac0000 0x1000>;
--=20
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
