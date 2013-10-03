From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] mmc: sdhci-s3c: Remove unused define for NUM_GPIOS
Date: Thu, 03 Oct 2013 16:59:10 +0800
Message-ID: <1380790750.30876.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:48422 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab3JCI7P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Oct 2013 04:59:15 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so2142143pbb.38
        for <linux-mmc@vger.kernel.org>; Thu, 03 Oct 2013 01:59:14 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org

NUM_GPIOS is not used after commit e19499ae
"mmc: sdhci-s3c: let device core setup the default pin configuration".
Thus remove it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mmc/host/sdhci-s3c.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 926aaf6..d0732d2 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -33,9 +33,6 @@
 
 #define MAX_BUS_CLK	(4)
 
-/* Number of gpio's used is max data bus width + command and clock lines */
-#define NUM_GPIOS(x)	(x + 2)
-
 /**
  * struct sdhci_s3c - S3C SDHCI instance
  * @host: The SDHCI host created
-- 
1.8.1.2



