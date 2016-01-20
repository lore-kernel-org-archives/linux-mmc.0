From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 2/3] mmc: pwrseq_emmc: add to_pwrseq_emmc() macro
Date: Wed, 20 Jan 2016 10:46:22 +0000
Message-ID: <1453286782-9704-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1453286730-9616-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37055 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935007AbcATKqc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2016 05:46:32 -0500
Received: by mail-wm0-f52.google.com with SMTP id n5so22327494wmn.0
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2016 02:46:32 -0800 (PST)
In-Reply-To: <1453286730-9616-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds to_pwrseq_emmc() macro to make the code more readable.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/core/pwrseq_emmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
index 4a82bc7..c2d732a 100644
--- a/drivers/mmc/core/pwrseq_emmc.c
+++ b/drivers/mmc/core/pwrseq_emmc.c
@@ -25,6 +25,8 @@ struct mmc_pwrseq_emmc {
 	struct gpio_desc *reset_gpio;
 };
 
+#define to_pwrseq_emmc(p) container_of(p, struct mmc_pwrseq_emmc, pwrseq)
+
 static void __mmc_pwrseq_emmc_reset(struct mmc_pwrseq_emmc *pwrseq)
 {
 	gpiod_set_value(pwrseq->reset_gpio, 1);
@@ -35,16 +37,14 @@ static void __mmc_pwrseq_emmc_reset(struct mmc_pwrseq_emmc *pwrseq)
 
 static void mmc_pwrseq_emmc_reset(struct mmc_host *host)
 {
-	struct mmc_pwrseq_emmc *pwrseq = container_of(host->pwrseq,
-					struct mmc_pwrseq_emmc, pwrseq);
+	struct mmc_pwrseq_emmc *pwrseq =  to_pwrseq_emmc(host->pwrseq);
 
 	__mmc_pwrseq_emmc_reset(pwrseq);
 }
 
 static void mmc_pwrseq_emmc_free(struct mmc_host *host)
 {
-	struct mmc_pwrseq_emmc *pwrseq = container_of(host->pwrseq,
-					struct mmc_pwrseq_emmc, pwrseq);
+	struct mmc_pwrseq_emmc *pwrseq =  to_pwrseq_emmc(host->pwrseq);
 
 	unregister_restart_handler(&pwrseq->reset_nb);
 	gpiod_put(pwrseq->reset_gpio);
-- 
1.9.1

