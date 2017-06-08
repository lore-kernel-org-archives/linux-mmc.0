From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 9/9] mmc: core: Clarify code for sending CSD
Date: Thu,  8 Jun 2017 15:27:45 +0200
Message-ID: <1496928465-25004-10-git-send-email-ulf.hansson@linaro.org>
References: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33446 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbdFHN2D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Jun 2017 09:28:03 -0400
Received: by mail-lf0-f45.google.com with SMTP id a136so18053591lfa.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Jun 2017 06:28:03 -0700 (PDT)
In-Reply-To: <1496928465-25004-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>

To make the code more consistent and to increase readability, add an
mmc_spi_send_csd() function, which gets called from mmc_send_csd() in case
of SPI mode.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc_ops.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index b60b4da..5f051ea 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -291,15 +291,11 @@ mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 	return 0;
 }
 
-int mmc_send_csd(struct mmc_card *card, u32 *csd)
+static int mmc_spi_send_csd(struct mmc_card *card, u32 *csd)
 {
 	int ret, i;
 	__be32 *csd_tmp;
 
-	if (!mmc_host_is_spi(card->host))
-		return mmc_send_cxd_native(card->host, card->rca << 16,
-				csd, MMC_SEND_CSD);
-
 	csd_tmp = kzalloc(16, GFP_KERNEL);
 	if (!csd_tmp)
 		return -ENOMEM;
@@ -316,6 +312,15 @@ int mmc_send_csd(struct mmc_card *card, u32 *csd)
 	return ret;
 }
 
+int mmc_send_csd(struct mmc_card *card, u32 *csd)
+{
+	if (mmc_host_is_spi(card->host))
+		return mmc_spi_send_csd(card, csd);
+
+	return mmc_send_cxd_native(card->host, card->rca << 16,	csd,
+				MMC_SEND_CSD);
+}
+
 static int mmc_spi_send_cid(struct mmc_host *host, u32 *cid)
 {
 	int ret, i;
-- 
2.7.4

