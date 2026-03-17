Received: from mail-m1973183.qiye.163.com (mail-m1973183.qiye.163.com [220.197.31.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D424F1922F5;
	Tue, 17 Mar 2026 04:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773722417; cv=none; b=UI7DT3i9M7zmupVQty9iTTG0Aeds1pGSDlBSZIvenr5bZuo+LIY4SWwCO2wzCTrwONoffOIMOGpThDSBfz22jvE6ONB2XCLKNm0TELDVmMBpZ5D69AjOHXN6xoBguf4bJ6xy2hiCqYOBtGmdK9jEUo8EmjmzEjN9ftehSjvTzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773722417; c=relaxed/simple;
	bh=rZAvBs0kCa6+dDFfb1paTm0dlPJER4IhnXm8Hu/w3IM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Pd4DCupL5w5HJpbypQD3jSNNglghwSvrL0Y9NFN0uhYBCvr+hOVVIXSfvrKDoz9tKjs0BRZOaiUPZzOXIh1t6bHl+iQLYSq3vBnzs09QiA0kXfMldrrb2XHTwuBqDYHBJr+KQX+lCECGkYgA94sabKpz0Rsp6h9tfnf5IY5Eyyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SfNm8VKu; arc=none smtp.client-ip=220.197.31.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SfNm8VKu"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3730c9536;
	Tue, 17 Mar 2026 10:17:40 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Use standard mmc_clk_phase_map infrastructure
Date: Tue, 17 Mar 2026 10:17:23 +0800
Message-Id: <1773713843-118137-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9cf995a5af09cckunm36b77d1441bddb
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkkdGlZMHUhNSxpMH09KQxpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=SfNm8VKuyeaMQxbBB1BKaE8tKRmE6DFlwfTI5n9MoHwLtef+kF877p0OJQWmjWJhx1kqbQx9IDZJzflX8kr5p61fo1ZgbQ3uabqkd2lgowMj4Jod7DgjsSULAOL0kCia6TC+ATY4gV+ZffYgRRt5UJ7e1luioIe4uBEfnfpUmQY=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=Aw2qzU/WL/QH++pabQgw3t7YDPLqsAwco2/p6jzYROs=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Convert the Arasan SDHCI driver to use the mainline standard
mmc_clk_phase_map infrastructure instead of custom clk_phase_in/out
arrays as well as arasan_dt_read_clk_phase().

The phase values for ZynqMP, Versal, and Versal-NET platforms are
still initialized from the predefined tables, but now follow the
standard phase_map format with valid flag.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-of-arasan.c | 79 +++++++++-----------------------------
 1 file changed, 18 insertions(+), 61 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index caf9723..b97d27c 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -152,8 +152,7 @@ struct sdhci_arasan_clk_ops {
  * @sdcardclk:		Pointer to normal 'struct clock' for sdcardclk_hw.
  * @sampleclk_hw:	Struct for the clock we might provide to a PHY.
  * @sampleclk:		Pointer to normal 'struct clock' for sampleclk_hw.
- * @clk_phase_in:	Array of Input Clock Phase Delays for all speed modes
- * @clk_phase_out:	Array of Output Clock Phase Delays for all speed modes
+ * @phase_map:		Struct for mmc_clk_phase_map provided.
  * @set_clk_delays:	Function pointer for setting Clock Delays
  * @clk_of_data:	Platform specific runtime clock data storage pointer
  */
@@ -162,8 +161,7 @@ struct sdhci_arasan_clk_data {
 	struct clk      *sdcardclk;
 	struct clk_hw	sampleclk_hw;
 	struct clk      *sampleclk;
-	int		clk_phase_in[MMC_TIMING_MMC_HS400 + 1];
-	int		clk_phase_out[MMC_TIMING_MMC_HS400 + 1];
+	struct mmc_clk_phase_map phase_map;
 	void		(*set_clk_delays)(struct sdhci_host *host);
 	void		*clk_of_data;
 };
@@ -1248,37 +1246,13 @@ static void sdhci_arasan_set_clk_delays(struct sdhci_host *host)
 	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
 	struct sdhci_arasan_clk_data *clk_data = &sdhci_arasan->clk_data;
 
-	clk_set_phase(clk_data->sampleclk,
-		      clk_data->clk_phase_in[host->timing]);
-	clk_set_phase(clk_data->sdcardclk,
-		      clk_data->clk_phase_out[host->timing]);
-}
-
-static void arasan_dt_read_clk_phase(struct device *dev,
-				     struct sdhci_arasan_clk_data *clk_data,
-				     unsigned int timing, const char *prop)
-{
-	struct device_node *np = dev->of_node;
-
-	u32 clk_phase[2] = {0};
-	int ret;
-
-	/*
-	 * Read Tap Delay values from DT, if the DT does not contain the
-	 * Tap Values then use the pre-defined values.
-	 */
-	ret = of_property_read_variable_u32_array(np, prop, &clk_phase[0],
-						  2, 0);
-	if (ret < 0) {
-		dev_dbg(dev, "Using predefined clock phase for %s = %d %d\n",
-			prop, clk_data->clk_phase_in[timing],
-			clk_data->clk_phase_out[timing]);
+	if (!clk_data->phase_map.phase[host->timing].valid)
 		return;
-	}
 
-	/* The values read are Input and Output Clock Delays in order */
-	clk_data->clk_phase_in[timing] = clk_phase[0];
-	clk_data->clk_phase_out[timing] = clk_phase[1];
+	clk_set_phase(clk_data->sampleclk,
+		      clk_data->phase_map.phase[host->timing].in_deg);
+	clk_set_phase(clk_data->sdcardclk,
+		      clk_data->phase_map.phase[host->timing].out_deg);
 }
 
 /**
@@ -1315,8 +1289,9 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
 		}
 
 		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
-			clk_data->clk_phase_in[i] = zynqmp_iclk_phase[i];
-			clk_data->clk_phase_out[i] = zynqmp_oclk_phase[i];
+			clk_data->phase_map.phase[i].in_deg = zynqmp_iclk_phase[i];
+			clk_data->phase_map.phase[i].out_deg = zynqmp_oclk_phase[i];
+			clk_data->phase_map.phase[i].valid = true;
 		}
 	}
 
@@ -1327,8 +1302,9 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
 			VERSAL_OCLK_PHASE;
 
 		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
-			clk_data->clk_phase_in[i] = versal_iclk_phase[i];
-			clk_data->clk_phase_out[i] = versal_oclk_phase[i];
+			clk_data->phase_map.phase[i].in_deg = versal_iclk_phase[i];
+			clk_data->phase_map.phase[i].out_deg = versal_oclk_phase[i];
+			clk_data->phase_map.phase[i].valid = true;
 		}
 	}
 	if (of_device_is_compatible(dev->of_node, "xlnx,versal-net-emmc")) {
@@ -1338,32 +1314,13 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
 			VERSAL_NET_EMMC_OCLK_PHASE;
 
 		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
-			clk_data->clk_phase_in[i] = versal_net_iclk_phase[i];
-			clk_data->clk_phase_out[i] = versal_net_oclk_phase[i];
+			clk_data->phase_map.phase[i].in_deg = versal_net_iclk_phase[i];
+			clk_data->phase_map.phase[i].out_deg = versal_net_oclk_phase[i];
+			clk_data->phase_map.phase[i].valid = true;
 		}
 	}
-	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_LEGACY,
-				 "clk-phase-legacy");
-	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS,
-				 "clk-phase-mmc-hs");
-	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_SD_HS,
-				 "clk-phase-sd-hs");
-	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR12,
-				 "clk-phase-uhs-sdr12");
-	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR25,
-				 "clk-phase-uhs-sdr25");
-	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR50,
-				 "clk-phase-uhs-sdr50");
-	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_SDR104,
-				 "clk-phase-uhs-sdr104");
-	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_UHS_DDR50,
-				 "clk-phase-uhs-ddr50");
-	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_DDR52,
-				 "clk-phase-mmc-ddr52");
-	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS200,
-				 "clk-phase-mmc-hs200");
-	arasan_dt_read_clk_phase(dev, clk_data, MMC_TIMING_MMC_HS400,
-				 "clk-phase-mmc-hs400");
+
+	mmc_of_parse_clk_phase(dev, &clk_data->phase_map);
 }
 
 static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
-- 
2.7.4

