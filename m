From: <cl@rock-chips.com>
Subject: [PATCH v1 5/7] Documentation: rockchip: grf: add grf and pmugrf description for px30
Date: Tue, 17 Jul 2018 15:56:01 +0800
Message-ID: <1531814161-8940-1-git-send-email-cl@rock-chips.com>
References: <1531813747-8804-1-git-send-email-cl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531813747-8804-1-git-send-email-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: robh+dt@kernel.org, mark.rutland@arm.com, klaus.goger@theobroma-systems.com, cl@rock-chips.com, jagan@amarulasolutions.com, djw@t-chip.com.cn, jacob-chen@iotwrt.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, frank.wang@rock-chips.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, gregkh@linuxfoundation.org, catalin.marinas@arm.com, will.deacon@arm.com, yamada.masahiro@socionext.com, arnd@arndb.de, zhangqing@rock-chips.com, shawn.lin@rock-chips.com, kever.yang@rock-chips.com, david.wu@rock-chips.com, huangtao@rock-chips.com, tony.xie@rock-chips.com, sugar.zhang@rock-chips.com, huibin.hong@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

This patch adds the compatible of GRF and PMUGRF for PX30 SoCs.

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.txt b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
index 7dc5ce8..46e27cd 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.txt
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.txt
@@ -13,6 +13,7 @@ On RK3328 SoCs, the GRF adds a section for USB2PHYGRF,
 Required Properties:
 
 - compatible: GRF should be one of the following:
+   - "rockchip,px30-grf", "syscon": for px30
    - "rockchip,rk3036-grf", "syscon": for rk3036
    - "rockchip,rk3066-grf", "syscon": for rk3066
    - "rockchip,rk3188-grf", "syscon": for rk3188
@@ -23,6 +24,7 @@ Required Properties:
    - "rockchip,rk3399-grf", "syscon": for rk3399
    - "rockchip,rv1108-grf", "syscon": for rv1108
 - compatible: PMUGRF should be one of the following:
+   - "rockchip,px30-pmugrf", "syscon": for px30
    - "rockchip,rk3368-pmugrf", "syscon": for rk3368
    - "rockchip,rk3399-pmugrf", "syscon": for rk3399
 - compatible: SGRF should be one of the following
-- 
1.9.1
