From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH 1/3] Document: dw_mmc-k3: add document of hi6220 mmc
Date: Fri,  1 May 2015 09:46:56 +0800
Message-ID: <1430444818-7740-2-git-send-email-zhangfei.gao@linaro.org>
References: <1430444818-7740-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35484 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958AbbEABrO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2015 21:47:14 -0400
Received: by pabtp1 with SMTP id tp1so77129522pab.2
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2015 18:47:14 -0700 (PDT)
In-Reply-To: <1430444818-7740-1-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
index 3b35449..a353d0b 100644
--- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
@@ -13,6 +13,10 @@ Required Properties:
 
 * compatible: should be one of the following.
   - "hisilicon,hi4511-dw-mshc": for controllers with hi4511 specific extensions.
+  - "hisilicon,hi6220-dw-mshc": for controllers with hi6220 specific extensions.
+
+Optional Properties:
+- hisilicon,peripheral-syscon: phandle of syscon used to control peripheral.
 
 Example:
 
@@ -42,3 +46,49 @@ Example:
 		cap-mmc-highspeed;
 		cap-sd-highspeed;
 	};
+
+	/* for Hi6220 */
+
+	/* SoC portion */
+	dwmmc_0: dwmmc0@f723d000 {
+	        compatible = "hisilicon,hi6220-dw-mshc";
+	        num-slots = <0x1>;
+	        board-mmc-bus-clk = <0x0>;
+	        reg = <0x0 0xf723d000 0x0 0x1000>;
+	        interrupts = <0x0 0x48 0x4>;
+	        clocks = <&clock_sys HI6220_MMC0_CIUCLK>, <&clock_sys HI6220_MMC0_CLK>;
+	        clock-names = "ciu", "biu";
+	};
+
+	dwmmc_1: dwmmc1@f723e000 {
+		compatible = "hisilicon,hi6220-dw-mshc";
+		num-slots = <0x1>;
+		board-mmc-bus-clk = <0x0>;
+		card-detect-delay = <200>;
+		hisilicon,peripheral-syscon = <&ao_ctrl>;
+		reg = <0x0 0xf723e000 0x0 0x1000>;
+		interrupts = <0x0 0x49 0x4>;
+		clocks = <&clock_sys HI6220_MMC1_CIUCLK>, <&clock_sys HI6220_MMC1_CLK>;
+		clock-names = "ciu", "biu";
+	};
+
+	/* Board portion */
+	dwmmc_0: dwmmc0@f723d000 {
+		bus-width = <0x8>;
+	        broken-cd;
+		vmmc-supply = <&ldo19>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&emmc_pmx_func &emmc_clk_cfg_func
+			     &emmc_cfg_func &emmc_rst_cfg_func>;
+	};
+
+	dwmmc_1: dwmmc1@f723e000 {
+		bus-width = <0x4>;
+		disable-wp;
+		cd-gpios = <&gpio1 0 1>;
+		pinctrl-names = "default", "idle";
+		pinctrl-0 = <&sd_pmx_func &sd_clk_cfg_func &sd_cfg_func>;
+		pinctrl-1 = <&sd_pmx_idle &sd_clk_cfg_idle &sd_cfg_idle>;
+		vqmmc-supply = <&ldo7>;
+		vmmc-supply = <&ldo10>;
+	};
-- 
1.9.1

