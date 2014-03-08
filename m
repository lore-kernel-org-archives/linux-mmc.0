From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RESEND] mmc: sdhci-s3c: Remove unused define for NUM_GPIOS
Date: Sat, 08 Mar 2014 15:03:44 +0800
Message-ID: <1394262224.3868.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:62963 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911AbaCHHDt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 8 Mar 2014 02:03:49 -0500
Received: by mail-pa0-f42.google.com with SMTP id fb1so5134823pad.15
        for <linux-mmc@vger.kernel.org>; Fri, 07 Mar 2014 23:03:48 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org

NUM_GPIOS is not used after commit e19499ae
"mmc: sdhci-s3c: let device core setup the default pin configuration".
Thus remove it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
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



