Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD5BC47082
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Jun 2021 18:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B691613BF
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Jun 2021 18:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhFCSYl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Jun 2021 14:24:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:6082 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229620AbhFCSYl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 3 Jun 2021 14:24:41 -0400
IronPort-SDR: CzCQIv9oEukAEsKzjsMUafIgRPRN8BQNU9w13gTnEP9KNA2vdKqsW2aHz0nmLEjTF9Xf02Qi0p
 O8xzcygyScUw==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="191222686"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="191222686"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 11:22:54 -0700
IronPort-SDR: cYBAxOZcDF9xlY6icljnyITeKlTh5nZ6LDxGSPBDxMzt+DDQ6GzKjE57deaB00G9OORiewQLvy
 CTq2bW/3vf5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="636326865"
Received: from coresw01.iind.intel.com ([10.223.252.64])
  by fmsmga005.fm.intel.com with ESMTP; 03 Jun 2021 11:22:47 -0700
From:   rashmi.a@intel.com
To:     linux-drivers-review-request@eclists.intel.com,
        michal.simek@xilinx.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        andriy.shevchenko@linux.intel.com, linux-phy@lists.infradead.org
Cc:     mgross@linux.intel.com, kris.pan@linux.intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        adrian.hunter@intel.com, mahesh.r.vaidya@intel.com,
        nandhini.srikandan@intel.com,
        lakshmi.bai.raja.subramanian@intel.com, rashmi.a@intel.com
Subject: =?utf-8?q?=5B=E2=80=9CPATCH=E2=80=9D=201/2=5D=20mmc=3A=20sdhci-of-arasan=3A=20Use=20clock-frequency=20property=20to=20update=20clk=5Fxin?=
Date:   Thu,  3 Jun 2021 23:52:41 +0530
Message-Id: <20210603182242.25733-2-rashmi.a@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210603182242.25733-1-rashmi.a@intel.com>
References: <20210603182242.25733-1-rashmi.a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Rashmi A <rashmi.a@intel.com>

If clock-frequency property is set and it is not the same as the current
clock rate of clk_xin(base clock frequency), set clk_xin to use the
provided clock rate.

Signed-off-by: Rashmi A <rashmi.a@intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 839965f7c717..0e7c07ed9690 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1542,6 +1542,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		}
 	}
 
+	sdhci_get_of_property(pdev);
+
 	sdhci_arasan->clk_ahb = devm_clk_get(dev, "clk_ahb");
 	if (IS_ERR(sdhci_arasan->clk_ahb)) {
 		ret = dev_err_probe(dev, PTR_ERR(sdhci_arasan->clk_ahb),
@@ -1561,14 +1563,22 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	/* If clock-frequency property is set, use the provided value */
+	if (pltfm_host->clock &&
+	    pltfm_host->clock != clk_get_rate(clk_xin)) {
+		ret = clk_set_rate(clk_xin, pltfm_host->clock);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to set SD clock rate\n");
+			goto clk_dis_ahb;
+		}
+	}
+
 	ret = clk_prepare_enable(clk_xin);
 	if (ret) {
 		dev_err(dev, "Unable to enable SD clock.\n");
 		goto clk_dis_ahb;
 	}
 
-	sdhci_get_of_property(pdev);
-
 	if (of_property_read_bool(np, "xlnx,fails-without-test-cd"))
 		sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_FORCE_CDTEST;
 
-- 
2.17.1

