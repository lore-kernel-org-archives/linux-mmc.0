From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH-v2 3/3] mmc: sdhci: print notice on -EPROBE_DEFER in sdhci_add_host() fn
Date: Mon,  7 Sep 2015 17:01:11 +0530
Message-ID: <1441625471-16315-4-git-send-email-vaibhav.hiremath@linaro.org>
References: <1441625471-16315-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441625471-16315-1-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds kernel notice/message to sdhci_host_add() fn on
-EPROBE_DEFER.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mmc/host/sdhci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1dbe932..37a5cd5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3130,8 +3130,11 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	/* If there are external regulators, get them */
-	if (mmc_regulator_get_supply(mmc) == -EPROBE_DEFER)
+	if (mmc_regulator_get_supply(mmc) == -EPROBE_DEFER) {
+		pr_notice("%s: regulator supply unavailable, deferring probe.\n",
+				mmc_hostname(mmc));
 		return -EPROBE_DEFER;
+	}
 
 	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
 	if (!IS_ERR(mmc->supply.vqmmc)) {
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
