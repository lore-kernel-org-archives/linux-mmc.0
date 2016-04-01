From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 6/9] mmc: host: add note that set_ios needs to handle 0Hz properly
Date: Fri,  1 Apr 2016 17:44:36 +0200
Message-ID: <1459525479-20842-7-git-send-email-wsa@the-dreams.de>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

While here, refactor the comments so that they are before the
declaration they are referring to.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/mmc/host.h | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 8dd4d290ab0d86..85800b48241fad 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -93,28 +93,39 @@ struct mmc_host_ops {
 	void	(*pre_req)(struct mmc_host *host, struct mmc_request *req,
 			   bool is_first_req);
 	void	(*request)(struct mmc_host *host, struct mmc_request *req);
+
+	/*
+	 * Avoid calling the next three functions too often or in a "fast
+	 * path", since underlaying controller might implement them in an
+	 * expensive and/or slow way. Also note that these functions might
+	 * sleep, so don't call them in the atomic contexts!
+	 */
+
+	/*
+	 * Notes to the set_ios callback:
+	 * ios->clock might be 0. For some controllers, setting 0Hz
+	 * as any other frequency works. However, some controllers
+	 * explicitly need to disable the clock. Otherwise e.g. voltage
+	 * switching might fail because the SDCLK is not really quiet.
+	 */
+	void	(*set_ios)(struct mmc_host *host, struct mmc_ios *ios);
+
 	/*
-	 * Avoid calling these three functions too often or in a "fast path",
-	 * since underlaying controller might implement them in an expensive
-	 * and/or slow way.
-	 *
-	 * Also note that these functions might sleep, so don't call them
-	 * in the atomic contexts!
-	 *
 	 * Return values for the get_ro callback should be:
 	 *   0 for a read/write card
 	 *   1 for a read-only card
 	 *   -ENOSYS when not supported (equal to NULL callback)
 	 *   or a negative errno value when something bad happened
-	 *
+	 */
+	int	(*get_ro)(struct mmc_host *host);
+
+	/*
 	 * Return values for the get_cd callback should be:
 	 *   0 for a absent card
 	 *   1 for a present card
 	 *   -ENOSYS when not supported (equal to NULL callback)
 	 *   or a negative errno value when something bad happened
 	 */
-	void	(*set_ios)(struct mmc_host *host, struct mmc_ios *ios);
-	int	(*get_ro)(struct mmc_host *host);
 	int	(*get_cd)(struct mmc_host *host);
 
 	void	(*enable_sdio_irq)(struct mmc_host *host, int enable);
-- 
2.7.0
