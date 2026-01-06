Received: from mail-m83119.xmail.ntesmail.com (mail-m83119.xmail.ntesmail.com [156.224.83.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE38513FEE
	for <linux-mmc@vger.kernel.org>; Tue,  6 Jan 2026 02:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.83.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767666894; cv=none; b=PQbJBmvskdznFeuyCR+2DiG5kad+0yogqtjQ16FNKHmijQmRgN876oIKog+ZB69mvxP3S9nEcUqEriJdK/eAUyvfQa1O1gr7saLKHXBBlL+o0vi833bZkIRMsOEKCzTP6jjcG5cSNJ3fkSnVRoVW6d1sOsEKcyZDEHYS1Epenas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767666894; c=relaxed/simple;
	bh=A1zN3G3XIqL7s2ONYG82aeUJoa9XXXoOabNmK2l9RQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FPjAutjfNxGVMvonL74p4mxg02UVoFyN7yQM4ODaQfykZwj/d9p3+0PdaoSwSB4A/ere5PI9X62MJiVKItsBaz/Q9+a8YgRYUpulhbAMnqOKhEkRSBf5ghp/6Lh0KwLECTAvsSi9K699Mj/FhHBeRH17jfLNe8xPycOg1EjjLQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=VOsGyTXm; arc=none smtp.client-ip=156.224.83.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="VOsGyTXm"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f9c31bc7;
	Tue, 6 Jan 2026 10:19:26 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 06/18] mmc: dw_mmc: Move rstc from struct dw_mci_board to struct dw_mci
Date: Tue,  6 Jan 2026 10:16:57 +0800
Message-Id: <1767665829-183001-7-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b911a1c9809cckunmc69ba49b79bdcd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR9DHVZLQh9LGUNDTR9PSkhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE
	pVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=VOsGyTXm1rrm00XNH2vGlLF1dFwihR32cvu7RK8pgULhsazpchXXbtGmpzNfMcIX4Y9QmGdlzZmikdKyZoA8j7fyb9R0lsVScR3N1s04B4zkLPxHDd27p6m/Xs1Xndc/I01LiYZy1YpKA55Sud5rG2gS91kGDRYOMwDNzcBrf4s=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=fCQ2En02kElEUKN3zRdqUHMmsCYFfsjR2A7BhAL9G0g=;
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

Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 16 ++++++++--------
 drivers/mmc/host/dw_mmc.h |  6 ++++--
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3c616aa..c9e8165 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3166,9 +3166,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
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
@@ -3299,10 +3299,10 @@ int dw_mci_probe(struct dw_mci *host)
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
@@ -3443,7 +3443,7 @@ int dw_mci_probe(struct dw_mci *host)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
-	reset_control_assert(host->pdata->rstc);
+	reset_control_assert(host->rstc);
 
 err_clk_ciu:
 	clk_disable_unprepare(host->ciu_clk);
@@ -3470,7 +3470,7 @@ void dw_mci_remove(struct dw_mci *host)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
-	reset_control_assert(host->pdata->rstc);
+	reset_control_assert(host->rstc);
 
 	clk_disable_unprepare(host->ciu_clk);
 	clk_disable_unprepare(host->biu_clk);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 47775dd..3cac7ce 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -130,6 +130,8 @@ struct dw_mci_dma_slave {
  * @ctype: Card type for this host.
  * @clock: Clock rate configured by set_ios(). Protected by host->lock.
  * @clk_old: The last clock value that was requested from core.
+ * @pdev: platform_device registered
+ * @rstc: Reset controller for this host.
  *
  * Locking
  * =======
@@ -249,6 +251,8 @@ struct dw_mci {
 	u32			ctype;
 	unsigned int		clock;
 	unsigned int		clk_old;
+	struct platform_device	*pdev;
+	struct reset_control *rstc;
 };
 
 /* DMA ops for Internal/External DMAC interface */
@@ -276,8 +280,6 @@ struct dw_mci_board {
 
 	/* delay in mS before detecting cards after interrupt */
 	u32 detect_delay_ms;
-
-	struct reset_control *rstc;
 };
 
 /* Support for longer data read timeout */
-- 
2.7.4

