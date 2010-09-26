From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: seperate out reset so if platform specific helper
 exists it is called
Date: Sat, 25 Sep 2010 17:44:39 -0700
Message-ID: <06FF83D7-6C8A-47FE-934B-E1F21E7AB915@marvell.com>
References: <E6553F30-7D88-476A-A8AF-3F7793FA4DE0@marvell.com>
 <A8DEF24B-343B-4ED8-B556-12E3550506A9@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:35553 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754013Ab0IZAom convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 25 Sep 2010 20:44:42 -0400
In-Reply-To: <A8DEF24B-343B-4ED8-B556-12E3550506A9@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

>From ae9c828941b7d170881ef62190b6d5d90d122ece Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Sat, 25 Sep 2010 17:36:42 -0700
Subject: [PATCH] sdhci: seperate out reset so if platform specific helper exists it is called
 if it exists otherwise standard reset function is called.  This way the platform
 specific code and use the standard code if needed.

for example in our driver we need to reset some platform specific registers depending
on the type of reset

a) if not reset_all -> just call the helper
b) if reset_all --> call the helper then do our private stuff

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |   10 +++++++++-
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 17f1554..451fad3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -138,7 +138,7 @@ static void sdhci_disable_card_detection(struct sdhci_host *host)
 	sdhci_set_card_detection(host, false);
 }
 
-static void sdhci_reset(struct sdhci_host *host, u8 mask)
+void sdhci_reset_helper(struct sdhci_host *host, u8 mask)
 {
 	unsigned long timeout;
 	u32 uninitialized_var(ier);
@@ -176,6 +176,14 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 		sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, ier);
 }
 
+static void sdhci_reset(struct sdhci_host *host, u8 mask)
+{
+	if (host->ops->sdhci_reset)
+		return host->ops->sdhci_reset(host, mask);
+	else
+		return sdhci_reset_helper(host, mask);
+}
+
 static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 
 static void sdhci_init(struct sdhci_host *host, int soft)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index a41ad8c..f8c18cd 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -323,6 +323,7 @@ struct sdhci_ops {
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
+	void	(*sdhci_reset)(struct sdhci_host *host, u8 mask);
 	int	(*get_ro)(struct mmc_host *mmc);
 };
 
-- 
1.6.0.4

