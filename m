From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v9 0/5] Add intial support to DW MMC host on ZTE SoC
Date: Fri,  6 Jan 2017 12:24:41 +0800
Message-ID: <1483676686-17011-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36768 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937881AbdAFEY4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jan 2017 23:24:56 -0500
Received: by mail-pf0-f169.google.com with SMTP id 189so91326938pfz.3
        for <linux-mmc@vger.kernel.org>; Thu, 05 Jan 2017 20:24:56 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, shawn.guo@linaro.org, xie.baoyou@zte.com.cn, devicetree@vger.kernel.org
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, chen.chaokai@zte.com.cn, lai.binz@zte.com.cn, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

Add intial support to DW MMC host on ZTE SoC. It include platform
specific wrapper driver and workarounds for fifo quirk.

Changes vs version 8:
  - Fix bug of uninitialized variable len in zx mmc driver.

Changes vs version 7:
  - Re-order patches sequence so that new dts property is introduced before usage.
  - Remove unecessary property in zx mmc dts.

Changes vs version 6:
  - Resolve confilict when rebase to latest dw-mmc.git for-ulf branch.
  - Add Shawn Lin's review tag.

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
  Documentation: synopsys-dw-mshc: add binding for fifo quirks
  mmc: dw: Add fifo address property
  mmc: dw: Add fifo watermark alignment property
  mmc: dt-bindings: add ZTE ZX296718 MMC bindings
  mmc: zx: Initial support for ZX mmc controller

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  13 ++
 .../devicetree/bindings/mmc/zx-dw-mshc.txt         |  33 +++
 drivers/mmc/host/Kconfig                           |   9 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/dw_mmc-zx.c                       | 242 +++++++++++++++++++++
 drivers/mmc/host/dw_mmc-zx.h                       |  31 +++
 drivers/mmc/host/dw_mmc.c                          |  17 +-
 include/linux/mmc/dw_mmc.h                         |   5 +
 8 files changed, 348 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-zx.c
 create mode 100644 drivers/mmc/host/dw_mmc-zx.h

-- 
1.9.1

