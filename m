From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] sdhci: Forward EPROBE_DEFER on vmmc and vqmmc regulators
Date: Mon,  7 Apr 2014 08:45:19 +0200
Message-ID: <1396853119-11181-1-git-send-email-mike.looijmans@topic.nl>
References: <1396852708-11058-1-git-send-email-mike.looijmans@topic.nl>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from atl4mhob03.myregisteredsite.com ([209.17.115.41]:40632 "EHLO
	atl4mhob03.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754826AbaDGGpZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Apr 2014 02:45:25 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.208])
	by atl4mhob03.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s376jM4A018239
	for <linux-mmc@vger.kernel.org>; Mon, 7 Apr 2014 02:45:22 -0400
In-Reply-To: <1396852708-11058-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cjb@laptop.org, gdjakov@mm-sol.com, Mike Looijmans <mike.looijmans@topic.nl>

If vmmc or vqmmc regulators are controlled by an I2C device, the
request for the regulator is likely to fail because the I2C bus has
not been probed yet. The sdhci then incorrectly assumes that the user
never wanted to use a regulator anyway and continues without ever
enabling or configuring the required regulator.

To solve this, when a required voltage regulator returns
EPROBE_DEFER, signalling that the regulator exists but is not
available yet, forward this error to the probe method instead
of simply assuming that the user never wanted to use a regulator
anyway.

Tested on a custom board that has an I2C regulator for one of the sdhcis
and no regulators at all for the other. This patch enables such a system
to work correctly.

v2: Do not change logging output

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/mmc/host/sdhci.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 34aef81..c92a5a1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2972,6 +2972,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	host->vqmmc = regulator_get_optional(mmc_dev(mmc), "vqmmc");
 	if (IS_ERR_OR_NULL(host->vqmmc)) {
 		if (PTR_ERR(host->vqmmc) < 0) {
+			if (PTR_ERR(host->vqmmc) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
 			pr_info("%s: no vqmmc regulator found\n",
 				mmc_hostname(mmc));
 			host->vqmmc = NULL;
@@ -3048,6 +3050,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	host->vmmc = regulator_get_optional(mmc_dev(mmc), "vmmc");
 	if (IS_ERR_OR_NULL(host->vmmc)) {
 		if (PTR_ERR(host->vmmc) < 0) {
+			if (PTR_ERR(host->vmmc) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
 			pr_info("%s: no vmmc regulator found\n",
 				mmc_hostname(mmc));
 			host->vmmc = NULL;
-- 
1.7.9.5

