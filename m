From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 06/12] mmc: core: Extend shutdown sequence to handle bus operations
Date: Mon, 10 Jun 2013 17:03:41 +0200
Message-ID: <1370876627-13439-7-git-send-email-ulf.hansson@stericsson.com>
References: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:54585 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753700Ab3FJPEU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2013 11:04:20 -0400
In-Reply-To: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

By adding an optional .shutdown callback to the bus_ops struct we
provide the possibility to let each bus type handle it's shutdown
requirements.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c  |    9 +++++++++
 drivers/mmc/core/core.h |    1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 219bf4b..4c0decf 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -126,8 +126,17 @@ static void mmc_bus_shutdown(struct device *dev)
 {
 	struct mmc_driver *drv = to_mmc_driver(dev->driver);
 	struct mmc_card *card = mmc_dev_to_card(dev);
+	struct mmc_host *host = card->host;
+	int ret;
 
 	drv->shutdown(card);
+
+	if (host->bus_ops->shutdown) {
+		ret = host->bus_ops->shutdown(host);
+		if (ret)
+			pr_warn("%s: error %d during shutdown\n",
+				mmc_hostname(host), ret);
+	}
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 79f37cf..5345d15 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -26,6 +26,7 @@ struct mmc_bus_ops {
 	int (*power_save)(struct mmc_host *);
 	int (*power_restore)(struct mmc_host *);
 	int (*alive)(struct mmc_host *);
+	int (*shutdown)(struct mmc_host *);
 };
 
 void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
-- 
1.7.10

