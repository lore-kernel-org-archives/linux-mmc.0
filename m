Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D04AC4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Nov 2022 17:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKXRHb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Nov 2022 12:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiKXRHa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2022 12:07:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF78AD56
        for <linux-mmc@vger.kernel.org>; Thu, 24 Nov 2022 09:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669309647; x=1700845647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vNkwgPL0CNjaQGOKzzwauhSrwBibHfjUncgWHMExQOs=;
  b=ea/LFsM9CW6ZxMFnd1bpXaxSBtl9kaBIsqyT76YQZEvg5r3DJY+my44i
   f0ANN41it1H/91saiq18gonh5cZQEeQ7c6teLMsE2FQLyFZ9wyQwgHT9O
   JouIdDDwPDct62XjhQmHPieQS6qJAn3wdvcZwsLW1aRld4KqQvK9dT8YJ
   Rr5cUFYFjCRBXp7qXrc4KJL+jofa2qlcYNxO73psg5hKubvHivXyKy2PI
   ZFTrMYTXWTtKCwYSzVz+/tKsBRAdjW5B14aYzeqq7LgAvcQYfIv18SAW+
   xpmMMqRzYLKPCL2UPoHasieby3Fanz/B9MCZjStv7I/Ms76zVWq0MCaWf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="400630255"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="400630255"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 09:07:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="971313061"
X-IronPort-AV: E=Sophos;i="5.96,190,1665471600"; 
   d="scan'208";a="971313061"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.33.41])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2022 09:07:22 -0800
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
Subject: [PATCH 4/4] mmc: sdhci: Enable card clock instead of ->set_clock()
Date:   Thu, 24 Nov 2022 19:06:49 +0200
Message-Id: <20221124170649.63851-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124170649.63851-1-adrian.hunter@intel.com>
References: <20221124170649.63851-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SDHCI has separate controls for the internal clock and enabling the
clock signal to the card.

The card clock signal was disabled via SDHCI_CLOCK_CARD_EN to avoid
glitches on the clock line. It is not necessary to reset the internal clock
to re-enable it. Instead re-enable by re-asserting SDHCI_CLOCK_CARD_EN.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 79a50d461ee4..19e0cb7add94 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2442,8 +2442,11 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			host->drv_type = ios->drv_type;
 		}
 
-		/* Re-enable SD Clock */
-		host->ops->set_clock(host, host->clock);
+		if (ios->clock) {
+			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+			clk |= SDHCI_CLOCK_CARD_EN;
+			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+		}
 	} else
 		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 }
-- 
2.34.1

