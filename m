From: Martin Fuzzey <mfuzzey@parkeon.com>
Subject: [PATCH] mmc: pwrseq_simple: Support assigned-clocks
Date: Fri, 08 Jan 2016 10:59:17 +0100
Message-ID: <20160108095917.32335.11094.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ip83.parkeon.com ([213.152.31.83]:38320 "EHLO mta2.parkeon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751314AbcAHJ7T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Jan 2016 04:59:19 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

The clock subsystem now allows clock rates and parents to be configured
in the device tree.

This requires calling of_clk_set_defaults() which is done automatically
for platform, i2c, spi devices. Since pwrseq_simple does not fit into
those catagories we must do it ourself.

With this patch the standard assigned-clocks, assigned-clock-rates,
assigned-clock-parents DT properties to be used in pwrseq_simple nodes.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/mmc/core/pwrseq_simple.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 4d2962b..fd8f38e 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -8,6 +8,7 @@
  *  Simple MMC power sequence management
  */
 #include <linux/clk.h>
+#include <linux/clk/clk-conf.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/device.h>
@@ -108,6 +109,10 @@ struct mmc_pwrseq *mmc_pwrseq_simple_alloc(struct mmc_host *host,
 	if (!pwrseq)
 		return ERR_PTR(-ENOMEM);
 
+	ret = of_clk_set_defaults(dev->of_node, false);
+	if (ret)
+		goto free;
+
 	pwrseq->ext_clk = clk_get(dev, "ext_clock");
 	if (IS_ERR(pwrseq->ext_clk) &&
 	    PTR_ERR(pwrseq->ext_clk) != -ENOENT) {

