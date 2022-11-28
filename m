Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57982C43217
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Nov 2022 13:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiK1Ndb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Nov 2022 08:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiK1Nda (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2022 08:33:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53BF111B
        for <linux-mmc@vger.kernel.org>; Mon, 28 Nov 2022 05:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669642409; x=1701178409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FtXjHdWOaBBWnhlNgbFNHd1IfXjI0EUclb/wpwPsbkQ=;
  b=KSbK8AQa1IjlQFP43NFWX8jNgBCqYeCd1CoTf8lV6bX7K5rxInB0PIbV
   hZDNCIg8AuDNKZ/BsKIXvmsux7ja++CKXdNnbPNKI8tiXpS/kgus/e8Z/
   DQmwcO0oCPtrL2bLgIrdnlC1KFMgO1EPNNOZlfWSbkKcxCafjq/+Ll2YS
   9dNH79Ugz8jZC7QreLDEVL13xqGRGp87zS5wsYN7JJEZrPB2kj9TN9TAP
   ZTGEEGkBMj1YPK8FdZnHI/bU0XUa733wV88/CKuRGFTVg8v+XcBf5DJm+
   PIOZ/Xi+6xTRAAVw2VtDN7Qfs3cx4RUbYMgcWY+i1446Rf1JSoY8oLLMs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="401121799"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401121799"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:33:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="676044529"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="676044529"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.50.218])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:33:23 -0800
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
Subject: [PATCH V2 2/4] mmc: sdhci: Avoid unnecessary re-configuration
Date:   Mon, 28 Nov 2022 15:32:57 +0200
Message-Id: <20221128133259.38305-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128133259.38305-1-adrian.hunter@intel.com>
References: <20221128133259.38305-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Avoid re-configuring UHS and preset settings when the settings have not
changed, irrespective of whether the clock is turning on.

Tested-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 64750fbb0ac8..17e5ccf9a855 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2315,7 +2315,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	bool reinit_uhs = host->reinit_uhs;
-	bool turning_on_clk = false;
 	u8 ctrl;
 
 	host->reinit_uhs = false;
@@ -2345,8 +2344,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		sdhci_enable_preset_value(host, false);
 
 	if (!ios->clock || ios->clock != host->clock) {
-		turning_on_clk = ios->clock && !host->clock;
-
 		host->ops->set_clock(host, ios->clock);
 		host->clock = ios->clock;
 
@@ -2374,11 +2371,10 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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
 	    !sdhci_presetable_values_change(host, ios))
-- 
2.34.1

