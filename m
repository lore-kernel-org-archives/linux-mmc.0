From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/9] mmc: core: Don't export some eMMC specific functions from core.c
Date: Thu,  8 Jun 2017 15:27:37 +0200
Message-ID: <1496928465-25004-2-git-send-email-ulf.hansson@linaro.org>
References: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:35410 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751580AbdFHN2E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 09:28:04 -0400
Received: by mail-lf0-f53.google.com with SMTP id p189so18037487lfe.2
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 06:28:03 -0700 (PDT)
In-Reply-To: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

The mmc_start|stop_bkops(), mmc_read_bkops_status() and mmc_interrupt_hpi()
functions are all used from within the mmc core module, thus there are no
need to use EXPORT_SYMBOL() for them, so let's remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ad8caf4..d48be0b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -428,7 +428,6 @@ void mmc_start_bkops(struct mmc_card *card, bool from_exception)
 out:
 	mmc_release_host(card->host);
 }
-EXPORT_SYMBOL(mmc_start_bkops);
 
 /*
  * mmc_wait_data_done() - done callback for data request
@@ -811,7 +810,6 @@ int mmc_interrupt_hpi(struct mmc_card *card)
 	mmc_release_host(card->host);
 	return err;
 }
-EXPORT_SYMBOL(mmc_interrupt_hpi);
 
 /**
  *	mmc_wait_for_cmd - start a command and wait for completion
@@ -869,7 +867,6 @@ int mmc_stop_bkops(struct mmc_card *card)
 
 	return err;
 }
-EXPORT_SYMBOL(mmc_stop_bkops);
 
 int mmc_read_bkops_status(struct mmc_card *card)
 {
@@ -887,7 +884,6 @@ int mmc_read_bkops_status(struct mmc_card *card)
 	kfree(ext_csd);
 	return 0;
 }
-EXPORT_SYMBOL(mmc_read_bkops_status);
 
 /**
  *	mmc_set_data_timeout - set the timeout for a data command
-- 
2.7.4

