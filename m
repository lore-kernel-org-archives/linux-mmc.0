Received: from mail-m32100.qiye.163.com (mail-m32100.qiye.163.com [220.197.32.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D86285CA9;
	Fri, 23 Jan 2026 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769171382; cv=none; b=MZ9FgrO5lwQSeE7K5Rho5SoK87CDlsPo+YFsEnPDqSSnj9PSw8qu1Bsa7LkZTaYfuRyhbO0wqgC6DmjRtnPyzN/MFzl6PFnnIxgwDCZ/Ubd95RSmuXDtxQRe6D4OTo2UQNY0gjlSIGkS43JUunqN/necJRNHNYqAmA48fS/3/nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769171382; c=relaxed/simple;
	bh=sJFbzS2KYnvKubOf6HuPygbUAU2HDW1cK4RIDcKRVU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JaatUbzdvp0cPbAS6o85MTty9dEEXC0hvWy4kvGF3P2IulOxjVuiohgCdgXwhYOXtScG+D0JHt52Rx3+9duYUCQAEYHT/i6+r+qBm7KRMlY7oOtWSIjQZ7l0DJDzDXVr6qdoRtyI8R7UQit2uODayARKhSWX7BE4aDzM4Pv9MJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Nbthz/Vj; arc=none smtp.client-ip=220.197.32.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Nbthz/Vj"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31c0b4b0d;
	Fri, 23 Jan 2026 20:24:27 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Wei Xu <xuwei5@hisilicon.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/3] mmc: dw_mmc-k3: Remove mshc alias support
Date: Fri, 23 Jan 2026 20:24:08 +0800
Message-Id: <1769171049-74327-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1769171049-74327-1-git-send-email-shawn.lin@rock-chips.com>
References: <1769171049-74327-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9bead022e109cckunm9fc1f74e1df6fe
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hDGFYZQ0lJGh5NT09MSEhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Nbthz/VjjV5MWWAnKMm3RNUjFRVi0zIwDy/ZbpuoxmG+MsTs9OIvq1AKYVRCdq4u3h0e4FdjnwKfW/J7gfKiznCpNSleRP29e0SBHO4AGNiFXa8gfxjH1RrgKU7jREK7sNqaQ4yPrVseZG+4GpiI/OmPe29PiMlIcKWeyi7pHKk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=ooZZaEXJ/oZlBNinH/rLcCvfRO5xbkVU8aMpX+rwdZg=;
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

dw_mci_hi6220_parse_dt() which parse mshc alias is used for hi6220, hi3660 and
hi3670. Given hi6220 never assigned mshc alias on the DTS files, and hi3360
and hi3670 share the same code, so with it removed, add a return value to
dw_mci_hs_set_timing() and let dw_mci_hi3660_init() check if index exceeds
TIMING_MODE in the firs place to bail out early, the same as before.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2:
- Fix a warning(lkp)

 drivers/mmc/host/dw_mmc-k3.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 23c3031..e7b3613 100644
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
@@ -220,10 +212,10 @@ static void dw_mci_hs_set_timing(struct dw_mci *host, int timing,
 	u32 enable_shift = 0;
 	u32 reg_value;
 	int ctrl_id;
-	struct k3_priv *priv;
 
-	priv = host->priv;
-	ctrl_id = priv->ctrl_id;
+	ctrl_id = host->mmc->index;
+	if (ctrl_id >= TIMING_MODE)
+		return -EINVAL;
 
 	drv_phase = hs_timing_cfg[ctrl_id][timing].drv_phase;
 	smpl_dly   = hs_timing_cfg[ctrl_id][timing].smpl_dly;
@@ -260,6 +252,8 @@ static void dw_mci_hs_set_timing(struct dw_mci *host, int timing,
 
 	/* We should delay 1ms wait for timing setting finished. */
 	usleep_range(1000, 2000);
+
+	return 0;
 }
 
 static int dw_mci_hi3660_init(struct dw_mci *host)
@@ -267,10 +261,9 @@ static int dw_mci_hi3660_init(struct dw_mci *host)
 	mci_writel(host, CDTHRCTL, SDMMC_SET_THLD(SDCARD_RD_THRESHOLD,
 		    SDMMC_CARD_RD_THR_EN));
 
-	dw_mci_hs_set_timing(host, MMC_TIMING_LEGACY, -1);
 	host->bus_hz /= (GENCLK_DIV + 1);
 
-	return 0;
+	return dw_mci_hs_set_timing(host, MMC_TIMING_LEGACY, -1);
 }
 
 static int dw_mci_set_sel18(struct dw_mci *host, bool set)
@@ -407,7 +400,7 @@ static int dw_mci_hi3660_switch_voltage(struct dw_mci *host,
 	if (!priv || !priv->reg)
 		return 0;
 
-	if (priv->ctrl_id == DWMMC_SDIO_ID)
+	if (mmc->index == DWMMC_SDIO_ID)
 		return 0;
 
 	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
-- 
2.7.4

