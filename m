From: Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v2 6/7] ARM: dts: rockchip: Add io-domain node for rk3228
Date: Thu, 22 Jun 2017 15:24:19 +0800
Message-ID: <1498116259-27619-1-git-send-email-frank.wang@rock-chips.com>
References: <1498116055-20977-1-git-send-email-frank.wang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498116055-20977-1-git-send-email-frank.wang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, charles.chen@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, finley.xiao@rock-chips.com, david.wu@rock-chips.com, shawn.lin@rock-chips.com, chenjh@rock-chips.com, wmc@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

From: David Wu <david.wu@rock-chips.com>

This patch adds io-domain support for rk3228 SoC.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 66578fa..bd7ef53 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -237,6 +237,11 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
+		io_domains: io-domains {
+			compatible = "rockchip,rk3228-io-voltage-domain";
+			status = "disabled";
+		};
+
 		u2phy0: usb2-phy@760 {
 			compatible = "rockchip,rk3228-usb2phy";
 			reg = <0x0760 0x0c>;
-- 
2.0.0
