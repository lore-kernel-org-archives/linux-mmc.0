From: Manish Narani <manish.narani@xilinx.com>
Subject: [RFC PATCH v2 4/4] arm64: zynqmp: Add 'xlnx,mio-bank' property in SDHCI node
Date: Thu, 20 Sep 2018 15:00:45 +0530
Message-ID: <1537435845-6682-5-git-send-email-manish.narani@xilinx.com>
References: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537435845-6682-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, michal.simek@xilinx.com, adrian.hunter@intel.com, manish.narani@xilinx.com, amit.kucheria@linaro.org, sudeep.holla@arm.com, leoyang.li@nxp.com, jollys@xilinx.com, rajanv@xilinx.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add a required property indicating the MIO Bank number for SDHCI
controller in ZynqMP.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 1def7e1..7ef002d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -492,6 +492,7 @@
 			reg = <0x0 0xff160000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
 			xlnx,device_id = <0>;
+			xlnx,mio-bank = <0>;
 		};
 
 		sdhci1: sdhci@ff170000 {
@@ -502,6 +503,7 @@
 			reg = <0x0 0xff170000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
 			xlnx,device_id = <1>;
+			xlnx,mio-bank = <1>;
 		};
 
 		smmu: smmu@fd800000 {
-- 
2.1.1
