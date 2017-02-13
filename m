From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH 1/7] dt-bindings: rockchip-dw-mshc: rename RK1108 to RV1108
Date: Mon, 13 Feb 2017 19:02:39 +0800
Message-ID: <1486983759-32337-1-git-send-email-andy.yan@rock-chips.com>
References: <1486983566-32265-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.141]:59314 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751023AbdBMLC6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Feb 2017 06:02:58 -0500
In-Reply-To: <1486983566-32265-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robh+dt@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, Andy Yan <andy.yan@rock-chips.com>

Rockchip finally named the SOC as RV1108, so change it.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
index ea9c1c9..520d61d 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
@@ -13,7 +13,7 @@ Required Properties:
 	- "rockchip,rk2928-dw-mshc": for Rockchip RK2928 and following,
 							before RK3288
 	- "rockchip,rk3288-dw-mshc": for Rockchip RK3288
-	- "rockchip,rk1108-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK1108
+	- "rockchip,rv1108-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RV1108
 	- "rockchip,rk3036-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3036
 	- "rockchip,rk3368-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3368
 	- "rockchip,rk3399-dw-mshc", "rockchip,rk3288-dw-mshc": for Rockchip RK3399
-- 
2.7.4


