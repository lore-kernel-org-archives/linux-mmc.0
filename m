Received: from mail-m1973174.qiye.163.com (mail-m1973174.qiye.163.com [220.197.31.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1812FE583
	for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2025 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763636728; cv=none; b=nMTzn9sadCkeeTJM5pDzFi2+LxtsI0BLLxZxboDRQ+sB3vc4Q77+ueZi4+DGZog9NOcV/lM8dKbSRP/UYhMhvp62Ox4aCTDkZpMvGEOubYMKYu8R1x242LDGMYRGw3dSGh0VPGFDC4KFqpY0R7xNgSTa+57E2AupQSGW7p1IcW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763636728; c=relaxed/simple;
	bh=6TGZlfdtbqzxdIZ9stPPR0IkjqvPadypq9DAKGgp2Nw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hgXEDOzhs+iatePK999dEpPAyx9QdPN+TeXsLb93mc2KWtrDkl0xQDtCfPsFo/sXIQLNGz0HXRaqf9xVgLDD0xd6oSp0x/rcjJ5XShpi1FLwKSIWUJI7ZMZ/ggSHyoHRrGatizbXdrGYrSw6vCxfP+fw9zCTV76Aj60YL+9gSos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=C2O1GeoJ; arc=none smtp.client-ip=220.197.31.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="C2O1GeoJ"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a49599a9;
	Thu, 20 Nov 2025 18:29:50 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 01/13] mmc: dw_mmc: Remove unused struct dma_pdata
Date: Thu, 20 Nov 2025 18:29:13 +0800
Message-Id: <1763634565-183891-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
References: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9aa0d0348509cckunma871e903175099
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUMfTlYaSUhITUlDSh8fTk1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=C2O1GeoJsvXGhhMDJMlOta9Ak+5YUB9GCzH6lPl0ffiyviX/WMLmqSlp+VX/wUvWIkkvjL0OXm7eAIwIkkZL+X+Wd6AqzgDhvfXnPcWwD1yhnxX73MRBVeT7llim722qPyTsQi5G4nYmdH4xRkd/K6Ez+wtmlkANva8Aa0qU2Hw=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=IC39oXDrZvtwm/c+t0O3c0/6ZUWMXbfTaoIexwvzyhc=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

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

