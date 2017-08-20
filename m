From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/8] debugfs and RPMB cleanups
Date: Sun, 20 Aug 2017 23:39:05 +0200
Message-ID: <20170820213913.9737-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:38455 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753300AbdHTVjV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Aug 2017 17:39:21 -0400
Received: by mail-lf0-f52.google.com with SMTP id y15so59682730lfd.5
        for <linux-mmc@vger.kernel.org>; Sun, 20 Aug 2017 14:39:20 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>

Here is a series of all the cleanup patches and RPMB rewrite
I didn't manage to finish for the last merge window, hoping we can
include these cleanups/refactorings for v4.14.

It's OK to stop applying at any step if there is any problem.

Linus Walleij (8):
  mmc: block: Anonymize the drv op data pointer
  mmc: ops: export mmc_get_status()
  mmc: debugfs: Move block debugfs into block module
  mmc: block: Move duplicate check
  mmc: block: Refactor mmc_blk_part_switch()
  mmc: block: Reparametrize mmc_blk_ioctl_[multi]_cmd()
  mmc: block: Convert RPMB to a character device
  mmc: block: Delete mmc_access_rpmb()

 drivers/mmc/core/block.c   | 543 ++++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/core/debugfs.c |  89 --------
 drivers/mmc/core/mmc_ops.c |   1 +
 drivers/mmc/core/queue.c   |   2 +-
 drivers/mmc/core/queue.h   |  10 +-
 5 files changed, 467 insertions(+), 178 deletions(-)

-- 
2.13.5

