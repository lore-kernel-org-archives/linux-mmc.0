From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.16-rc1
Date: Mon,  5 Feb 2018 14:49:26 +0100
Message-ID: <1517838566-2345-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:43073 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeBENta (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Feb 2018 08:49:30 -0500
Received: by mail-lf0-f67.google.com with SMTP id o89so41816983lfg.10
        for <linux-mmc@vger.kernel.org>; Mon, 05 Feb 2018 05:49:29 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

Hi Linus,

Here's a PR with a few MMC fixes intended for v4.16-rc1. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 3da90b159b146672f830bcd2489dd3a1f4e9e089:

  Merge tag 'f2fs-for-4.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs (2018-01-30 19:07:32 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.16-2

for you to fetch changes up to 56174d9a21496fce64fcc6ba2f475734c20c12e4:

  mmc: MMC_SDHI_{SYS,INTERNAL}_DMAC should depend on HAS_DMA (2018-01-31 11:27:23 +0100)

----------------------------------------------------------------
MMC host:
 - renesas_sdhi: Fix build error in case NO_DMA=y
 - sdhci: Implement a bounce buffer to address throughput regressions

----------------------------------------------------------------
Geert Uytterhoeven (1):
      mmc: MMC_SDHI_{SYS,INTERNAL}_DMAC should depend on HAS_DMA

Linus Walleij (1):
      mmc: sdhci: Implement an SDHCI-specific bounce buffer

 drivers/mmc/host/Kconfig |   4 +-
 drivers/mmc/host/sdhci.c | 164 ++++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/sdhci.h |   3 +
 3 files changed, 161 insertions(+), 10 deletions(-)
