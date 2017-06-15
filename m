From: Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH 2/6] Documentation: rockchip-dw-mshc: add description for rk3228
Date: Thu, 15 Jun 2017 15:16:16 +0800
Message-ID: <1497510980-23207-3-git-send-email-frank.wang@rock-chips.com>
References: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.132]:56501 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbdFOHQl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jun 2017 03:16:41 -0400
In-Reply-To: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, charles.chen@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, finley.xiao@rock-chips.com, david.wu@rock-chips.com, shawn.lin@rock-chips.com, wmc@rock-chips.com

From: Shawn Lin <shawn.lin@rock-chips.com>

Add "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc" for
dwmmc on rk322x platform.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
index 520d61d..ce30dff 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
@@ -15,6 +15,7 @@ Required Properties:
 	- "rockchip,rk3288-dw-mshc": for Rockchip RK3288
 	- "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RV1108
 	- "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3036
+	- "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK322X
 	- "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3368
 	- "rockchip,rk3399-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3399
 
-- 
2.0.0


