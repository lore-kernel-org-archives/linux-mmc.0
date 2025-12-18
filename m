Received: from mail-m1973170.qiye.163.com (mail-m1973170.qiye.163.com [220.197.31.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ACE2E040D
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066845; cv=none; b=uLn0uIkMGUcwqDVOWVPzqo/7A7RefdcWWo+/Fo6uqhz5ic3QsYuq4Kn8JclfbDQJFK+ynHw0QZxO0Z5qGrWTvFygKCZ9xN/eViQ+lRrzPikuMEowS6YygxPK5Rbr3tS6ETJnalyBgnY5dU22uAOUXuyDBoxxMfE8p0+eNRDpFVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066845; c=relaxed/simple;
	bh=afKC79fgDL/mdmJZaUzivDyKji5JTNygGr3024OUSDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BDeVPpcHmkruPGGr1174KQ6HTOhoTaewxLhbApWDAtRLPs6DRqofL4ygIa5305kgFz6FnrXcJT3wx1WroavSVYSzMWf/7K3v90PPvrb+ZiU+fCQiA5MAXBF/7Qy8PYyaBZu9h9Hhz6Yh+VYEo1/dleKb8wPL22Oq9EJSv9CRK+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=a2d6JVrj; arc=none smtp.client-ip=220.197.31.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="a2d6JVrj"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb4b7;
	Thu, 18 Dec 2025 22:07:18 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 18/18] mmc: dw_mmc: Implement Host Software Queue support
Date: Thu, 18 Dec 2025 22:00:45 +0800
Message-Id: <1766066445-14144-19-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c95aa009cckunm1f354c4b78fc
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh0fGFZNGUlDSk9MGE9KSkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=a2d6JVrjof8fqFZAygNaHCTG1rGci1PddECr73IGcWRwyOrVhp6SCbVIs8XeBjx0SKNJeb48UVXCq/4Vlp+XEZwHbOkaaHPQBipJDKzG+n3eCD7kLGymyCSJg6F3WSwYpbLRkU8XmwkfLdJ3ffaV4BBE7s3wGKonSbGtthIS198=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=E3WhQIT5I74jdmXNW2xeBhQpDWF6OSLb2In4Gb0398M=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Per tests done by different TF cards under 200MHz in HS200 mode,
the average random read/write is improved by 10% and 7% respectively,
while no obvious improvement for sequential read and write.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/host/Kconfig  |  1 +
 drivers/mmc/host/dw_mmc.c | 26 ++++++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 6d79cc9..c354a0e 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -790,6 +790,7 @@ config MMC_CAVIUM_THUNDERX
 config MMC_DW
 	tristate "Synopsys DesignWare Memory Card Interface"
 	depends on ARC || ARM || ARM64 || MIPS || RISCV || CSKY || COMPILE_TEST
+	select MMC_HSQ
 	help
 	  This selects support for the Synopsys DesignWare Mobile Storage IP
 	  block, this provides host support for SD and MMC interfaces, in both
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index d2b895b..557f9de 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -31,6 +31,7 @@
 #include <linux/regulator/consumer.h>
 
 #include "dw_mmc.h"
+#include "mmc_hsq.h"
 
 /* Common flag combinations */
 #define DW_MCI_DATA_ERROR_FLAGS	(SDMMC_INT_DRTO | SDMMC_INT_DCRC | \
@@ -1318,6 +1319,14 @@ static void dw_mci_queue_request(struct dw_mci *host, struct mmc_request *mrq)
 	}
 }
 
+static void dw_mci_request_done(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	if (mmc_hsq_finalize_request(mmc, mrq))
+		return;
+
+	mmc_request_done(mmc, mrq);
+}
+
 static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct dw_mci *host = mmc_priv(mmc);
@@ -1332,7 +1341,7 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	if (!dw_mci_get_cd(mmc)) {
 		mrq->cmd->error = -ENOMEDIUM;
-		mmc_request_done(mmc, mrq);
+		dw_mci_request_done(mmc, mrq);
 		return;
 	}
 
@@ -1780,7 +1789,7 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
 		host->state = STATE_IDLE;
 
 	spin_unlock(&host->lock);
-	mmc_request_done(prev_mmc, mrq);
+	dw_mci_request_done(prev_mmc, mrq);
 	spin_lock(&host->lock);
 }
 
@@ -3204,9 +3213,14 @@ int dw_mci_probe(struct dw_mci *host)
 {
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	struct dw_mci *local_host;
+	struct mmc_hsq *hsq;
 	int width, i, ret = 0;
 	u32 fifo_size;
 
+	hsq = devm_kzalloc(host->dev, sizeof(*hsq), GFP_KERNEL);
+	if (!hsq)
+		return dev_err_probe(host->dev, -ENOMEM, "hsq allocation failed\n");
+
 	ret = dw_mci_parse_dt(host);
 	if (ret)
 		return dev_err_probe(host->dev, ret, "parse dt failed\n");
@@ -3391,6 +3405,10 @@ int dw_mci_probe(struct dw_mci *host)
 	if (ret)
 		goto err_dmaunmap;
 
+	ret = mmc_hsq_init(hsq, local_host->mmc);
+	if (ret)
+		goto err_dmaunmap;
+
 	/* Now that host is all setup, we can enable card detect */
 	dw_mci_enable_cd(local_host);
 
@@ -3439,6 +3457,8 @@ int dw_mci_runtime_suspend(struct device *dev)
 {
 	struct dw_mci *host = dev_get_drvdata(dev);
 
+	mmc_hsq_suspend(host->mmc);
+
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
@@ -3509,6 +3529,8 @@ int dw_mci_runtime_resume(struct device *dev)
 	if (sdio_irq_claimed(host->mmc))
 		__dw_mci_enable_sdio_irq(host, 1);
 
+	mmc_hsq_resume(host->mmc);
+
 	/* Now that host is setup, we can enable card detect */
 	dw_mci_enable_cd(host);
 
-- 
2.7.4

