From: <Eugen.Hristev@microchip.com>
Subject: [PATCH 2/2] ARM: dts: at91: sama5d27_som1_ek: add mmc capabilities
 for SDMMC0
Date: Thu, 8 Aug 2019 08:35:43 +0000
Message-ID: <1565252928-28994-2-git-send-email-eugen.hristev@microchip.com>
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com, alexandre.belloni@bootlin.com, adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Eugen.Hristev@microchip.com
List-Id: linux-mmc@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Add mmc capabilities for SDMMC0 for this board.
With this enabled, eMMC connected card is detected as:

mmc0: new DDR MMC card at address 0001

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dt=
s/at91-sama5d27_som1_ek.dts
index 149e539..194b3a3 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -54,6 +54,7 @@
=20
 		sdmmc0: sdio-host@a0000000 {
 			bus-width =3D <8>;
+			mmc-ddr-3_3v;
 			pinctrl-names =3D "default";
 			pinctrl-0 =3D <&pinctrl_sdmmc0_default>;
 			status =3D "okay";
--=20
2.7.4
