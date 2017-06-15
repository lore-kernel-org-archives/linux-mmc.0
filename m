From: Frank Wang <frank.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 0/6] add some device nodes support for rk322x SoC
Date: Thu, 15 Jun 2017 15:16:14 +0800
Message-ID: <1497510980-23207-1-git-send-email-frank.wang@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, charles.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kevan.lan-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, finley.xiao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, david.wu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, wmc-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Frank Wang <frank.wang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

These series add sdmmc, sdio, and other device nodes support for
rk322x SoCs, and also introduce rk3229 basic dtsi file specifically.

David Wu (1):
  ARM: dts: rockchip: Add io-domain node for rk3228

Finley Xiao (1):
  ARM: dts: rockchip: add efuse device node for rk3228

Frank Wang (1):
  ARM: dts: rockchip: add basic dtsi file for RK3229 SoC

Shawn Lin (3):
  Documentation: rockchip-dw-mshc: add description for rk3228
  ARM: dts: rockchip: fix compatible string for eMMC node of rk3228 SoC
  ARM: dts: rockchip: add sdmmc and sdio nodes for rk3228 SoC

 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   1 +
 arch/arm/boot/dts/rk3229-evb.dts                   |   2 +-
 arch/arm/boot/dts/rk3229.dtsi                      | 110 +++++++++++++++++++++
 arch/arm/boot/dts/rk322x.dtsi                      |  84 +++++++++++++++-
 4 files changed, 195 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3229.dtsi

-- 
2.0.0


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
