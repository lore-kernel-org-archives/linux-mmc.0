Received: from mail-m21470.qiye.163.com (mail-m21470.qiye.163.com [117.135.214.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCF034FF76
	for <linux-mmc@vger.kernel.org>; Tue, 16 Dec 2025 11:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886176; cv=none; b=AmBUUVcqEhk8HACBq4efigtZXpFa5zv7Bvo1+IKjOxUaFsbbRWHMOwTvHzFzCpYYGdGt2SDIZgfXw0A78duATMpVbm+moHm5+i88qOhF/+5WfxQ1lNUjwG/CwvIAchGEB7bBYvzrE8oeHxC12jI/p4UUkriseEYnXkqvpuoLlEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886176; c=relaxed/simple;
	bh=dciZmOjXza+HqyWhNTgyy7PM0i797m9+8WNWi4m0A6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hyjvopuVNFcblpw+f0eS0URoQicOP8cbgoC0KPWRcGZDsbRUEa1ocznt/0HWpnICRGh9Hh0onzV/AIGoPOJIx6nn3DSD6EqEx7kBjnQURk1ooWzHGPRZjDnnC+Gtd7kgW8RPP9Wo+Z1LavcHXogJFeajS+6FL3vkbZYSYQSfEx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XYfbd5+h; arc=none smtp.client-ip=117.135.214.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XYfbd5+h"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2d6f8a831;
	Tue, 16 Dec 2025 19:50:56 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 02/12] mmc: dw_mmc: Remove check before calling mmc_regulator_set_ocr()
Date: Tue, 16 Dec 2025 19:49:57 +0800
Message-Id: <1765885807-186577-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
References: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b26ffc96b09cckunmc1d96abd3f99ef
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkIeGlYfSUJIGR4eS04aSkxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XYfbd5+hhrCmxTCQN8Dk2ubX8yIar9A8c7VFzZ5i2PAmu447IkTbpKWgr4sWaPOeDmx3JLBWk83ybw2iuxnxJ6a97fQTD0OcmHtwLKugOwa5DYq8hXX3Du7+U8Sihl0OMK4BWgu66WrjlPQyNpi9tBfrxvN22kmrs8K2ygzayhw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=uNe2QZneAO61qeVCHchDm+sprbdWb5LJUHcvHqfDWD4=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

mmc_regulator_set_ocr() already checks if vqmmc is correct.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 560bff0..fe20ea62 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1424,15 +1424,10 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
-		if (!IS_ERR(mmc->supply.vmmc)) {
-			ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
-					ios->vdd);
-			if (ret) {
-				dev_err(slot->host->dev,
-					"failed to enable vmmc regulator\n");
-				/*return, if failed turn on vmmc*/
-				return;
-			}
+		ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
+		if (ret) {
+			dev_err(slot->host->dev, "failed to enable vmmc regulator\n");
+			return;
 		}
 		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
 		regs = mci_readl(slot->host, PWREN);
-- 
2.7.4

