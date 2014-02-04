From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 02/17] amba: Add late and early PM callbacks
Date: Tue,  4 Feb 2014 16:58:43 +0100
Message-ID: <1391529538-21685-3-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
Cc: Alessandro Rubini <rubini@unipv.it>, Linus Walleij <linus.walleij@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <chris@printf.net>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

To give provision for amba drivers to make use of the late|early PM
callbacks, we point the amba bus PM callbacks to the generic versions
of these.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/amba/bus.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 3cf61a1..c255d62 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -123,6 +123,12 @@ static const struct dev_pm_ops amba_pm = {
 	.thaw		= pm_generic_thaw,
 	.poweroff	= pm_generic_poweroff,
 	.restore	= pm_generic_restore,
+	.suspend_late	= pm_generic_suspend_late,
+	.resume_early	= pm_generic_resume_early,
+	.freeze_late	= pm_generic_freeze_late,
+	.thaw_early	= pm_generic_thaw_early,
+	.poweroff_late	= pm_generic_poweroff_late,
+	.restore_early	= pm_generic_restore_early,
 	SET_PM_RUNTIME_PM_OPS(
 		amba_pm_runtime_suspend,
 		amba_pm_runtime_resume,
-- 
1.7.9.5
