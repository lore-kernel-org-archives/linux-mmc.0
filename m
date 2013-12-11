From: Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4 0/3] mmc: dw_mmc: add dw_mmc-k3
Date: Wed, 11 Dec 2013 22:02:18 +0800
Message-ID: <1386770541-15056-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Haojian Zhuang <haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zhangfei Gao <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

v4:
Follow Arnd's suggestion abstracting specific tuning to clock,
also because new version ip use different method and not use same tuning registers.

0001 acked by Jaehoon

v3:
0001: 
Put set/clear_bit DW_MMC_CARD_PRESENT in dw_mci_get_cd, 
Since dw_mci_request will check DW_MMC_CARD_PRESENT before sending cmd

0002:
Follow suggestion from Chris, Kumar and Seungwon
Sync to latest mmc-next, which is 3.12-rc2
Remove enum dw_mci_k3_type etc

v2:
Follow Jaehoon's suggestion
Use slot-gpio.c handle cd pin
Move table out to dts
other suggestion

Zhangfei Gao (3):
  mmc: dw_mmc: use slot-gpio to handle cd pin
  mmc: dw_mmc: add dw_mmc-k3 for k3 platform
  clk: hisilicon: add hi3620_mmc_clks

 .../bindings/arm/hisilicon/hisilicon.txt           |   14 ++
 .../devicetree/bindings/clock/hi3620-clock.txt     |    1 +
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   51 ++++
 drivers/clk/hisilicon/clk-hi3620.c                 |  266 ++++++++++++++++++++
 drivers/mmc/host/Kconfig                           |   10 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-k3.c                       |  136 ++++++++++
 drivers/mmc/host/dw_mmc.c                          |   48 +++-
 include/dt-bindings/clock/hi3620-clock.h           |    5 +
 9 files changed, 519 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-k3.c

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
