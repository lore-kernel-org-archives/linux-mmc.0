From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v5 9/9] ARM: STi: DT: STiH418: Add dt nodes for sdhci and emmc.
Date: Fri, 10 Apr 2015 10:40:31 +0100
Message-ID: <1428658831-14308-10-git-send-email-peter.griffin@linaro.org>
References: <1428658831-14308-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428658831-14308-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, ulf.hansson@linaro.org, peppe.cavallaro@st.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Add dt nodes to enable sdhci / eMMC for stih418-b2199 board.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih418-b2199.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index 926235c..a2fdada 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -74,5 +74,17 @@
 			st,i2c-min-scl-pulse-width-us = <0>;
 			st,i2c-min-sda-pulse-width-us = <5>;
 		};
+
+		mmc1: sdhci@09080000 {
+			status = "okay";
+		};
+
+		mmc0: sdhci@09060000 {
+			status = "okay";
+			max-frequency = <200000000>;
+			sd-uhs-sdr50;
+			sd-uhs-sdr104;
+			sd-uhs-ddr50;
+		};
 	};
 };
-- 
1.9.1
