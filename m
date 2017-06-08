From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/6] Move debugfs to block layer, take 3
Date: Thu,  8 Jun 2017 10:53:57 +0200
Message-ID: <20170608085403.11795-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35945 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbdFHIyN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 04:54:13 -0400
Received: by mail-lf0-f44.google.com with SMTP id o83so15229140lff.3
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 01:54:12 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>

Changes since last revision:

- Added a necessary EXPORT patch

- Added a patch on top that moves the debugfs into the block
  module.

Linus Walleij (6):
  mmc: block: Anonymize the drv op data pointer
  mmc: debugfs: No blocklayer = no card status and extcsd
  mmc: ops: export mmc_get_status()
  mmc: debugfs: Move card status retrieveal into the block layer
  mmc: debugfs: Move EXT CSD debugfs access to block layer
  mmc: debugfs: Move block debugfs into block module

 drivers/mmc/core/block.c   | 151 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/core/debugfs.c |  90 +--------------------------
 drivers/mmc/core/mmc_ops.c |   1 +
 drivers/mmc/core/queue.h   |   6 +-
 4 files changed, 155 insertions(+), 93 deletions(-)

-- 
2.9.4

