From: philipspatches@gmail.com
Subject: [PATCH 2/2] mmc: only support voltage (vdd) that regulator agree's with
Date: Fri,  8 Jun 2012 12:26:13 -0700
Message-ID: <1339183573-21688-1-git-send-email-prakity@marvell.com>
References: <prakity@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53921 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755355Ab2FHT0T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jun 2012 15:26:19 -0400
Received: by pbbrp8 with SMTP id rp8so2933830pbb.19
        for <linux-mmc@vger.kernel.org>; Fri, 08 Jun 2012 12:26:19 -0700 (PDT)
In-Reply-To: <prakity@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org, aaron.lu@amd.com, mark.brown314@gmail.com
Cc: Philip Rakity <prakity@marvell.com>

From: Philip Rakity <prakity@marvell.com>

If we are using a regulator the SD Host Controller and the
regulator should agree about the voltages supported.  Use
the common subset that is supported.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 248f68b..78be427 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2894,6 +2894,21 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * register is set. The actual current value is 4 times the register
 	 * value.
 	 */
+	if (host->vmmc) {
+		ret = regulator_is_supported_voltage(host->vmmc, 3300000,
+			3300000);
+		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_330)))
+			caps[0] &= ~SDHCI_CAN_VDD_330;
+		ret = regulator_is_supported_voltage(host->vmmc, 3000000,
+			3000000);
+		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_300)))
+			caps[0] &= ~SDHCI_CAN_VDD_300;
+		ret = regulator_is_supported_voltage(host->vmmc, 1800000,
+			1800000);
+		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_180)))
+			caps[0] &= ~SDHCI_CAN_VDD_180;
+	}
+
 	max_current_caps = sdhci_readl(host, SDHCI_MAX_CURRENT);
 	if (!max_current_caps && host->vmmc) {
 		u32 curr = regulator_get_current_limit(host->vmmc);
-- 
1.7.0.4

