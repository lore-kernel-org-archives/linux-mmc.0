From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v3 0/2] mmc: dw_mmc: add dw_mmc-k3
Date: Fri,  8 Nov 2013 13:38:45 +0800
Message-ID: <1383889128-12540-1-git-send-email-zhangfei.gao@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:43546 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab3KHFjJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Nov 2013 00:39:09 -0500
Received: by mail-pb0-f51.google.com with SMTP id xa7so1663447pbc.38
        for <linux-mmc@vger.kernel.org>; Thu, 07 Nov 2013 21:39:08 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Zhangfei Gao <zhangfei.gao@linaro.org>

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

Zhangfei Gao (2):
  mmc: dw_mmc: add dw_mci_of_get_cd_gpio to handle cd pin
  mmc: dw_mmc: add dw_mmc-k3 for k3 platform

 .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   83 +++++++
 drivers/mmc/host/Kconfig                           |   10 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-k3.c                       |  247 ++++++++++++++++++++
 drivers/mmc/host/dw_mmc.c                          |   52 +++--
 5 files changed, 380 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-k3.c

-- 
1.7.9.5

