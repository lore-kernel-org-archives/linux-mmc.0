Received: from mail-m81160.xmail.ntesmail.com (mail-m81160.xmail.ntesmail.com [156.224.81.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE50817993
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 04:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.81.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773029096; cv=none; b=ou91n7xDXqmMHVtEHkUO+qIxSsruiqUtc7Y/IWE/jEVJWRDHsooTs3y/8IzkuSC3eM/Ah3hvS3ewGt31A8uUqsV1ooY4cK4zm3ajyLO/xI0cIR54waPwt3di3NAmlhObX+wCqgBI/JV0qiK11LHkHpUrxtclQPpoGKGc8zpnvqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773029096; c=relaxed/simple;
	bh=VUMiTJTTNT0gMaIPQrUaNVvPTYRgjibhxH32ptnLnok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qihFJ44WHeFpfQgHqjOd/LwfvEaEz2cGrdPKlTRUP/wFZuH4Uf25OMRK6/wcRcN5JUCEmbJks4z1bY4cNtNCTpWRCovlKFZWYYyWWy8T4TtJ7wPYwzfzRimhiQHZC9MowTINGE303mO7MKFkLJhmFuF6nItClwX0mXO3d7oJqJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=K6i2E8P8; arc=none smtp.client-ip=156.224.81.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="K6i2E8P8"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 36314790e;
	Mon, 9 Mar 2026 11:29:25 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/3] mmc: dw_mmc-hi3798mv200: Using phase map from dw_mmc core
Date: Mon,  9 Mar 2026 11:29:02 +0800
Message-Id: <1773026943-111633-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1773026943-111633-1-git-send-email-shawn.lin@rock-chips.com>
References: <1773026943-111633-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9cd0a4763f09cckunm2100c80115ef306
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGktIHlZOQk5CGEoZQkhPSkxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=K6i2E8P8Lo3hbZsVort13sKlOJO46PPgw38q44XJtpcIeKP4z2GwbLLH8DN1WF0snftpLPjOp+hniYroBFmaIb8ybXfiqoUQojEi3sRNHCWGxiRZGJHkxVp7kkdN3UzoT0P2Bri8Ub1SXHly5Zpt70qmnMpvZNU0YCAybCk7Od8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=i5btDijxszuMykpSWLDZiSOgfbymhsrQbgwiBJnZEsY=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

dw_mmc core helps parse phase map now, so reuse it.

No functional changes intended.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc-hi3798mv200.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-hi3798mv200.c b/drivers/mmc/host/dw_mmc-hi3798mv200.c
index a64907e..fda4178 100644
--- a/drivers/mmc/host/dw_mmc-hi3798mv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
@@ -30,13 +30,12 @@ struct dw_mci_hi3798mv200_priv {
 	struct clk *drive_clk;
 	struct regmap *crg_reg;
 	u32 sap_dll_offset;
-	struct mmc_clk_phase_map phase_map;
 };
 
 static void dw_mci_hi3798mv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 {
 	struct dw_mci_hi3798mv200_priv *priv = host->priv;
-	struct mmc_clk_phase phase = priv->phase_map.phase[ios->timing];
+	struct mmc_clk_phase phase = host->phase_map.phase[ios->timing];
 	u32 val;
 
 	val = mci_readl(host, ENABLE_SHIFT);
@@ -158,9 +157,9 @@ static int dw_mci_hi3798mv200_execute_tuning_mix_mode(struct dw_mci *host,
 		 * We don't care what timing we are tuning for,
 		 * simply use the same phase for all timing needs tuning.
 		 */
-		priv->phase_map.phase[MMC_TIMING_MMC_HS200].in_deg = degrees[mid];
-		priv->phase_map.phase[MMC_TIMING_MMC_HS400].in_deg = degrees[mid];
-		priv->phase_map.phase[MMC_TIMING_UHS_SDR104].in_deg = degrees[mid];
+		host->phase_map.phase[MMC_TIMING_MMC_HS200].in_deg = degrees[mid];
+		host->phase_map.phase[MMC_TIMING_MMC_HS400].in_deg = degrees[mid];
+		host->phase_map.phase[MMC_TIMING_UHS_SDR104].in_deg = degrees[mid];
 
 		clk_set_phase(priv->sample_clk, degrees[mid]);
 		dev_dbg(host->dev, "Tuning clk_sample[%d, %d], set[%d]\n",
@@ -185,8 +184,6 @@ static int dw_mci_hi3798mv200_init(struct dw_mci *host)
 	if (!priv)
 		return -ENOMEM;
 
-	mmc_of_parse_clk_phase(host->dev, &priv->phase_map);
-
 	priv->sample_clk = devm_clk_get_enabled(host->dev, "ciu-sample");
 	if (IS_ERR(priv->sample_clk))
 		return dev_err_probe(host->dev, PTR_ERR(priv->sample_clk),
-- 
2.7.4

