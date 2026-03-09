Received: from mail-m8197.xmail.ntesmail.com (mail-m8197.xmail.ntesmail.com [156.224.81.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B3F17993
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 04:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.81.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773029099; cv=none; b=ChnyH6vxY0SaUyAJFMSXl9W+lkpXmz2aCKInUAz6UxOHiBDmDPqAacNxjKwnTX0QVVBLD30OwLEsFNfa4e7bAZXSgMCAwNPEuF21Kf/VY/xykG7cLGv0PQxvRD0RTUu1m3GHgHHDGjbaAn8rzHe1AFOIl2IQNtzpLeKKTkBq+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773029099; c=relaxed/simple;
	bh=vhTKfmJsBZNkvnH21gzDPu/ucRk/oispG6if9A/y2mA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NXTzpZUNyHY9UIaRE59Jei6zi667rUYzhpiXzrTO2jVHPQHNBhmScYkODHKL2ACmHSru4feKl7VMMg7utR9r9miXlRa3Kt7HhRFWh8QJ9Uw1u6c96CZLlossxg8UP05OphlqdZd7Ma7QgeR4mljvFTBbMnq/jgvdOwZURfH/TP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=WgGzW8ab; arc=none smtp.client-ip=156.224.81.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="WgGzW8ab"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 363147917;
	Mon, 9 Mar 2026 11:29:28 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/3] mmc: dw_mmc-rockchip: Add phase map support
Date: Mon,  9 Mar 2026 11:29:03 +0800
Message-Id: <1773026943-111633-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1773026943-111633-1-git-send-email-shawn.lin@rock-chips.com>
References: <1773026943-111633-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9cd0a4824709cckunm2100c80115ef32a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUsfT1ZKTx5IT00fTR4fHhlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=WgGzW8abesGFh9oR765J1VaMLti7Y58/5mXfxfZ/MGLS7vvkbc2hs+ryCY57+YH2Ub0SuPwwqMU7F2TKObwZkxDBlqPj28CDVyDZq7+2nNxWvOhPthRo3zHVXyZ2wBbl3CRX417U08YswR94Rd8N2XNTD+uOK1ZnIUCvUcw7384=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=mlM35uqN2yUhjHZ4GGat8HwhQ4cccNIP8fSMoinlNo4=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Multiple boards require different phase settings, rendering the default
phase policy unscalable. Therefore, we introduce phase map to address this
limitation. To preserve backward compatibility, the default_sample_phase
and original drv phase for different modes are retained, with phase map
values taking precedence when available.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/host/dw_mmc-rockchip.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 7699541..c6eece4 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -179,7 +179,8 @@ static int rockchip_mmc_set_phase(struct dw_mci *host, bool sample, int degrees)
 static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
 	struct dw_mci_rockchip_priv_data *priv = host->priv;
-	int ret;
+	struct mmc_clk_phase phase = host->phase_map.phase[ios->timing];
+	int ret, sample_phase, drv_phase;
 	unsigned int cclkin;
 	u32 bus_hz;
 
@@ -213,8 +214,15 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	}
 
 	/* Make sure we use phases which we can enumerate with */
-	if (!IS_ERR(priv->sample_clk) && ios->timing <= MMC_TIMING_SD_HS)
-		rockchip_mmc_set_phase(host, true, priv->default_sample_phase);
+	if (!IS_ERR(priv->sample_clk)) {
+		/* Keep backward compatibility */
+		if (ios->timing <= MMC_TIMING_SD_HS) {
+			sample_phase = phase.valid ? phase.in_deg : priv->default_sample_phase;
+			rockchip_mmc_set_phase(host, true, sample_phase);
+		} else if (phase.valid) {
+			rockchip_mmc_set_phase(host, true, phase.in_deg);
+		}
+	}
 
 	/*
 	 * Set the drive phase offset based on speed mode to achieve hold times.
@@ -243,15 +251,13 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	 * same results, for instance).
 	 */
 	if (!IS_ERR(priv->drv_clk)) {
-		int phase;
-
 		/*
 		 * In almost all cases a 90 degree phase offset will provide
 		 * sufficient hold times across all valid input clock rates
 		 * assuming delay_o is not absurd for a given SoC.  We'll use
 		 * that as a default.
 		 */
-		phase = 90;
+		drv_phase = 90;
 
 		switch (ios->timing) {
 		case MMC_TIMING_MMC_DDR52:
@@ -261,7 +267,7 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 			 * to get the same timings.
 			 */
 			if (ios->bus_width == MMC_BUS_WIDTH_8)
-				phase = 180;
+				drv_phase = 180;
 			break;
 		case MMC_TIMING_UHS_SDR104:
 		case MMC_TIMING_MMC_HS200:
@@ -273,11 +279,14 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 			 * SoCs measured this seems to be OK, but it doesn't
 			 * hurt to give margin here, so we use 180.
 			 */
-			phase = 180;
+			drv_phase = 180;
 			break;
 		}
 
-		rockchip_mmc_set_phase(host, false, phase);
+		/* Use out phase from phase map first */
+		if (phase.valid)
+			drv_phase = phase.out_deg;
+		rockchip_mmc_set_phase(host, false, drv_phase);
 	}
 }
 
-- 
2.7.4

