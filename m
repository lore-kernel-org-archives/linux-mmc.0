From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 07/12] mmc: core: Add shutdown callback for SD bus_ops
Date: Mon, 10 Jun 2013 17:03:42 +0200
Message-ID: <1370876627-13439-8-git-send-email-ulf.hansson@stericsson.com>
References: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:45132 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753604Ab3FJPEW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2013 11:04:22 -0400
In-Reply-To: <1370876627-13439-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

For the SD .shutdown callback we re-use the SD suspend function since
it performs the relevant actions.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sd.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index cacef27..176d125 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -1170,6 +1170,7 @@ static const struct mmc_bus_ops mmc_sd_ops = {
 	.resume = NULL,
 	.power_restore = mmc_sd_power_restore,
 	.alive = mmc_sd_alive,
+	.shutdown = mmc_sd_suspend,
 };
 
 static const struct mmc_bus_ops mmc_sd_ops_unsafe = {
@@ -1181,6 +1182,7 @@ static const struct mmc_bus_ops mmc_sd_ops_unsafe = {
 	.resume = mmc_sd_resume,
 	.power_restore = mmc_sd_power_restore,
 	.alive = mmc_sd_alive,
+	.shutdown = mmc_sd_suspend,
 };
 
 static void mmc_sd_attach_bus_ops(struct mmc_host *host)
-- 
1.7.10

