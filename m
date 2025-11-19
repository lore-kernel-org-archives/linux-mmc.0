Received: from mail-m49221.qiye.163.com (mail-m49221.qiye.163.com [45.254.49.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8BF3203AA
	for <linux-mmc@vger.kernel.org>; Wed, 19 Nov 2025 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763540538; cv=none; b=s/4CQOXbz6kYolWRP0kecMPaVlrf0JGkob6LcfGANbPDmxvip3oNsF1tIeOHiY2boadywNBwXlAalC0Uh/BkKVtbCE9HsLYnwr0hLv9MnZMYEpNdrEpaD13EVzDcN/RbL1lATF+RYvEpgbXXyN3cCY96K3Tr5Uuf9R3Qq+cxzyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763540538; c=relaxed/simple;
	bh=w61JSqKDoYti3JcAAhaohWNg+7JjlnzN5GN8e9tmmaY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LlxPUGIpmpdaLdRJBE0/aw/7fk0t40XDWSFitLoouBqZ2fjV5gSpM8i7i8O1WvlpNT1mDkOTA+54iUKr2sYvNnJjTguSqlLOGvu9Oj/vuwkNfInIwDdp7yVSWAHFFh/vYcgySRf7y/oeYT9bD8bF6muDEMdCF47Btkm9ZVv7vzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=S/4diGDs; arc=none smtp.client-ip=45.254.49.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="S/4diGDs"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a1df4e30;
	Wed, 19 Nov 2025 16:22:03 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] mmc: dw_mmc: Remove unused struct dma_pdata
Date: Wed, 19 Nov 2025 16:21:37 +0800
Message-Id: <1763540498-84315-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9a9b34d72e09cckunm1538b04d9b757
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhkdQlZDTEIfSEhNSkhITh1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=S/4diGDsqbjB0NAQRPI7JaeyKfsjLjUNZxDFzXhANjZ0ZWDF6oZOrMM3t6b3BfxF6udNVKcIl9KIi/sIF4GhOORQSdsp8IbH+M86g/IuwJ+HmEMaAuyiuevn7U60FRJpDfD6Rk+Feoj85eHZ6T72IEk+FgAL7ivLpjhGxJqfCjU=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=WAzDTFFhVgysFvoM/cxO6xPU/fR2dn/vgcKN5p4+mtE=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Thers is no public user for it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 648b4a5..b4ceca0 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -255,8 +255,6 @@ struct dw_mci_dma_ops {
 	void (*exit)(struct dw_mci *host);
 };
 
-struct dma_pdata;
-
 /* Board platform data */
 struct dw_mci_board {
 	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
@@ -276,7 +274,6 @@ struct dw_mci_board {
 
 	struct reset_control *rstc;
 	struct dw_mci_dma_ops *dma_ops;
-	struct dma_pdata *data;
 };
 
 /* Support for longer data read timeout */
-- 
2.7.4

