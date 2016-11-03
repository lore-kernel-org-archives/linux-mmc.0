From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v3 0/5] Add intial support to DW MMC host on ZTE SoC
Date: Thu,  3 Nov 2016 21:31:36 +0800
Message-ID: <1478179901-25645-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35813 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753137AbcKCNbz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2016 09:31:55 -0400
Received: by mail-pf0-f174.google.com with SMTP id i88so31891622pfk.2
        for <linux-mmc@vger.kernel.org>; Thu, 03 Nov 2016 06:31:55 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

Add intial support to DW MMC host on ZTE SoC. It include platform
specific wrapper driver and workarounds for fifo quirk.

Patches are prepared based on latest dw mmc runtime change:
   https://github.com/jh80chung/dw-mmc.git for-ulf

Changes vs version 2:
  - Change dt property fifo-addr to data-addr and fifo-watermark-quirk to
    fifo-watermark-aligned.
  - Polish ZX MMC driver on minor coding style issues.

Changes vs version 1:
  - Change fifo-addr-override to fifo-addr and remove its workaround tag in comments.
  - Remove ZX DW MMC driver reset cap in driver, which can be added in dt nodes.

Jun Nie (5):
  mmc: dt-bindings: add ZTE ZX296718 MMC bindings
  mmc: zx: Initial support for ZX mmc controller
  Documentation: synopsys-dw-mshc: add binding for fifo quirks
  mmc: dw: Add fifo address property
  mmc: dw: Add fifo watermark alignment property

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  13 ++
 .../devicetree/bindings/mmc/zx-dw-mshc.txt         |  34 +++
 drivers/mmc/host/Kconfig                           |   9 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/dw_mmc-zx.c                       | 242 +++++++++++++++++++++
 drivers/mmc/host/dw_mmc-zx.h                       |  31 +++
 drivers/mmc/host/dw_mmc.c                          |  17 +-
 include/linux/mmc/dw_mmc.h                         |   5 +
 8 files changed, 349 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-zx.c
 create mode 100644 drivers/mmc/host/dw_mmc-zx.h

-- 
1.9.1

