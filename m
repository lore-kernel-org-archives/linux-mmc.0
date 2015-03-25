From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Subject: [PATCH] mmc: mmci: Cascade EPROBE_DEFER from regulators.
Date: Tue, 24 Mar 2015 18:39:49 -0700
Message-ID: <1427247589-1229-1-git-send-email-bjorn.andersson@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:9964 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752059AbbCYBjx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2015 21:39:53 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 drivers/mmc/host/mmci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 7fe1619..fb26674 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1613,7 +1613,10 @@ static int mmci_probe(struct amba_device *dev,
 	dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
 
 	/* Get regulators and the supported OCR mask */
-	mmc_regulator_get_supply(mmc);
+	ret = mmc_regulator_get_supply(mmc);
+	if (ret == -EPROBE_DEFER)
+		goto clk_disable;
+
 	if (!mmc->ocr_avail)
 		mmc->ocr_avail = plat->ocr_mask;
 	else if (plat->ocr_mask)
-- 
1.8.2.2

