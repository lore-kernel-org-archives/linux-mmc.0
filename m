From: Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v2 3/7] Documentation: rockchip-dw-mshc: add description for rk3228
Date: Thu, 22 Jun 2017 15:20:51 +0800
Message-ID: <1498116055-20977-4-git-send-email-frank.wang@rock-chips.com>
References: <1498116055-20977-1-git-send-email-frank.wang@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498116055-20977-1-git-send-email-frank.wang@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de, robh+dt@kernel.org, ulf.hansson@linaro.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, charles.chen@rock-chips.com, kevan.lan@rock-chips.com, huangtao@rock-chips.com, finley.xiao@rock-chips.com, david.wu@rock-chips.com, shawn.lin@rock-chips.com, chenjh@rock-chips.com, wmc@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

From: Shawn Lin <shawn.lin@rock-chips.com>

Add "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc" for
dwmmc on rk322x platform.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
index 18e33cb..a600833 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
@@ -15,6 +15,7 @@ Required Properties:
 	- "rockchip,rk3288-dw-mshc": for Rockchip RK3288
 	- "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RV1108
 	- "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3036
+	- "rockchip,rk3228-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK322X
 	- "rockchip,rk3328-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3328
 	- "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3368
 	- "rockchip,rk3399-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3399
-- 
2.0.0
