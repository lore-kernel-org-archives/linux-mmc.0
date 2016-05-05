From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC v2 09/13] power: pwrseq: Add support for USB hubs with external
 power
Date: Thu, 05 May 2016 14:34:22 +0200
Message-ID: <1462451666-17945-10-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: hverkuil@xs4all.nl, tjakobi@math.uni-bielefeld.de, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, m.szyprowski@samsung.com
List-Id: linux-mmc@vger.kernel.org

Some USB devices on embedded boards have external power supply which has
to be reset in certain conditions. Add pwrseq interface for this.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/power/pwrseq/pwrseq.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/pwrseq.h        |  8 ++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/power/pwrseq/pwrseq.c b/drivers/power/pwrseq/pwrseq.c
index 495a19d3c30b..306265f55a10 100644
--- a/drivers/power/pwrseq/pwrseq.c
+++ b/drivers/power/pwrseq/pwrseq.c
@@ -52,6 +52,43 @@ int mmc_pwrseq_alloc(struct mmc_host *host)
 }
 EXPORT_SYMBOL_GPL(mmc_pwrseq_alloc);
 
+struct pwrseq *pwrseq_alloc(struct device *dev)
+{
+	struct device_node *np;
+	struct pwrseq *p, *ret = NULL;
+
+	np = of_parse_phandle(dev->of_node, "usb-pwrseq", 0);
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
+	/* FIXME: this path can be simplified... */
+	if (!ret) {
+		dev_info(dev, "usb-pwrseq defer\n");
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
@@ -84,6 +121,13 @@ void mmc_pwrseq_free(struct mmc_host *host)
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
index fcc8fd855d4c..c3c91f50e4cb 100644
--- a/include/linux/pwrseq.h
+++ b/include/linux/pwrseq.h
@@ -31,9 +31,13 @@ void pwrseq_unregister(struct pwrseq *pwrseq);
 void pwrseq_pre_power_on(struct pwrseq *pwrseq);
 void pwrseq_post_power_on(struct pwrseq *pwrseq);
 void pwrseq_power_off(struct pwrseq *pwrseq);
+
 int mmc_pwrseq_alloc(struct mmc_host *host);
 void mmc_pwrseq_free(struct mmc_host *host);
 
+struct pwrseq *pwrseq_alloc(struct device *dev);
+void pwrseq_free(const struct pwrseq *pwrseq);
+
 #else /* CONFIG_POWER_SEQ */
 
 static inline int pwrseq_register(struct pwrseq *pwrseq)
@@ -44,9 +48,13 @@ static inline void pwrseq_unregister(struct pwrseq *pwrseq) {}
 static inline void pwrseq_pre_power_on(struct pwrseq *pwrseq) {}
 static inline void pwrseq_post_power_on(struct pwrseq *pwrseq) {}
 static inline void pwrseq_power_off(struct pwrseq *pwrseq) {}
+
 static inline int mmc_pwrseq_alloc(struct mmc_host *host) { return 0; }
 static inline void mmc_pwrseq_free(struct mmc_host *host) {}
 
+static inline struct pwrseq *pwrseq_alloc(struct device *dev) { return NULL; }
+static inline void pwrseq_free(const struct pwrseq *pwrseq) {}
+
 #endif /* CONFIG_POWER_SEQ */
 
 #endif /* _LINUX_PWRSEQ_H */
-- 
1.9.1
