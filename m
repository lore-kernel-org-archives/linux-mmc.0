From: Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v3 3/5] ARM: mvebu: set SW polling as SDHCI card detection on A388-GP
Date: Thu, 15 Oct 2015 18:25:44 +0200
Message-ID: <1444926346-29763-4-git-send-email-mw@semihalf.com>
References: <1444926346-29763-1-git-send-email-mw@semihalf.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444926346-29763-1-git-send-email-mw@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, andrew@lunn.ch, jason@lakedaemon.net, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, nadavh@marvell.com, alior@marvell.com, tawfik@marvell.com, mw@semihalf.com, jaz@semihalf.com, jszhang@marvell.com
List-Id: linux-mmc@vger.kernel.org

The newest revisions of A388-GP (v1.5 and higher) support only
DAT3-based card detection. Revisions < v1.5 based on GPIO detection
via I2C expander, but this solution is supposed to be deprecated on
new boards. In order to satisfy all type of hardware this commit
changes card detection to use software polling mechanism. Also a
comment is added on possible card detection options in A388-GP
DT board file.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Acked-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/armada-388-gp.dts | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index 391dea9..3deba13 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -213,8 +213,21 @@
 			sdhci@d8000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&sdhci_pins>;
-				cd-gpios = <&expander0 5 GPIO_ACTIVE_LOW>;
 				no-1-8-v;
+				/*
+				 * A388-GP board v1.5 and higher replace
+				 * hitherto card detection method based on GPIO
+				 * with the one using DAT3 pin. As they are
+				 * incompatible, software-based polling is
+				 * enabled with 'broken-cd' property. For boards
+				 * older than v1.5 it can be replaced with:
+				 * 'cd-gpios = <&expander0 5 GPIO_ACTIVE_LOW>;',
+				 * whereas for the newer ones following can be
+				 * used instead:
+				 * 'dat3-cd;'
+				 * 'cd-inverted;'
+				 */
+				broken-cd;
 				wp-inverted;
 				bus-width = <8>;
 				status = "okay";
-- 
1.8.3.1
