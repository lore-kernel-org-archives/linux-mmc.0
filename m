Received: from mail-m32109.qiye.163.com (mail-m32109.qiye.163.com [220.197.32.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF89123D2AB;
	Fri, 27 Mar 2026 04:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774585387; cv=none; b=lqzEu2eUyANo48dKFYN1fpFCg7O3JkZKlJDl99uJCxB66KsvqSaWH5lU4XV2nnUy8Iu4E64HWUZ5NMohkCbfVZ4gu7FKCHJJfAbO/Oj02zsZd4yxuqIuUiTpRODlmbl17V+9f/7UjUAiQuKO9Y/4ko4DyncoGnmn8CAri+dBuvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774585387; c=relaxed/simple;
	bh=mQg9AkXeSmLd0X1ieOYcBc3B1YsjdT0vVcM3QzjwKwM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=poUbhUvcyKb2PIsuRtE6W3n9qI1gAjwKa+Bu+3IURQvSL2NfjSkYJziUJOQ53Mu2jnFRbYrMOl0NsaARXXwTMl4oWSjSs6PtLfIhWExgAWj8iZRETohAngptDiliCOAPEpLceNlGMLjLS8KIV/GFwWorjI/QMoBcKxwEuusaJYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=OzAt1qBt; arc=none smtp.client-ip=220.197.32.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="OzAt1qBt"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 388109537;
	Fri, 27 Mar 2026 12:07:36 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: core: Remove legacy 'enable-sdio-wakeup' DT property support
Date: Fri, 27 Mar 2026 12:07:29 +0800
Message-Id: <1774584449-130249-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9d2d79e4fe09cckunm94b891b6c3f3e0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpJQ1YZQ0oaGR4fSx9NHUtWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=OzAt1qBtI1/ZtXdf4QBpHa25xcCGvL4UhkNQpM6zhJDHOkDn/QF33xR3qSCKv3jmEcqGvmVHS3i+CGTGpy/LuYXC5OZlfMeXl289Pt/2rovkjhFDcXw366RkD9o6Fpkp5ZMVk/3a2U5ZAnoP+mcO7DHgvWY4lY+VaxeTMQjWMK0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=3DzG4lF3Tl7aSSQGUW7ynT1WpZYD13cWytT2vU2dqiM=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The 'enable-sdio-wakeup' device tree property was marked as legacy and
superseded by the standard 'wakeup-source' property in commit 71a0151c5c82
("Documentation: devicetree: fix reference to legacy wakeup properties")
back in 2015.

Since it has been a decade and the migration to the standard property
has long been completed, remove this obsolete legacy support.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/host.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index a457c88..4e1514b 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -379,8 +379,7 @@ int mmc_of_parse(struct mmc_host *host)
 		host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE_IN_SUSPEND;
 	if (device_property_read_bool(dev, "keep-power-in-suspend"))
 		host->pm_caps |= MMC_PM_KEEP_POWER;
-	if (device_property_read_bool(dev, "wakeup-source") ||
-	    device_property_read_bool(dev, "enable-sdio-wakeup")) /* legacy */
+	if (device_property_read_bool(dev, "wakeup-source"))
 		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 	if (device_property_read_bool(dev, "mmc-ddr-3_3v"))
 		host->caps |= MMC_CAP_3_3V_DDR;
-- 
2.7.4

