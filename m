From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 0/6] mmc: Add in-kernel firmware upgrade support.
Date: Wed, 13 Apr 2016 15:33:38 -0700
Message-ID: <1460586824-40688-1-git-send-email-gwendal@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36813 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbcDMWeJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2016 18:34:09 -0400
Received: by mail-pa0-f49.google.com with SMTP id er2so9869920pad.3
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2016 15:34:09 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, Alex.Lemberg@sandisk.com, avi.shchislowski@sandisk.com, yaniv.agman@sandisk.com, holgerschurig@gmail.com, chris@printf.net, baolin.wang@linaro.org
Cc: linux-mmc@vger.kernel.org

Add support for eMMC 5.0 FFU (Field Firmware Upgrade).
Assuming the new firmware does not wipde data or reduce size of device,
allow upgrading eMMC device while behing used.
The kernel will pick the firmware specified in the ioctl() from
/lib/firmware directory.
Some devices do not fully follow eMMC 5.0 specs, add "Hacks" in the ioctl
to accommodate them.

Grant Grundler (1):
  mmc: add FFU support to card/block.c

Gwendal Grignou (5):
  mmc: core: in _init, exclude FW revision from CID check.
  mmc: core: resecan [EXT_]CSD at card init.
  mmc: core: Support FFU for eMMC v5.0
  mmc: ffu: Hack for Hynix eMMC
  mmc: ffu: Hack for Samsung part

 drivers/mmc/card/Kconfig    |   8 +
 drivers/mmc/card/block.c    |   6 +
 drivers/mmc/card/mmc_test.c |  97 +--------
 drivers/mmc/core/Makefile   |   1 +
 drivers/mmc/core/core.c     | 125 +++++++++++
 drivers/mmc/core/ffu.c      | 496 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/mmc.c      |  54 +++--
 include/linux/mmc/card.h    |   1 +
 include/linux/mmc/core.h    |   9 +
 include/linux/mmc/ffu.h     |  65 ++++++
 include/linux/mmc/mmc.h     |   7 +
 11 files changed, 762 insertions(+), 107 deletions(-)
 create mode 100644 drivers/mmc/core/ffu.c
 create mode 100644 include/linux/mmc/ffu.h

-- 
2.8.0.rc3.226.g39d4020

