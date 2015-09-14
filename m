From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2] mmc: core: Don't return an error for CD/WP GPIOs when GPIOLIB is unset
Date: Mon, 14 Sep 2015 12:18:55 +0200
Message-ID: <1442225935-24155-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34312 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801AbbINKTH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2015 06:19:07 -0400
Received: by lbbmp1 with SMTP id mp1so64738608lbb.1
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2015 03:19:06 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, Marcus Overhagen <marcus.overhagen@gmail.com>, Venu Byravarasu <vbyravarasu@nvidia.com>

When CONFIG_GPIOLIB is unset, its stubs will return -ENOSYS. That means
when the mmc core parses DT for CD/WP GPIOs via mmc_of_parse(), -ENOSYS
becomes propagated to the caller. Typically this means that the mmc host
driver fails to probe.

As the CD/WP GPIOs are already treated as optional, let's extend that to
cover the case when CONFIG_GPIOLIB is unset.

Reported-by: Michal Simek <michal.simek@xilinx.com>
Fixes: 16b23787fc70 ("mmc: sdhci-of-arasan: Call OF parsing for MMC")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Corrected error code check.

---
 drivers/mmc/core/host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index abd933b..5466f25 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -457,7 +457,7 @@ int mmc_of_parse(struct mmc_host *host)
 					   0, &cd_gpio_invert);
 		if (!ret)
 			dev_info(host->parent, "Got CD GPIO\n");
-		else if (ret != -ENOENT)
+		else if (ret != -ENOENT && ret != -ENOSYS)
 			return ret;
 
 		/*
@@ -481,7 +481,7 @@ int mmc_of_parse(struct mmc_host *host)
 	ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0, &ro_gpio_invert);
 	if (!ret)
 		dev_info(host->parent, "Got WP GPIO\n");
-	else if (ret != -ENOENT)
+	else if (ret != -ENOENT && ret != -ENOSYS)
 		return ret;
 
 	if (of_property_read_bool(np, "disable-wp"))
-- 
1.9.1

