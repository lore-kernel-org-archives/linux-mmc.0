From: =?UTF-8?q?Antoine=20T=C3=A9nart?=
	<antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 2/4] Documentation: bindings: add the sdhci-berlin
Date: Wed, 16 Apr 2014 14:40:09 +0200
Message-ID: <1397652011-21284-3-git-send-email-antoine.tenart@free-electrons.com>
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

Add the binding documentation for the Marvell Berlin SDHCI driver.

Signed-off-by: Antoine T=C3=A9nart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-berlin.txt | 18 ++++++++++=
++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-berlin.=
txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-berlin.txt b/D=
ocumentation/devicetree/bindings/mmc/sdhci-berlin.txt
new file mode 100644
index 000000000000..1a5591f85a64
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-berlin.txt
@@ -0,0 +1,18 @@
+* Marvell Berlin SDHCI controller
+
+All common properties are documented in mmc.txt
+
+Required properties:
+- compatible: "marvell,berlin2-sdhci",
+	      "marvell,berlin2cd-sdhci",
+	      "marvell,berlin2q-sdhci"
+- clocks: reference to the SDHCI controller clock
+
+Example:
+
+sdhci0: sdhci@ab0000 {
+	compatible =3D "marvell,berlin2q-sdhci";
+	reg =3D <0xab0000 0x200>;
+	clocks =3D <&sdio1clk>;
+	interrupts =3D <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+};
--=20
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
