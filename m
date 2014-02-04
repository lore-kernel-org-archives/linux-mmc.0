From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 04/17] mmc: mmci: Let runtime PM callbacks be available for CONFIG_PM
Date: Tue,  4 Feb 2014 16:58:45 +0100
Message-ID: <1391529538-21685-5-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:32805 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071AbaBDP7a (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Feb 2014 10:59:30 -0500
Received: by mail-lb0-f176.google.com with SMTP id w7so6482837lbi.21
        for <linux-mmc@vger.kernel.org>; Tue, 04 Feb 2014 07:59:28 -0800 (PST)
In-Reply-To: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
Cc: Alessandro Rubini <rubini@unipv.it>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

Convert to the SET_PM_RUNTIME_PM macro while defining the runtime PM
callbacks. This means the callbacks becomes available for both
CONFIG_PM_SLEEP and CONFIG_PM_RUNTIME, which is needed to handle the
combinations of these scenarios.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 178868a..c88da1c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1753,7 +1753,7 @@ static int mmci_resume(struct device *dev)
 }
 #endif
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 static void mmci_save(struct mmci_host *host)
 {
 	unsigned long flags;
@@ -1821,7 +1821,7 @@ static int mmci_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops mmci_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(mmci_suspend, mmci_resume)
-	SET_RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
+	SET_PM_RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
 };
 
 static struct amba_id mmci_ids[] = {
-- 
1.7.9.5

