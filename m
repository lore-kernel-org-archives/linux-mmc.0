Received: from mail-m3274.qiye.163.com (mail-m3274.qiye.163.com [220.197.32.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2792C21CC
	for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2025 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933488; cv=none; b=YLwVK+0fr71sW7YuYJPpzomwfMAYy8nQhm0+G7Ga1QhNCXivPysIkfDZDflennK6CS1VaWUBEMbiG0h1NNrNaIgwYSsXkJXZ+3MOSOKWNmQALtdan++a4AQ9V9mx2SR9zX0k1domVfCntgKO+RiHJCqfug0kCcmUf16Cx5Ex4GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933488; c=relaxed/simple;
	bh=4xGUM1eN8e5kK3mFmSPZ9g/YKBDdSIKAVzwBOxwLP6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WsbAO7YJqkVhJimrPb1gX3S4/oKye35SfC7pgbOcbYX/KQKok2x1L6jbkGGcMmz6J2BnGEZlx46xEff1iQ/Ei84VSsaUfgrv7grvaUXfok1cGafRbQNYnU776sSfakGITkSsJhIPgx8njIr9YrcdBuSM9k1t2XDPXYzENDyxp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=EqalDPPL; arc=none smtp.client-ip=220.197.32.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="EqalDPPL"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 294e35849;
	Wed, 12 Nov 2025 15:44:35 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] mmc: sdhci-of-dwcmshc: reduce CIT for better performance
Date: Wed, 12 Nov 2025 15:44:20 +0800
Message-Id: <1762933460-204066-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1762933460-204066-1-git-send-email-shawn.lin@rock-chips.com>
References: <1762933460-204066-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9a7706096a09cckunm8f73707313c8a8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxlKSlYZShkZGklLH0pDSR9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=EqalDPPL0j5CyaUmzf68LwMuynULiV4qfMIMJcAIk132+68QqKNr32d6N/opUnx7eNgH5T2dfiaG5yt6XHjVE1cbwOGTPiqLEuGmNFV9wJhZ5zO01gW2WBAeFxXDT1xX3xFaa8t15CSD6nKI4G2xiNp/vSq0wQ+CeJ1RFKBNjXQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=eQpfZEJeVDoHX/pt3LZYm2mfJEiV7aEbD+NJE5uWFxg=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

CQHCI_SSC1.CIT indicates to the CQE the polling period to use for
periodic SEND_QUEUE_STATUS (CMD13) polling. Some eMMCs have only one
hardware queue, and CMD13 can only query one slot at a time for data
transmission, which cannot be processed in parallel. Modifying the
CMD13 query interval can increase the query frequency and improve
random write performance.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/cqhci.h            | 1 +
 drivers/mmc/host/sdhci-of-dwcmshc.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index ce189a1..3668856 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -93,6 +93,7 @@
 /* send status config 1 */
 #define CQHCI_SSC1			0x40
 #define CQHCI_SSC1_CBC_MASK		GENMASK(19, 16)
+#define CQHCI_SSC1_CIT_MASK		GENMASK(15, 0)
 
 /* send status config 2 */
 #define CQHCI_SSC2			0x44
diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e276a4e..cad5165 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -631,6 +631,11 @@ static void rk35xx_sdhci_cqe_pre_enable(struct mmc_host *mmc)
 	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
 	u32 reg;
 
+	/* Set Send Status Command Idle Timer to 10.66us (256 * 1 / 24) */
+	reg = sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_SSC1);
+	reg = (reg & ~CQHCI_SSC1_CIT_MASK) | 0x0100;
+	sdhci_writel(host, reg, dwc_priv->vendor_specific_area2 + CQHCI_SSC1);
+
 	reg = sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
 	reg |= CQHCI_ENABLE;
 	sdhci_writel(host, reg, dwc_priv->vendor_specific_area2 + CQHCI_CFG);
-- 
2.7.4

