From: Jeremy McNicoll <jeremymc@redhat.com>
Subject: [PATCH V4 4/6] arm64: dts: smem enablement for msm8992
Date: Fri, 27 Jan 2017 01:10:03 -0800
Message-ID: <1485508205-1904-5-git-send-email-jeremymc@redhat.com>
References: <1485508205-1904-1-git-send-email-jeremymc@redhat.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1485508205-1904-1-git-send-email-jeremymc@redhat.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, git@kchr.de, ulf.hansson@linaro.org, jszhang@marvell.com, jeremymc@redhat.com
List-Id: linux-mmc@vger.kernel.org

SMEM allows various subsystems/processors to share
memory/data (heap format) in order to enable various
peripherals.

Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
---
 arch/arm64/boot/dts/qcom/msm8992.dtsi | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
index 13fb6f7..2c05ec7 100644
--- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
@@ -93,6 +93,11 @@
 				<0xf9002000 0x1000>;
 		};
 
+		apcs: syscon@f900d000 {
+			compatible = "syscon";
+			reg = <0xf900d000 0x2000>;
+		};
+
 		timer@f9020000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -183,12 +188,49 @@
 			#power-domain-cells = <1>;
 			reg = <0xfc400000 0x2000>;
 		};
+
+		rpm_msg_ram: memory@fc428000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0xfc428000 0x4000>;
+		};
+
+		sfpb_mutex_regs: syscon@fd484000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "syscon";
+			reg = <0xfd484000 0x400>;
+		};
+
+		sfpb_mutex: hwmutex {
+			compatible = "qcom,sfpb-mutex";
+			syscon = <&sfpb_mutex_regs 0x0 0x100>;
+			#hwlock-cells = <1>;
+		};
+
+		smem {
+			compatible = "qcom,smem";
+			memory-region = <&smem_region>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+			hwlocks = <&sfpb_mutex 3>;
+		};
 	};
 
 	memory {
 		device_type = "memory";
 		reg = <0 0 0 0>; // bootloader will update
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		smem_region: smem@6a00000 {
+			reg = <0x0 0x6a00000 0x0 0x200000>;
+			no-map;
+		};
+	};
+
 };
 
 
-- 
2.6.1
