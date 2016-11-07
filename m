From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v4 0/5] Add intial support to DW MMC host on ZTE SoC
Date: Mon,  7 Nov 2016 21:04:43 +0800
Message-ID: <1478523888-4524-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36227 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752911AbcKGNaB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2016 08:30:01 -0500
Received: by mail-pf0-f177.google.com with SMTP id 189so91550646pfz.3
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2016 05:30:01 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

Add intial support to DW MMC host on ZTE SoC. It include platform
specific wrapper driver and workarounds for fifo quirk.

Patches are prepared based on latest dw mmc runtime change:
   https://github.com/jh80chung/dw-mmc.git for-ulf

Changes vs version 3:
  - Fix brace error in document.

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

