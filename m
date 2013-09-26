From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 18/27] mmc: s3cmci: Remove redundant suspend and resume
 callbacks
Date: Thu, 26 Sep 2013 16:54:43 +0200
Message-ID: <1380207292-16968-19-git-send-email-ulf.hansson@linaro.org>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-mmc@vger.kernel.org

Suspend and resume of cards are handled by the protocol layer and
consequently the mmc_suspend|resume_host APIs are marked as deprecated.

While moving away from using the deprecated APIs, there are nothing
left to be done for the suspend and resume callbacks, so remove them.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/s3cmci.c |   29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 8d6794c..2fce5ea 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1949,39 +1949,10 @@ static struct platform_device_id s3cmci_driver_ids[] = {
 
 MODULE_DEVICE_TABLE(platform, s3cmci_driver_ids);
 
-
-#ifdef CONFIG_PM
-
-static int s3cmci_suspend(struct device *dev)
-{
-	struct mmc_host *mmc = platform_get_drvdata(to_platform_device(dev));
-
-	return mmc_suspend_host(mmc);
-}
-
-static int s3cmci_resume(struct device *dev)
-{
-	struct mmc_host *mmc = platform_get_drvdata(to_platform_device(dev));
-
-	return mmc_resume_host(mmc);
-}
-
-static const struct dev_pm_ops s3cmci_pm = {
-	.suspend	= s3cmci_suspend,
-	.resume		= s3cmci_resume,
-};
-
-#define s3cmci_pm_ops &s3cmci_pm
-#else /* CONFIG_PM */
-#define s3cmci_pm_ops NULL
-#endif /* CONFIG_PM */
-
-
 static struct platform_driver s3cmci_driver = {
 	.driver	= {
 		.name	= "s3c-sdi",
 		.owner	= THIS_MODULE,
-		.pm	= s3cmci_pm_ops,
 	},
 	.id_table	= s3cmci_driver_ids,
 	.probe		= s3cmci_probe,
-- 
1.7.9.5
