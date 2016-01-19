From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 2/3] mmc: pwrseq_emmc: add to_pwrseq_emmc() macro
Date: Tue, 19 Jan 2016 10:59:08 +0000
Message-ID: <1453201148-2547-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1453201052-2347-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453201052-2347-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds to_pwrseq_emmc() macro to make the code more readable.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/core/pwrseq_emmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
index ad4f94e..7978fb7 100644
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
