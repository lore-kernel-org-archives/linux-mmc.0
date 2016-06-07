From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 11/11] arm64: dts: rockchip: Provide emmcclk to PHY for rk3399
Date: Tue,  7 Jun 2016 15:44:44 -0700
Message-ID: <1465339484-969-12-git-send-email-dianders@chromium.org>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33506 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423523AbcFGWpT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2016 18:45:19 -0400
Received: by mail-pf0-f174.google.com with SMTP id y124so22388365pfy.0
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2016 15:45:19 -0700 (PDT)
In-Reply-To: <1465339484-969-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, kishon@ti.com, Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org
Cc: shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, catalin.marinas@arm.com, will.deacon@arm.com, wxt@rock-chips.com, jay.xu@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Previous changes in this series allowed exposing the card clock from the
rk3399 SDHCI device and allowed consuming the card clock in the rk3399
eMMC PHY.  Hook things up in the main rk3399 dtsi file.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 1b57e92e0093..004b599ca285 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -225,8 +225,10 @@
 		assigned-clock-rates = <200000000>;
 		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
 		clock-names = "clk_xin", "clk_ahb";
+		clock-output-names = "emmc_cardclock";
 		phys = <&emmc_phy>;
 		phy-names = "phy_arasan";
+		#clock-cells = <0>;
 		status = "disabled";
 	};
 
@@ -621,6 +623,8 @@
 		emmc_phy: phy@f780 {
 			compatible = "rockchip,rk3399-emmc-phy";
 			reg = <0xf780 0x24>;
+			clocks = <&sdhci>;
+			clock-names = "emmcclk";
 			#phy-cells = <0>;
 			status = "disabled";
 		};
-- 
2.8.0.rc3.226.g39d4020

