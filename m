From: Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH 5/6] ARM: dts: rockchip: Add io-domain node for rk3228
Date: Thu, 15 Jun 2017 15:21:47 +0800
Message-ID: <1497511307-23262-1-git-send-email-frank.wang@rock-chips.com>
References: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.132]:59739 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751016AbdFOHWF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jun 2017 03:22:05 -0400
In-Reply-To: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, charles.chen@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, finley.xiao@rock-chips.com, david.wu@rock-chips.com, shawn.lin@rock-chips.com, wmc@rock-chips.com, Frank Wang <frank.wang@rock-chips.com>

From: David Wu <david.wu@rock-chips.com>

This patch adds io-domain support for rk3228 SoC.

Signed-off-by: David Wu <david.wu@rock-chips.com>
Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 5e7b54c..c2a78f4 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -215,6 +215,11 @@
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


