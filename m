Received: from mail-m49208.qiye.163.com (mail-m49208.qiye.163.com [45.254.49.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DF82D8398
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764113536; cv=none; b=G+rtVGJmLoUdNFw9lyMQeHWPejSpv4IKZs+1u8/wEmOf0N7DuICquPqjIu7mXxAWOROmgQ21sHPK4yhYqKbAtWuIRi0aTf5zDv8mc9ETTnw6+SDQv9dwPoch7E0XcUA6/bD0QP2ELZN1zkMp7tdzzfO9jUKLOMrtld7bvzLhgig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764113536; c=relaxed/simple;
	bh=ANCFohWlgLhmXTLpkSVzDAh4E9Qcoou8AOBnj+xfgO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KBY/pAD4zsSm5dSweX890H09KHcI9MAtACWxn+Z29OGd311vJUUm3B8WuMzUdOVeD5/5QtPq+OZf4jynIlJvv8MZ6eEH0TYETrgokWLu34uY931opnrJqPb3UbDhEIXHIKSguJ7h8tZe2Wtck0VkkF86gtAKCNe6HInUT2MQRKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QX3sIx0T; arc=none smtp.client-ip=45.254.49.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QX3sIx0T"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2ae234a1b;
	Wed, 26 Nov 2025 07:27:00 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 2/2] mmc: sdhci-of-dwcmshc: reduce CIT for better performance
Date: Wed, 26 Nov 2025 07:26:40 +0800
Message-Id: <1764113200-237279-3-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1764113200-237279-1-git-send-email-shawn.lin@rock-chips.com>
References: <1764113200-237279-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9abd5783a809cckunm0d7ff06b4d7c1b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkJPHVYaGUpJHU0YQ00eGhhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=QX3sIx0Ty4/OFX3X62A8lKV8D4H9JvcraBMzoXlBo0rcPF3WDvV0g15qsTMJbUsmWzK0HVOv40uUufqFojAsoAI7rcE8QlTJDmPvtdHQ11EkpFyhsohZsDGJnouwM5UomSQ/yx9ZgjdXbdihMQnGJ7PvniQaE9pd6vfwJkxQ8ds=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=OZHPhjL4QkHRRqFNW+rxGRk+OtVXm+AIK+TIQx+giug=;
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

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Changes in v2:
- rebase and add acked-by tag

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

