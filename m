From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 1/3] mmc: pwrseq_simple: add to_pwrseq_simple() macro
Date: Wed, 20 Jan 2016 10:46:10 +0000
Message-ID: <1453286770-9660-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1453286730-9616-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453286730-9616-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds to_pwrseq_simple() macro to make the code more readable.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/core/pwrseq_simple.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 2b16263..3e07533 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -26,6 +26,8 @@ struct mmc_pwrseq_simple {
 	struct gpio_descs *reset_gpios;
 };
 
+#define to_pwrseq_simple(p) container_of(p, struct mmc_pwrseq_simple, pwrseq)
+
 static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 					      int value)
 {
@@ -42,8 +44,7 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 
 static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
 {
-	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
-					struct mmc_pwrseq_simple, pwrseq);
+	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
 	if (!IS_ERR(pwrseq->ext_clk) && !pwrseq->clk_enabled) {
 		clk_prepare_enable(pwrseq->ext_clk);
@@ -55,16 +56,14 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
 
 static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
 {
-	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
-					struct mmc_pwrseq_simple, pwrseq);
+	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
 }
 
 static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
 {
-	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
-					struct mmc_pwrseq_simple, pwrseq);
+	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
 
@@ -76,8 +75,7 @@ static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
 
 static void mmc_pwrseq_simple_free(struct mmc_host *host)
 {
-	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
-					struct mmc_pwrseq_simple, pwrseq);
+	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
 	gpiod_put_array(pwrseq->reset_gpios);
 
-- 
1.9.1
