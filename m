From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH 2/4] mmc: pwrseq-simple: Add optional op. for
 post_ios_power_on callback
Date: Wed,  1 Mar 2017 15:53:08 +0100
Message-ID: <20170301145310.22813-3-romain.perier@collabora.com>
References: <20170301145310.22813-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170301145310.22813-1-romain.perier@collabora.com>
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
Cc: Romain Perier <romain.perier@collabora.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Some devices require to do their entire power sequence after that the
power supply of the MMC has been powered on. This can be done by
only implementing the optional post_ios_power_on() callback that rely on
pre_power_on/post_power_on functions, other functions being NULL. Then
we introduce a new DT property "post_ios_power_on", when this property
is set the driver will use its post_ios_power_on operations, otherwise
it fallbacks to the default operations with pre_power_on/post_power_on.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 drivers/mmc/core/pwrseq_simple.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 1304160..a9aad9a 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -84,12 +84,22 @@ static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
 	}
 }
 
+static void mmc_pwrseq_simple_post_ios_power_on(struct mmc_host *host)
+{
+	mmc_pwrseq_simple_pre_power_on(host);
+	mmc_pwrseq_simple_post_power_on(host);
+}
+
 static const struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
 	.pre_power_on = mmc_pwrseq_simple_pre_power_on,
 	.post_power_on = mmc_pwrseq_simple_post_power_on,
 	.power_off = mmc_pwrseq_simple_power_off,
 };
 
+static const struct mmc_pwrseq_ops mmc_pwrseq_post_ios_ops = {
+	.post_ios_power_on = mmc_pwrseq_simple_post_ios_power_on,
+};
+
 static const struct of_device_id mmc_pwrseq_simple_of_match[] = {
 	{ .compatible = "mmc-pwrseq-simple",},
 	{/* sentinel */},
@@ -121,7 +131,10 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 				 &pwrseq->post_power_on_delay_ms);
 
 	pwrseq->pwrseq.dev = dev;
-	pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
+	if (device_property_read_bool(dev, "post-ios-power-on"))
+		pwrseq->pwrseq.ops = &mmc_pwrseq_post_ios_ops;
+	else
+		pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
 	pwrseq->pwrseq.owner = THIS_MODULE;
 	platform_set_drvdata(pdev, pwrseq);
 
-- 
2.9.3
