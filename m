From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH 0/5] Add intial support to DW MMC host on ZTE SoC
Date: Mon, 24 Oct 2016 17:11:51 +0800
Message-ID: <1477300316-1420-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34669 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935681AbcJXJMI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2016 05:12:08 -0400
Received: by mail-pf0-f179.google.com with SMTP id r16so95432948pfg.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Oct 2016 02:12:08 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shawn.guo@linaro.org, xie.baoyou@zte.com.cn
Cc: ulf.hansson@linaro.org, jh80.chung@samsung.com, jason.liu@linaro.org, linux-mmc@vger.kernel.org, Jun Nie <jun.nie@linaro.org>

Add intial support to DW MMC host on ZTE SoC. It include platform
specific wrapper driver and workarounds for fifo quirk.

Patches are prepared based on latest dw mmc runtime change:
   https://github.com/jh80chung/dw-mmc.git for-ulf

Jun Nie (5):
  mmc: dt-bindings: add ZTE MMC bindings
  mmc: zx: Initial support for ZX mmc controller
  Documentation: synopsys-dw-mshc: add binding for fifo quirks
  mmc: dw: Add fifo address override property
  mmc: dw: Add fifo watermark quirk

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  13 ++
 .../devicetree/bindings/mmc/zx-dw-mshc.txt         |  34 +++
 drivers/mmc/host/Kconfig                           |   9 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/dw_mmc-zx.c                       | 230 +++++++++++++++++++++
 drivers/mmc/host/dw_mmc-zx.h                       |  23 +++
 drivers/mmc/host/dw_mmc.c                          |  17 +-
 include/linux/mmc/dw_mmc.h                         |   3 +
 8 files changed, 328 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/zx-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-zx.c
 create mode 100644 drivers/mmc/host/dw_mmc-zx.h

-- 
1.9.1

