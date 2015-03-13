From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH] mmc: core: do not abort if wp is disabled
Date: Fri, 13 Mar 2015 16:08:53 +0800
Message-ID: <1426234133-5889-1-git-send-email-jun.nie@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:44920 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946AbbCMIJR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Mar 2015 04:09:17 -0400
Received: by padet14 with SMTP id et14so27559024pad.11
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2015 01:09:17 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, jun.nie@linaro.org

Do not abort probe due to no detection to write protection pin,
if host specify disable-wp.

Signed-off-by: Jun Nie <jun.nie@linaro.org>

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 8be0df7..30ed253 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -394,11 +394,14 @@ int mmc_of_parse(struct mmc_host *host)
 	/* Parse Write Protection */
 	ro_cap_invert = of_property_read_bool(np, "wp-inverted");
 
-	ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0, &ro_gpio_invert);
-	if (!ret)
-		dev_info(host->parent, "Got WP GPIO\n");
-	else if (ret != -ENOENT)
-		return ret;
+	if (!of_get_property(np, "disable-wp", NULL)) {
+		ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0,
+					   &ro_gpio_invert);
+		if (!ret)
+			dev_info(host->parent, "Got WP GPIO\n");
+		else if (ret != -ENOENT)
+			return ret;
+	}
 
 	/* See the comment on CD inversion above */
 	if (ro_cap_invert ^ ro_gpio_invert)
-- 
1.9.1

