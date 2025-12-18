Received: from mail-m49226.qiye.163.com (mail-m49226.qiye.163.com [45.254.49.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50673226CEB
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067070; cv=none; b=eQ24dj1g4eYdhVrfNOX5X96yl8V0UnyIChv5bMovq4er8aPo8ajYr1zSAPzH7Q1B7EB67f4CnDajBu9NFcgLThljAicKjeN9yg7Ca+jC374PiizJuhGSTrEgoT/ptxpp2YOvgdRo/PuQnR0JZHq1x6rNs7BZMdt+KYTDZ8M24qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067070; c=relaxed/simple;
	bh=Dd+J7IvCLcx0NlALWlsgxw/pATOoV2Qr9xcFCi+69Gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UTFYgsvlI9fknrs9v+xm7GZGGaClPuykkHrRaefn//NbWvvjOHpP7FgGFzb7R/WGQwtCrxXv7ZZEfRhYxnQXgCIpjeLROfitR9T5vJM4zPEwnuzNKdj7rI8bvfUnK1Lh1g9vYX9ASw/1zvuoxU0FnEFNqG+Ir5zVkgrWrveXkao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FGoO1ba/; arc=none smtp.client-ip=45.254.49.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FGoO1ba/"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb43e;
	Thu, 18 Dec 2025 22:05:49 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 13/18] mmc: dw_mmc: Improve dw_mci_get_cd()
Date: Thu, 18 Dec 2025 22:00:40 +0800
Message-Id: <1766066445-14144-14-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c7ff4309cckunm1f354c4b774a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU9CQlZIH05IGkpNHR9IGkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=FGoO1ba/vInRj5T0/QdDjB4SCgcjuJaLWLPG4wxVYPndUHeWKVpD6lD9sO48aMnPL9JXzF196hOfazdIhOB/+WRrSzdwtTLtPXlxCRS0fOR30ytPqLtqjPd1/y0/hXE0ewPyq8tXOeKoxmppD86NtfzWjABXzPWX77Yy2wdvq1U=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=gwdXez/F57D9OhXGWEL8cw4ZqMhaB7c/FGfxRh3Om8E=;
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

 drivers/mmc/host/dw_mmc.c | 44 ++++++++++++++------------------------------
 drivers/mmc/host/dw_mmc.h |  9 ++++-----
 2 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index db21f36..bd8e810 100644
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
@@ -2930,6 +2909,11 @@ static struct dw_mci *dw_mci_init_host(struct dw_mci *host)
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
index 647517a..60dc333 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -239,11 +239,10 @@ struct dw_mci {
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

