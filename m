From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH RESEND 09/12] mmc: sdhci-pxav3: Document clocks and additional clock-names property
Date: Tue, 21 Oct 2014 11:22:41 +0200
Message-ID: <1413883364-681-10-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?q?Antoine=20T=C3=A9nart?= <antoine.tenart@free-electrons.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Now that sdhci-pxav3 driver allows to have more than one IP clock defin=
ed,
document both clocks and clock-names properties.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Antoine T=C3=A9nart" <antoine.tenart@free-electrons.com>
Cc: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/mmc/sdhci-pxa.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt b/Docu=
mentation/devicetree/bindings/mmc/sdhci-pxa.txt
index 86223c3eda90..4dd6deb90719 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
@@ -12,6 +12,10 @@ Required properties:
   * for "marvell,armada-380-sdhci", two register areas. The first one
     for the SDHCI registers themselves, and the second one for the
     AXI/Mbus bridge registers of the SDHCI unit.
+- clocks: Array of clocks required for SDHCI; requires at least one fo=
r
+    I/O clock.
+- clock-names: Array of names corresponding to clocks property; shall =
be
+    "io" for I/O clock and "core" for optional core clock.
=20
 Optional properties:
 - mrvl,clk-delay-cycles: Specify a number of cycles to delay for tunin=
g.
@@ -23,6 +27,8 @@ sdhci@d4280800 {
 	reg =3D <0xd4280800 0x800>;
 	bus-width =3D <8>;
 	interrupts =3D <27>;
+	clocks =3D <&chip CLKID_SDIO1XIN>, <&chip CLKID_SDIO1>;
+	clock-names =3D "io", "core";
 	non-removable;
 	mrvl,clk-delay-cycles =3D <31>;
 };
@@ -32,5 +38,6 @@ sdhci@d8000 {
 	reg =3D <0xd8000 0x1000>, <0xdc000 0x100>;
 	interrupts =3D <0 25 0x4>;
 	clocks =3D <&gateclk 17>;
+	clock-names =3D "io";
 	mrvl,clk-delay-cycles =3D <0x1F>;
 };
--=20
2.1.1
