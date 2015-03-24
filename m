From: NeilBrown <neil@brown.name>
Subject: [PATCH 4/4] mmc/host: use runtime_pm to switch to 1-bit mode
Date: Wed, 25 Mar 2015 07:56:10 +1100
Message-ID: <20150324205610.20572.59951.stgit@notabene.brown>
References: <20150324205316.20572.30538.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55442 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbbCXVIs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 Mar 2015 17:08:48 -0400
In-Reply-To: <20150324205316.20572.30538.stgit@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

sdio card needs to switch to 1-bit more before the
device can go to sleep.  So when the host has been unclaimed
for a while, do that using runtime_pm.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/mmc/core/host.c |   55 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/sdio.c |    4 ++-
 2 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index c205c4531b44..866df1858e6e 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -47,9 +47,64 @@ static void mmc_host_classdev_release(struct device *dev)
 	kfree(host);
 }
 
+int sdio_disable_wide(struct mmc_card *card);
+
+static int mmc_host_runtime_suspend(struct device *dev)
+{
+	/* If SDIO card is in 4bit mode, we need to
+	 * switch it to 1-bit mode so that it can
+	 * go to sleep.
+	 */
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	if (host->card && host->card->type == MMC_TYPE_SDIO &&
+		host->ios.bus_width == 4) {
+		/* The host cannot be claimed while suspending,
+		 * so we are safe
+		 */
+		BUG_ON(host->claimed);
+		host->claimed = 1;
+		host->claim_cnt = 1;
+		host->claimer = current;
+		sdio_disable_wide(host->card);
+		host->claimed = 0;
+		host->claim_cnt = 0;
+		host->claimer = NULL;
+		host->unused = 1;
+	}
+	return 0;
+}
+
+int sdio_enable_wide(struct mmc_card *card);
+static int mmc_host_runtime_resume(struct device *dev)
+{
+	struct mmc_host *host = cls_dev_to_mmc_host(dev);
+	if (host->card && host->card->type == MMC_TYPE_SDIO &&
+		host->unused) {
+		/* The host cannot be claimed while suspending,
+		 * so we are safe
+		 */
+		BUG_ON(host->claimed);
+		host->claimed = 1;
+		host->claim_cnt = 1;
+		host->claimer = current;
+		sdio_enable_wide(host->card);
+		host->claimed = 0;
+		host->claim_cnt = 0;
+		host->claimer = NULL;
+		host->unused = 0;
+	}
+	return 0;
+}
+
+static struct dev_pm_ops mmc_host_dev_pm_ops = {
+	.runtime_suspend= mmc_host_runtime_suspend,
+	.runtime_resume	= mmc_host_runtime_resume,
+};
+
 static struct class mmc_host_class = {
 	.name		= "mmc_host",
 	.dev_release	= mmc_host_classdev_release,
+	.pm		= &mmc_host_dev_pm_ops,
 };
 
 int mmc_register_host_class(void)
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index f432b11677bd..b4713be32fb9 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -200,7 +200,7 @@ out:
 	return ret;
 }
 
-static int sdio_enable_wide(struct mmc_card *card)
+int sdio_enable_wide(struct mmc_card *card)
 {
 	int ret;
 	u8 ctrl;
@@ -260,7 +260,7 @@ static int sdio_disable_cd(struct mmc_card *card)
  * Devices that remain active during a system suspend are
  * put back into 1-bit mode.
  */
-static int sdio_disable_wide(struct mmc_card *card)
+int sdio_disable_wide(struct mmc_card *card)
 {
 	int ret;
 	u8 ctrl;


