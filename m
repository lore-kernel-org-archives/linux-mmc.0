From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/4] Move debugfs to block layer, take 2
Date: Mon,  5 Jun 2017 14:15:18 +0200
Message-ID: <20170605121522.27678-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34876 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751290AbdFEMPc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jun 2017 08:15:32 -0400
Received: by mail-lf0-f51.google.com with SMTP id p189so3737030lfe.2
        for <linux-mmc@vger.kernel.org>; Mon, 05 Jun 2017 05:15:31 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>

This is an interation of the patches removing the big MMC lock
from the debugfs. The following is changed:

- Put the DRV_OP anonymization into its own patch and put it
  first so we can have that nice thing queued at least, instead
  of letting it be part of another patch.

- Add a patch making the "status" and "ext_csd" card-related
  debugfs files only appear if the block layer is enabled.

- Move the card access over to the block layer, but now without
  !block_layer stubs, since we only have this if the block
  layer is enabled.

Linus Walleij (4):
  mmc: block: Anonymize the drv op data pointer
  mmc: debugfs: No blocklayer = no card status and extcsd
  mmc: debugfs: Move card status retrieveal into the block layer
  mmc: debugfs: Move EXT CSD debugfs acces to block layer

 drivers/mmc/core/block.c   | 57 ++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/core/block.h   |  2 ++
 drivers/mmc/core/debugfs.c | 58 ++++++++++++++++++++++++++--------------------
 drivers/mmc/core/queue.h   |  6 ++++-
 4 files changed, 94 insertions(+), 29 deletions(-)

-- 
2.9.4

