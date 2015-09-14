From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: core: Don't return an error for CD/WP GPIOs when GPIOLIB is unset
Date: Mon, 14 Sep 2015 10:56:33 +0200
Message-ID: <1442220993-20468-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:35877 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502AbbINI4o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2015 04:56:44 -0400
Received: by lanb10 with SMTP id b10so81985839lan.3
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2015 01:56:43 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>

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
 drivers/mmc/core/host.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index abd933b..ad11425 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -457,7 +457,7 @@ int mmc_of_parse(struct mmc_host *host)
 					   0, &cd_gpio_invert);
 		if (!ret)
 			dev_info(host->parent, "Got CD GPIO\n");
-		else if (ret != -ENOENT)
+		else if (ret != -ENOENT && ret != ENOSYS)
 			return ret;
 
 		/*
@@ -481,7 +481,7 @@ int mmc_of_parse(struct mmc_host *host)
 	ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0, &ro_gpio_invert);
 	if (!ret)
 		dev_info(host->parent, "Got WP GPIO\n");
-	else if (ret != -ENOENT)
+	else if (ret != -ENOENT && ret != ENOSYS)
 		return ret;
 
 	if (of_property_read_bool(np, "disable-wp"))
-- 
1.9.1

