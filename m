Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2203CC6FA82
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Sep 2022 19:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiIZTUy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiIZTUv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Sep 2022 15:20:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA3E8993B
        for <linux-mmc@vger.kernel.org>; Mon, 26 Sep 2022 12:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664220048; x=1695756048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IKkzsajcGfV5nh1sk06cVjdWVf9CsOBN6vLETMgIk8Q=;
  b=L41e9iZu3mpJsJIY+sPEYtTIez7be7bWwFGaWA+fODr+TrDyExwn6D2C
   7nsOdMHRX9j49giZ2G86yy3r+n5K2eIWWgQPBfI5XPuTpi/d6ahSvVj6T
   aWTrHhACRpm2FHmTWOrK07eJXmDO7Eu54NfxcO9rZKqHvOpaF8Nzzv4MA
   YAvNiIwTirNgSqRWFAX+XYebTtNNWfW+u1Z17nRhDRQc1YGkkZaa+AmgM
   esNAdTOFtEI5dxs7/LuWopvOMNLuD1dUByuCAP5mQOnN0C7pNubgzgFg2
   Cc87pCf9LWMbxVJvJtaG8p6uUHN1XZVrpAE0G84vcI3sTrAhXmqnIZQ+j
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="298717914"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="298717914"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 12:20:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="796455594"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="796455594"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.59.121])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 12:20:45 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     pshete@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
Subject: [PATCH 3/4] mmc: sdhci: Get rid of SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS
Date:   Mon, 26 Sep 2022 22:20:21 +0300
Message-Id: <20220926192022.85660-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926192022.85660-1-adrian.hunter@intel.com>
References: <20220926192022.85660-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS is used by only ENE controllers but can
be replaced by driver code.

Amend the ENE code to hook the ->set_ios() mmc host operation and do the
reset there.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 23 ++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c          |  8 --------
 drivers/mmc/host/sdhci.h          |  2 --
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index ed53276f6ad9..63613b3d648f 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -297,6 +297,27 @@ static const struct sdhci_pci_fixes sdhci_ricoh_mmc = {
 			  SDHCI_QUIRK_MISSING_CAPS
 };
 
+static void ene_714_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	sdhci_set_ios(mmc, ios);
+
+	/*
+	 * Some (ENE) controllers misbehave on some ios operations,
+	 * signalling timeout and CRC errors even on CMD0. Resetting
+	 * it on each ios seems to solve the problem.
+	 */
+	if (!(host->flags & SDHCI_DEVICE_DEAD))
+		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+}
+
+static int ene_714_probe_slot(struct sdhci_pci_slot *slot)
+{
+	slot->host->mmc_host_ops.set_ios = ene_714_set_ios;
+	return 0;
+}
+
 static const struct sdhci_pci_fixes sdhci_ene_712 = {
 	.quirks		= SDHCI_QUIRK_SINGLE_POWER_WRITE |
 			  SDHCI_QUIRK_BROKEN_DMA,
@@ -304,8 +325,8 @@ static const struct sdhci_pci_fixes sdhci_ene_712 = {
 
 static const struct sdhci_pci_fixes sdhci_ene_714 = {
 	.quirks		= SDHCI_QUIRK_SINGLE_POWER_WRITE |
-			  SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS |
 			  SDHCI_QUIRK_BROKEN_DMA,
+	.probe_slot	= ene_714_probe_slot,
 };
 
 static const struct sdhci_pci_fixes sdhci_cafe = {
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 100c7d6be385..df79b407813f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2403,14 +2403,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		host->ops->set_clock(host, host->clock);
 	} else
 		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
-
-	/*
-	 * Some (ENE) controllers go apeshit on some ios operation,
-	 * signalling timeout and CRC errors even on CMD0. Resetting
-	 * it on each ios seems to solve the problem.
-	 */
-	if (host->quirks & SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS)
-		sdhci_do_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 }
 EXPORT_SYMBOL_GPL(sdhci_set_ios);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d7929d725730..69d7b9a75aab 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -376,8 +376,6 @@ struct sdhci_host {
 #define SDHCI_QUIRK_NO_CARD_NO_RESET			(1<<2)
 /* Controller doesn't like clearing the power reg before a change */
 #define SDHCI_QUIRK_SINGLE_POWER_WRITE			(1<<3)
-/* Controller has flaky internal state so reset it on each ios change */
-#define SDHCI_QUIRK_RESET_CMD_DATA_ON_IOS		(1<<4)
 /* Controller has an unusable DMA engine */
 #define SDHCI_QUIRK_BROKEN_DMA				(1<<5)
 /* Controller has an unusable ADMA engine */
-- 
2.25.1

