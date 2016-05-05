From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC v2 06/13] power: pwrseq: Generalize mmc_pwrseq operations by
 removing mmc prefix
Date: Thu, 05 May 2016 14:34:19 +0200
Message-ID: <1462451666-17945-7-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:54521 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755512AbcEEMfC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2016 08:35:02 -0400
In-reply-to: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: tjakobi@math.uni-bielefeld.de, m.szyprowski@samsung.com, hverkuil@xs4all.nl, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

The power sequence hooks (mmc_pwrseq_pre_power_on(),
mmc_pwrseq_post_power_on() and mmc_pwrseq_power_off()) can be made more
generic to allow re-use in other subsystems. They do not need to take
pointer to struct mmc_host but instead the struct pwrseq should be
sufficient.

Remove the "mmc" prefix and use the pointer to struct pwrseq as
argument.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/mmc/core/core.c              |  6 +++---
 drivers/power/pwrseq/pwrseq.c        | 24 +++++++++---------------
 drivers/power/pwrseq/pwrseq_emmc.c   |  4 ++--
 drivers/power/pwrseq/pwrseq_simple.c | 12 ++++++------
 include/linux/pwrseq.h               | 18 +++++++++---------
 5 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 0f145ff6e4f1..dfc4681054a8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1719,7 +1719,7 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	if (host->ios.power_mode == MMC_POWER_ON)
 		return;
 
-	mmc_pwrseq_pre_power_on(host);
+	pwrseq_pre_power_on(host->pwrseq);
 
 	host->ios.vdd = fls(ocr) - 1;
 	host->ios.power_mode = MMC_POWER_UP;
@@ -1740,7 +1740,7 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	 */
 	mmc_delay(10);
 
-	mmc_pwrseq_post_power_on(host);
+	pwrseq_post_power_on(host->pwrseq);
 
 	host->ios.clock = host->f_init;
 
@@ -1759,7 +1759,7 @@ void mmc_power_off(struct mmc_host *host)
 	if (host->ios.power_mode == MMC_POWER_OFF)
 		return;
 
-	mmc_pwrseq_power_off(host);
+	pwrseq_power_off(host->pwrseq);
 
 	host->ios.clock = 0;
 	host->ios.vdd = 0;
diff --git a/drivers/power/pwrseq/pwrseq.c b/drivers/power/pwrseq/pwrseq.c
index 9c665821f890..495a19d3c30b 100644
--- a/drivers/power/pwrseq/pwrseq.c
+++ b/drivers/power/pwrseq/pwrseq.c
@@ -52,32 +52,26 @@ int mmc_pwrseq_alloc(struct mmc_host *host)
 }
 EXPORT_SYMBOL_GPL(mmc_pwrseq_alloc);
 
-void mmc_pwrseq_pre_power_on(struct mmc_host *host)
+void pwrseq_pre_power_on(struct pwrseq *pwrseq)
 {
-	struct pwrseq *pwrseq = host->pwrseq;
-
 	if (pwrseq && pwrseq->ops->pre_power_on)
-		pwrseq->ops->pre_power_on(host);
+		pwrseq->ops->pre_power_on(pwrseq);
 }
-EXPORT_SYMBOL_GPL(mmc_pwrseq_pre_power_on);
+EXPORT_SYMBOL_GPL(pwrseq_pre_power_on);
 
-void mmc_pwrseq_post_power_on(struct mmc_host *host)
+void pwrseq_post_power_on(struct pwrseq *pwrseq)
 {
-	struct pwrseq *pwrseq = host->pwrseq;
-
 	if (pwrseq && pwrseq->ops->post_power_on)
-		pwrseq->ops->post_power_on(host);
+		pwrseq->ops->post_power_on(pwrseq);
 }
-EXPORT_SYMBOL_GPL(mmc_pwrseq_post_power_on);
+EXPORT_SYMBOL_GPL(pwrseq_post_power_on);
 
-void mmc_pwrseq_power_off(struct mmc_host *host)
+void pwrseq_power_off(struct pwrseq *pwrseq)
 {
-	struct pwrseq *pwrseq = host->pwrseq;
-
 	if (pwrseq && pwrseq->ops->power_off)
-		pwrseq->ops->power_off(host);
+		pwrseq->ops->power_off(pwrseq);
 }
-EXPORT_SYMBOL_GPL(mmc_pwrseq_power_off);
+EXPORT_SYMBOL_GPL(pwrseq_power_off);
 
 void mmc_pwrseq_free(struct mmc_host *host)
 {
diff --git a/drivers/power/pwrseq/pwrseq_emmc.c b/drivers/power/pwrseq/pwrseq_emmc.c
index a68ac9a68e04..82327d0223f2 100644
--- a/drivers/power/pwrseq/pwrseq_emmc.c
+++ b/drivers/power/pwrseq/pwrseq_emmc.c
@@ -37,9 +37,9 @@ static void __mmc_pwrseq_emmc_reset(struct mmc_pwrseq_emmc *pwrseq)
 	udelay(200);
 }
 
-static void mmc_pwrseq_emmc_reset(struct mmc_host *host)
+static void mmc_pwrseq_emmc_reset(struct pwrseq *_pwrseq)
 {
-	struct mmc_pwrseq_emmc *pwrseq =  to_pwrseq_emmc(host->pwrseq);
+	struct mmc_pwrseq_emmc *pwrseq = to_pwrseq_emmc(_pwrseq);
 
 	__mmc_pwrseq_emmc_reset(pwrseq);
 }
diff --git a/drivers/power/pwrseq/pwrseq_simple.c b/drivers/power/pwrseq/pwrseq_simple.c
index d5fbd653153e..ab0098412690 100644
--- a/drivers/power/pwrseq/pwrseq_simple.c
+++ b/drivers/power/pwrseq/pwrseq_simple.c
@@ -46,9 +46,9 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 	}
 }
 
-static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
+static void mmc_pwrseq_simple_pre_power_on(struct pwrseq *_pwrseq)
 {
-	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
+	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(_pwrseq);
 
 	if (!IS_ERR(pwrseq->ext_clk) && !pwrseq->clk_enabled) {
 		clk_prepare_enable(pwrseq->ext_clk);
@@ -58,16 +58,16 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
 }
 
-static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
+static void mmc_pwrseq_simple_post_power_on(struct pwrseq *_pwrseq)
 {
-	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
+	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(_pwrseq);
 
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
 }
 
-static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
+static void mmc_pwrseq_simple_power_off(struct pwrseq *_pwrseq)
 {
-	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
+	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(_pwrseq);
 
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
 
diff --git a/include/linux/pwrseq.h b/include/linux/pwrseq.h
index 6d2d2a44ad35..fcc8fd855d4c 100644
--- a/include/linux/pwrseq.h
+++ b/include/linux/pwrseq.h
@@ -11,9 +11,9 @@
 #include <linux/mmc/host.h>
 
 struct pwrseq_ops {
-	void (*pre_power_on)(struct mmc_host *host);
-	void (*post_power_on)(struct mmc_host *host);
-	void (*power_off)(struct mmc_host *host);
+	void (*pre_power_on)(struct pwrseq *pwrseq);
+	void (*post_power_on)(struct pwrseq *pwrseq);
+	void (*power_off)(struct pwrseq *pwrseq);
 };
 
 struct pwrseq {
@@ -28,10 +28,10 @@ struct pwrseq {
 int pwrseq_register(struct pwrseq *pwrseq);
 void pwrseq_unregister(struct pwrseq *pwrseq);
 
+void pwrseq_pre_power_on(struct pwrseq *pwrseq);
+void pwrseq_post_power_on(struct pwrseq *pwrseq);
+void pwrseq_power_off(struct pwrseq *pwrseq);
 int mmc_pwrseq_alloc(struct mmc_host *host);
-void mmc_pwrseq_pre_power_on(struct mmc_host *host);
-void mmc_pwrseq_post_power_on(struct mmc_host *host);
-void mmc_pwrseq_power_off(struct mmc_host *host);
 void mmc_pwrseq_free(struct mmc_host *host);
 
 #else /* CONFIG_POWER_SEQ */
@@ -41,10 +41,10 @@ static inline int pwrseq_register(struct pwrseq *pwrseq)
 	return -ENOSYS;
 }
 static inline void pwrseq_unregister(struct pwrseq *pwrseq) {}
+static inline void pwrseq_pre_power_on(struct pwrseq *pwrseq) {}
+static inline void pwrseq_post_power_on(struct pwrseq *pwrseq) {}
+static inline void pwrseq_power_off(struct pwrseq *pwrseq) {}
 static inline int mmc_pwrseq_alloc(struct mmc_host *host) { return 0; }
-static inline void mmc_pwrseq_pre_power_on(struct mmc_host *host) {}
-static inline void mmc_pwrseq_post_power_on(struct mmc_host *host) {}
-static inline void mmc_pwrseq_power_off(struct mmc_host *host) {}
 static inline void mmc_pwrseq_free(struct mmc_host *host) {}
 
 #endif /* CONFIG_POWER_SEQ */
-- 
1.9.1

