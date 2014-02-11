From: Shuah Khan <shuah.kh@samsung.com>
Subject: [RFT][PATCH v2] mmc: change cb710-mmc platform power management to use dev_pm_ops
Date: Tue, 11 Feb 2014 13:16:21 -0700
Message-ID: <1392149781-4991-1-git-send-email-shuah.kh@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, mirq-linux@rere.qmqm.pl, chris@printf.net
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, shuahkhan@gmail.com
List-Id: linux-mmc@vger.kernel.org

Change cb710-mmc platform driver to register pm ops using dev_pm_ops instead
of legacy pm_ops. The existing legacy suspend/resume routines are identical
and simply clear IRQ mask in the device in case it got undefined during sleep
state. Changed code to collapse suspend and resume into one .pm interface
for suspend and resume which gets installed for suspend, freeze, poweroff,
thaw, restore, and resume states.

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---

patch v2: Addresses review comments on patch v1

 drivers/mmc/host/cb710-mmc.c |   42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
index 1087b4c..ccf7a75 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -662,26 +662,6 @@ static const struct mmc_host_ops cb710_mmc_host = {
 	.get_cd = cb710_mmc_get_cd,
 };
 
-#ifdef CONFIG_PM
-
-static int cb710_mmc_suspend(struct platform_device *pdev, pm_message_t state)
-{
-	struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
-
-	cb710_mmc_enable_irq(slot, 0, ~0);
-	return 0;
-}
-
-static int cb710_mmc_resume(struct platform_device *pdev)
-{
-	struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
-
-	cb710_mmc_enable_irq(slot, 0, ~0);
-	return 0;
-}
-
-#endif /* CONFIG_PM */
-
 static int cb710_mmc_init(struct platform_device *pdev)
 {
 	struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
@@ -762,13 +742,31 @@ static int cb710_mmc_exit(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int cb710_mmc_suspend_resume(struct device *dev)
+{
+	struct cb710_slot *slot = cb710_pdev_to_slot(to_platform_device(dev));
+
+	cb710_mmc_enable_irq(slot, 0, ~0);
+	return 0;
+}
+
+static const struct dev_pm_ops cb710_mmc_dev_pm_ops = {
+	.suspend = cb710_mmc_suspend_resume,
+	.resume = cb710_mmc_suspend_resume,
+	/* Hibernate hooks */
+	.freeze = cb710_mmc_suspend_resume,
+	.thaw = cb710_mmc_suspend_resume,
+	.poweroff = cb710_mmc_suspend_resume,
+	.restore = cb710_mmc_suspend_resume,
+};
+#endif
 static struct platform_driver cb710_mmc_driver = {
 	.driver.name = "cb710-mmc",
 	.probe = cb710_mmc_init,
 	.remove = cb710_mmc_exit,
 #ifdef CONFIG_PM
-	.suspend = cb710_mmc_suspend,
-	.resume = cb710_mmc_resume,
+	.driver.pm = &cb710_mmc_dev_pm_ops,
 #endif
 };
 
-- 
1.7.10.4
