From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH 1/4] mmc: core: Add post_ios_power_on callback for power sequences
Date: Wed,  1 Mar 2017 15:53:07 +0100
Message-ID: <20170301145310.22813-2-romain.perier@collabora.com>
References: <20170301145310.22813-1-romain.perier@collabora.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44122 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbdCAPC1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Mar 2017 10:02:27 -0500
In-Reply-To: <20170301145310.22813-1-romain.perier@collabora.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Romain Perier <romain.perier@collabora.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>

Currently, ->pre_power_on() callback is called at the beginning of the
mmc_power_up() function before MMC_POWER_UP and MMC_POWER_ON sequences.
The callback ->post_power_on() is called at the end of the
mmc_power_up() function. Some SDIO Chipsets require to gate the clock
after than the vqmmc supply is powered on and then toggle the reset
line. Currently, there is no way for doing this.

This commit introduces a new callback ->post_ios_power_on(), that is
called at the end of the mmc_power_up() function after the mmc_set_ios()
operation. In this way the entire power sequences can be done from this
function after the enablement of the power supply.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 drivers/mmc/core/core.c   | 1 +
 drivers/mmc/core/pwrseq.c | 8 ++++++++
 drivers/mmc/core/pwrseq.h | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 1076b9d..d73a050 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1831,6 +1831,7 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	 * time required to reach a stable voltage.
 	 */
 	mmc_delay(10);
+	mmc_pwrseq_post_ios_power_on(host);
 }
 
 void mmc_power_off(struct mmc_host *host)
diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
index 9386c47..98f50b7 100644
--- a/drivers/mmc/core/pwrseq.c
+++ b/drivers/mmc/core/pwrseq.c
@@ -68,6 +68,14 @@ void mmc_pwrseq_post_power_on(struct mmc_host *host)
 		pwrseq->ops->post_power_on(host);
 }
 
+void mmc_pwrseq_post_ios_power_on(struct mmc_host *host)
+{
+	struct mmc_pwrseq *pwrseq = host->pwrseq;
+
+	if (pwrseq && pwrseq->ops->post_ios_power_on)
+		pwrseq->ops->post_ios_power_on(host);
+}
+
 void mmc_pwrseq_power_off(struct mmc_host *host)
 {
 	struct mmc_pwrseq *pwrseq = host->pwrseq;
diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
index d69e751..2053ebd 100644
--- a/drivers/mmc/core/pwrseq.h
+++ b/drivers/mmc/core/pwrseq.h
@@ -13,6 +13,7 @@
 struct mmc_pwrseq_ops {
 	void (*pre_power_on)(struct mmc_host *host);
 	void (*post_power_on)(struct mmc_host *host);
+	void (*post_ios_power_on)(struct mmc_host *host);
 	void (*power_off)(struct mmc_host *host);
 };
 
@@ -31,6 +32,7 @@ void mmc_pwrseq_unregister(struct mmc_pwrseq *pwrseq);
 int mmc_pwrseq_alloc(struct mmc_host *host);
 void mmc_pwrseq_pre_power_on(struct mmc_host *host);
 void mmc_pwrseq_post_power_on(struct mmc_host *host);
+void mmc_pwrseq_post_ios_power_on(struct mmc_host *host);
 void mmc_pwrseq_power_off(struct mmc_host *host);
 void mmc_pwrseq_free(struct mmc_host *host);
 
-- 
2.9.3

