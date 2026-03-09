Received: from mail-m3289.qiye.163.com (mail-m3289.qiye.163.com [220.197.32.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C974155326
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 03:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773027891; cv=none; b=CB+OZMPTUCNCL097/3xShw9v4lkzubDh/I8Xa8FBpgC2DpiGhmM3jb2lEm97XOlKdzKlTLqejJKBTSLgKq+vPEtYDErKx86MNnqNlwwJLe9ZzV1ZE/VdCQjUPK/16Qzifg6UYnOBG0fZwaOxRGSX8oNpOK23iKMB6+avf9sHArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773027891; c=relaxed/simple;
	bh=F14sdSEq7TDP04+md3ZSyUUZM50eAvjoj1y9Q9Y3NFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=o7bPve9H910JnglbTY4/AA81nEtmCAy6j/zFuRl11wldZIYhJUlHE5oiRZHn65yj47s2PWCbCxf7E5OnD9I24XlgykihkWNs9ynuS9i7UIwy4wqj9FB6+bWWSuvbiHO7C7eid+UMgtRf65fobdEMKFIa+PzZMB3cyDKnJ3CYtHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=JlSIYYYK; arc=none smtp.client-ip=220.197.32.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="JlSIYYYK"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3631478fe;
	Mon, 9 Mar 2026 11:29:21 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/3] mmc: dw_mmc: Add parsing mmc_clk_phase_map support
Date: Mon,  9 Mar 2026 11:29:01 +0800
Message-Id: <1773026943-111633-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1773026943-111633-1-git-send-email-shawn.lin@rock-chips.com>
References: <1773026943-111633-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9cd0a4678a09cckunm2100c80115ef2d2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ09JSVYaS0MdQk9DSUpKT0JWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JlSIYYYK+dDaJlXBq2h0qk9lzKjvwqMvstw8DmcFgvV+2HILyYWb8AutXkyTxozE8n3/OrF721nS+S9IhflnK/lSSRtdn0AUygMMPvHVkk8vcejsLxFLRampCgXTd3Zlpv+M1Uim12tleVkyZlo2qBKLMl1mOZ0Jjh7eh9mrSqE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=OX+mVHT1fmYQaO98NVvH8Ox08vkymTaLRGMH2ErP/a8=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The dw_mmc library already assists in invoking mmc_of_parse() to
provide unified parsing for variant drivers. We can also call
mmc_of_parse_clk_phase() to help variant drivers achieve unified parsing.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 2 ++
 drivers/mmc/host/dw_mmc.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index edea9f4..bbdd759 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2866,6 +2866,8 @@ static int dw_mci_init_host(struct dw_mci *host)
 	if (ret)
 		return ret;
 
+	mmc_of_parse_clk_phase(host->dev, &host->phase_map);
+
 	ret = dw_mci_init_host_caps(host);
 	if (ret)
 		return ret;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 9a27d77..42e58be 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -130,6 +130,7 @@ struct dw_mci_dma_slave {
  * @pdev: platform_device registered
  * @rstc: Reset controller for this host.
  * @detect_delay_ms: Delay in mS before detecting cards after interrupt.
+ * @phase_map: The map for recording in and out phases for each timing
  *
  * Locking
  * =======
@@ -250,6 +251,7 @@ struct dw_mci {
 	struct platform_device	*pdev;
 	struct reset_control *rstc;
 	u32 detect_delay_ms;
+	struct mmc_clk_phase_map phase_map;
 };
 
 /* DMA ops for Internal/External DMAC interface */
-- 
2.7.4

