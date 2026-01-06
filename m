Received: from mail-m15599.qiye.163.com (mail-m15599.qiye.163.com [101.71.155.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D37224B15
	for <linux-mmc@vger.kernel.org>; Tue,  6 Jan 2026 02:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767668352; cv=none; b=AySYxxxg+R3EeGkmDWcP0dGWxsJzD9a3dbFlNvBzHep/ojhPqoNJSlwj0jamyCkC4NyFeI6Xnf3p/5O1h8e/tR+2305OfeIbv9NAHLV9eK2ZrXlf8PVZpyp2yZVdgFZCKw9b1YQ+EDRBUyPmGsoH1zhFttyUf7dUqUeKABoaT/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767668352; c=relaxed/simple;
	bh=kk5eBHGNJ4UyPBiqsUZXDV2hIpkfnjC3xaXI46pBChk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qe7ZhNqbbkZQBQYiyXTvxqA9dK7Euxkvz2sR2s9t676kSfggiG1gVqmss3vtNK6gVZnzjUwq9kAjZbL4fa/VpiNRJX2gHOU/SPxjC571xOxdBRFPrXedPUnog0tiJUBWGr29UtI6LSPX5dxsm+WdBuwjtnteu5IqmDT6yxp5fCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ZFjvNBSa; arc=none smtp.client-ip=101.71.155.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZFjvNBSa"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f9c4acbc;
	Tue, 6 Jan 2026 10:23:37 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 13/18] mmc: dw_mmc: Improve dw_mci_get_cd()
Date: Tue,  6 Jan 2026 10:17:04 +0800
Message-Id: <1767665829-183001-14-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b911df10c09cckunmc69ba49b79cd75
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU8aHlYZGRoYTEpKS0NJT0pWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZFjvNBSaU/eHNxc4HEvuhaA/K7KKDDcJW67Nr/XAEBLpRbsXIFkoCTF+Gb6OShs6ggj0PjpaGG55yJCr83hFgHfTQxwQAy1OpyEvqEfm3BfNuxqTByifyy35QRrouOUPXofiE4RZ1ZZR7TbifWdXnHqhXikQUSKtbhDQLeDVUzM=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=jGuBRvWM7xxA7/dr7ydzR/LKV0IsTwt5sd2wOx4aFYc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The current dw_mci_get_cd() implementation maintains a DW_MMC_CARD_PRESENT
flag primarily for logging purposes, which adds unnecessary complexity.
Additionally, the if-else-elif control flow does not align with the Linux
kernel coding style.

This commit simplifies the function by:
- Removing the redundant card presence flag
- Replacing the conditional chain with a cleaner implementation
- Improving code readability while maintaining functionality

The change reduces code complexity without affecting the actual card
detection behavior.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 44 ++++++++++++++------------------------------
 drivers/mmc/host/dw_mmc.h |  9 ++++-----
 2 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 00b3e7e..2ad7d74 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -881,42 +881,21 @@ static void dw_mci_post_req(struct mmc_host *mmc,
 
 static int dw_mci_get_cd(struct mmc_host *mmc)
 {
-	int present;
 	struct dw_mci *host = mmc_priv(mmc);
 	int gpio_cd = mmc_gpio_get_cd(mmc);
 
-	/* Use platform get_cd function, else try onboard card detect */
-	if (((mmc->caps & MMC_CAP_NEEDS_POLL)
-				|| !mmc_card_is_removable(mmc))) {
-		present = 1;
+	if (mmc->caps & MMC_CAP_NEEDS_POLL)
+		return 1;
 
-		if (!test_bit(DW_MMC_CARD_PRESENT, &host->flags)) {
-			if (mmc->caps & MMC_CAP_NEEDS_POLL) {
-				dev_info(&mmc->class_dev,
-					"card is polling.\n");
-			} else {
-				dev_info(&mmc->class_dev,
-					"card is non-removable.\n");
-			}
-			set_bit(DW_MMC_CARD_PRESENT, &host->flags);
-		}
-
-		return present;
-	} else if (gpio_cd >= 0)
-		present = gpio_cd;
-	else
-		present = (mci_readl(host, CDETECT) & BIT(0))
-			== 0 ? 1 : 0;
+	if (!mmc_card_is_removable(mmc))
+		return 1;
 
-	spin_lock_bh(&host->lock);
-	if (present && !test_and_set_bit(DW_MMC_CARD_PRESENT, &host->flags))
-		dev_dbg(&mmc->class_dev, "card is present\n");
-	else if (!present &&
-			!test_and_clear_bit(DW_MMC_CARD_PRESENT, &host->flags))
-		dev_dbg(&mmc->class_dev, "card is not present\n");
-	spin_unlock_bh(&host->lock);
+	/* Try slot gpio detection */
+	if (gpio_cd >= 0)
+		return !!gpio_cd;
 
-	return present;
+	/* Host native card detect */
+	return !(mci_readl(host, CDETECT) & BIT(0));
 }
 
 static void dw_mci_adjust_fifoth(struct dw_mci *host, struct mmc_data *data)
@@ -2918,6 +2897,11 @@ static int dw_mci_init_host(struct dw_mci *host)
 		mmc->max_seg_size = mmc->max_req_size;
 	}
 
+	if (mmc->caps & MMC_CAP_NEEDS_POLL)
+		dev_info(&mmc->class_dev, "card is polling.\n");
+	else if (!mmc_card_is_removable(mmc))
+		dev_info(&mmc->class_dev, "card is non-removable.\n");
+
 	dw_mci_get_cd(mmc);
 
 	ret = mmc_add_host(mmc);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 5c17bcc..6800e7c 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -240,11 +240,10 @@ struct dw_mci {
 #endif
 	struct mmc_host		*mmc;
 	unsigned long		flags;
-#define DW_MMC_CARD_PRESENT	0
-#define DW_MMC_CARD_NEED_INIT	1
-#define DW_MMC_CARD_NO_LOW_PWR	2
-#define DW_MMC_CARD_NO_USE_HOLD 3
-#define DW_MMC_CARD_NEEDS_POLL	4
+#define DW_MMC_CARD_NEED_INIT	0
+#define DW_MMC_CARD_NO_LOW_PWR	1
+#define DW_MMC_CARD_NO_USE_HOLD 2
+#define DW_MMC_CARD_NEEDS_POLL	3
 	u32			ctype;
 	unsigned int		clock;
 	unsigned int		clk_old;
-- 
2.7.4

