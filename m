From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 05/11] arm64: dts: rockchip: Add soc-ctl-syscon to sdhci for rk3399
Date: Tue,  7 Jun 2016 15:44:38 -0700
Message-ID: <1465339484-969-6-git-send-email-dianders@chromium.org>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465339484-969-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, kishon@ti.com, Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org
Cc: shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, catalin.marinas@arm.com, will.deacon@arm.com, jay.xu@rock-chips.com, wxt@rock-chips.com, zhengxing@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On rk3399 we'd like to be able to properly set corecfg registers in the
Arasan SDHCI component.  Specify the syscon to enable that.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index a4383f359264..1b57e92e0093 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -220,6 +220,7 @@
 		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
 		reg = <0x0 0xfe330000 0x0 0x10000>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		arasan,soc-ctl-syscon = <&grf>;
 		assigned-clocks = <&cru SCLK_EMMC>;
 		assigned-clock-rates = <200000000>;
 		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
-- 
2.8.0.rc3.226.g39d4020
