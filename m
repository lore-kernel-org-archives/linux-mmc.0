From: Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v2 4/7] ARM: dts: rockchip: fix compatible string for eMMC node of rk3228 SoC
Date: Thu, 22 Jun 2017 15:20:52 +0800
Message-ID: <1498116055-20977-5-git-send-email-frank.wang@rock-chips.com>
References: <1498116055-20977-1-git-send-email-frank.wang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498116055-20977-1-git-send-email-frank.wang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, charles.chen@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, finley.xiao@rock-chips.com, david.wu@rock-chips.com, shawn.lin@rock-chips.com, chenjh@rock-chips.com, wmc@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

From: Shawn Lin <shawn.lin@rock-chips.com>

This adds amend compatible content for eMMC of RK3228 SoC.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 34d175e..c4d43ce 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -523,7 +523,7 @@
 	};
 
 	emmc: dwmmc@30020000 {
-		compatible = "rockchip,rk3288-dw-mshc";
+		compatible = "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x30020000 0x4000>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <37500000>;
-- 
2.0.0
