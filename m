From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH 2/2] omap3-n900.dts: Add slot-name properties for mmc devices
Date: Fri, 15 May 2015 23:14:49 +0200
Message-ID: <1431724489-32359-3-git-send-email-pali.rohar@gmail.com>
References: <1431724489-32359-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34573 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945963AbbEOVPF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2015 17:15:05 -0400
In-Reply-To: <1431724489-32359-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3=
-n900.dts
index 7a3b14c..4154f8d 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -678,6 +678,7 @@
 };
=20
 &mmc1 {
+	slot-name =3D "external";
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&mmc1_pins>;
 	vmmc-supply =3D <&vmmc1>;
@@ -687,6 +688,7 @@
=20
 /* most boards use vaux3, only some old versions use vmmc2 instead */
 &mmc2 {
+	slot-name =3D "internal";
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&mmc2_pins>;
 	vmmc-supply =3D <&vaux3>;
--=20
1.7.9.5

