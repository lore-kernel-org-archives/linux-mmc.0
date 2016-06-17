From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 05/12] power: pwrseq: Generalize mmc_pwrseq operations by
 removing mmc prefix
Date: Fri, 17 Jun 2016 18:09:18 +0800
Message-ID: <1466158165-9380-6-git-send-email-peter.chen@nxp.com>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu, ulf.hansson@linaro.org, broonie@kernel.org, sre@kernel.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, k.kozlowski@samsung.com, stephen.boyd@linaro.org, oscar@naiandei.net, arnd@arndb.de, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, javier@osg.samsung.com, p.zabel@pengutronix.de, festevam@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

The power sequence hooks (mmc_pwrseq_pre_power_on(),
mmc_pwrseq_post_power_on() and mmc_pwrseq_power_off()) can be made more
generic to allow re-use in other subsystems. They do not need to take
pointer to struct mmc_host but instead the struct pwrseq should be
sufficient.

Remove the "mmc" prefix and use the pointer to struct pwrseq as
argument.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 drivers/mmc/core/core.c              |  6 +++---
 drivers/power/pwrseq/pwrseq.c        | 24 +++++++++---------------
 drivers/power/pwrseq/pwrseq_emmc.c   |  6 ++----
 drivers/power/pwrseq/pwrseq_simple.c | 14 ++++++--------
 include/linux/pwrseq.h               | 18 +++++++++---------
 5 files changed, 29 insertions(+), 39 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index edefc3f..09a4722 100644
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
index 9c66582..495a19d 100644
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
index a68ac9a..dbb7e75 100644
--- a/drivers/power/pwrseq/pwrseq_emmc.c
+++ b/drivers/power/pwrseq/pwrseq_emmc.c
@@ -19,8 +19,6 @@
 #include <linux/reboot.h>
 #include <linux/pwrseq.h>
 
-#include <linux/mmc/host.h>
-
 struct mmc_pwrseq_emmc {
 	struct pwrseq pwrseq;
 	struct notifier_block reset_nb;
@@ -37,9 +35,9 @@ static void __mmc_pwrseq_emmc_reset(struct mmc_pwrseq_emmc *pwrseq)
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
index d5fbd65..93807a6 100644
--- a/drivers/power/pwrseq/pwrseq_simple.c
+++ b/drivers/power/pwrseq/pwrseq_simple.c
@@ -18,8 +18,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/pwrseq.h>
 
-#include <linux/mmc/host.h>
-
 struct mmc_pwrseq_simple {
 	struct pwrseq pwrseq;
 	bool clk_enabled;
@@ -46,9 +44,9 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 	}
 }
 
-static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
+static void mmc_pwrseq_simple_pre_power_on(struct pwrseq *_pwrseq)
 {
-	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
+	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(_pwrseq);
 
 	if (!IS_ERR(pwrseq->ext_clk) && !pwrseq->clk_enabled) {
 		clk_prepare_enable(pwrseq->ext_clk);
@@ -58,16 +56,16 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
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
index 6d2d2a4..fcc8fd8 100644
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
