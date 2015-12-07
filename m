From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] mmc: fix racy probe cleanup
Date: Mon, 07 Dec 2015 11:15:39 +0000
Message-ID: <E1a5tlb-0000UY-81@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:59322 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754931AbbLGLPn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Dec 2015 06:15:43 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

MMC probe cleanup is racy: consider the following sequence:

- mmc_alloc_host()
- mmc_gpio_request_cd()
- some failure
- mmc_free_host()

mmc_gpio_request_cd() registers a handler for the card detect GPIO
signal, and if this is triggered, it can queue the delayed work in
struct mmc_host.  mmc_free_host() then frees the mmc_host structure
with the still queued delayed work, which will then cause the timer
subsystem to touch free'd memory, potentially oopsing the kernel.

Fix this by ensuring that the delayed work is properly cancelled
before freeing the underlying memory.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/core/host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 5466f25f0281..b246803f2f1d 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -677,6 +677,7 @@ EXPORT_SYMBOL(mmc_remove_host);
  */
 void mmc_free_host(struct mmc_host *host)
 {
+	cancel_delayed_work_sync(&host->detect);
 	mmc_pwrseq_free(host);
 	put_device(&host->class_dev);
 }
-- 
2.1.0

