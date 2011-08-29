From: Per Forlin <per.forlin@linaro.org>
Subject: [PATCH 1/2] mmc: core: clarify how to use post_req in case of errors
Date: Mon, 29 Aug 2011 15:35:58 +0200
Message-ID: <1314624959-4634-2-git-send-email-per.forlin@linaro.org>
References: <1314624959-4634-1-git-send-email-per.forlin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33306 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674Ab1H2Ngn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2011 09:36:43 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so4160433bke.19
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2011 06:36:42 -0700 (PDT)
In-Reply-To: <1314624959-4634-1-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santo
Cc: Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>

The err condition in post_req() is set to undo a call made
to pre_req() that hasn't been started yet.
The err condition is not set if an MMC request returns error.

Signed-off-by: Per Forlin <per.forlin@linaro.org>
---
 drivers/mmc/core/core.c  |    6 ++++++
 include/linux/mmc/host.h |    3 +++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 91a0a74..542aa06 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -279,8 +279,14 @@ struct mmc_async_req *mmc_start_req(struct mmc_host *host,
 		mmc_wait_for_req_done(host, host->areq->mrq);
 		err = host->areq->err_check(host->card, host->areq);
 		if (err) {
+			/* post process the completed failed request */
 			mmc_post_req(host, host->areq->mrq, 0);
 			if (areq)
+				/*
+				 * Cancel the new prepared request, because
+				 * it can't run until the failed
+				 * request has been properly handled.
+				 */
 				mmc_post_req(host, areq->mrq, -EINVAL);
 
 			host->areq = NULL;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 1d09562..7896fb4 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -108,6 +108,9 @@ struct mmc_host_ops {
 	 * It is optional for the host to implement pre_req and post_req in
 	 * order to support double buffering of requests (prepare one
 	 * request while another request is active).
+	 * pre_req() must always be followed by a post_req().
+	 * To undo a call made to pre_req(), call post_req() with
+	 * a nonzero err condition.
 	 */
 	void	(*post_req)(struct mmc_host *host, struct mmc_request *req,
 			    int err);
-- 
1.7.4.1

