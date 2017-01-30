From: Jeremy McNicoll <jeremymc@redhat.com>
Subject: [PATCH V4 4/6] arm64: dts: smem enablement for msm8992
Date: Sun, 29 Jan 2017 21:44:33 -0800
Message-ID: <1485755073-6416-1-git-send-email-jeremymc@redhat.com>
References: <20170127195831.GH8801@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751604AbdA3Foy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 30 Jan 2017 00:44:54 -0500
In-Reply-To: <20170127195831.GH8801@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: sboyd@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, andy.gross@linaro.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, git@kchr.de, ulf.hansson@linaro.org, jszhang@marvell.com

SMEM allows various subsystems/processors to share
memory/data (heap format) in order to enable various
peripherals.

Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
---

 [ Moved sfpb_mutex and smem outside sock as they didn't have
  'reg' entries.  Everything else is exactly the same. ]

 arch/arm64/boot/dts/qcom/msm8992.dtsi | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
index 13fb6f7..1715787 100644
--- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
@@ -79,6 +79,19 @@
 		regulator-always-on;
 	};
 
+	sfpb_mutex: hwmutex {
+		compatible = "qcom,sfpb-mutex";
+		syscon = <&sfpb_mutex_regs 0x0 0x100>;
+		#hwlock-cells = <1>;
+	};
+
+	smem {
+		compatible = "qcom,smem";
+		memory-region = <&smem_region>;
+		qcom,rpm-msg-ram = <&rpm_msg_ram>;
+		hwlocks = <&sfpb_mutex 3>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -93,6 +106,11 @@
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
@@ -183,12 +201,36 @@
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

