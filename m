From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] MAINTAINERS: mmc: Add Jaehoon as co-maintainer for SDHCI SAMSUNG DRIVER
Date: Fri, 20 Mar 2015 10:15:29 +0100
Message-ID: <1426842929-3810-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:35271 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbbCTJPe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Mar 2015 05:15:34 -0400
Received: by lbcgn8 with SMTP id gn8so70779704lbc.2
        for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2015 02:15:33 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>

Jaehoon has volunteered in maintaining the SDHCI SAMSUNG DRIVER so
add him.

Since we are updating this section let's also correct file path to
cover all files for sdhci-s3c.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e1abe8..b7b7267 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8689,9 +8689,10 @@ F:	drivers/mmc/host/sdhci-pltfm.[ch]
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER
 M:	Ben Dooks <ben-linux@fluff.org>
+M:	Jaehoon Chung <jh80.chung@samsung.com>
 L:	linux-mmc@vger.kernel.org
 S:	Maintained
-F:	drivers/mmc/host/sdhci-s3c.c
+F:	drivers/mmc/host/sdhci-s3c*
 
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) ST SPEAR DRIVER
 M:	Viresh Kumar <viresh.linux@gmail.com>
-- 
1.9.1

