From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/4] arm64: dts: rockchip: add clk_syscon for sdhci on rk3399
Date: Mon, 29 Aug 2016 16:02:58 +0800
Message-ID: <1472457779-7194-4-git-send-email-shawn.lin@rock-chips.com>
References: <1472457779-7194-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472457779-7194-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, Douglas Anderson <dianders@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

We are intent on letting the sdhci variant driver handle this
optional clock on rk3399 platform now.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index bc86e8c..d26c6ad 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -233,8 +233,9 @@
 		arasan,soc-ctl-syscon = <&grf>;
 		assigned-clocks = <&cru SCLK_EMMC>;
 		assigned-clock-rates = <200000000>;
-		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
-		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>,
+			 <&cru ACLK_EMMC_GRF>;
+		clock-names = "clk_xin", "clk_ahb", "clk_syscon";
 		clock-output-names = "emmc_cardclock";
 		#clock-cells = <0>;
 		phys = <&emmc_phy>;
-- 
2.3.7
