From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 09/12] mmc: core: Add shutdown callback for (e)MMC bus_ops
Date: Mon, 10 Jun 2013 17:03:44 +0200
Message-ID: <1370876627-13439-10-git-send-email-ulf.hansson@stericsson.com>
References: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog121.obsmtp.com ([207.126.144.151]:57703 "EHLO
	eu1sys200aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753743Ab3FJPEW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2013 11:04:22 -0400
In-Reply-To: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

The shutdown sequence of an (e)MMC is very similar to a suspend. We
re-use the suspend function and tell it we are not in suspend context.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index dcf0169..3aafb2e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1509,6 +1509,14 @@ static int mmc_suspend(struct mmc_host *host)
 }
 
 /*
+ * Shutdown callback
+ */
+static int mmc_shutdown(struct mmc_host *host)
+{
+	return _mmc_suspend(host, false);
+}
+
+/*
  * Resume callback from host.
  *
  * This function tries to determine if the same card is still present
@@ -1597,6 +1605,7 @@ static const struct mmc_bus_ops mmc_ops = {
 	.resume = NULL,
 	.power_restore = mmc_power_restore,
 	.alive = mmc_alive,
+	.shutdown = mmc_shutdown,
 };
 
 static const struct mmc_bus_ops mmc_ops_unsafe = {
@@ -1608,6 +1617,7 @@ static const struct mmc_bus_ops mmc_ops_unsafe = {
 	.runtime_resume = mmc_runtime_resume,
 	.power_restore = mmc_power_restore,
 	.alive = mmc_alive,
+	.shutdown = mmc_shutdown,
 };
 
 static void mmc_attach_bus_ops(struct mmc_host *host)
-- 
1.7.10

