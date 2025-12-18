Received: from mail-m19731117.qiye.163.com (mail-m19731117.qiye.163.com [220.197.31.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F3347FCD
	for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2025 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766066590; cv=none; b=Q+bi21SHJh+o6aiqTb0x7wVl21uaz/HiydTvw3Pfw37MoicqaiA50cX9saeHsMDUKqZIpsdZJNnfv9Yrwv94z+9GenvYc01zCs/N4yqoBo8GQqg0jI63QEa8nC/UmlKwRCPksbWCFEcY8kqxa2fWW1U7jCXEXhWDm2PPdhxag7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766066590; c=relaxed/simple;
	bh=GuX6A3pNtJOOHN5GW2TptBckqh/Le2IjT3csrEBYnh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Qu3K2S9wyb5GrW3OClQeKS0KJ0cJYYV7EgZ45SDeC0KlhLnQxrJaYnLXtCgzGC7XeHSmAtmxt+3IbHAiM0IhC63ZEtXD/a46mB4Z9TqK2chdumTYFBbKtr3fcnawPutx57llmtFrU9xvFXAMnQWCgNws+xaEI9ZFg4S9u1kfoAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=c+fc2T13; arc=none smtp.client-ip=220.197.31.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="c+fc2T13"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2dc3bb312;
	Thu, 18 Dec 2025 22:02:58 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 05/18] mmc: dw_mmc: Remove caps2 and pm_caps from struct dw_mci_board
Date: Thu, 18 Dec 2025 22:00:32 +0800
Message-Id: <1766066445-14144-6-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
References: <1766066445-14144-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b31c562eb09cckunm1f354c4b7329
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR8dTlYfSk8YSElLGkhPHR9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=c+fc2T13o9JosPnqUkKPzBSpmqq0UNVs0uRSFsjePqmHX1X9cNB6VWNu+0rpnEnmHeyvcFcbJrVk5OU7taRadhzYBZX3gk2AlIsn9smcPc+JkxNtC0iXU6liCzSZEPglEpaAMzcDHfkfJM2qTvlezggvth81iQdZoNAg3LaCLRg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=WNnYnJ/MLoRwXhlHdKutVM1W2NKHmxuItD3PEnKPtys=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Nobody uses it.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/dw_mmc.c | 6 ------
 drivers/mmc/host/dw_mmc.h | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 57b4cfd..650f84a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2840,9 +2840,6 @@ static int dw_mci_init_host_caps(struct dw_mci *host)
 	if (host->pdata->caps)
 		mmc->caps = host->pdata->caps;
 
-	if (host->pdata->pm_caps)
-		mmc->pm_caps = host->pdata->pm_caps;
-
 	if (drv_data)
 		mmc->caps |= drv_data->common_caps;
 
@@ -2863,9 +2860,6 @@ static int dw_mci_init_host_caps(struct dw_mci *host)
 		mmc->caps |= drv_data->caps[ctrl_id];
 	}
 
-	if (host->pdata->caps2)
-		mmc->caps2 = host->pdata->caps2;
-
 	/* if host has set a minimum_freq, we should respect it */
 	if (host->minimum_speed)
 		mmc->f_min = host->minimum_speed;
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 99d492f..206c2a4 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -268,8 +268,6 @@ struct dw_mci_board {
 	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
 
 	u32 caps;	/* Capabilities */
-	u32 caps2;	/* More capabilities */
-	u32 pm_caps;	/* PM capabilities */
 	/*
 	 * Override fifo depth. If 0, autodetect it from the FIFOTH register,
 	 * but note that this may not be reliable after a bootloader has used
-- 
2.7.4

