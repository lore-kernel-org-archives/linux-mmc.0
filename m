From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/2] mmc: core: Don't do eMMC HW reset when resuming the eMMC card
Date: Tue,  9 May 2017 00:09:03 +0200
Message-ID: <1494281343-18963-3-git-send-email-ulf.hansson@linaro.org>
References: <1494281343-18963-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36204 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbdEHWJL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 May 2017 18:09:11 -0400
Received: by mail-wm0-f41.google.com with SMTP id u65so100520382wmu.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 May 2017 15:09:10 -0700 (PDT)
In-Reply-To: <1494281343-18963-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Douglas Anderson <dianders@chromium.org>, Markus Reichl <m.reichl@fivetechno.de>, Anand Moon <linux.amoon@gmail.com>

In case if a pwrseq-emmc has been bound to the host, a call to
mmc_power_up() triggers an eMMC HW reset via the pwrseq_emmc's
->post_power_on() callback. This isn't really what we want, as
mmc_power_up() is called each time when resuming the card.

As a matter of fact, the current approach may also violate the eMMC spec,
as the involved delays managed in pwrseq_emmc assumes both VCC and VCCQ has
been turned on, which isn't the case for VCCQ, unless the regulator is
always on.

Fix this behaviour by aligning to the same procedure used when the mmc host
implements the ->hw_reset() callback and has the MMC_CAP_HW_RESET flag set.
In this way the eMMC HW reset is issued at card detection scan, to cope
with bogus bootloaders and in the error recovery path via the mmc specific
bus_ops->reset() callback.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c        | 2 ++
 drivers/mmc/core/mmc.c         | 2 ++
 drivers/mmc/core/pwrseq_emmc.c | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 82c45dd..ad8caf4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2597,6 +2597,8 @@ EXPORT_SYMBOL(mmc_set_blockcount);
 
 static void mmc_hw_reset_for_init(struct mmc_host *host)
 {
+	mmc_pwrseq_reset(host);
+
 	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
 		return;
 	host->ops->hw_reset(host);
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 2c87ded..e3b6bea 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -27,6 +27,7 @@
 #include "mmc_ops.h"
 #include "quirks.h"
 #include "sd_ops.h"
+#include "pwrseq.h"
 
 #define DEFAULT_CMD6_TIMEOUT_MS	500
 
@@ -2127,6 +2128,7 @@ static int mmc_reset(struct mmc_host *host)
 	} else {
 		/* Do a brute force power cycle */
 		mmc_power_cycle(host, card->ocr);
+		mmc_pwrseq_reset(host);
 	}
 	return mmc_init_card(host, card->ocr, card);
 }
diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
index adc9c0c..efb8a79 100644
--- a/drivers/mmc/core/pwrseq_emmc.c
+++ b/drivers/mmc/core/pwrseq_emmc.c
@@ -56,7 +56,7 @@ static int mmc_pwrseq_emmc_reset_nb(struct notifier_block *this,
 }
 
 static const struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
-	.post_power_on = mmc_pwrseq_emmc_reset,
+	.reset = mmc_pwrseq_emmc_reset,
 };
 
 static int mmc_pwrseq_emmc_probe(struct platform_device *pdev)
-- 
2.7.4

