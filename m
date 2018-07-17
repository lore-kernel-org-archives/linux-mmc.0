From: <cl@rock-chips.com>
Subject: [PATCH v1 3/7] Documentation: spi-rockchip: add description for px30
Date: Tue, 17 Jul 2018 15:49:03 +0800
Message-ID: <1531813747-8804-4-git-send-email-cl@rock-chips.com>
References: <1531813747-8804-1-git-send-email-cl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531813747-8804-1-git-send-email-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: robh+dt@kernel.org, mark.rutland@arm.com, klaus.goger@theobroma-systems.com, cl@rock-chips.com, jagan@amarulasolutions.com, djw@t-chip.com.cn, jacob-chen@iotwrt.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, frank.wang@rock-chips.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, gregkh@linuxfoundation.org, catalin.marinas@arm.com, will.deacon@arm.com, yamada.masahiro@socionext.com, arnd@arndb.de, zhangqing@rock-chips.com, shawn.lin@rock-chips.com, kever.yang@rock-chips.com, david.wu@rock-chips.com, huangtao@rock-chips.com, tony.xie@rock-chips.com, sugar.zhang@rock-chips.com, huibin.hong@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

Add "rockchip,px30-spi", "rockchip,rk3066-spi" for spi on px30 platform.

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/spi/spi-rockchip.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.txt b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
index 6e3ffac..a0edac1 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.txt
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 - compatible: should be one of the following.
     "rockchip,rv1108-spi" for rv1108 SoCs.
+    "rockchip,px30-spi", "rockchip,rk3066-spi" for px30 SoCs.
     "rockchip,rk3036-spi" for rk3036 SoCS.
     "rockchip,rk3066-spi" for rk3066 SoCs.
     "rockchip,rk3188-spi" for rk3188 SoCs.
-- 
1.9.1
