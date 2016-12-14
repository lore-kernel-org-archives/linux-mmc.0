From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH] ARM: dts: n900: Mark eMMC slot with no-sdio and no-sd flags
Date: Wed, 14 Dec 2016 22:29:44 +0100
Message-ID: <1481750984-11239-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Aaro Koskinen <aaro.koskinen@iki.fi>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Trying to initialize eMMC slot as SDIO or SD cause failure in n900 port of
qemu. eMMC itself is not detected and is not working.

Real Nokia N900 harware does not have this problem. As eMMC is really not
SDIO or SD based such change is harmless and will fix support for qemu.

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index bc8d6be..345a940 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -770,6 +770,8 @@
 	vmmc_aux-supply = <&vsim>;
 	bus-width = <8>;
 	non-removable;
+	no-sdio;
+	no-sd;
 };
 
 &mmc3 {
-- 
1.7.9.5
