From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/3] MAINTAINERS: mmc: Update filepath to cover all files for sdhci-s3c
Date: Fri, 13 Mar 2015 13:51:33 +0100
Message-ID: <1426251093-10885-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:43133 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755095AbbCMMvm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Mar 2015 08:51:42 -0400
Received: by labge10 with SMTP id ge10so21899002lab.10
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2015 05:51:40 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6239a30..78a22aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8680,7 +8680,7 @@ SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER
 M:	Ben Dooks <ben-linux@fluff.org>
 L:	linux-mmc@vger.kernel.org
 S:	Maintained
-F:	drivers/mmc/host/sdhci-s3c.c
+F:	drivers/mmc/host/sdhci-s3c*
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) ST SPEAR DRIVER
 M:	Viresh Kumar <viresh.linux@gmail.com>
-- 
1.9.1

