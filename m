Received: from mail-m19731118.qiye.163.com (mail-m19731118.qiye.163.com [220.197.31.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B682448BA8;
	Tue, 22 Sep 2026 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070943; cv=none; b=hu+wNlXt2eGJ1xMeHe+mhScuSdDo8hXGjoT53BokDwsaA26J2ina2et6FHn4y4dodgk6A5Q6ZddnsfJ+5CH2ZfMlQs33CEDV7uTuAknBn4/IMCRv29t0k7Y/E44KagLGvQqCvjFNeG/9ukyV/7nqkvaqdWu2edegxYUe4qGWtKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070943; c=relaxed/simple;
	bh=oSR3RX6lW2WzBQ9wzxQ9L0dh2fh5A2soSY+c4RxAr3E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=pxVHDQeX7/Apay0IxpiOuM/4b5zZkXMYV8RTFe2YQYiMQTzSabYCFE0Fdw4p9qy06laQK4Qsa3BevR8Ajb9MWUxuVL0JZRMjC7S/qqXJJHOIswC2CVkiNhwsl0ldjgpj3pFgzfCfW6FEm2eZqqc+d2oUzF6s3YCcJ8Dji40cN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=D+pgf7Qa; arc=none smtp.client-ip=220.197.31.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="D+pgf7Qa"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4eb71259a;
	Tue, 22 Sep 2026 17:40:11 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: sdhci-of-dwcmshc: Disable CQE error halt request for Rockchip
Date: Tue, 22 Sep 2026 17:40:07 +0800
Message-Id: <1790070007-11769-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa0c87cb5f703a4kunm19317a9c3dd933
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGktLGVZLSUsdGkwfHh
	1OGUNWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=D+pgf7QaJchbI6V0QzlalGg7A9cBibSDwBSd/jIc7xDfJIq82KPc5Llkg1loawvmPLOCx0+TLL4tFvTQaAqGn3NhVK8zulUcDk/K2kvrFynOs7lVqnZg3qG2yGrnshHdecFApnUJY3y11AAbruARPM9cZ2a1ZXXanW6gs996CSQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=omXEob1gsfEqKiAmnKblrTqqqrVd7A7fcEatHpMuRrE=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

In CMDQ mode an I/O error in one task (data_crc_err, data_end_bit_err,
etc.) makes the controller raise a halt request. While the halt request
is pending, the controller rejects doorbell writes with a slave response
error, which hangs the CPU (or raises SError on ARM) on Rockchip
platforms.

A software workaround[1] clears CQHCI_CTL right before ringing the
doorbell to narrow down the window, but a race remains: an I/O error can
still happen in another slot between the CQHCI_CTL write and the
doorbell kick, so the hang is not fully solved.

To fix this once and for all, newer silicon introduces
SW_ERR_HALR_REQ_DISABLE (CQHCI_CTL[1]) which stops the controller from
raising a halt request on I/O errors. Set the bit when the CQE is
enabled, which is the last CQHCI_CTL write before any doorbell write.

Older SoCs keep this bit reserved, so writing it is a no-op and nothing
changes in the wild, thus no fixes tag is needed.

[1] https://github.com/rockchip-linux/kernel/commit/4b7ea0500a1a5c186807b737fecfc6bb4d4e06f8
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/host/sdhci-of-dwcmshc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 1baa237..0970202 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -239,6 +239,8 @@
 					 SDHCI_TRNS_BLK_CNT_EN | \
 					 SDHCI_TRNS_DMA)
 
+#define CQHCI_SW_ERR_HALT_REQ_DISABLE	BIT(1)
+
 #define to_pltfm_data(priv, name) \
 	container_of((priv)->dwcmshc_pdata, struct name##_pltfm_data, dwcmshc_pdata)
 
@@ -702,6 +704,8 @@ static void rk35xx_sdhci_cqe_pre_enable(struct mmc_host *mmc)
 static void rk35xx_sdhci_cqe_enable(struct mmc_host *mmc)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
 	u32 reg;
 
 	reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
@@ -712,6 +716,15 @@ static void rk35xx_sdhci_cqe_enable(struct mmc_host *mmc)
 
 	sdhci_writew(host, DWCMSHC_SDHCI_CQE_TRNS_MODE, SDHCI_TRANSFER_MODE);
 
+	/*
+	 * Disable the halt request raised on an I/O error, otherwise a
+	 * doorbell write gets a slave response error while the halt request
+	 * is pending and hangs the CPU. This bit is reserved on older SoCs,
+	 * so the write is a no-op there.
+	 */
+	sdhci_writel(host, CQHCI_SW_ERR_HALT_REQ_DISABLE,
+		     dwc_priv->vendor_specific_area2 + CQHCI_CTL);
+
 	sdhci_cqe_enable(mmc);
 }
 
-- 
2.7.4

