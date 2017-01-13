From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 00/15] mmc: core: A start to slim down public mmc headers
Date: Fri, 13 Jan 2017 14:14:01 +0100
Message-ID: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33887 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbdAMNOe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2017 08:14:34 -0500
Received: by mail-lf0-f49.google.com with SMTP id v186so37158798lfa.1
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2017 05:14:33 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

Changes in v3:
	- As patch 1 was applied from version 2, it has been dropped from the
	series.
	- Folded in a four new changes in patch 1->4/15, to solve build issues
	for davinci, mips and pxa.

Changes in v2:
	- As patch 1->11 was applied from version 1, those have been dropped
	from the series.
	- Folded in a new change in patch 1/12, to solve a build issue for imx
	which is using the mxcmmc platform data header.
	- Added reviews/acks.


Ideally we should not expose functions nor structures as being public available
as the interface for mmc - unless they really are intended to be used like that.

Unfortunate this is not the case today and which has lead to the mmc interface
in some cases being abused. That of course has its own problems, but we can
still move things in the right direction, which is what this series intend to
do. More precisely, it moves things that can be easily moved from the public mmc
headers to the private mmc headers.

This should be considered as a first step of improving the situation, further
additional changes will have to continue this path.


Ulf Hansson (15):
  ARM: pxa: Don't rely on public mmc header to include leds.h
  ARM: davinci: Don't rely on public mmc header to include leds.h
  ARM: davinci: Don't rely on public mmc header to include interrupt.h
  MIPS: Alchemy: Don't rely on public mmc header to include interrupt.h
  mmc: core: First step in cleaning up public mmc header files
  mmc: core: First step in cleaning up private mmc header files
  mmc: core: Move public functions from core.h to private headers
  mmc: core: Move some host specific public functions to host.h
  mmc: core: Move erase/trim/discard defines from public core.h to mmc.h
  mmc: core: Remove unused struct _mmc_csd from public mmc.h header
  mmc: omap: Don't use mmc_card_present() when validating for inserted
    card
  mmc: vub300: Don't use mmc_card_present() when validating for inserted
    card
  mmc: core: Move public functions from card.h to private headers
  mmc: core: Move public functions from host.h to private headers
  mmc: core: Don't use extern declarations of public mmc functions

 arch/arm/mach-davinci/board-da850-evm.c     |   1 +
 arch/arm/mach-davinci/board-dm644x-evm.c    |   1 +
 arch/arm/mach-davinci/board-neuros-osd2.c   |   1 +
 arch/arm/mach-davinci/board-omapl138-hawk.c |   1 +
 arch/arm/mach-pxa/balloon3.c                |   1 +
 arch/arm/mach-pxa/colibri-pxa270-income.c   |   1 +
 arch/arm/mach-pxa/corgi.c                   |   1 +
 arch/arm/mach-pxa/trizeps4.c                |   1 +
 arch/arm/mach-pxa/vpac270.c                 |   1 +
 arch/arm/mach-pxa/zeus.c                    |   1 +
 arch/arm/mach-pxa/zylonite.c                |   1 +
 arch/mips/alchemy/devboards/db1300.c        |   1 +
 drivers/mmc/core/block.c                    |   6 +
 drivers/mmc/core/block.h                    |   8 +
 drivers/mmc/core/bus.c                      |   2 +
 drivers/mmc/core/bus.h                      |  16 +-
 drivers/mmc/core/card.h                     | 223 +++++++++++++++++++++++++
 drivers/mmc/core/core.c                     |   1 +
 drivers/mmc/core/core.h                     |  41 ++++-
 drivers/mmc/core/debugfs.c                  |   2 +
 drivers/mmc/core/host.h                     |  48 ++++++
 drivers/mmc/core/mmc.c                      |  13 ++
 drivers/mmc/core/mmc_ops.h                  |  14 ++
 drivers/mmc/core/mmc_test.c                 |   5 +
 drivers/mmc/core/pwrseq.h                   |   6 +-
 drivers/mmc/core/queue.c                    |   2 +
 drivers/mmc/core/queue.h                    |   6 +-
 drivers/mmc/core/quirks.c                   |   2 +
 drivers/mmc/core/sd.c                       |   2 +
 drivers/mmc/core/sd.h                       |   5 +-
 drivers/mmc/core/sd_ops.h                   |   9 ++
 drivers/mmc/core/sdio.c                     |   2 +
 drivers/mmc/core/sdio_bus.c                 |   1 +
 drivers/mmc/core/sdio_bus.h                 |   3 +
 drivers/mmc/core/sdio_cis.h                 |   3 +
 drivers/mmc/core/sdio_io.c                  |   2 +
 drivers/mmc/core/sdio_irq.c                 |   2 +
 drivers/mmc/core/sdio_ops.h                 |   5 +
 drivers/mmc/core/slot-gpio.h                |   2 +
 drivers/mmc/host/omap.c                     |   2 +-
 drivers/mmc/host/vub300.c                   |   6 +-
 include/linux/mmc/card.h                    | 242 ----------------------------
 include/linux/mmc/core.h                    |  86 ++--------
 include/linux/mmc/host.h                    |  63 ++------
 include/linux/mmc/mmc.h                     |  59 ++-----
 include/linux/mmc/slot-gpio.h               |   3 +
 46 files changed, 478 insertions(+), 426 deletions(-)
 create mode 100644 drivers/mmc/core/card.h

-- 
1.9.1

