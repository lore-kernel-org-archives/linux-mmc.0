From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 5/5 fixed] sdhci-s3c: add support for new card detection methods
Date: Thu, 10 Jun 2010 14:06:03 +0200
Message-ID: <1276171563-6612-1-git-send-email-m.szyprowski@samsung.com>
References: <1276076383-24825-6-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1276076383-24825-6-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: m.szyprowski@samsung.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

On some Samsung SoCs not all SDHCI controllers have card detect (CD)
line. For some embedded designs it is not even needed, because ususally
the device (like SDIO flash memory or wifi controller) is permanently
wired to the controller. There are also systems which have a card detect
line connected to some of the external interrupt lines or the presence
of the card depends on some other actions (like enabling a power
regulator).

This patch adds support for all these cases. The following card
detection methods are possible:

1. internal sdhci host card detect line
2. external event
3. no card detect line, controller will poll for the card
4. no card detect line, card is permanently wired to the controller
(once detected host won't poll it any more)

By default, all existing code would use method #1, what is compatible
with the previous version of the driver.

In case of external event, two callbacks must be provided in platdata:
ext_cd_init and ext_cd_cleanup. Both of them get a callback to a
function that notifies the s3c-sdhci host contoller as their argument.
That callback function should be called from the even dispatcher to let
host notice the card insertion/removal.

This patch adds changes to sdhci-s3c driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---

This is a quick resend, in the previous version one line was missing in the
sdhci_s3c_remove() function causing a compilation break.

 drivers/mmc/host/sdhci-s3c.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 615008d..f472295 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -242,6 +242,29 @@ static struct sdhci_ops sdhci_s3c_ops = {
 	.get_min_clock		= sdhci_s3c_get_min_clock,
 };
 
+static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
+{
+	struct sdhci_host *host;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	host = platform_get_drvdata(dev);
+	if (host) {
+		if (state) {
+			dev_info(&dev->dev, "card inserted.\n");
+			host->flags &= ~SDHCI_DEVICE_DEAD;
+			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+			tasklet_schedule(&host->card_tasklet);
+		} else {
+			dev_info(&dev->dev, "card removed.\n");
+			host->flags |= SDHCI_DEVICE_DEAD;
+			host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+			tasklet_schedule(&host->card_tasklet);
+		}
+	}
+	local_irq_restore(flags);
+}
+
 static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 {
 	struct s3c_sdhci_platdata *pdata = pdev->dev.platform_data;
@@ -362,6 +385,13 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ;
 	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+	if (pdata->cd_type == S3C_SDHCI_CD_NONE ||
+	    pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+
+	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
+		host->mmc->caps = MMC_CAP_NONREMOVABLE;
+
 	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
 			 SDHCI_QUIRK_32BIT_DMA_SIZE);
 
@@ -371,6 +401,11 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 		goto err_add_host;
 	}
 
+	/* pdata->ext_cd_init might call sdhci_s3c_notify_change immediately,
+	   so it can be called only after sdhci_add_host() */
+	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_init)
+		pdata->ext_cd_init(&sdhci_s3c_notify_change);
+
 	return 0;
 
  err_add_host:
@@ -395,10 +430,14 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 
 static int __devexit sdhci_s3c_remove(struct platform_device *pdev)
 {
+	struct s3c_sdhci_platdata *pdata = pdev->dev.platform_data;
 	struct sdhci_host *host =  platform_get_drvdata(pdev);
 	struct sdhci_s3c *sc = sdhci_priv(host);
 	int ptr;
 
+	if (pdata->cd_type == S3C_SDHCI_CD_EXTERNAL && pdata->ext_cd_cleanup)
+		pdata->ext_cd_cleanup(&sdhci_s3c_notify_change);
+
 	sdhci_remove_host(host, 1);
 
 	for (ptr = 0; ptr < 3; ptr++) {
-- 
1.7.1.240.g225c
