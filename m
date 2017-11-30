From: Colin King <colin.king@canonical.com>
Subject: [PATCH] mmc: block: make function mmc_cqe_issue_type static
Date: Thu, 30 Nov 2017 11:37:38 +0000
Message-ID: <20171130113738.3851-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41169 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbdK3Lhl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Nov 2017 06:37:41 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function mmc_cqe_issue_type is local to the source and does
not need to be in global scope, so make it static.

Cleans up sparse warning:
drivers/mmc/core/queue.c:62:21: warning: symbol 'mmc_cqe_issue_type'
was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/core/queue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index d8394007bc99..5db388081789 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -59,8 +59,8 @@ static inline bool mmc_cqe_can_dcmd(struct mmc_host *host)
 	return host->caps2 & MMC_CAP2_CQE_DCMD;
 }
 
-enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
-				       struct request *req)
+static enum mmc_issue_type mmc_cqe_issue_type(struct mmc_host *host,
+					      struct request *req)
 {
 	switch (req_op(req)) {
 	case REQ_OP_DRV_IN:
-- 
2.14.1

