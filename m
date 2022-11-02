Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7D2C433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Nov 2022 12:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKBMVI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Nov 2022 08:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKBMVH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2022 08:21:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0BD24F26
        for <linux-mmc@vger.kernel.org>; Wed,  2 Nov 2022 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667391666; x=1698927666;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QTKSYTvGdG0H5D815nQysvtl8Z57bsCRdI2NUB1na3Y=;
  b=N8yRF49BbUnFe/iRIsGj89CevsgXzz2GxiJovo3L912zpsXt8edTrY/B
   eAxosuxBBBP4UHAX1X6l+OwnSFqN2W9p/zz3c+DNBHwNiqGInJb+20hrX
   Gq3zCPj4lly/DNwVxvlAQrH0d7DSYzad8gvgbohrKuyLrlOrHodaW1UBc
   JMh3t9dyzOw8H+TU0UFPlXil2tPB2VIl1ZN+KmpVrzezB8pNJRn+s9N4w
   VAhcfkMaQLBeZroJqMLe1r5iI2Ye+JZp/WMj8/kuvHrhjBQg0vmEK+Xd4
   QZUIDKKQRXuXLKM5c5Wg5KrKZr8XMGA+r73xz9a8WzEnHi7HzKzbJoZbH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="395699563"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="395699563"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 05:21:06 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="636761555"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="636761555"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.47.170])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 05:21:05 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: Remove duplicate words in comments
Date:   Wed,  2 Nov 2022 14:01:05 +0200
Message-Id: <20221102120105.5747-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Remove duplicate words in comments found using the following commands:

pcregrep --color=always -n \
	'([^a-zA-Z_])([a-zA-Z_]+)[[:space:]]+\2[^a-zA-Z_]' \
	drivers/mmc/host/*.[ch] drivers/mmc/core/*.[ch] \
	include/linux/mmc/*.h \
	include/uapi/linux/mmc/*.h | \
	grep -v 'long long'

pcregrep --color=always -n -M \
	'([^a-zA-Z_])([a-zA-Z_]+)[ \t]*\n[[:space:]*]+\2[^a-zA-Z_]' \
	drivers/mmc/host/*.[ch] \
	drivers/mmc/core/*.[ch] \
	include/linux/mmc/*.h \
	include/uapi/linux/mmc/*.h

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c           | 4 ++--
 drivers/mmc/core/host.c           | 2 +-
 drivers/mmc/host/sdhci-acpi.c     | 2 +-
 drivers/mmc/host/sdhci-bcm-kona.c | 2 +-
 drivers/mmc/host/sdhci-omap.c     | 2 +-
 drivers/mmc/host/sdhci.h          | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 95fa8fb1d45f..757208b5a65c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -56,7 +56,7 @@ static const unsigned freqs[] = { 400000, 300000, 200000, 100000 };
 /*
  * Enabling software CRCs on the data blocks can be a significant (30%)
  * performance cost, and for other reasons may not always be desired.
- * So we allow it it to be disabled.
+ * So we allow it to be disabled.
  */
 bool use_spi_crc = 1;
 module_param(use_spi_crc, bool, 0);
@@ -527,7 +527,7 @@ EXPORT_SYMBOL(mmc_cqe_post_req);
  * mmc_cqe_recovery - Recover from CQE errors.
  * @host: MMC host to recover
  *
- * Recovery consists of stopping CQE, stopping eMMC, discarding the queue in
+ * Recovery consists of stopping CQE, stopping eMMC, discarding the queue
  * in eMMC, and discarding the queue in CQE. CQE must call
  * mmc_cqe_request_done() on all requests. An error is returned if the eMMC
  * fails to discard its queue.
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index b89dca1f15e9..5457c8aeeea1 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -269,7 +269,7 @@ EXPORT_SYMBOL(mmc_of_parse_clk_phase);
  * @host: host whose properties should be parsed.
  *
  * To keep the rest of the MMC subsystem unaware of whether DT has been
- * used to to instantiate and configure this host instance or not, we
+ * used to instantiate and configure this host instance or not, we
  * parse the properties and set respective generic mmc-host flags and
  * parameters.
  */
diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index bddfaba091a9..8f0e639236b1 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -651,7 +651,7 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
 	 *       instead use the SDR104 preset register.
 	 *
 	 *    If the above issues are resolved we could remove this quirk for
-	 *    firmware that that has valid presets (i.e., SDR12 <= 12 MHz).
+	 *    firmware that has valid presets (i.e., SDR12 <= 12 MHz).
 	 */
 	host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
 
diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 61a12f2f7f03..6a93a54fe067 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -168,7 +168,7 @@ static void sdhci_bcm_kona_init_74_clocks(struct sdhci_host *host,
 	/*
 	 *  JEDEC and SD spec specify supplying 74 continuous clocks to
 	 * device after power up. With minimum bus (100KHz) that
-	 * that translates to 740us
+	 * translates to 740us
 	 */
 	if (power_mode != MMC_POWER_OFF)
 		udelay(740);
diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 033be559a730..8ed9256b83da 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -370,7 +370,7 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	/*
 	 * Stage 1: Search for a maximum pass window ignoring any
-	 * any single point failures. If the tuning value ends up
+	 * single point failures. If the tuning value ends up
 	 * near it, move away from it in stage 2 below
 	 */
 	while (phase_delay <= MAX_PHASE_DELAY) {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d750c464bd1e..908da47ac5ba 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -345,7 +345,7 @@ struct sdhci_adma2_64_desc {
  */
 #define SDHCI_MAX_SEGS		128
 
-/* Allow for a a command request and a data request at the same time */
+/* Allow for a command request and a data request at the same time */
 #define SDHCI_MAX_MRQS		2
 
 /*
-- 
2.34.1

