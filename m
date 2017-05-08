From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] mmc: pwrseq: Add reset callback to the struct mmc_pwrseq_ops
Date: Tue,  9 May 2017 00:09:02 +0200
Message-ID: <1494281343-18963-2-git-send-email-ulf.hansson@linaro.org>
References: <1494281343-18963-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35711 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdEHWJJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 May 2017 18:09:09 -0400
Received: by mail-wm0-f49.google.com with SMTP id b84so70744160wmh.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 May 2017 15:09:09 -0700 (PDT)
In-Reply-To: <1494281343-18963-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Douglas Anderson <dianders@chromium.org>, Markus Reichl <m.reichl@fivetechno.de>, Anand Moon <linux.amoon@gmail.com>

The ->reset() callback is needed to implement a better support for eMMC HW
reset. The following changes will take advantage of the new callback.

Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/pwrseq.c | 8 ++++++++
 drivers/mmc/core/pwrseq.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
index 9386c47..e3ad30f 100644
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
index 39c911a..819386f 100644
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
-- 
2.7.4

