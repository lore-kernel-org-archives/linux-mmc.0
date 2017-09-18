From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.14-rc2
Date: Sun, 17 Sep 2017 23:50:10 -0700
Message-ID: <1505717410-7041-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:43518 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdIRGuO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Sep 2017 02:50:14 -0400
Received: by mail-lf0-f48.google.com with SMTP id c80so6912361lfh.0
        for <linux-mmc@vger.kernel.org>; Sun, 17 Sep 2017 23:50:13 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.14-rc2.

Details about the highlights are as usual found in the signed tag. Please pull
this in!

Kind regards
Ulf Hansson


The following changes since commit c16a854e4463078aedad601fac76341760a66dd1:

  mmc: renesas_sdhi: Add r8a7743/5 support (2017-09-01 15:31:01 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.14-2

for you to fetch changes up to b917c6d18c031cfce11ec35139033845f205b1d0:

  mmc: cavium: Fix use-after-free in of_platform_device_destroy (2017-09-08 15:38:22 +0200)

----------------------------------------------------------------
MMC core:
 - Fix trivial typo in Kconfig
 - Fixup initialization of mmc block requests

MMC host:
 - cavium: Fix use-after-free bug reported by KASAN

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: block: Fix incorrectly initialized requests

Jan Glauber (1):
      mmc: cavium: Fix use-after-free in of_platform_device_destroy

Wolfram Sang (1):
      mmc: host: fix typo after MMC_DEBUG move

 drivers/mmc/core/queue.c           | 7 ++++++-
 drivers/mmc/host/Kconfig           | 2 +-
 drivers/mmc/host/cavium-thunderx.c | 6 +++++-
 3 files changed, 12 insertions(+), 3 deletions(-)
