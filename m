From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 3/4] mmc: sdhci: defer probing on regulator_get_optional() failures
Date: Mon, 14 Apr 2014 18:42:42 -0700
Message-ID: <1397526163-20126-4-git-send-email-abrestic@chromium.org>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397526163-20126-1-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

If regulator_get_optional() returns EPROBE_DEFER, it indicates
that the regulator may show up later (e.g. the DT property is
present but the corresponding regulator may not have probed).
Instead of continuing without the regulator, return EPROBE_DEFER
from sdhci_add_host().  Also, fix regulator leaks in the error
paths in sdhci_add_host().

Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/mmc/host/sdhci.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9a79fc4..e87c5d3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2978,7 +2978,9 @@ int sdhci_add_host(struct sdhci_host *host)
 	/* If vqmmc regulator and no 1.8V signalling, then there's no UHS */
 	host->vqmmc = regulator_get_optional(mmc_dev(mmc), "vqmmc");
 	if (IS_ERR_OR_NULL(host->vqmmc)) {
-		if (PTR_ERR(host->vqmmc) < 0) {
+		if (PTR_ERR(host->vqmmc) == -EPROBE_DEFER) {
+			return PTR_ERR(host->vqmmc);
+		} else if (PTR_ERR(host->vqmmc) < 0) {
 			pr_info("%s: no vqmmc regulator found\n",
 				mmc_hostname(mmc));
 			host->vqmmc = NULL;
@@ -2993,6 +2995,7 @@ int sdhci_add_host(struct sdhci_host *host)
 		if (ret) {
 			pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
 				mmc_hostname(mmc), ret);
+			regulator_put(host->vqmmc);
 			host->vqmmc = NULL;
 		}
 	}
@@ -3056,7 +3059,10 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	host->vmmc = regulator_get_optional(mmc_dev(mmc), "vmmc");
 	if (IS_ERR_OR_NULL(host->vmmc)) {
-		if (PTR_ERR(host->vmmc) < 0) {
+		if (PTR_ERR(host->vmmc) == -EPROBE_DEFER) {
+			ret = PTR_ERR(host->vmmc);
+			goto put_vqmmc;
+		} else if (PTR_ERR(host->vmmc) < 0) {
 			pr_info("%s: no vmmc regulator found\n",
 				mmc_hostname(mmc));
 			host->vmmc = NULL;
@@ -3150,7 +3156,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (mmc->ocr_avail == 0) {
 		pr_err("%s: Hardware doesn't report any "
 			"support voltages.\n", mmc_hostname(mmc));
-		return -ENODEV;
+		ret = -ENODEV;
+		goto put_vmmc;
 	}
 
 	spin_lock_init(&host->lock);
@@ -3280,6 +3287,12 @@ reset:
 untasklet:
 	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->finish_tasklet);
+put_vmmc:
+	if (host->vmmc)
+		regulator_put(host->vmmc);
+put_vqmmc:
+	if (host->vqmmc)
+		regulator_put(host->vqmmc);
 
 	return ret;
 }
-- 
1.9.1.423.g4596e3a
