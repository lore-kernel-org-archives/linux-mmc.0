Received: from mail-m128121.netease.com (mail-m128121.netease.com [103.209.128.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA31A22A4E1
	for <linux-mmc@vger.kernel.org>; Tue,  6 Jan 2026 02:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.209.128.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767667163; cv=none; b=C8B2E2s9LuoMfDxnkUXLuP0H8yywZTNgh1MQ31sIll8IWtdtajRKESkJi+IIQ9B/Q/ZytxuI61aM1B8McJ8fAoJgdY0suIiBdI3E0NJsZfzIzGdHKKoLIOFxd7Im3xf60CzsczJUSo9Nr9sBDxGPmhZ9ckmnUeJ3saIbR8x57hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767667163; c=relaxed/simple;
	bh=uj9XvzDRXnCcOTHs3OUQ06H+zcvTcTX6QqNQKNpI3JM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OoV3w4Fcavlr8vyWygf9xXSA3f+HDR6xsWNpVYw6mn3yh7/wyMpHzyyzd3fe2HrpdnxXJrLKnjK4q4RGUIcTQpvNyh6ydL2N1LAWzBYGFixxJoSnK8SGCBokBxD/XEKXZFuFUMMXO23Jz8BaJbd/jAuVHYqtzbhonoCZdhJek04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=gVHOjJ8j; arc=none smtp.client-ip=103.209.128.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="gVHOjJ8j"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f9c4ad42;
	Tue, 6 Jan 2026 10:23:58 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 14/18] mmc: dw_mmc: Remove unused register access macros
Date: Tue,  6 Jan 2026 10:17:05 +0800
Message-Id: <1767665829-183001-15-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b911e43f909cckunmc69ba49b79ce99
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUhPH1YdTBpKGEkeS0NMGk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=gVHOjJ8joDLGxaUsFoRs+DQfI6q9s1JVhC6Yx+LGTMzbeND3JdcHT0RqC8g/dGo0B/ILpN7Amz8u4QPfcOlot2lfmay8yaeAgSdsUSSKUgPH1zah5/pmZfAnJOyN0jsjSReKauwhFGkwSOxgar4diL1VRHF2AtyRwzoaYchrUSw=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=iG/yN2ChWi0Xi71qbUbdZP2GuzB7Qftc5s23LkU6j9o=;
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

Changes in v2:
- fix compile error

 drivers/mmc/host/dw_mmc.h | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 6800e7c..a4d5f4f 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -488,32 +488,7 @@ static inline void mci_fifo_l_writeq(void __iomem *addr, u64 value)
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
+#ifndef readq
 #define __raw_writeq(__value, __reg) \
 	(*(volatile u64 __force *)(__reg) = (__value))
 #define __raw_readq(__reg) (*(volatile u64 __force *)(__reg))
-- 
2.7.4

