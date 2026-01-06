Received: from mail-m21469.qiye.163.com (mail-m21469.qiye.163.com [117.135.214.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E77D1A256E
	for <linux-mmc@vger.kernel.org>; Tue,  6 Jan 2026 02:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767668088; cv=none; b=YOcZGFF97JVvW0iGVr5jM2m9AjKSSPJQlU9Qd4mM1SUNWQOWmEdyEh2jDAObnRN66rlcAllOHsaXgVmFC8PY7HmBhRMk8VUE0L1WqhzM8SL0xAoALBm+0AniJp2KiS4YBM5jGuSr4DvW2Tg/ed/HRAuPAKWz6OMJfrzYZt3D3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767668088; c=relaxed/simple;
	bh=gm8GD29kEkMYoXQoKvBeyckTj1WJw+QZW5SfJFd++C8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mKFdZLUvU4vUe6JkAQlvhoRznGh2c8OshBEcc8Wk0CTQBNYhYL6H85uZFrwJPUNOmxPLvRvuZ/sKoiANLaOvKAiQdZp/4u4oin++CXC2yHdM2jewhNr9a1mb2jeyCVIeKwBBJImpSnJyAf2KhMFK4Z8tf4D4YMINpgBj3HLIGGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=HPegi2+A; arc=none smtp.client-ip=117.135.214.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="HPegi2+A"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2f9c1564e;
	Tue, 6 Jan 2026 10:19:12 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 05/18] mmc: dw_mmc: Remove caps2 and pm_caps from struct dw_mci_board
Date: Tue,  6 Jan 2026 10:16:56 +0800
Message-Id: <1767665829-183001-6-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
References: <1767665829-183001-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9b9119e5ac09cckunmc69ba49b79bcfd
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ01ISVZMGkhPTUhISEwfTB5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=HPegi2+ARThZf9SbNu2j2FjLBqaCVvBVLQRbCQGFza9OfAm1JvRWxDvoj7HFx3GIc3cMfeOO+1O3KV6MphD4/2JH0lvmIlzXEEwIJR5TK4EDxl2G2OwMcKKgz96LtOEJrmARNUXhIBTCoz8eL6KDQqPGJE1avxgMxIFBEN0GaKU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=T0C04/XMzK5wHzZTuIDGbEJVCrmB5CjpMQZ8F8zHQnI=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Nobody uses them.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 6 ------
 drivers/mmc/host/dw_mmc.h | 2 --
 2 files changed, 8 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 71cbb7e..3c616aa 100644
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
index 0ff301c..47775dd 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -267,8 +267,6 @@ struct dw_mci_board {
 	unsigned int bus_hz; /* Clock speed at the cclk_in pad */
 
 	u32 caps;	/* Capabilities */
-	u32 caps2;	/* More capabilities */
-	u32 pm_caps;	/* PM capabilities */
 	/*
 	 * Override fifo depth. If 0, autodetect it from the FIFOTH register,
 	 * but note that this may not be reliable after a bootloader has used
-- 
2.7.4

