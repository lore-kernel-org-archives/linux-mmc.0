Received: from mail-m49216.qiye.163.com (mail-m49216.qiye.163.com [45.254.49.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C12F37F720;
	Fri, 23 Jan 2026 01:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132844; cv=none; b=QGRCeCGRMq6mDqEemRap2SwF9NNk5gTUNy9gFF9+3iCOSN1pGnC7XvrfSuRLJDTQHZT5cMLRssrhCSyCq48TJ3fD7F/Nt3yDOuCONy1eZ0jbyx/+SfuUuceDofZbIs9/NHV96/G0a161YjTa/mmn/B/3vpgfEX6JOj8u5/81Qe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132844; c=relaxed/simple;
	bh=xQ8YJwn8cs2dD60QOHeLbpja+J3iuPtQ6c7j58mmFfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Qqn8on9FqimYOUJEiA5YwLu9oLmnnlSliQADdWOBH04+iBpP7sMEQyGVgaWdB2rXqEvstuNKyEQxNfsBLLEWFvXDo6CJxA733hwLuFe2+MiqtueM6BfbCXFUhZbhzuT5GIngkIGCA4ZpJ0mNaygV+aFG8NWD59DY00V95VCLtX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=e68KdPbi; arc=none smtp.client-ip=45.254.49.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="e68KdPbi"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31a9def00;
	Fri, 23 Jan 2026 09:41:40 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Wei Xu <xuwei5@hisilicon.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/3] mmc: dw_mmc-k3: Remove mshc alias support
Date: Fri, 23 Jan 2026 09:41:20 +0800
Message-Id: <1769132482-177365-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1769132482-177365-1-git-send-email-shawn.lin@rock-chips.com>
References: <1769132482-177365-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9be883a62e09cckunmb02720d31387e9
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxgfHlYeGEpNGElJQk1MGUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=e68KdPbiYkIKbF92hL/FOWiu7yy5bjEDbs0IcaChqXS4yDKrgMMokd79sHgmLCo+Vb0jkQVS3FKLoqVySx5u5L1pDpCTaOxjwT0i07N0Nc7BEtV8Z2BzXv+ajQqbdHxxUjtRBciZSKrIFnEUWpMsE0pJ2u3KornQXPNPSMyRj/4=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=CqCqQBJ01IQMne5KBahAyEhEAzJwQ8xXLs3vSgnf9jw=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Remove the long-deprecated mshc alias support, as the mmc core already
provides alias functionality through the standard mmc alias. This eliminates
the redundant dual-alias system. The driver now obtains the controller ID
from struct mmc_host::index(supplied by mmc alias) instead of the legacy mshc
alias.

dw_mci_hi6220_parse_dt() which parses mshc alias is used for hi6220, hi3660 and
hi3670. Given hi6220 never assigned mshc alias on the DTS files, and hi3360
and hi3670 share the same code, so with it removed, add a return value to
dw_mci_hs_set_timing() and let dw_mci_hi3660_init() check if index exceeds
TIMING_MODE in the firs place to bail out early, the same as before.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-k3.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 23c3031..4d52033 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -53,7 +53,6 @@
 #define USE_DLY_MAX_SMPL (14)
 
 struct k3_priv {
-	int ctrl_id;
 	u32 cur_speed;
 	struct regmap	*reg;
 };
@@ -127,13 +126,6 @@ static int dw_mci_hi6220_parse_dt(struct dw_mci *host)
 	if (IS_ERR(priv->reg))
 		priv->reg = NULL;
 
-	priv->ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
-	if (priv->ctrl_id < 0)
-		priv->ctrl_id = 0;
-
-	if (priv->ctrl_id >= TIMING_MODE)
-		return -EINVAL;
-
 	host->priv = priv;
 	return 0;
 }
@@ -211,7 +203,7 @@ static const struct dw_mci_drv_data hi6220_data = {
 	.execute_tuning		= dw_mci_hi6220_execute_tuning,
 };
 
-static void dw_mci_hs_set_timing(struct dw_mci *host, int timing,
+static int dw_mci_hs_set_timing(struct dw_mci *host, int timing,
 				     int smpl_phase)
 {
 	u32 drv_phase;
@@ -223,7 +215,10 @@ static void dw_mci_hs_set_timing(struct dw_mci *host, int timing,
 	struct k3_priv *priv;
 
 	priv = host->priv;
-	ctrl_id = priv->ctrl_id;
+	ctrl_id = host->mmc->index;
+
+	if (ctrl_id >= TIMING_MODE)
+		return -EINVAL;
 
 	drv_phase = hs_timing_cfg[ctrl_id][timing].drv_phase;
 	smpl_dly   = hs_timing_cfg[ctrl_id][timing].smpl_dly;
@@ -260,6 +255,8 @@ static void dw_mci_hs_set_timing(struct dw_mci *host, int timing,
 
 	/* We should delay 1ms wait for timing setting finished. */
 	usleep_range(1000, 2000);
+
+	return 0;
 }
 
 static int dw_mci_hi3660_init(struct dw_mci *host)
@@ -267,10 +264,9 @@ static int dw_mci_hi3660_init(struct dw_mci *host)
 	mci_writel(host, CDTHRCTL, SDMMC_SET_THLD(SDCARD_RD_THRESHOLD,
 		    SDMMC_CARD_RD_THR_EN));
 
-	dw_mci_hs_set_timing(host, MMC_TIMING_LEGACY, -1);
 	host->bus_hz /= (GENCLK_DIV + 1);
 
-	return 0;
+	return dw_mci_hs_set_timing(host, MMC_TIMING_LEGACY, -1);
 }
 
 static int dw_mci_set_sel18(struct dw_mci *host, bool set)
@@ -407,7 +403,7 @@ static int dw_mci_hi3660_switch_voltage(struct dw_mci *host,
 	if (!priv || !priv->reg)
 		return 0;
 
-	if (priv->ctrl_id == DWMMC_SDIO_ID)
+	if (mmc->index == DWMMC_SDIO_ID)
 		return 0;
 
 	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
-- 
2.7.4

