From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/3] mmc: pwrseq_simple: add to_pwrseq_simple() macro
Date: Wed,  2 Mar 2016 16:45:10 +0000
Message-ID: <1456937110-27286-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1456937078-27241-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35057 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461AbcCBQpS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2016 11:45:18 -0500
Received: by mail-wm0-f41.google.com with SMTP id l68so94410079wml.0
        for <linux-mmc@vger.kernel.org>; Wed, 02 Mar 2016 08:45:17 -0800 (PST)
In-Reply-To: <1456937078-27241-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mfuzzey@parkeon.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds to_pwrseq_simple() macro to make the code more readable.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/mmc/core/pwrseq_simple.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index aba786d..03573e1 100644
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
@@ -45,8 +47,7 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 
 static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
 {
-	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
-					struct mmc_pwrseq_simple, pwrseq);
+	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
 	if (!IS_ERR(pwrseq->ext_clk) && !pwrseq->clk_enabled) {
 		clk_prepare_enable(pwrseq->ext_clk);
@@ -58,16 +59,14 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
 
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
 
@@ -79,8 +78,7 @@ static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
 
 static void mmc_pwrseq_simple_free(struct mmc_host *host)
 {
-	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
-					struct mmc_pwrseq_simple, pwrseq);
+	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
 	if (!IS_ERR(pwrseq->reset_gpios))
 		gpiod_put_array(pwrseq->reset_gpios);
-- 
1.9.1

