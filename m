From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 3/8] ARM: STi: DT: Add sdhci pins for stih416
Date: Thu, 22 May 2014 16:18:17 +0100
Message-ID: <1400771902-26553-4-git-send-email-peter.griffin@linaro.org>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, kernel@stlinux.com, linux-mmc@vger.kernel.org, peter.griffin@linaro.org, Giuseppe Cavallaro <peppe.cavallaro@st.com>, lee.jones@linaro.org
List-Id: linux-mmc@vger.kernel.org

This adds the required pin config for both SDHCI controllers on
the stih416 SoC.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 arch/arm/boot/dts/stih416-pinctrl.dtsi | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/dts/stih416-pinctrl.dtsi
index 6252188..140af6b 100644
--- a/arch/arm/boot/dts/stih416-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
@@ -467,6 +467,45 @@
 					};
 				};
 			};
+
+			mmc0 {
+				pinctrl_mmc0: mmc0 {
+					st,pins {
+						mmcclk = <&PIO13 4 ALT4 BIDIR_PU NICLK 0 CLK_B>;
+						data0 = <&PIO14 4 ALT4 BIDIR_PU BYPASS 0>;
+						data1 = <&PIO14 5 ALT4 BIDIR_PU BYPASS 0>;
+						data2 = <&PIO14 6 ALT4 BIDIR_PU BYPASS 0>;
+						data3 = <&PIO14 7 ALT4 BIDIR_PU BYPASS 0>;
+						cmd = <&PIO15 1 ALT4 BIDIR_PU BYPASS 0>;
+						wp = <&PIO15 3 ALT4 IN>;
+						data4 = <&PIO16 4 ALT4 BIDIR_PU BYPASS 0>;
+						data5 = <&PIO16 5 ALT4 BIDIR_PU BYPASS 0>;
+						data6 = <&PIO16 6 ALT4 BIDIR_PU BYPASS 0>;
+						data7 = <&PIO16 7 ALT4 BIDIR_PU BYPASS 0>;
+						pwr = <&PIO17 1 ALT4 OUT>;
+						cd = <&PIO17 2 ALT4 IN>;
+						led = <&PIO17 3 ALT4 OUT>;
+					};
+				};
+			};
+			mmc1 {
+				pinctrl_mmc1: mmc1 {
+					st,pins {
+						mmcclk = <&PIO15 0 ALT3 BIDIR_PU NICLK 0 CLK_B>;
+						data0 = <&PIO13 7 ALT3 BIDIR_PU BYPASS 0>;
+						data1 = <&PIO14 1 ALT3 BIDIR_PU BYPASS 0>;
+						data2 = <&PIO14 2 ALT3 BIDIR_PU BYPASS 0>;
+						data3 = <&PIO14 3 ALT3 BIDIR_PU BYPASS 0>;
+						cmd = <&PIO15 4 ALT3 BIDIR_PU BYPASS 0>;
+						data4 = <&PIO15 6 ALT3 BIDIR_PU BYPASS 0>;
+						data5 = <&PIO15 7 ALT3 BIDIR_PU BYPASS 0>;
+						data6 = <&PIO16 0 ALT3 BIDIR_PU BYPASS 0>;
+						data7 = <&PIO16 1 ALT3 BIDIR_PU BYPASS 0>;
+						pwr = <&PIO16 2 ALT3 OUT>;
+						nreset = <&PIO13 6 ALT3 OUT>;
+					};
+				};
+			};
 		};
 
 		pin-controller-fvdp-fe {
-- 
1.9.1
