From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.14-rc4
Date: Sat,  7 Oct 2017 09:33:30 +0200
Message-ID: <1507361610-31577-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:46684 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbdJGHdf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 7 Oct 2017 03:33:35 -0400
Received: by mail-lf0-f47.google.com with SMTP id g70so6883066lfl.3
        for <linux-mmc@vger.kernel.org>; Sat, 07 Oct 2017 00:33:35 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.14-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9e66317d3c92ddaab330c125dfe9d06eee268aff:

  Linux 4.14-rc3 (2017-10-01 14:54:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.14-rc3

for you to fetch changes up to bb16ea1742c8f35a9349b7508dc45d3a922db5f5:

  mmc: sdhci-xenon: Fix clock resource by adding an optional bus clock (2017-10-04 10:50:36 +0200)

----------------------------------------------------------------
MMC core:
 - Fix driver strength selection when selecting hs400es
 - Delete bounce buffer handling:
   This change fixes a problem related to how bounce buffers are being
   allocated. However, instead of trying to fix that, let's just remove
   the mmc bounce buffer code altogether, as it has practically no use.

MMC host:
 - meson-gx: A couple of fixes related to clock/phase/tuning
 - sdhci-xenon: Fix clock resource by adding an optional bus clock

----------------------------------------------------------------
Chanho Min (1):
      mmc: core: add driver strength selection when selecting hs400es

Gregory CLEMENT (1):
      mmc: sdhci-xenon: Fix clock resource by adding an optional bus clock

Jerome Brunet (3):
      mmc: meson-gx: make sure the clock is rounded down
      mmc: meson-gx: fix rx phase reset
      mmc: meson-gx: include tx phase in the tuning process

Linus Walleij (1):
      mmc: Delete bounce buffer handling

 .../bindings/mmc/marvell,xenon-sdhci.txt           |  12 +-
 drivers/mmc/core/block.c                           |   3 -
 drivers/mmc/core/mmc.c                             |  36 +++---
 drivers/mmc/core/queue.c                           | 125 ++-------------------
 drivers/mmc/core/queue.h                           |   6 -
 drivers/mmc/host/cavium.c                          |   2 +-
 drivers/mmc/host/meson-gx-mmc.c                    |  26 ++++-
 drivers/mmc/host/pxamci.c                          |   6 +-
 drivers/mmc/host/sdhci-xenon.c                     |  24 +++-
 drivers/mmc/host/sdhci-xenon.h                     |   1 +
 include/linux/mmc/host.h                           |   2 +-
 11 files changed, 81 insertions(+), 162 deletions(-)
