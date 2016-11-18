From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v6 0/5] Add intial support to DW MMC host on ZTE SoC
Date: Fri, 18 Nov 2016 14:29:10 +0800
Message-ID: <1479450555-19047-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33250 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbcKRG3Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2016 01:29:24 -0500
Received: by mail-pf0-f174.google.com with SMTP id d2so53279827pfd.0
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2016 22:29:23 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, chen.chaokai@zte.com.cn, lai.binz@zte.com.cn, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

Add intial support to DW MMC host on ZTE SoC. It include platform
specific wrapper driver and workarounds for fifo quirk.

Patches are prepared based on latest dw mmc runtime change:
   https://github.com/jh80chung/dw-mmc.git for-ulf

Changes vs version 5:
  - Add clock delay lock status check to save CPU cycle in timing tuning CMD.

Changes vs version 4:
  - Fix missing empty dts compatible element in the end of compatible array.

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

