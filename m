From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v7 0/3] mmc: dw_mmc: add dw_mmc-k3
Date: Thu,  9 Jan 2014 22:35:09 +0800
Message-ID: <1389278112-7099-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:51461 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbaAIOf0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2014 09:35:26 -0500
Received: by mail-pb0-f49.google.com with SMTP id jt11so3048936pbb.8
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jan 2014 06:35:26 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, Mike Turquette <mturquette@linaro.org>, Rob Herring <robherring2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>, Haojian Zhuang <haojian.zhuang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

v7:
0002:
use undefined local value in suspend/resume

v6:
0002:
Jaehoon pointed HIGHSPEED cap can be omitted if supports-highspeed is defined.
Seungwon mentioned clk operation should be called after suspend.
Remove k3_dwmmc_caps

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
 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   60 +++++
 drivers/clk/hisilicon/clk-hi3620.c                 |  262 ++++++++++++++++++++
 drivers/mmc/host/Kconfig                           |   10 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-k3.c                       |  126 ++++++++++
 drivers/mmc/host/dw_mmc.c                          |   48 +++-
 include/dt-bindings/clock/hi3620-clock.h           |    5 +
 9 files changed, 514 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-k3.c

-- 
1.7.9.5

