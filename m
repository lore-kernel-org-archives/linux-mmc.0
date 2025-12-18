Received: from mail-m49208.qiye.163.com (mail-m49208.qiye.163.com [45.254.49.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8B9314D3D
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066782; cv=none; b=BGQBZZGKmOgBaaa/xWWNte5RAPwhIT8ro7odPsMbSTy4SHLAbTbEcxev7J43NX4p2meTwTNWkH0WCYoh23oQutPCkPNSW6vG98CXl09Nhj5TR3N8BV6DHz6kQNPeKMARoA6RZfmjuWXA3dnZwcVduHv6Oc/M0GAIxE92/L7SI3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066782; c=relaxed/simple;
	bh=CVx7xZeJuGvLoFo/7eAJxqFxQrLoCPe4hCc+7APBWYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GMJArC/VcNaZ+kaQmpwlT6bQ7ZNPv/WIzCDttxq5m14tl41OfU5Vk4H0osZcvO7GcP7x1TEzSu6NLsXS0ZzydRJEahGRcqgvlTl7psrk47LwCRilh6OHg5yW1993dIuRq1I7einGpIvF6/tm/dMyqMtcp64cik7Kh+8sIpvHnRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XkRgkRA6; arc=none smtp.client-ip=45.254.49.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XkRgkRA6"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb467;
	Thu, 18 Dec 2025 22:06:15 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 14/18] mmc: dw_mmc: Remove unused register access macros
Date: Thu, 18 Dec 2025 22:00:41 +0800
Message-Id: <1766066445-14144-15-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c864fb09cckunm1f354c4b77d4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh4aQlYZShhLGBkZT0hDQx5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XkRgkRA67J8Y6UQFsm9l0H4CaGEb+hnijnM5xS8AwGT471Nl99wL1hkn0bvWXHOJN/rlF1AXM2B15+iGzlaH7Yz2sg0aAmukDCHcz3YUCCS/WcgGpgiuEBdLrkTdFxUXw39fvlyZ6hupUpuuqYLZQH3Tn4vaVOTVDb9P7zrGZHQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Cs1mUukxMGqMKX/LbpefzQU3HVbarOW4Qwq7a266KC8=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The mci_readw/mci_writew/mci_readq/mci_writeq macros were added
to provide 16-bit and 64-bit register access operations, but they
have remained unused since their introduction. Remove these dead code.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.h | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 60dc333..efc97b9 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -487,37 +487,6 @@ static inline void mci_fifo_l_writeq(void __iomem *addr, u64 value)
 #define mci_writel(dev, reg, value)			\
 	writel_relaxed((value), (dev)->regs + SDMMC_##reg)
 
-/* 16-bit FIFO access macros */
-#define mci_readw(dev, reg)			\
-	readw_relaxed((dev)->regs + SDMMC_##reg)
-#define mci_writew(dev, reg, value)			\
-	writew_relaxed((value), (dev)->regs + SDMMC_##reg)
-
-/* 64-bit FIFO access macros */
-#ifdef readq
-#define mci_readq(dev, reg)			\
-	readq_relaxed((dev)->regs + SDMMC_##reg)
-#define mci_writeq(dev, reg, value)			\
-	writeq_relaxed((value), (dev)->regs + SDMMC_##reg)
-#else
-/*
- * Dummy readq implementation for architectures that don't define it.
- *
- * We would assume that none of these architectures would configure
- * the IP block with a 64bit FIFO width, so this code will never be
- * executed on those machines. Defining these macros here keeps the
- * rest of the code free from ifdefs.
- */
-#define mci_readq(dev, reg)			\
-	(*(volatile u64 __force *)((dev)->regs + SDMMC_##reg))
-#define mci_writeq(dev, reg, value)			\
-	(*(volatile u64 __force *)((dev)->regs + SDMMC_##reg) = (value))
-
-#define __raw_writeq(__value, __reg) \
-	(*(volatile u64 __force *)(__reg) = (__value))
-#define __raw_readq(__reg) (*(volatile u64 __force *)(__reg))
-#endif
-
 extern int dw_mci_probe(struct dw_mci *host);
 extern void dw_mci_remove(struct dw_mci *host);
 #ifdef CONFIG_PM
-- 
2.7.4

