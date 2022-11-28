Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5C7C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Nov 2022 13:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiK1Ndn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Nov 2022 08:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiK1Ndm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2022 08:33:42 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B0825C9
        for <linux-mmc@vger.kernel.org>; Mon, 28 Nov 2022 05:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669642421; x=1701178421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uHGvyOIOB3UU2O0X9qTB4LUiTkQ92SmG6rL8aeZob+Y=;
  b=NK3No2r5/4dd/3bK2sVb0Bqm2c9C7d/PV7wxn7KefCyaafpYBZdZoGsF
   jc6SrXR/cay/DLQaL30AhMVHPjkYx3HZ7C5sU11B9a25HkTsnFV19Kulh
   o1nfDdv5ne+rH3e0/+N+qFzypBpY2cAzHMTBM0oKiGRvDYT4099izwQoP
   R0waVzRcqgmAlSofB5vWXqsouvtkyrFl8deIcCOcSsvZqJ/osUSPAU7Hz
   yeB81v3F4xd+WVHhkWu8a1wa4PMmxV/k/tc2o7IHj+Yzlze1O2pyYX07n
   MBQ3hfalwecs+Ycf2wxyugAXJnEuEszyq/UWv3/+CDAF7kx3pfLAPfsyn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="401121903"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401121903"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:33:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="676044614"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="676044614"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.50.218])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:33:35 -0800
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
Subject: [PATCH V2 4/4] mmc: sdhci: Enable card clock instead of ->set_clock()
Date:   Mon, 28 Nov 2022 15:32:59 +0200
Message-Id: <20221128133259.38305-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128133259.38305-1-adrian.hunter@intel.com>
References: <20221128133259.38305-1-adrian.hunter@intel.com>
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

Tested-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index beb1fe643634..9a245d5c532b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2452,8 +2452,11 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
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

