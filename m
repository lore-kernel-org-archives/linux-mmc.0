From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v5 0/3] mmc: dw_mmc: add dw_mmc-k3
Date: Sat, 14 Dec 2013 10:12:51 +0800
Message-ID: <1386987174-1788-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:40053 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab3LNCNI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Dec 2013 21:13:08 -0500
Received: by mail-oa0-f41.google.com with SMTP id j17so2937744oag.28
        for <linux-mmc@vger.kernel.org>; Fri, 13 Dec 2013 18:13:07 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Rob Herring <robherring2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>, Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

V5:
0002:
Follow advice from Arnd, 
Update dt descirption and use of_property_for_each_u32 to get table number.

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
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   59 +++++
 drivers/clk/hisilicon/clk-hi3620.c                 |  262 ++++++++++++++++++++
 drivers/mmc/host/Kconfig                           |   10 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-k3.c                       |  133 ++++++++++
 drivers/mmc/host/dw_mmc.c                          |   48 +++-
 include/dt-bindings/clock/hi3620-clock.h           |    5 +
 9 files changed, 520 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-k3.c

-- 
1.7.9.5

