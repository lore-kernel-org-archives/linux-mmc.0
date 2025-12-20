Received: from mail-m19731106.qiye.163.com (mail-m19731106.qiye.163.com [220.197.31.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B8D27CB04
	for <linux-mmc@vger.kernel.org>; Sat, 20 Dec 2025 05:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766208453; cv=none; b=B5ELl+gd8t1WPnSN8LHCcXJwmwdFY0zXge0uSw/cSwFH1vuyX+4T2VOfpKxnPdP8K61VaenJG2BxWeL+iMaP6x+5Q/oTkZHNBkov7L0PrwU/KaQ5TuGHIPUw9QWnb7aKiRHcygnqDVlqJQdyWN4Xj/ubsqK17at4EoV0Et3qYv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766208453; c=relaxed/simple;
	bh=7YC/H9GGj7mF778ww7gqa5j9INBuooDA1ms++vBE0c0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=kzkuTnVrGINP993SPH3J9JovlVkrlayEL7xOhDiDsu/isWS05EiOMOeUfnyZZVny8Zx0M4tLnQP871HzMR2nEE/C9WcI3vO/DamZeh+ffQuqKvJ+1mfrPyLhhXCNcVi/0gTQiDlJCtOStd4juvXyRhc0ei2Wo5u2/6cCZ/MS+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=YH9eG7is; arc=none smtp.client-ip=220.197.31.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="YH9eG7is"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2df4584da;
	Sat, 20 Dec 2025 13:22:16 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 1/2] mmc: dw_mmc: Introduce dw_mci_alloc_host()
Date: Sat, 20 Dec 2025 13:22:05 +0800
Message-Id: <1766208126-42506-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9b3a35621909cckunme03d6958113b62
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkpNT1YaQhgeHUlNGh1MTB9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=YH9eG7isCKOBX6llPaLAOH+GZPaTWVcxlUYgbmedKSvb+3a6/JQg1QptYynMj7N+mADvnwZr0SnGRl8xc98ulJcjTuxBf8JKkBy/bY4RLm3KCF8+xSfxU4NA7j5iE8BvqmYsXRuBzvyaQKQ4RTBloEy1kL8dXKY57DayjfcwybE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=Ly8UL67EjEZi3t5BpTvVMXO2HfUT525wJnFxlVsDpKQ=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

This helper is used for variant drivers to allocate struct dw_mci
and set struct dw_mci as private data of struct mmc_host.

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 17 +++++++++++++++++
 drivers/mmc/host/dw_mmc.h |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 82309cd..2f3c08c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3258,6 +3258,23 @@ static void dw_mci_enable_cd(struct dw_mci *host)
 	}
 }
 
+struct dw_mci *dw_mci_alloc_host(struct device *dev)
+{
+	struct mmc_host *mmc;
+	struct dw_mci *host;
+
+	mmc = devm_mmc_alloc_host(dev, sizeof(struct dw_mci));
+	if (!mmc)
+		return ERR_PTR(-ENOMEM);
+
+	host = mmc_priv(mmc);
+	host->mmc = mmc;
+	host->dev = dev;
+
+	return host;
+}
+EXPORT_SYMBOL(dw_mci_alloc_host);
+
 int dw_mci_probe(struct dw_mci *host)
 {
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index d5e4e6d..892b545 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -544,6 +544,7 @@ static inline void mci_fifo_l_writeq(void __iomem *addr, u64 value)
 #define __raw_readq(__reg) (*(volatile u64 __force *)(__reg))
 #endif
 
+extern struct dw_mci *dw_mci_alloc_host(struct device *device);
 extern int dw_mci_probe(struct dw_mci *host);
 extern void dw_mci_remove(struct dw_mci *host);
 #ifdef CONFIG_PM
-- 
2.7.4

