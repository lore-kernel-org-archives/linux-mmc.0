From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH v2 3/4] mmc: core: expose the capability of gpio card detect
Date: Fri, 30 Sep 2016 16:48:36 +0800
Message-ID: <1475225317-2815-4-git-send-email-shawn.lin@rock-chips.com>
References: <1475225317-2815-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.136]:58818 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbcI3Iq4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Sep 2016 04:46:56 -0400
In-Reply-To: <1475225317-2815-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

Add new helper API mmc_can_gpio_cd for slot-gpio to make
host drivers know whether it supports gpio card detect.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/core/slot-gpio.c  | 8 ++++++++
 include/linux/mmc/slot-gpio.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 27117ba..babe591 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -258,6 +258,14 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 }
 EXPORT_SYMBOL(mmc_gpiod_request_cd);
 
+bool mmc_can_gpio_cd(struct mmc_host *host)
+{
+	struct mmc_gpio *ctx = host->slot.handler_priv;
+
+	return ctx->cd_gpio ? true : false;
+}
+EXPORT_SYMBOL(mmc_can_gpio_cd);
+
 /**
  * mmc_gpiod_request_ro - request a gpio descriptor for write protection
  * @host: mmc host
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
index 3945a8c..a7972cd 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -29,5 +29,6 @@ int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
 void mmc_gpio_set_cd_isr(struct mmc_host *host,
 			 irqreturn_t (*isr)(int irq, void *dev_id));
 void mmc_gpiod_request_cd_irq(struct mmc_host *host);
+bool mmc_can_gpio_cd(struct mmc_host *host);
 
 #endif
-- 
2.3.7


