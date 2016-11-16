From: Colin King <colin.king@canonical.com>
Subject: [PATCH] mmc: dw_mmc: fix spelling mistake in dev_dbg message
Date: Wed, 16 Nov 2016 18:55:01 +0000
Message-ID: <20161116185501.10976-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:52212 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754084AbcKPSzL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2016 13:55:11 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake "desciptor" to "descriptor" in
dev_dbg message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/dw_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a16c537..9341b18 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -612,7 +612,7 @@ static inline int dw_mci_prepare_desc64(struct dw_mci *host,
 	return 0;
 err_own_bit:
 	/* restore the descriptor chain as it's polluted */
-	dev_dbg(host->dev, "desciptor is still owned by IDMAC.\n");
+	dev_dbg(host->dev, "descriptor is still owned by IDMAC.\n");
 	memset(host->sg_cpu, 0, DESC_RING_BUF_SZ);
 	dw_mci_idmac_init(host);
 	return -EINVAL;
@@ -688,7 +688,7 @@ static inline int dw_mci_prepare_desc32(struct dw_mci *host,
 	return 0;
 err_own_bit:
 	/* restore the descriptor chain as it's polluted */
-	dev_dbg(host->dev, "desciptor is still owned by IDMAC.\n");
+	dev_dbg(host->dev, "descriptor is still owned by IDMAC.\n");
 	memset(host->sg_cpu, 0, DESC_RING_BUF_SZ);
 	dw_mci_idmac_init(host);
 	return -EINVAL;
-- 
2.10.2

