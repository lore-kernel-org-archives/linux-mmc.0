Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15BFC53210
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Jan 2023 14:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbjAEOrG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Jan 2023 09:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234037AbjAEOqv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Jan 2023 09:46:51 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519435275F
        for <linux-mmc@vger.kernel.org>; Thu,  5 Jan 2023 06:46:43 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 368788558F;
        Thu,  5 Jan 2023 15:46:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1672930001;
        bh=0ScBuz7YhCerPwNfhVgAFOSQG0g1j5wIecHPLmQ1RT4=;
        h=From:To:Cc:Subject:Date:From;
        b=AHuqcCm/BmcaFiDnMDfJF9yJWtRvegJU+soh4DqUhYOJk9IM7Om6JbqH7oPESmSLR
         E0jEWPjYkD2TIn/DZu4Ygi//hAS46RbjhphK+R9UFGciGxTToq68cLgRnciJLfjqux
         bLzybcoK2KiPw4ufW4HGQCEfahwNoTejVyNhkI09sD335+2FvIPj5qxEfRbwwGVg8c
         3ZYbFPsFKlCyHwCOPaiUemLCxqKNIGUtlA3rTSYKGNETdHlzbSC1iEDvE0EVVG2x4i
         V5qubMxDcPDO4Mk9FakE3FkDwVnxCGrTsSe4ACM/n//t3F2L4qflZFzz/eSQRuwHxm
         xwRGO6FGTDIsQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-mmc@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bough Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Zach Brown <zach.brown@ni.com>
Subject: [PATCH] mmc: sdhci: Always apply sdhci-caps-mask and sdhci-caps to caps
Date:   Thu,  5 Jan 2023 15:46:28 +0100
Message-Id: <20230105144628.223420-1-marex@denx.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The original implementation in the commit referenced below only modifies
caps in case no caps are passed to sdhci_read_caps() via parameter, this
does not seem correct. Always modify the caps according to the properties
from DT.

While at it, drop the always NULL caps and caps1 function parameters.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Bough Chen <haibo.chen@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Zach Brown <zach.brown@ni.com>
To: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/sdhci-cadence.c |  2 +-
 drivers/mmc/host/sdhci.c         | 23 +++++++----------------
 drivers/mmc/host/sdhci.h         |  5 ++---
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 6f2de54a59877..af1bd66402cb7 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -390,7 +390,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	host->mmc_host_ops.hs400_enhanced_strobe =
 				sdhci_cdns_hs400_enhanced_strobe;
 	sdhci_enable_v4_mode(host);
-	__sdhci_read_caps(host, &version, NULL, NULL);
+	__sdhci_read_caps(host, &version);
 
 	sdhci_get_of_property(pdev);
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f3af1bd0f7b95..0ed8c5b36ecb9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4090,8 +4090,7 @@ static int sdhci_set_dma_mask(struct sdhci_host *host)
 	return ret;
 }
 
-void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
-		       const u32 *caps, const u32 *caps1)
+void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver)
 {
 	u16 v;
 	u64 dt_caps_mask = 0;
@@ -4124,24 +4123,16 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
 	if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
 		return;
 
-	if (caps) {
-		host->caps = *caps;
-	} else {
-		host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
-		host->caps &= ~lower_32_bits(dt_caps_mask);
-		host->caps |= lower_32_bits(dt_caps);
-	}
+	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+	host->caps &= ~lower_32_bits(dt_caps_mask);
+	host->caps |= lower_32_bits(dt_caps);
 
 	if (host->version < SDHCI_SPEC_300)
 		return;
 
-	if (caps1) {
-		host->caps1 = *caps1;
-	} else {
-		host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
-		host->caps1 &= ~upper_32_bits(dt_caps_mask);
-		host->caps1 |= upper_32_bits(dt_caps);
-	}
+	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	host->caps1 &= ~upper_32_bits(dt_caps_mask);
+	host->caps1 |= upper_32_bits(dt_caps);
 }
 EXPORT_SYMBOL_GPL(__sdhci_read_caps);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 605eaee805f74..19695e542161e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -757,8 +757,7 @@ static inline void *sdhci_priv(struct sdhci_host *host)
 	return host->private;
 }
 
-void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
-		       const u32 *caps, const u32 *caps1);
+void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver);
 int sdhci_setup_host(struct sdhci_host *host);
 void sdhci_cleanup_host(struct sdhci_host *host);
 int __sdhci_add_host(struct sdhci_host *host);
@@ -767,7 +766,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead);
 
 static inline void sdhci_read_caps(struct sdhci_host *host)
 {
-	__sdhci_read_caps(host, NULL, NULL, NULL);
+	__sdhci_read_caps(host, NULL);
 }
 
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
-- 
2.39.0

