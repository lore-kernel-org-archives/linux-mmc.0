From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC v2 05/13] power: pwrseq: Remove mmc prefix from mmc_pwrseq
Date: Thu, 05 May 2016 14:34:18 +0200
Message-ID: <1462451666-17945-6-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1462451666-17945-1-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The "mmc" prefix is no longer needed after moving the pwrseq core code
from mmc/ to power/.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/power/pwrseq/pwrseq.c        | 18 +++++++++---------
 drivers/power/pwrseq/pwrseq_emmc.c   |  8 ++++----
 drivers/power/pwrseq/pwrseq_simple.c |  8 ++++----
 include/linux/mmc/host.h             |  4 ++--
 include/linux/pwrseq.h               | 20 ++++++++++----------
 5 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/power/pwrseq/pwrseq.c b/drivers/power/pwrseq/pwrseq.c
index 66310d7643cc..9c665821f890 100644
--- a/drivers/power/pwrseq/pwrseq.c
+++ b/drivers/power/pwrseq/pwrseq.c
@@ -21,7 +21,7 @@ static LIST_HEAD(pwrseq_list);
 int mmc_pwrseq_alloc(struct mmc_host *host)
 {
 	struct device_node *np;
-	struct mmc_pwrseq *p;
+	struct pwrseq *p;
 
 	np = of_parse_phandle(host->parent->of_node, "mmc-pwrseq", 0);
 	if (!np)
@@ -54,7 +54,7 @@ EXPORT_SYMBOL_GPL(mmc_pwrseq_alloc);
 
 void mmc_pwrseq_pre_power_on(struct mmc_host *host)
 {
-	struct mmc_pwrseq *pwrseq = host->pwrseq;
+	struct pwrseq *pwrseq = host->pwrseq;
 
 	if (pwrseq && pwrseq->ops->pre_power_on)
 		pwrseq->ops->pre_power_on(host);
@@ -63,7 +63,7 @@ EXPORT_SYMBOL_GPL(mmc_pwrseq_pre_power_on);
 
 void mmc_pwrseq_post_power_on(struct mmc_host *host)
 {
-	struct mmc_pwrseq *pwrseq = host->pwrseq;
+	struct pwrseq *pwrseq = host->pwrseq;
 
 	if (pwrseq && pwrseq->ops->post_power_on)
 		pwrseq->ops->post_power_on(host);
@@ -72,7 +72,7 @@ EXPORT_SYMBOL_GPL(mmc_pwrseq_post_power_on);
 
 void mmc_pwrseq_power_off(struct mmc_host *host)
 {
-	struct mmc_pwrseq *pwrseq = host->pwrseq;
+	struct pwrseq *pwrseq = host->pwrseq;
 
 	if (pwrseq && pwrseq->ops->power_off)
 		pwrseq->ops->power_off(host);
@@ -81,7 +81,7 @@ EXPORT_SYMBOL_GPL(mmc_pwrseq_power_off);
 
 void mmc_pwrseq_free(struct mmc_host *host)
 {
-	struct mmc_pwrseq *pwrseq = host->pwrseq;
+	struct pwrseq *pwrseq = host->pwrseq;
 
 	if (pwrseq) {
 		module_put(pwrseq->owner);
@@ -90,7 +90,7 @@ void mmc_pwrseq_free(struct mmc_host *host)
 }
 EXPORT_SYMBOL_GPL(mmc_pwrseq_free);
 
-int mmc_pwrseq_register(struct mmc_pwrseq *pwrseq)
+int pwrseq_register(struct pwrseq *pwrseq)
 {
 	if (!pwrseq || !pwrseq->ops || !pwrseq->dev)
 		return -EINVAL;
@@ -101,9 +101,9 @@ int mmc_pwrseq_register(struct mmc_pwrseq *pwrseq)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mmc_pwrseq_register);
+EXPORT_SYMBOL_GPL(pwrseq_register);
 
-void mmc_pwrseq_unregister(struct mmc_pwrseq *pwrseq)
+void pwrseq_unregister(struct pwrseq *pwrseq)
 {
 	if (pwrseq) {
 		mutex_lock(&pwrseq_list_mutex);
@@ -111,4 +111,4 @@ void mmc_pwrseq_unregister(struct mmc_pwrseq *pwrseq)
 		mutex_unlock(&pwrseq_list_mutex);
 	}
 }
-EXPORT_SYMBOL_GPL(mmc_pwrseq_unregister);
+EXPORT_SYMBOL_GPL(pwrseq_unregister);
diff --git a/drivers/power/pwrseq/pwrseq_emmc.c b/drivers/power/pwrseq/pwrseq_emmc.c
index a0583ed46d7f..a68ac9a68e04 100644
--- a/drivers/power/pwrseq/pwrseq_emmc.c
+++ b/drivers/power/pwrseq/pwrseq_emmc.c
@@ -22,7 +22,7 @@
 #include <linux/mmc/host.h>
 
 struct mmc_pwrseq_emmc {
-	struct mmc_pwrseq pwrseq;
+	struct pwrseq pwrseq;
 	struct notifier_block reset_nb;
 	struct gpio_desc *reset_gpio;
 };
@@ -54,7 +54,7 @@ static int mmc_pwrseq_emmc_reset_nb(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
-static const struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
+static const struct pwrseq_ops mmc_pwrseq_emmc_ops = {
 	.post_power_on = mmc_pwrseq_emmc_reset,
 };
 
@@ -85,7 +85,7 @@ static int mmc_pwrseq_emmc_probe(struct platform_device *pdev)
 	pwrseq->pwrseq.owner = THIS_MODULE;
 	platform_set_drvdata(pdev, pwrseq);
 
-	return mmc_pwrseq_register(&pwrseq->pwrseq);
+	return pwrseq_register(&pwrseq->pwrseq);
 }
 
 static int mmc_pwrseq_emmc_remove(struct platform_device *pdev)
@@ -93,7 +93,7 @@ static int mmc_pwrseq_emmc_remove(struct platform_device *pdev)
 	struct mmc_pwrseq_emmc *pwrseq = platform_get_drvdata(pdev);
 
 	unregister_restart_handler(&pwrseq->reset_nb);
-	mmc_pwrseq_unregister(&pwrseq->pwrseq);
+	pwrseq_unregister(&pwrseq->pwrseq);
 
 	return 0;
 }
diff --git a/drivers/power/pwrseq/pwrseq_simple.c b/drivers/power/pwrseq/pwrseq_simple.c
index 786f1db53a3f..d5fbd653153e 100644
--- a/drivers/power/pwrseq/pwrseq_simple.c
+++ b/drivers/power/pwrseq/pwrseq_simple.c
@@ -21,7 +21,7 @@
 #include <linux/mmc/host.h>
 
 struct mmc_pwrseq_simple {
-	struct mmc_pwrseq pwrseq;
+	struct pwrseq pwrseq;
 	bool clk_enabled;
 	struct clk *ext_clk;
 	struct gpio_descs *reset_gpios;
@@ -77,7 +77,7 @@ static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
 	}
 }
 
-static const struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
+static const struct pwrseq_ops mmc_pwrseq_simple_ops = {
 	.pre_power_on = mmc_pwrseq_simple_pre_power_on,
 	.post_power_on = mmc_pwrseq_simple_post_power_on,
 	.power_off = mmc_pwrseq_simple_power_off,
@@ -115,14 +115,14 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 	pwrseq->pwrseq.owner = THIS_MODULE;
 	platform_set_drvdata(pdev, pwrseq);
 
-	return mmc_pwrseq_register(&pwrseq->pwrseq);
+	return pwrseq_register(&pwrseq->pwrseq);
 }
 
 static int mmc_pwrseq_simple_remove(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_simple *pwrseq = platform_get_drvdata(pdev);
 
-	mmc_pwrseq_unregister(&pwrseq->pwrseq);
+	pwrseq_unregister(&pwrseq->pwrseq);
 
 	return 0;
 }
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 85800b48241f..ad281bb3475f 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -203,7 +203,7 @@ struct mmc_context_info {
 };
 
 struct regulator;
-struct mmc_pwrseq;
+struct pwrseq;
 
 struct mmc_supply {
 	struct regulator *vmmc;		/* Card power supply */
@@ -215,7 +215,7 @@ struct mmc_host {
 	struct device		class_dev;
 	int			index;
 	const struct mmc_host_ops *ops;
-	struct mmc_pwrseq	*pwrseq;
+	struct pwrseq		*pwrseq;
 	unsigned int		f_min;
 	unsigned int		f_max;
 	unsigned int		f_init;
diff --git a/include/linux/pwrseq.h b/include/linux/pwrseq.h
index e230670c1d8d..6d2d2a44ad35 100644
--- a/include/linux/pwrseq.h
+++ b/include/linux/pwrseq.h
@@ -5,19 +5,19 @@
  *
  * License terms: GNU General Public License (GPL) version 2
  */
-#ifndef _MMC_CORE_PWRSEQ_H
-#define _MMC_CORE_PWRSEQ_H
+#ifndef _LINUX_PWRSEQ_H
+#define _LINUX_PWRSEQ_H
 
 #include <linux/mmc/host.h>
 
-struct mmc_pwrseq_ops {
+struct pwrseq_ops {
 	void (*pre_power_on)(struct mmc_host *host);
 	void (*post_power_on)(struct mmc_host *host);
 	void (*power_off)(struct mmc_host *host);
 };
 
-struct mmc_pwrseq {
-	const struct mmc_pwrseq_ops *ops;
+struct pwrseq {
+	const struct pwrseq_ops *ops;
 	struct device *dev;
 	struct list_head pwrseq_node;
 	struct module *owner;
@@ -25,8 +25,8 @@ struct mmc_pwrseq {
 
 #ifdef CONFIG_POWER_SEQ
 
-int mmc_pwrseq_register(struct mmc_pwrseq *pwrseq);
-void mmc_pwrseq_unregister(struct mmc_pwrseq *pwrseq);
+int pwrseq_register(struct pwrseq *pwrseq);
+void pwrseq_unregister(struct pwrseq *pwrseq);
 
 int mmc_pwrseq_alloc(struct mmc_host *host);
 void mmc_pwrseq_pre_power_on(struct mmc_host *host);
@@ -36,11 +36,11 @@ void mmc_pwrseq_free(struct mmc_host *host);
 
 #else /* CONFIG_POWER_SEQ */
 
-static inline int mmc_pwrseq_register(struct mmc_pwrseq *pwrseq)
+static inline int pwrseq_register(struct pwrseq *pwrseq)
 {
 	return -ENOSYS;
 }
-static inline void mmc_pwrseq_unregister(struct mmc_pwrseq *pwrseq) {}
+static inline void pwrseq_unregister(struct pwrseq *pwrseq) {}
 static inline int mmc_pwrseq_alloc(struct mmc_host *host) { return 0; }
 static inline void mmc_pwrseq_pre_power_on(struct mmc_host *host) {}
 static inline void mmc_pwrseq_post_power_on(struct mmc_host *host) {}
@@ -49,4 +49,4 @@ static inline void mmc_pwrseq_free(struct mmc_host *host) {}
 
 #endif /* CONFIG_POWER_SEQ */
 
-#endif
+#endif /* _LINUX_PWRSEQ_H */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
