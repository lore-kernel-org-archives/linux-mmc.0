From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/3] MMC cleanups
Date: Fri,  4 Nov 2016 11:05:16 +0100
Message-ID: <1478253919-2469-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34579 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761027AbcKDKF2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2016 06:05:28 -0400
Received: by mail-lf0-f48.google.com with SMTP id b81so59770276lfe.1
        for <linux-mmc@vger.kernel.org>; Fri, 04 Nov 2016 03:05:27 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

This is a set of three cleanup patches for the MMC core/card/block
code. I had to make them to start to understand what the code was
doing.

It would be great if we could apply these as a base for further
refactoring of the core code, e.g. for multiqueue efforts.

Linus Walleij (3):
  mmc: block: make gen_err a bool variable
  mmc: block: convert ecc_err to a bool
  mmc: core: use enum mmc_blk_status properly

 drivers/mmc/card/block.c    | 34 ++++++++++++++++++----------------
 drivers/mmc/card/mmc_test.c | 44 ++++++++++++++++++++++++++++++++++----------
 drivers/mmc/core/core.c     | 35 ++++++++++++++++++-----------------
 include/linux/mmc/card.h    | 12 ------------
 include/linux/mmc/core.h    | 15 ++++++++++++++-
 include/linux/mmc/host.h    |  2 +-
 6 files changed, 85 insertions(+), 57 deletions(-)

-- 
2.7.4

