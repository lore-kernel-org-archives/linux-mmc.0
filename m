From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 1/2] mmc: slot-gpio: check cd_gpio before setting up cd_gpio_isr
Date: Tue, 11 Apr 2017 18:20:55 +0800
Message-ID: <20170411102056.2869-2-jszhang@marvell.com>
References: <20170411102056.2869-1-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170411102056.2869-1-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

slot-gpio knows more information than its user, such as whether there
is cd gpio_desc or not. While one of its user -- the common sdhci
driver doesn't know it. To prepare for next patch which will setup
sdhci's own isr for card-detect interrupts, we add the check before
setting up cd_gpio_isr.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/core/slot-gpio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index a8450a8701e4..42b260593955 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -162,6 +162,9 @@ void mmc_gpio_set_cd_isr(struct mmc_host *host,
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
 
+	if (!ctx->cd_gpio)
+		return;
+
 	WARN_ON(ctx->cd_gpio_isr);
 	ctx->cd_gpio_isr = isr;
 }
-- 
2.11.0
