Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBF8C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Nov 2022 17:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiKXRHY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Nov 2022 12:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKXRHX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2022 12:07:23 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE2C2C65C
        for <linux-mmc@vger.kernel.org>; Thu, 24 Nov 2022 09:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669309642; x=1700845642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ALQv4DnCqfN8zFU/NxN/jmxtWkRJySOJzLmM5gFmr4=;
  b=OjFeylZU8p6xnlm7+chOWFTtQGX7Uoav/EtklZwZreBj9XGqu4Qc1+f1
   u3HL9Ns+DW5+n0tP4X80gyb85QruKBLw7eZNY5sdhpyzLEoZ/s7ejRWXZ
   JrWPY6rbVNsjf1SlkntnoeAuL3uafxxJuEUZZszD7rR+IqUnnF0/W+Lsr
   m53mx+bMd1zBLHO7zKBjsZBJ07fsy2x3JZOyrJc51wyFmlgq9tjrUtvSx
   bkASCrzw72U+tzGw5Gs3ZS5VMSGzg3a3aFIUXbcAzQE+vELaxJU3mkwo1
   EOONMByLR6la6U6UZL4GU5DH6reUzWdHA5FLnFYR9DTXY+3xDcBed7NKa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="316159909"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="316159909"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 09:07:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="971313047"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="971313047"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.33.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 09:07:16 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sarthak Garg <quic_sartgarg@quicinc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Prabu Thangamuthu <prabu.t@synopsys.com>,
        Manjunath M B <manjumb@synopsys.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>,
        Wenchao Chen <wenchao.chen@unisoc.com>,
        Chevron Li <chevron.li@bayhubtech.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH 3/4] mmc: sdhci: Avoid unnecessary ->set_clock()
Date:   Thu, 24 Nov 2022 19:06:48 +0200
Message-Id: <20221124170649.63851-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124170649.63851-1-adrian.hunter@intel.com>
References: <20221124170649.63851-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

To avoid glitches on the clock line, the card clock is disabled when making
timing changes. Do not do that separately for HISPD and UHS settings.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3675d69fb590..79a50d461ee4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2390,8 +2390,21 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (host->version >= SDHCI_SPEC_300) {
 		u16 clk, ctrl_2;
 
+		/*
+		 * According to SDHCI Spec v3.00, if the Preset Value
+		 * Enable in the Host Control 2 register is set, we
+		 * need to reset SD Clock Enable before changing High
+		 * Speed Enable to avoid generating clock glitches.
+		 */
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		if (clk & SDHCI_CLOCK_CARD_EN) {
+			clk &= ~SDHCI_CLOCK_CARD_EN;
+			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+		}
+
+		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+
 		if (!host->preset_enabled) {
-			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 			/*
 			 * We only need to set Driver Strength if the
 			 * preset value enable is not set.
@@ -2414,30 +2427,8 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
 			host->drv_type = ios->drv_type;
-		} else {
-			/*
-			 * According to SDHC Spec v3.00, if the Preset Value
-			 * Enable in the Host Control 2 register is set, we
-			 * need to reset SD Clock Enable before changing High
-			 * Speed Enable to avoid generating clock gliches.
-			 */
-
-			/* Reset SD Clock Enable */
-			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-			clk &= ~SDHCI_CLOCK_CARD_EN;
-			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-
-			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
-
-			/* Re-enable SD Clock */
-			host->ops->set_clock(host, host->clock);
 		}
 
-		/* Reset SD Clock Enable */
-		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-		clk &= ~SDHCI_CLOCK_CARD_EN;
-		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
-
 		host->ops->set_uhs_signaling(host, ios->timing);
 		host->timing = ios->timing;
 
-- 
2.34.1

