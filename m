From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/4] mmc: pwrseq: add op reset to struct mmc_pwrseq_ops
Date: Wed, 8 Feb 2017 22:48:56 +0100
Message-ID: <c75c3e5c-c4e1-3f2f-267b-1c781052c55e@gmail.com>
References: <75ad5eac-412b-fe73-ff53-3d8b975937e4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36061 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbdBHVvK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Feb 2017 16:51:10 -0500
Received: by mail-wr0-f195.google.com with SMTP id k90so9979263wrc.3
        for <linux-mmc@vger.kernel.org>; Wed, 08 Feb 2017 13:49:51 -0800 (PST)
In-Reply-To: <75ad5eac-412b-fe73-ff53-3d8b975937e4@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Add an operation reset to struct mmc_pwrseq_ops and related wrappers.

Don't expose the pwrseq-internal reset function directly to kernel
users but just to the mmc core.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/core/core.c   | 6 ++++++
 drivers/mmc/core/pwrseq.c | 8 ++++++++
 drivers/mmc/core/pwrseq.h | 3 +++
 include/linux/mmc/core.h  | 1 +
 4 files changed, 18 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 926e0fde..5d5fe591 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1869,6 +1869,12 @@ void mmc_power_cycle(struct mmc_host *host, u32 ocr)
 	mmc_power_up(host, ocr);
 }
 
+void mmc_hw_reset_pwrseq(struct mmc_host *host)
+{
+	mmc_pwrseq_reset(host);
+}
+EXPORT_SYMBOL(mmc_hw_reset_pwrseq);
+
 /*
  * Cleanup when the last reference to the bus operator is dropped.
  */
diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
index 9386c477..e3ad30fa 100644
--- a/drivers/mmc/core/pwrseq.c
+++ b/drivers/mmc/core/pwrseq.c
@@ -76,6 +76,14 @@ void mmc_pwrseq_power_off(struct mmc_host *host)
 		pwrseq->ops->power_off(host);
 }
 
+void mmc_pwrseq_reset(struct mmc_host *host)
+{
+	struct mmc_pwrseq *pwrseq = host->pwrseq;
+
+	if (pwrseq && pwrseq->ops->reset)
+		pwrseq->ops->reset(host);
+}
+
 void mmc_pwrseq_free(struct mmc_host *host)
 {
 	struct mmc_pwrseq *pwrseq = host->pwrseq;
diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
index 39c911aa..819386f4 100644
--- a/drivers/mmc/core/pwrseq.h
+++ b/drivers/mmc/core/pwrseq.h
@@ -18,6 +18,7 @@ struct mmc_pwrseq_ops {
 	void (*pre_power_on)(struct mmc_host *host);
 	void (*post_power_on)(struct mmc_host *host);
 	void (*power_off)(struct mmc_host *host);
+	void (*reset)(struct mmc_host *host);
 };
 
 struct mmc_pwrseq {
@@ -36,6 +37,7 @@ int mmc_pwrseq_alloc(struct mmc_host *host);
 void mmc_pwrseq_pre_power_on(struct mmc_host *host);
 void mmc_pwrseq_post_power_on(struct mmc_host *host);
 void mmc_pwrseq_power_off(struct mmc_host *host);
+void mmc_pwrseq_reset(struct mmc_host *host);
 void mmc_pwrseq_free(struct mmc_host *host);
 
 #else
@@ -49,6 +51,7 @@ static inline int mmc_pwrseq_alloc(struct mmc_host *host) { return 0; }
 static inline void mmc_pwrseq_pre_power_on(struct mmc_host *host) {}
 static inline void mmc_pwrseq_post_power_on(struct mmc_host *host) {}
 static inline void mmc_pwrseq_power_off(struct mmc_host *host) {}
+static inline void mmc_pwrseq_reset(struct mmc_host *host) {}
 static inline void mmc_pwrseq_free(struct mmc_host *host) {}
 
 #endif
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index a0c63ea2..8dbbd7a1 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -166,6 +166,7 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
 		int retries);
 
 int mmc_hw_reset(struct mmc_host *host);
+void mmc_hw_reset_pwrseq(struct mmc_host *host);
 void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card);
 
 #endif /* LINUX_MMC_CORE_H */
-- 
2.11.0


