From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 06/12] power: pwrseq: change common helpers as generic
Date: Fri, 17 Jun 2016 18:09:19 +0800
Message-ID: <1466158165-9380-7-git-send-email-peter.chen@nxp.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, k.kozlowski@samsung.com, stephen.boyd@linaro.org, oscar@naiandei.net, arnd@arndb.de, pawel.moll@arm.com, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, mail@maciej.szmigiero.name, troy.kisky@boundarydevices.com, javier@osg.samsung.com, Peter Chen <peter.chen@nxp.com>, p.zabel@pengutronix.de, festevam@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

These helpers are only used by mmc now, change them as generic and
do corresponding changes at mmc code.

Meanwhile, change return value of helper pwrseq_pre_power_on since
it may occur error during enable clock/regulator, etc.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/mmc/core/host.c              |  8 +++++--
 drivers/power/pwrseq/pwrseq.c        | 45 ++++++++++++++++++------------------
 drivers/power/pwrseq/pwrseq_simple.c | 10 +++++---
 include/linux/pwrseq.h               | 31 ++++++++++++++-----------
 4 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 1db7d58..c8ffd9b 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -322,7 +322,11 @@ int mmc_of_parse(struct mmc_host *host)
 		host->dsr_req = 0;
 	}
 
-	return mmc_pwrseq_alloc(host);
+	host->pwrseq = pwrseq_alloc(host->parent->of_node, "mmc-pwrseq");
+	if (IS_ERR(host->pwrseq))
+		return PTR_ERR(host->pwrseq);
+	else
+		return 0;
 }
 
 EXPORT_SYMBOL(mmc_of_parse);
@@ -462,7 +466,7 @@ EXPORT_SYMBOL(mmc_remove_host);
  */
 void mmc_free_host(struct mmc_host *host)
 {
-	mmc_pwrseq_free(host);
+	pwrseq_free(host->pwrseq);
 	put_device(&host->class_dev);
 }
 
diff --git a/drivers/power/pwrseq/pwrseq.c b/drivers/power/pwrseq/pwrseq.c
index 495a19d..25e4dfd 100644
--- a/drivers/power/pwrseq/pwrseq.c
+++ b/drivers/power/pwrseq/pwrseq.c
@@ -5,37 +5,38 @@
  *
  * License terms: GNU General Public License (GPL) version 2
  *
- *  MMC power sequence management
+ * Power sequence management helpers
  */
+
+#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pwrseq.h>
 
-#include <linux/mmc/host.h>
 
 static DEFINE_MUTEX(pwrseq_list_mutex);
 static LIST_HEAD(pwrseq_list);
 
-int mmc_pwrseq_alloc(struct mmc_host *host)
+struct pwrseq *pwrseq_alloc(const struct device_node *node,
+	const char *phandle_name)
 {
 	struct device_node *np;
-	struct pwrseq *p;
+	struct pwrseq *p, *pwrseq = NULL;
 
-	np = of_parse_phandle(host->parent->of_node, "mmc-pwrseq", 0);
+	np = of_parse_phandle(node, phandle_name, 0);
 	if (!np)
-		return 0;
+		return NULL;
 
 	mutex_lock(&pwrseq_list_mutex);
 	list_for_each_entry(p, &pwrseq_list, pwrseq_node) {
 		if (p->dev->of_node == np) {
 			if (!try_module_get(p->owner))
-				dev_err(host->parent,
+				dev_err(p->dev,
 					"increasing module refcount failed\n");
 			else
-				host->pwrseq = p;
-
+				pwrseq = p;
 			break;
 		}
 	}
@@ -43,19 +44,21 @@ int mmc_pwrseq_alloc(struct mmc_host *host)
 	of_node_put(np);
 	mutex_unlock(&pwrseq_list_mutex);
 
-	if (!host->pwrseq)
-		return -EPROBE_DEFER;
+	if (!pwrseq)
+		return ERR_PTR(-EPROBE_DEFER);
 
-	dev_info(host->parent, "allocated mmc-pwrseq\n");
+	dev_info(p->dev, "pwrseq is allocated\n");
 
-	return 0;
+	return pwrseq;
 }
-EXPORT_SYMBOL_GPL(mmc_pwrseq_alloc);
+EXPORT_SYMBOL_GPL(pwrseq_alloc);
 
-void pwrseq_pre_power_on(struct pwrseq *pwrseq)
+int pwrseq_pre_power_on(struct pwrseq *pwrseq)
 {
 	if (pwrseq && pwrseq->ops->pre_power_on)
-		pwrseq->ops->pre_power_on(pwrseq);
+		return pwrseq->ops->pre_power_on(pwrseq);
+	else
+		return 0;
 }
 EXPORT_SYMBOL_GPL(pwrseq_pre_power_on);
 
@@ -73,16 +76,12 @@ void pwrseq_power_off(struct pwrseq *pwrseq)
 }
 EXPORT_SYMBOL_GPL(pwrseq_power_off);
 
-void mmc_pwrseq_free(struct mmc_host *host)
+void pwrseq_free(struct pwrseq *pwrseq)
 {
-	struct pwrseq *pwrseq = host->pwrseq;
-
-	if (pwrseq) {
+	if (pwrseq)
 		module_put(pwrseq->owner);
-		host->pwrseq = NULL;
-	}
 }
-EXPORT_SYMBOL_GPL(mmc_pwrseq_free);
+EXPORT_SYMBOL_GPL(pwrseq_free);
 
 int pwrseq_register(struct pwrseq *pwrseq)
 {
diff --git a/drivers/power/pwrseq/pwrseq_simple.c b/drivers/power/pwrseq/pwrseq_simple.c
index 93807a6..349443f 100644
--- a/drivers/power/pwrseq/pwrseq_simple.c
+++ b/drivers/power/pwrseq/pwrseq_simple.c
@@ -44,16 +44,20 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 	}
 }
 
-static void mmc_pwrseq_simple_pre_power_on(struct pwrseq *_pwrseq)
+static int mmc_pwrseq_simple_pre_power_on(struct pwrseq *_pwrseq)
 {
 	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(_pwrseq);
+	int ret = 0;
 
 	if (!IS_ERR(pwrseq->ext_clk) && !pwrseq->clk_enabled) {
-		clk_prepare_enable(pwrseq->ext_clk);
-		pwrseq->clk_enabled = true;
+		ret = clk_prepare_enable(pwrseq->ext_clk);
+		if (!ret)
+			pwrseq->clk_enabled = true;
 	}
 
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
+
+	return 0;
 }
 
 static void mmc_pwrseq_simple_post_power_on(struct pwrseq *_pwrseq)
diff --git a/include/linux/pwrseq.h b/include/linux/pwrseq.h
index fcc8fd8..f726e7e 100644
--- a/include/linux/pwrseq.h
+++ b/include/linux/pwrseq.h
@@ -8,14 +8,6 @@
 #ifndef _LINUX_PWRSEQ_H
 #define _LINUX_PWRSEQ_H
 
-#include <linux/mmc/host.h>
-
-struct pwrseq_ops {
-	void (*pre_power_on)(struct pwrseq *pwrseq);
-	void (*post_power_on)(struct pwrseq *pwrseq);
-	void (*power_off)(struct pwrseq *pwrseq);
-};
-
 struct pwrseq {
 	const struct pwrseq_ops *ops;
 	struct device *dev;
@@ -23,16 +15,23 @@ struct pwrseq {
 	struct module *owner;
 };
 
+struct pwrseq_ops {
+	int (*pre_power_on)(struct pwrseq *pwrseq);
+	void (*post_power_on)(struct pwrseq *pwrseq);
+	void (*power_off)(struct pwrseq *pwrseq);
+};
+
 #ifdef CONFIG_POWER_SEQ
 
 int pwrseq_register(struct pwrseq *pwrseq);
 void pwrseq_unregister(struct pwrseq *pwrseq);
 
-void pwrseq_pre_power_on(struct pwrseq *pwrseq);
+int pwrseq_pre_power_on(struct pwrseq *pwrseq);
 void pwrseq_post_power_on(struct pwrseq *pwrseq);
 void pwrseq_power_off(struct pwrseq *pwrseq);
-int mmc_pwrseq_alloc(struct mmc_host *host);
-void mmc_pwrseq_free(struct mmc_host *host);
+struct pwrseq *pwrseq_alloc(const struct device_node *node,
+	const char *phandle_name);
+void pwrseq_free(struct pwrseq *pwrseq);
 
 #else /* CONFIG_POWER_SEQ */
 
@@ -41,11 +40,15 @@ static inline int pwrseq_register(struct pwrseq *pwrseq)
 	return -ENOSYS;
 }
 static inline void pwrseq_unregister(struct pwrseq *pwrseq) {}
-static inline void pwrseq_pre_power_on(struct pwrseq *pwrseq) {}
+static inline int pwrseq_pre_power_on(struct pwrseq *pwrseq) {}
 static inline void pwrseq_post_power_on(struct pwrseq *pwrseq) {}
 static inline void pwrseq_power_off(struct pwrseq *pwrseq) {}
-static inline int mmc_pwrseq_alloc(struct mmc_host *host) { return 0; }
-static inline void mmc_pwrseq_free(struct mmc_host *host) {}
+static inline struct pwrseq *pwrseq_alloc(const struct device_node *node,
+	const char *phandle_name)
+{
+	return NULL;
+}
+static inline void pwrseq_free(struct mmc_host *host) {}
 
 #endif /* CONFIG_POWER_SEQ */
 
-- 
1.9.1
