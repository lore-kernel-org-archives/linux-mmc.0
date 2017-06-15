From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/5] Convert RPMB block device to a character device
Date: Thu, 15 Jun 2017 14:12:54 +0200
Message-ID: <20170615121259.8281-1-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34009 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752376AbdFOMNF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jun 2017 08:13:05 -0400
Received: by mail-lf0-f54.google.com with SMTP id v20so7980712lfa.1
        for <linux-mmc@vger.kernel.org>; Thu, 15 Jun 2017 05:13:05 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Paolo Valente <paolo.valente@linaro.org>, Avri Altman <Avri.Altman@sandisk.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

Looking for ways to get rid of the RPMB "block device" and the
extra block queue. This is one approach, I don't know if it will
stick, let's discuss it, especially the RFC patch.

Patches 1,2,3 can be applied as cleanups unless they collide with
something else.

Patch 5 is a consequence of the character device conversion.

For motivation and in-depth description of the problem I am trying
to solve, see patch 4, the RFC.

Linus Walleij (5):
  mmc: block: Move duplicate check
  mmc: block: Refactor mmc_blk_part_switch()
  mmc: block: Reparametrize mmc_blk_ioctl_[multi]_cmd()
  RFC: mmc: block: Convert RPMB to a character device
  mmc: block: Delete mmc_access_rpmb()

 drivers/mmc/core/block.c | 384 ++++++++++++++++++++++++++++++++++++-----------
 drivers/mmc/core/queue.c |   2 +-
 drivers/mmc/core/queue.h |   4 +-
 3 files changed, 303 insertions(+), 87 deletions(-)

-- 
2.9.4

