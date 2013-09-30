From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/2] mmc: core: Remove all code related to MMC_CLKGATE
Date: Mon, 30 Sep 2013 16:41:58 +0200
Message-ID: <1380552120-31003-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f170.google.com ([209.85.215.170]:41924 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979Ab3I3OmH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Sep 2013 10:42:07 -0400
Received: by mail-ea0-f170.google.com with SMTP id h14so2808632eak.1
        for <linux-mmc@vger.kernel.org>; Mon, 30 Sep 2013 07:42:05 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

This patchset is remove all code related to MMC_CLKGATE. A significant
portion of code can then be removed from the core layer which would
simplify maintainance.

At the moment it seems like only some MIPS platforms were using
MMC_CLKGATE, but at the same time the corresponding host drivers
were not taking advantage of the mechanism. This made me feel confident
in removing the feature entirely from the mmc subsystem could be done.

Also do note that for host drivers that would like to implement clock
gating as a power save operation, using runtime PM is a far easier
way to address this. Several host drivers is already fully supporting
this as well.

Ulf Hansson (2):
  MIPS: db1235: Don't use MMC_CLKGATE
  mmc: core: Remove MMC_CLKGATE

 Documentation/mmc/mmc-dev-attrs.txt |   10 --
 arch/mips/configs/db1235_defconfig  |    1 -
 drivers/mmc/core/Kconfig            |   10 --
 drivers/mmc/core/core.c             |  116 +----------------
 drivers/mmc/core/core.h             |    3 -
 drivers/mmc/core/debugfs.c          |    5 -
 drivers/mmc/core/host.c             |  245 -----------------------------------
 drivers/mmc/core/mmc.c              |    6 +-
 drivers/mmc/core/sd.c               |   12 +-
 drivers/mmc/core/sdio.c             |    5 +-
 drivers/mmc/core/sdio_irq.c         |   10 +-
 include/linux/mmc/host.h            |   27 ----
 12 files changed, 12 insertions(+), 438 deletions(-)

-- 
1.7.9.5

