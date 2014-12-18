From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6/6] mmc: core: Return error at failure of request CD/WP in mmc_of_parse()
Date: Thu, 18 Dec 2014 10:41:44 +0100
Message-ID: <1418895704-25908-7-git-send-email-ulf.hansson@linaro.org>
References: <1418895704-25908-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:64703 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbaLRJmH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 04:42:07 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so1092769wid.15
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 01:42:05 -0800 (PST)
In-Reply-To: <1418895704-25908-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

Instead of just printing an error when mmc_of_parse() fails to request
CD/WP GPIO pins, let's propagate all errors, except for -ENOENT.
Earlier only -EPROBE_DEFER was handled correctly.

As a side effect of this change and by relying on host drivers to
handle the errors during ->probe(), we don't need to free any data in
the error path.

This also means we are actually fixing a bug, since we remove the call
to mmc_gpio_free_cd() which wasn't the correct function to invoke to
handle cleanup. Instead that should have been mmc_gpiod_free_cd().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/host.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 270d58a..45c2dae 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -367,16 +367,10 @@ int mmc_of_parse(struct mmc_host *host)
 
 		ret = mmc_gpiod_request_cd(host, "cd", 0, true,
 					   0, &cd_gpio_invert);
-		if (ret) {
-			if (ret == -EPROBE_DEFER)
-				return ret;
-			if (ret != -ENOENT) {
-				dev_err(host->parent,
-					"Failed to request CD GPIO: %d\n",
-					ret);
-			}
-		} else
+		if (!ret)
 			dev_info(host->parent, "Got CD GPIO\n");
+		else if (ret != -ENOENT)
+			return ret;
 
 		/*
 		 * There are two ways to flag that the CD line is inverted:
@@ -397,16 +391,10 @@ int mmc_of_parse(struct mmc_host *host)
 	ro_cap_invert = of_property_read_bool(np, "wp-inverted");
 
 	ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0, &ro_gpio_invert);
-	if (ret) {
-		if (ret == -EPROBE_DEFER)
-			goto out;
-		if (ret != -ENOENT) {
-			dev_err(host->parent,
-				"Failed to request WP GPIO: %d\n",
-				ret);
-		}
-	} else
+	if (!ret)
 		dev_info(host->parent, "Got WP GPIO\n");
+	else if (ret != -ENOENT)
+		return ret;
 
 	/* See the comment on CD inversion above */
 	if (ro_cap_invert ^ ro_gpio_invert)
@@ -458,10 +446,6 @@ int mmc_of_parse(struct mmc_host *host)
 	}
 
 	return 0;
-
-out:
-	mmc_gpio_free_cd(host);
-	return ret;
 }
 
 EXPORT_SYMBOL(mmc_of_parse);
-- 
1.9.1

