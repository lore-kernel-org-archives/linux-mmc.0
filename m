From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v2 0/5] Add intial support to DW MMC host on ZTE SoC
Date: Fri, 28 Oct 2016 10:37:04 +0800
Message-ID: <1477622229-32060-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33081 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034421AbcJ1ChV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2016 22:37:21 -0400
Received: by mail-pf0-f169.google.com with SMTP id 197so28473120pfu.0
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2016 19:37:20 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

Add intial support to DW MMC host on ZTE SoC. It include platform
specific wrapper driver and workarounds for fifo quirk.

Patches are prepared based on latest dw mmc runtime change:
   https://github.com/jh80chung/dw-mmc.git for-ulf

Changes vs version 1:
  - Change fifo-addr-override to fifo-addr and remove its workaround tag in comments.
  - Remove ZX DW MMC driver reset cap in driver, which can be added in dt nodes.

Jun Nie (5):
  mmc: dt-bindings: add ZTE MMC bindings
  mmc: zx: Initial support for ZX mmc controller
  Documentation: synopsys-dw-mshc: add binding for fifo quirks
  mmc: dw: Add fifo address property
  mmc: dw: Add fifo watermark quirk

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  13 ++
 .../devicetree/bindings/mmc/zx-dw-mshc.txt         |  34 +++
 drivers/mmc/host/Kconfig                           |   9 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/dw_mmc-zx.c                       | 230 +++++++++++++++++++++
 drivers/mmc/host/dw_mmc-zx.h                       |  23 +++
 drivers/mmc/host/dw_mmc.c                          |  16 +-
 include/linux/mmc/dw_mmc.h                         |   4 +
 8 files changed, 328 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-zx.c
 create mode 100644 drivers/mmc/host/dw_mmc-zx.h

-- 
1.9.1

