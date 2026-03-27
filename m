Received: from mail-m1973183.qiye.163.com (mail-m1973183.qiye.163.com [220.197.31.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622AD346FC6;
	Fri, 27 Mar 2026 04:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774585618; cv=none; b=O7MWlZd9wo6ybqRyUDdh+deL2BzrdyxFdqZyqLUeCla2s0asi/5Pe+DKv/41S/rE3XNIzKiIeq1uPsg9MlafzqdI7JwtkPDSoZW/LWhLLGyGMop7dkKvvUxfEUukgjQIiJHogCZ33UZ0QFq1Ac/+K2RugWciAu7BYDWgxG+csl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774585618; c=relaxed/simple;
	bh=/EL3VlepvHb4jkhmjfcukef+62K2gxaQda6Q55w8+eY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fZvAJOnUkSrX2mPPjuXjumKOV6vvehbgmOsutTavfx8iaLFkohWXLueqyq161RUX45dTWxbrARJHJAG2pTH5CsuQdjwwVe/bs4Mi+G694uirQfk8w+Zn3Wjygvn/NScXwesaCWcEVSdOI4qmIh8xFMZJjX1KgrNYOBW7pCAk5ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=hLaQfx90; arc=none smtp.client-ip=220.197.31.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="hLaQfx90"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 38811d305;
	Fri, 27 Mar 2026 12:11:29 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: core: Switch to use pm_ptr() for mmc_host_class_dev_pm_ops
Date: Fri, 27 Mar 2026 12:11:23 +0800
Message-Id: <1774584683-131402-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9d2d7d72ec09cckunm9788617ac402fa
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhhCS1YeGE0ZTx1MSxkZThlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=hLaQfx9007LDiRQl6azgIoCIilVwqCMl/5mjSmJZ4RGmp33WJ6MMvj5P/lyHgL/EnFxfWXFbwhBcdmdk9O04zh3XdHpA9EjOSjKn3zpMaUOldFXJD3h+06VZxZ867KDXtQbpIXL4WTC0ldMbZduzHi6tF1LNDUTkfTa7zcrKTuY=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=w30f01M2c0gwG88UUQkvCv6xt3m66RKkdT+oWi2zW54=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Currently, the mmc_host_class_dev_pm_ops and its callback
functions are wrapped in #ifdef CONFIG_PM_SLEEP to handle the
conditional compilation when PM support is disabled.

Replace this #ifdef usage with the standard pm_ptr() helpers. This
allows the compiler to automatically optimize away the unused code
paths when CONFIG_PM_SLEEP is not selected, resulting in cleaner and
more maintainable code.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/host.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 4e1514b..b7ce313 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -33,7 +33,6 @@
 
 static DEFINE_IDA(mmc_host_ida);
 
-#ifdef CONFIG_PM_SLEEP
 static int mmc_host_class_prepare(struct device *dev)
 {
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
@@ -60,15 +59,10 @@ static void mmc_host_class_complete(struct device *dev)
 }
 
 static const struct dev_pm_ops mmc_host_class_dev_pm_ops = {
-	.prepare = mmc_host_class_prepare,
-	.complete = mmc_host_class_complete,
+	.prepare = pm_sleep_ptr(mmc_host_class_prepare),
+	.complete = pm_sleep_ptr(mmc_host_class_complete),
 };
 
-#define MMC_HOST_CLASS_DEV_PM_OPS (&mmc_host_class_dev_pm_ops)
-#else
-#define MMC_HOST_CLASS_DEV_PM_OPS NULL
-#endif
-
 static void mmc_host_classdev_release(struct device *dev)
 {
 	struct mmc_host *host = cls_dev_to_mmc_host(dev);
@@ -90,7 +84,7 @@ static const struct class mmc_host_class = {
 	.name		= "mmc_host",
 	.dev_release	= mmc_host_classdev_release,
 	.shutdown_pre	= mmc_host_classdev_shutdown,
-	.pm		= MMC_HOST_CLASS_DEV_PM_OPS,
+	.pm		= pm_ptr(&mmc_host_class_dev_pm_ops),
 };
 
 int mmc_register_host_class(void)
-- 
2.7.4

