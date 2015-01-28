From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v2 4/6] mmc: pwrseq_simple: Add optional reference clock
 support
Date: Wed, 28 Jan 2015 19:15:51 +0100
Message-ID: <1422468953-7594-5-git-send-email-javier.martinez@collabora.co.uk>
References: <1422468953-7594-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422468953-7594-1-git-send-email-javier.martinez@collabora.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, Arend van Spriel <arend@broadcom.com>, Kukjin Kim <kgene@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Olof Johansson <olof@lixom.net>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Some WLAN chips attached to a SDIO interface, need a reference clock.

Since this is very common, extend the prseq_simple driver to support
an optional clock that is enabled prior the card power up procedure.

Note: the external clock is optional. Thus an error is not returned
if the clock is not found.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v1:
 - Rebase on top of latest changes.
 - Use IS_ERR() instead of checking for NULL to see if the clock exists.
---
 drivers/mmc/core/pwrseq_simple.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index e53d3c7e059c..5e34c77efa5e 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -7,6 +7,7 @@
  *
  *  Simple MMC power sequence management
  */
+#include <linux/clk.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/device.h>
@@ -20,6 +21,7 @@
 
 struct mmc_pwrseq_simple {
 	struct mmc_pwrseq pwrseq;
+	struct clk *ext_clk;
 	int nr_gpios;
 	struct gpio_desc *reset_gpios[0];
 };
@@ -39,6 +41,9 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
 	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
 					struct mmc_pwrseq_simple, pwrseq);
 
+	if (!IS_ERR(pwrseq->ext_clk))
+		clk_prepare_enable(pwrseq->ext_clk);
+
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
 }
 
@@ -50,6 +55,17 @@ static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
 }
 
+static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
+{
+	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
+					struct mmc_pwrseq_simple, pwrseq);
+
+	mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
+
+	if (!IS_ERR(pwrseq->ext_clk))
+		clk_disable_unprepare(pwrseq->ext_clk);
+}
+
 static void mmc_pwrseq_simple_free(struct mmc_host *host)
 {
 	struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
@@ -60,6 +76,9 @@ static void mmc_pwrseq_simple_free(struct mmc_host *host)
 		if (!IS_ERR(pwrseq->reset_gpios[i]))
 			gpiod_put(pwrseq->reset_gpios[i]);
 
+	if (!IS_ERR(pwrseq->ext_clk))
+		clk_put(pwrseq->ext_clk);
+
 	kfree(pwrseq);
 	host->pwrseq = NULL;
 }
@@ -67,7 +86,7 @@ static void mmc_pwrseq_simple_free(struct mmc_host *host)
 static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
 	.pre_power_on = mmc_pwrseq_simple_pre_power_on,
 	.post_power_on = mmc_pwrseq_simple_post_power_on,
-	.power_off = mmc_pwrseq_simple_pre_power_on,
+	.power_off = mmc_pwrseq_simple_power_off,
 	.free = mmc_pwrseq_simple_free,
 };
 
@@ -85,6 +104,14 @@ int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
 	if (!pwrseq)
 		return -ENOMEM;
 
+	pwrseq->ext_clk = clk_get(dev, "ext_clock");
+	if (IS_ERR(pwrseq->ext_clk) &&
+	    PTR_ERR(pwrseq->ext_clk) != -ENOENT &&
+	    PTR_ERR(pwrseq->ext_clk) != -ENOSYS) {
+		ret = PTR_ERR(pwrseq->ext_clk);
+		goto free;
+	}
+
 	for (i = 0; i < nr_gpios; i++) {
 		pwrseq->reset_gpios[i] = gpiod_get_index(dev, "reset", i,
 							 GPIOD_OUT_HIGH);
@@ -96,7 +123,7 @@ int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
 			while (--i)
 				gpiod_put(pwrseq->reset_gpios[i]);
 
-			goto free;
+			goto clk_put;
 		}
 	}
 
@@ -105,6 +132,9 @@ int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
 	host->pwrseq = &pwrseq->pwrseq;
 
 	return 0;
+clk_put:
+	if (!IS_ERR(pwrseq->ext_clk))
+		clk_put(pwrseq->ext_clk);
 free:
 	kfree(pwrseq);
 	return ret;
-- 
2.1.3
