Received: from mail-m49204.qiye.163.com (mail-m49204.qiye.163.com [45.254.49.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07D30DEA6
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066611; cv=none; b=PfhMYI+969JFfyc6Yvgm6DO4tfVsf2gjhwxxDQTQP5fjdyanOrCAwfhjUT8FD0fycgltypHnpbr1SsTZfAVGsUJG2ODHPgTVfbiwFynC6sL37MRqNLKcmZ5Oi9YP5tt2ZXdnPZHus0rFi06TGcjDU0r47OU8D0xbiUiHs3HCyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066611; c=relaxed/simple;
	bh=9EggsUITJ+KFUi+nWETECtbzoscBS8ocD3JNpwE0zUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WlIs64lsF2U9N0BNwoSbkK5MXv1MwGkOD3qN05AyFIcMKG5PMXAV07zfVrnt7WTm1MjPzd4PLvIW3QxtpknbhOkDyh6sG6xMEeDSJRxyri+aDJCngbwdg6Hs6raCEBdg4UhZL8C/9UtSHxXpp50FSDxJPxeiUtpb9v9Lj0gYKwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=L+xjAzL2; arc=none smtp.client-ip=45.254.49.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="L+xjAzL2"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb346;
	Thu, 18 Dec 2025 22:03:18 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 06/18] mmc: dw_mmc: Move rstc from struct dw_mci_board to struct dw_mci
Date: Thu, 18 Dec 2025 22:00:33 +0800
Message-Id: <1766066445-14144-7-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c5b1ae09cckunm1f354c4b73c5
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRhLGVZPTUhPGhgdGhhOSEhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=L+xjAzL2LMYzvjMpWTBA7o2LCQJTP44zxexnXRX+46E7ffdsh8hEqPxr4CBIfCGzjSYFPb4QWRhbezIO5DHnmwWkni4ef0CvCS+WfOJ2DP/8pL6ukLYUmWSjdoBE7eXoN03XTFfPB5aYYimtWmPeY5odwW1x8niyfVBiAYU+NUk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=lEXBjQg+LSIKuq7C4x9ipNBcti3wc5J3uyFMCk+IK1I=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Nobody using dw_mci_board passes in rstc, move it to the common struct
dw_mci needed by all users.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 16 ++++++++--------
 drivers/mmc/host/dw_mmc.h |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 650f84a..133da87 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3178,9 +3178,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 		return ERR_PTR(-ENOMEM);
 
 	/* find reset controller when exist */
-	pdata->rstc = devm_reset_control_get_optional_exclusive(dev, "reset");
-	if (IS_ERR(pdata->rstc))
-		return ERR_CAST(pdata->rstc);
+	host->rstc = devm_reset_control_get_optional_exclusive(dev, "reset");
+	if (IS_ERR(host->rstc))
+		return ERR_CAST(host->rstc);
 
 	if (device_property_read_u32(dev, "fifo-depth", &pdata->fifo_depth))
 		dev_info(dev,
@@ -3295,10 +3295,10 @@ int dw_mci_probe(struct dw_mci *host)
 		goto err_clk_ciu;
 	}
 
-	if (host->pdata->rstc) {
-		reset_control_assert(host->pdata->rstc);
+	if (host->rstc) {
+		reset_control_assert(host->rstc);
 		usleep_range(10, 50);
-		reset_control_deassert(host->pdata->rstc);
+		reset_control_deassert(host->rstc);
 	}
 
 	if (drv_data && drv_data->init) {
@@ -3439,7 +3439,7 @@ int dw_mci_probe(struct dw_mci *host)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
-	reset_control_assert(host->pdata->rstc);
+	reset_control_assert(host->rstc);
 
 err_clk_ciu:
 	clk_disable_unprepare(host->ciu_clk);
@@ -3467,7 +3467,7 @@ void dw_mci_remove(struct dw_mci *host)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
-	reset_control_assert(host->pdata->rstc);
+	reset_control_assert(host->rstc);
 
 	clk_disable_unprepare(host->ciu_clk);
 	clk_disable_unprepare(host->biu_clk);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 206c2a4..96fe923 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -131,6 +131,7 @@ struct dw_mci_dma_slave {
  * @clock: Clock rate configured by set_ios(). Protected by host->lock.
  * @clk_old: The last clock value that was requested from core.
  * @pdev: platform_device registered
+ * @rstc: Reset controller for this host.
  *
  * Locking
  * =======
@@ -250,6 +251,7 @@ struct dw_mci {
 	unsigned int		clock;
 	unsigned int		clk_old;
 	struct platform_device	*pdev;
+	struct reset_control *rstc;
 };
 
 /* DMA ops for Internal/External DMAC interface */
@@ -277,8 +279,6 @@ struct dw_mci_board {
 
 	/* delay in mS before detecting cards after interrupt */
 	u32 detect_delay_ms;
-
-	struct reset_control *rstc;
 };
 
 /* Support for longer data read timeout */
-- 
2.7.4

