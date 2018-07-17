From: <cl@rock-chips.com>
Subject: [PATCH v1 1/7] Documentation: usb: dwc2: add description for px30
Date: Tue, 17 Jul 2018 15:49:01 +0800
Message-ID: <1531813747-8804-2-git-send-email-cl@rock-chips.com>
References: <1531813747-8804-1-git-send-email-cl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531813747-8804-1-git-send-email-cl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: heiko@sntech.de
Cc: robh+dt@kernel.org, mark.rutland@arm.com, klaus.goger@theobroma-systems.com, cl@rock-chips.com, jagan@amarulasolutions.com, djw@t-chip.com.cn, jacob-chen@iotwrt.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, frank.wang@rock-chips.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, gregkh@linuxfoundation.org, catalin.marinas@arm.com, will.deacon@arm.com, yamada.masahiro@socionext.com, arnd@arndb.de, zhangqing@rock-chips.com, shawn.lin@rock-chips.com, kever.yang@rock-chips.com, david.wu@rock-chips.com, huangtao@rock-chips.com, tony.xie@rock-chips.com, sugar.zhang@rock-chips.com, huibin.hong@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

From: Liang Chen <cl@rock-chips.com>

This patch adds the compatible of dwc2 for PX30 SoCs.

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 Documentation/devicetree/bindings/usb/dwc2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index 46da5f1..6dc3c4a 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -6,6 +6,7 @@ Required properties:
   - brcm,bcm2835-usb: The DWC2 USB controller instance in the BCM2835 SoC.
   - hisilicon,hi6220-usb: The DWC2 USB controller instance in the hi6220 SoC.
   - rockchip,rk3066-usb: The DWC2 USB controller instance in the rk3066 Soc;
+  - "rockchip,px30-usb", "rockchip,rk3066-usb", "snps,dwc2": for px30 Soc;
   - "rockchip,rk3188-usb", "rockchip,rk3066-usb", "snps,dwc2": for rk3188 Soc;
   - "rockchip,rk3288-usb", "rockchip,rk3066-usb", "snps,dwc2": for rk3288 Soc;
   - "lantiq,arx100-usb": The DWC2 USB controller instance in Lantiq ARX SoCs;
-- 
1.9.1
