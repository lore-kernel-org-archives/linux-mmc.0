From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH] mmc: sdhci-s3c: Fix return value in sdhci_s3c_suspend/resume()
Date: Wed, 29 Jun 2011 11:38:38 +0900
Message-ID: <1309315118-16133-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, Wonil Choi <wonil22.choi@samsung.com>, Minho Ban <mhban@samsung.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

From: Wonil Choi <wonil22.choi@samsung.com>

Signed-off-by: Wonil Choi <wonil22.choi@samsung.com>
Signed-off-by: Minho Ban <mhban@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 69e3ee3..460ffaf 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -612,16 +612,14 @@ static int sdhci_s3c_suspend(struct platform_device *dev, pm_message_t pm)
 {
 	struct sdhci_host *host = platform_get_drvdata(dev);
 
-	sdhci_suspend_host(host, pm);
-	return 0;
+	return sdhci_suspend_host(host, pm);
 }
 
 static int sdhci_s3c_resume(struct platform_device *dev)
 {
 	struct sdhci_host *host = platform_get_drvdata(dev);
 
-	sdhci_resume_host(host);
-	return 0;
+	return sdhci_resume_host(host);
 }
 
 #else
-- 
1.7.1
