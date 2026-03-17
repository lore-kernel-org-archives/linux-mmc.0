Received: from mail-m1973177.qiye.163.com (mail-m1973177.qiye.163.com [220.197.31.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0476821CA13;
	Tue, 17 Mar 2026 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773713717; cv=none; b=qWmbB7W6jKmT7sKdVhVXMNypP3hc2daJEkNgedEUuEbnamSkXysfbw7TlZkBPFpi0omyG1vlbrYIwd2flCmw++SfXLJQ4eAswzb7kSdm+CdHR+kFL2y68Yo3UdIkjR8jMnqilJsk7sy9Sn85InwYicayQgQCe6l15jOMY+fliqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773713717; c=relaxed/simple;
	bh=16IqvEOFAgSW0Yimn/G+M2Umd+ZhQ5JmB0YocnUh0eU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RgVfHxFYTbe7hk4IOSzCXZqKFCvAxh6xnDR4V8acwFyuygORPIEj+4cJc+loAekzN+01E/D2Sc0jIfiBeAwbh8cVMpWiiQehqjYZ7b4ys3bSQvhvVdP5wx/Nds7uj+1nc9/i16ZGT62UpF4xs4chuEiwVu3gCjhjWapJL+9NkIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SZzaVJB7; arc=none smtp.client-ip=220.197.31.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SZzaVJB7"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3730a4c16;
	Tue, 17 Mar 2026 10:15:03 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: dw_mmc-pltfm: Use phase_map for SoCFPGA clock phase configuration
Date: Tue, 17 Mar 2026 10:14:52 +0800
Message-Id: <1773713692-117311-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9cf9933f9109cckunm716a35ed41b554
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkJJHlZOSx9CHUgZQ0MfTElWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=SZzaVJB7oglGpzSEMNbtdlTeujBtEj2iI56Y7VaOOzobGt44LYrhxee4IvS+tOQBDcQOhlVJ7OxvKnYBLeYs4DC0qoh62RqWe1MKAdwBFoFMS16/jZi9pL6A0D4GULAcL0vmus1N/dkOF3ktuprF2ctlE6KGu/RFXbg7OvLBdBk=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=yALgdmUXmEqWJDk2pFmbyjGn8ryNtxW8poD8P59UEC4=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

This change aligns the SoCFPGA driver with the current dw_mmc core,
which now manages clock phases through host->phase_map. The phase values
are still scaled by SOCFPGA_DW_MMC_CLK_PHASE_STEP before being written
to the system manager registers.

No functional changes intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-pltfm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index 68770aa..cf38bb1 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -59,12 +59,13 @@ EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
 static int dw_mci_socfpga_priv_init(struct dw_mci *host)
 {
 	struct device_node *np = host->dev->of_node;
+	struct mmc_clk_phase phase;
 	struct regmap *sys_mgr_base_addr;
-	u32 clk_phase[2] = {0}, reg_offset, reg_shift;
-	int i, rc, hs_timing;
+	u32 reg_offset, reg_shift;
+	int hs_timing;
 
-	rc = of_property_read_variable_u32_array(np, "clk-phase-sd-hs", &clk_phase[0], 2, 0);
-	if (rc < 0)
+	phase = host->phase_map.phase[MMC_TIMING_SD_HS];
+	if (!phase.valid)
 		return 0;
 
 	sys_mgr_base_addr = altr_sysmgr_regmap_lookup_by_phandle(np, "altr,sysmgr-syscon");
@@ -76,10 +77,10 @@ static int dw_mci_socfpga_priv_init(struct dw_mci *host)
 	of_property_read_u32_index(np, "altr,sysmgr-syscon", 1, &reg_offset);
 	of_property_read_u32_index(np, "altr,sysmgr-syscon", 2, &reg_shift);
 
-	for (i = 0; i < ARRAY_SIZE(clk_phase); i++)
-		clk_phase[i] /= SOCFPGA_DW_MMC_CLK_PHASE_STEP;
+	phase.in_deg /= SOCFPGA_DW_MMC_CLK_PHASE_STEP;
+	phase.out_deg /= SOCFPGA_DW_MMC_CLK_PHASE_STEP;
 
-	hs_timing = SYSMGR_SDMMC_CTRL_SET(clk_phase[0], clk_phase[1], reg_shift);
+	hs_timing = SYSMGR_SDMMC_CTRL_SET(phase.in_deg, phase.out_deg, reg_shift);
 	regmap_write(sys_mgr_base_addr, reg_offset, hs_timing);
 
 	return 0;
-- 
2.7.4

