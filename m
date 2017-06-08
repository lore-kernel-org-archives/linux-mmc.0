From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/9] mmc: core: Some trivial re-factoring and cleanups
Date: Thu,  8 Jun 2017 15:27:36 +0200
Message-ID: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33815 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752033AbdFHN1x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 09:27:53 -0400
Received: by mail-lf0-f48.google.com with SMTP id v20so18055612lfa.1
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 06:27:52 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

I have collected some cleanups along the road on the mmc core, now I thought it
was time to post them. None of these changes causes any functional changes, but
the goal is rather to just make the code more readable and avoid open coding.


Ulf Hansson (9):
  mmc: core: Don't export some eMMC specific functions from core.c
  mmc: core: Move mmc bkops functions from core.c to mmc_ops.c
  mmc: core: Move mmc_interrupt_hpi() from core.c to mmc_ops.c
  mmc: core: Move mmc_flush_cache() from core.c to mmc_ops.c
  mmc: core: Make mmc_can_reset() static
  mmc: core: Remove redundant code in mmc_send_cid()
  mmc: core: Re-factor code for sending CID
  mmc: core: Drop mmc_all_send_cid() and use mmc_send_cxd_native()
    instead
  mmc: core: Clarify code for sending CSD

 drivers/mmc/core/core.c    | 207 -------------------------------------
 drivers/mmc/core/mmc.c     |   8 +-
 drivers/mmc/core/mmc_ops.c | 250 +++++++++++++++++++++++++++++++++++++++------
 drivers/mmc/core/mmc_ops.h |   3 -
 drivers/mmc/core/sd.c      |   6 +-
 5 files changed, 221 insertions(+), 253 deletions(-)

-- 
2.7.4

