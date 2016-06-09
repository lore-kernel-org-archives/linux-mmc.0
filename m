From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC v4 09/14] power: pwrseq: Add support for USB hubs with external
 power
Date: Thu, 09 Jun 2016 11:44:26 +0200
Message-ID: <1465465471-28740-10-git-send-email-k.kozlowski@samsung.com>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Some USB devices on embedded boards have external power supply which has
to be reset in certain conditions. Add pwrseq interface for this.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/pwrseq/pwrseq.c | 47 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pwrseq.h        | 11 ++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/power/pwrseq/pwrseq.c b/drivers/power/pwrseq/pwrseq.c
index 495a19d3c30b..722aff4f740f 100644
--- a/drivers/power/pwrseq/pwrseq.c
+++ b/drivers/power/pwrseq/pwrseq.c
@@ -1,7 +1,9 @@
 /*
- *  Copyright (C) 2014 Linaro Ltd
+ * Copyright (C) 2014 Linaro Ltd
+ * Copyright (C) 2016 Samsung Electronics
  *
  * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *         Krzysztof Kozlowski <k.kozlowski@samsung.com>
  *
  * License terms: GNU General Public License (GPL) version 2
  *
@@ -52,6 +54,42 @@ int mmc_pwrseq_alloc(struct mmc_host *host)
 }
 EXPORT_SYMBOL_GPL(mmc_pwrseq_alloc);
 
+struct pwrseq *pwrseq_alloc(struct device *dev, const char *phandle_name)
+{
+	struct device_node *np;
+	struct pwrseq *p, *ret = NULL;
+
+	np = of_parse_phandle(dev->of_node, phandle_name, 0);
+	if (!np)
+		return NULL;
+
+	mutex_lock(&pwrseq_list_mutex);
+	list_for_each_entry(p, &pwrseq_list, pwrseq_node) {
+		if (p->dev->of_node == np) {
+			if (!try_module_get(p->owner))
+				dev_err(dev,
+					"increasing module refcount failed\n");
+			else
+				ret = p;
+
+			break;
+		}
+	}
+
+	of_node_put(np);
+	mutex_unlock(&pwrseq_list_mutex);
+
+	if (!ret) {
+		dev_dbg(dev, "%s defer probe\n", phandle_name);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	dev_info(dev, "allocated usb-pwrseq\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pwrseq_alloc);
+
 void pwrseq_pre_power_on(struct pwrseq *pwrseq)
 {
 	if (pwrseq && pwrseq->ops->pre_power_on)
@@ -84,6 +122,13 @@ void mmc_pwrseq_free(struct mmc_host *host)
 }
 EXPORT_SYMBOL_GPL(mmc_pwrseq_free);
 
+void pwrseq_free(const struct pwrseq *pwrseq)
+{
+	if (pwrseq)
+		module_put(pwrseq->owner);
+}
+EXPORT_SYMBOL_GPL(pwrseq_free);
+
 int pwrseq_register(struct pwrseq *pwrseq)
 {
 	if (!pwrseq || !pwrseq->ops || !pwrseq->dev)
diff --git a/include/linux/pwrseq.h b/include/linux/pwrseq.h
index fcc8fd855d4c..6215b3d6350d 100644
--- a/include/linux/pwrseq.h
+++ b/include/linux/pwrseq.h
@@ -31,9 +31,13 @@ void pwrseq_unregister(struct pwrseq *pwrseq);
 void pwrseq_pre_power_on(struct pwrseq *pwrseq);
 void pwrseq_post_power_on(struct pwrseq *pwrseq);
 void pwrseq_power_off(struct pwrseq *pwrseq);
+
 int mmc_pwrseq_alloc(struct mmc_host *host);
 void mmc_pwrseq_free(struct mmc_host *host);
 
+struct pwrseq *pwrseq_alloc(struct device *dev, const char *phandle_name);
+void pwrseq_free(const struct pwrseq *pwrseq);
+
 #else /* CONFIG_POWER_SEQ */
 
 static inline int pwrseq_register(struct pwrseq *pwrseq)
@@ -44,9 +48,16 @@ static inline void pwrseq_unregister(struct pwrseq *pwrseq) {}
 static inline void pwrseq_pre_power_on(struct pwrseq *pwrseq) {}
 static inline void pwrseq_post_power_on(struct pwrseq *pwrseq) {}
 static inline void pwrseq_power_off(struct pwrseq *pwrseq) {}
+
 static inline int mmc_pwrseq_alloc(struct mmc_host *host) { return 0; }
 static inline void mmc_pwrseq_free(struct mmc_host *host) {}
 
+static inline struct pwrseq *pwrseq_alloc(struct device *dev, const char *phandle_name)
+{
+	return NULL;
+}
+static inline void pwrseq_free(const struct pwrseq *pwrseq) {}
+
 #endif /* CONFIG_POWER_SEQ */
 
 #endif /* _LINUX_PWRSEQ_H */
-- 
1.9.1
