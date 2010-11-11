From: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Subject: [PATCH v1 3/3]implemented get_tmclk callback for SDHCI host
Date: Thu, 11 Nov 2010 17:05:53 +0800
Message-ID: <20101111090553.GD18170@intel.com>
Reply-To: "Chuanxiao.Dong" <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:8354 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab0KKJHn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Nov 2010 04:07:43 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: adrian.hunter@nokia.com, linux-mmc@vger.kernel.org

>From 30b712a99e25cb4e90807d20d2524fb74963e25e Mon Sep 17 00:00:00 2001
From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Date: Thu, 11 Nov 2010 15:49:11 +0800
Subject: [PATCH 3/3] mmc: implemented get_tmclk callback for sdhci host

get_tmclk callback will be used for calculating a suitable
max_discard_sectors value

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/host/sdhci.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 79fcca2..1575bfa 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1311,11 +1311,28 @@ out:
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+/*
+ * get the host controller timeout clock which will
+ * be used to calculate a suitable max_discard_sectors
+ * value for mmc queue
+ * */
+static unsigned int sdhci_get_tmclk(struct mmc_host *mmc)
+{
+	struct sdhci_host *host;
+	host = mmc_priv(mmc);
+
+	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
+		host->timeout_clk = host->clock / 1000;
+
+	return host->timeout_clk;
+}
+
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
 	.get_ro		= sdhci_get_ro,
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
+	.get_tmclk	= sdhci_get_tmclk,
 };
 
 /*****************************************************************************\
-- 
1.6.6.1

