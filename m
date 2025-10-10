Received: from mail-m32100.qiye.163.com (mail-m32100.qiye.163.com [220.197.32.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1853D76
	for <linux-mmc@vger.kernel.org>; Fri, 10 Oct 2025 03:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067771; cv=none; b=rPtVVgiUFLqEA6UBHX55qzVkyLor4iVCdzjbmwvA/cQAUeWFGPyOOdi8G0D2LZinTMXfdizWmkUylnhC3K6iLJYnvWx5FsVVK/uZwcfBTpoUteQ2MYGISsR8S5SaR5t9sWl5Jmk3TYWELxBqtGFu+aWC9RCVEelty/9oS/8QX3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067771; c=relaxed/simple;
	bh=iS/uuiwFxFED4/pB2vSFfLcnsasy6gS9pQJtJltu6AI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rFPY4rG+aqwUl2Wel1StOPauLV4tT5au4LA/8vrKWuD8AWFywHAXT1jGbulWZl4vqvLIqzJKe8mnYNzMsAAbNQhRCObru+tnSWBLBAn9rSe0OAeon0/fhw70I1uXILzJo50fGW0yeLBwD/uf7/ztTC5t8+5Lk75lHf2hdl4GT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=RQZ6bmPe; arc=none smtp.client-ip=220.197.32.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="RQZ6bmPe"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 25653ab13;
	Fri, 10 Oct 2025 11:37:33 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
	linux-mmc@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc: Use dma_set_mask_and_coherent() helper
Date: Fri, 10 Oct 2025 11:37:25 +0800
Message-Id: <1760067445-165115-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a99cc3202b009cckunm3d0281e8e356f7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhlNGVZLS0hJSRlLSENJSEpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=RQZ6bmPef42V3o662gYLiAJvHwQrsavq54f0rDyJwMG0sY0pipYXDllGdWgQpje5LrbLn56StZ7dAibPX5xB/a3UlbBz4JZo+zO0R2bkDkAiaG//qioVEiZFn/8MBHuD53vyyrLxq1nvWgbWirOyf6uSOWmTsCK1rl8UfQuX1rc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=w2thKE68u2NosGxcHMYO5X/UsCJimUu0uTwiqtLhc8M=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Use dma_set_mask_and_coherent() instead. No functional changes.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c5db92b..c4f5f44 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3120,9 +3120,8 @@ static void dw_mci_init_dma(struct dw_mci *host)
 			host->dma_64bit_address = 1;
 			dev_info(host->dev,
 				 "IDMAC supports 64-bit address mode.\n");
-			if (!dma_set_mask(host->dev, DMA_BIT_MASK(64)))
-				dma_set_coherent_mask(host->dev,
-						      DMA_BIT_MASK(64));
+			if (dma_set_mask_and_coherent(host->dev, DMA_BIT_MASK(64)))
+				dev_info(host->dev, "Fail to set 64-bit DMA mask");
 		} else {
 			/* host supports IDMAC in 32-bit address mode */
 			host->dma_64bit_address = 0;
-- 
2.7.4

