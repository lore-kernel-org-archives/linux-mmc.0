From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH 4/5] dts: imx25: fix sd card gpio polarity specified in device
 tree
Date: Thu, 18 Jun 2015 01:33:37 +0800
Message-ID: <1434562418-24090-5-git-send-email-aisheng.dong@freescale.com>
References: <1434562418-24090-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1434562418-24090-1-git-send-email-aisheng.dong@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: fabio.estevam@freescale.com, marex@denx.de, ulf.hansson@linaro.org, s.trumtrar@pengutronix.de, smoch@web.de, linux-arm-kernel@lists.infradead.org, robertcnelson@gmail.com, s.hauer@pengutronix.de, chris@printf.net, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, lisovy@gmail.com, hs@denx.de, gwenhael.goavec-merou@armadeus.com, p.zabel@pengutronix.de, rmk+kernel@arm.linux.org.uk, shawn.guo@linaro.org, b29396@freescale.com, tharvey@gateworks.com, LW@KARO-electronics.de, ipaton0@gmail.com
List-Id: linux-mmc@vger.kernel.org

cd-gpios polarity should be changed to GPIO_ACTIVE_LOW and wp-gpios
should be changed to GPIO_ACTIVE_HIGH.
Otherwise, the SD may not work properly due to wrong polarity inversion
specified in DT after switch to common parsing function mmc_of_parse().

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 arch/arm/boot/dts/imx25-pdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index dd45e69..faf252f 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -114,8 +114,8 @@
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
-	cd-gpios = <&gpio2 1 0>;
-	wp-gpios = <&gpio2 0 0>;
+	cd-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio2 0 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 
-- 
1.9.1
