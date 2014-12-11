From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mmc: atmel-mci: use SET_RUNTIME_PM_OPS() macro
Date: Thu, 11 Dec 2014 11:18:56 +0100
Message-ID: <1418293136-28356-1-git-send-email-ulf.hansson@linaro.org>
References: <patch_pm/0002-PM-Remove-the-SET_PM_RUNTIME_PM_OPS-macro.patch>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <patch_pm/0002-PM-Remove-the-SET_PM_RUNTIME_PM_OPS-macro.patch>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

The currently used SET_PM_RUNTIME_PM_OPS() macro is defined to the
SET_RUNTIME_PM_OPS() macro. Convert to the later, since that's the
proper one to use.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/atmel-mci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 62aba9a..03d7c75 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2561,7 +2561,7 @@ static int atmci_runtime_resume(struct device *dev)
 static const struct dev_pm_ops atmci_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
 				pm_runtime_force_resume)
-	SET_PM_RUNTIME_PM_OPS(atmci_runtime_suspend, atmci_runtime_resume, NULL)
+	SET_RUNTIME_PM_OPS(atmci_runtime_suspend, atmci_runtime_resume, NULL)
 };
 
 static struct platform_driver atmci_driver = {
-- 
1.9.1

