From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH 3/6] ARM: dts: imx7d-sdb: add eMMC5.0 support
Date: Wed, 10 Jun 2015 16:50:41 +0800
Message-ID: <1433926244-29244-4-git-send-email-haibo.chen@freescale.com>
References: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1433926244-29244-1-git-send-email-haibo.chen@freescale.com>
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
Cc: aisheng.dong@freescale.com, ulf.hansson@linaro.org, haibo.chen@freescale.com, chris@printf.net, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

imx7d-sdb board has a eMMC5.0 on usdhc3. This eMMC support HS400.
This patch add usdhc3 support for HS400

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 4d1a4b9..896eb54 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -241,6 +241,19 @@
 	status = "okay";
 };
 
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	assigned-clocks = <&clks IMX7D_USDHC3_ROOT_CLK>;
+	assigned-clock-rates = <400000000>;
+	bus-width = <8>;
+	tuning-step = <2>;
+	non-removable;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
-- 
1.9.1
