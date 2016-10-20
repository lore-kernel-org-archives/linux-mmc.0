From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/4] mmc: core: Clean-up and improve polling code in __mmc_switch()
Date: Thu, 20 Oct 2016 10:19:35 +0200
Message-ID: <1476951579-26125-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34395 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbcJTITy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Oct 2016 04:19:54 -0400
Received: by mail-lf0-f54.google.com with SMTP id b81so71603658lfe.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Oct 2016 01:19:53 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Chaotian Jing <chaotian.jing@mediatek.com>

The code in __mmc_switch() is rather messy and hard to follow/understand. This
series starts out by cleaning-up and re-factoring that code. In the final patch
I intend to improve the behaviour regarding the polling method, which is being
used to know when the card stops signal busy.

Ulf Hansson (4):
  mmc: core: Make mmc_switch_status() available for mmc core
  mmc: core: Clarify code which deals with polling in __mmc_switch()
  mmc: core: Factor out code related to polling in __mmc_switch()
  mmc: core: Don't use ->card_busy() and CMD13 in combination when
    polling

 drivers/mmc/core/mmc.c     |  13 -----
 drivers/mmc/core/mmc_ops.c | 138 +++++++++++++++++++++++++--------------------
 drivers/mmc/core/mmc_ops.h |   2 +-
 3 files changed, 79 insertions(+), 74 deletions(-)

-- 
1.9.1

