From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH V2 05/11] dts: imx7: fix sd card gpio polarity specified in
 device tree
Date: Wed, 22 Jul 2015 20:53:04 +0800
Message-ID: <1437569590-5228-6-git-send-email-aisheng.dong@freescale.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
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
Cc: fabio.estevam@freescale.com, marex@denx.de, ulf.hansson@linaro.org, hs@denx.de, p.zabel@pengutronix.de, tharvey@gateworks.com, shawn.guo@linaro.org, s.hauer@pengutronix.de, ipaton0@gmail.com, chris@printf.net, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, smoch@web.de, gwenhael.goavec-merou@armadeus.com, rmk+kernel@arm.linux.org.uk, lisovy@gmail.com, s.trumtrar@pengutronix.de, robertcnelson@gmail.com, b29396@freescale.com, linux-arm-kernel@lists.infradead.org, LW@KARO-electronics.de
List-Id: linux-mmc@vger.kernel.org

cd-gpios polarity should be changed to GPIO_ACTIVE_LOW and wp-gpios
should be changed to GPIO_ACTIVE_HIGH.
Otherwise, the SD may not work properly due to wrong polarity inversion
specified in DT after switch to common parsing function mmc_of_parse().

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 4d1a4b9..fdd1d7c 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -234,8 +234,8 @@
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
-	cd-gpios = <&gpio5 0 0>;
-	wp-gpios = <&gpio5 1 0>;
+	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
 	enable-sdio-wakeup;
 	keep-power-in-suspend;
 	status = "okay";
-- 
1.9.1
