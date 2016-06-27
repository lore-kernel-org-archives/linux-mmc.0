From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] mmc: s3cmci: Register cpufreq notifier only on S3C24xx
Date: Mon, 27 Jun 2016 14:52:03 +0200
Message-ID: <1467031923-10415-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:52954 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbcF0MwN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jun 2016 08:52:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

The driver registered for CPU frequency transitions to recalculate its
clock when ARM clock frequency changes (ratio between frequencies of
ARM's parent clock (fclk) and clock for peripherals remains fixed).

This is needed only on S3C24xx platform when cpufreq driver is enabled
so limit the ifdef to respective cpufreq Kconfig.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/mmc/host/s3cmci.c | 2 +-
 drivers/mmc/host/s3cmci.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 39814f3dc96f..c531deef3258 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1365,7 +1365,7 @@ static struct s3c24xx_mci_pdata s3cmci_def_pdata = {
 	 .no_detect = 1,
 };
 
-#ifdef CONFIG_CPU_FREQ
+#ifdef CONFIG_ARM_S3C24XX_CPUFREQ
 
 static int s3cmci_cpufreq_transition(struct notifier_block *nb,
 				     unsigned long val, void *data)
diff --git a/drivers/mmc/host/s3cmci.h b/drivers/mmc/host/s3cmci.h
index cc2e46cb5c64..30c2c0dd1bc8 100644
--- a/drivers/mmc/host/s3cmci.h
+++ b/drivers/mmc/host/s3cmci.h
@@ -74,7 +74,7 @@ struct s3cmci_host {
 	struct dentry		*debug_regs;
 #endif
 
-#ifdef CONFIG_CPU_FREQ
+#ifdef CONFIG_ARM_S3C24XX_CPUFREQ
 	struct notifier_block	freq_transition;
 #endif
 };
-- 
1.9.1

