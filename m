Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EA4C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Nov 2022 17:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKXRHT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Nov 2022 12:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiKXRHS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2022 12:07:18 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73303442FF
        for <linux-mmc@vger.kernel.org>; Thu, 24 Nov 2022 09:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669309637; x=1700845637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ezf+rpZocyXRKreSyghX+LViSU68SAwjjHpsXCLRbaA=;
  b=nNvJVW0uwoQpv9FsrzsHVN8TjYKFcdDGnMrw/FtQEJKLp14EA7Yy5pZV
   vFn5bqS/ojwcpyMZIsWu3kmH+OnZEvovm47UMzgNIVUtXgTcpGbS9Fbo/
   PpHSbXYHBhToegFR10vP/lRyaRxkIW0azSVa+X27TRVVRlgHA0uX0wvdH
   s2tFnZdj+FcSQ0kE+/xwz6oFcwQix8KTiwVf+GCofKJG3mFUfvUvVYoTC
   yttJCz7SnvGHOhbpUY2hRWjwArYkZgGKRCzWURPHocCsNtDrVmMTrLtcK
   a0dSoiEo6r7IHCac3rxPl5PINkVjvz1cZdxgnv/mOK1Cm9++VAruTKMkZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="316159890"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="316159890"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 09:07:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="971313036"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="971313036"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.33.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 09:07:11 -0800
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
Subject: [PATCH 2/4] mmc: sdhci: Avoid unnecessary re-configuration
Date:   Thu, 24 Nov 2022 19:06:47 +0200
Message-Id: <20221124170649.63851-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124170649.63851-1-adrian.hunter@intel.com>
References: <20221124170649.63851-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Avoid re-configuring UHS and preset settings when the settings have not
changed, irrespective of whether the clock is turning on.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 351b09b90d76..3675d69fb590 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2304,7 +2304,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	bool reinit_uhs = host->reinit_uhs;
-	bool turning_on_clk = false;
 	u8 ctrl;
 
 	host->reinit_uhs = false;
@@ -2334,8 +2333,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		sdhci_enable_preset_value(host, false);
 
 	if (!ios->clock || ios->clock != host->clock) {
-		turning_on_clk = ios->clock && !host->clock;
-
 		host->ops->set_clock(host, ios->clock);
 		host->clock = ios->clock;
 
@@ -2363,11 +2360,10 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	host->ops->set_bus_width(host, ios->bus_width);
 
 	/*
-	 * Special case to avoid multiple clock changes during voltage
-	 * switching.
+	 * Avoid unnecessary changes. In particular, this avoids multiple clock
+	 * changes during voltage switching.
 	 */
 	if (!reinit_uhs &&
-	    turning_on_clk &&
 	    host->timing == ios->timing &&
 	    host->version >= SDHCI_SPEC_300 &&
 	    (host->preset_enabled || host->drv_type == ios->drv_type) &&
-- 
2.34.1

