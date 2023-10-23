Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B31ECDB474
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Oct 2023 13:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjJWNZ1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Oct 2023 09:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjJWNZI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Oct 2023 09:25:08 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A68A26B1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Oct 2023 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698067400; x=1729603400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L5IMAX9aRp+HcRHxDO5rQd41FNFFoVGqSLJizDd68FU=;
  b=Y968Ngm8g+SpQ+U5WXPCJxuOkySkWlyGTFxZEmv3MNzlY0OCpADZa8wu
   LiGgVBTGjyCu5y8ApCorL11PgRVD5gMEtilP3yC2DGni+DsEK1sifd1w/
   a/7d2D9u37avJkVYpZt/6xpIQx0iCtbfIABwkqoBTe1iCzdykEqROP16O
   JVWZfRZEsIY4QWCSfqEd0orMMIiRIRIdrlw681IB1ltui91ysDzF+bd16
   MAW+Oa7Bntw1v8IY/1PsxEsrJnet1OWY05XG4iSSGooDCdEj0AQ+0rGX/
   zDwfP9TUgWcj6cHiJLTUBb4t7rOW4pvILJLQ6RyTcLcIQZ1zK0dpS0iqK
   g==;
X-CSE-ConnectionGUID: BX8UbkMpRo+UtLket+upoA==
X-CSE-MsgGUID: 0vtjWC9xQeu0yFGCLUb6eQ==
X-IronPort-AV: E=Sophos;i="6.03,244,1694707200"; 
   d="scan'208";a="393867"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2023 21:23:19 +0800
IronPort-SDR: xuZtXEA8ZRR8V6E/xCZautS+N0oMoe0C8F+0LB3gTwylMQEy9UHCuwg7vwL0h5AW43cpvB2c3V
 5jOs1zKKwh2veex68mIZ9tUwwUlw1qlmeBtp19qw0HY7kSWNLMvjY2OfmYrzp8GI/ofjR+KlkI
 ioeFkpjV5elcC221+RoSpmMWYF3BfVov5FnLt9HicQX2sS+Eoe02WjUNO7V02KWPRm4ikqijzu
 6m7sfZUUGPqfcGKiG5o8t9fUcBahb3o2U/yZ/39FVAkX/6EFVxy/FjhurrhCegUU2PTCtZveTY
 Cc4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2023 05:29:33 -0700
IronPort-SDR: dkaWLLu2ZzlNEEHTW7TJgrAgunxgV9AvwP7acOzrB33Ior/wNAsREIzzbZR8BEMc3FuJwyguz7
 KsHrgWTafQ4WpgvM4KjopP7zofLiXX9hF/1+0aW/snQES+Xb3UI+AHJ+2y1GnhnuO5auJQuaJQ
 5deDyo9nLKoa99NBTZSFvsCLWcea3LW3k6uqOkQHt7cHMe39Ghug58sV5x5BQMb8pk/y0G6E/h
 YiTFFWXvvVp+L5EsJAEVY9Jd2lyIxD0G6L4h9GcOmXcfqW4bi15IhU+oshLj19iJJZJwPzre2f
 KyY=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2023 06:23:17 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v2 2/2] mmc: host: msm: Disable auto-cmd12 during ffu
Date:   Mon, 23 Oct 2023 16:21:28 +0300
Message-Id: <20231023132128.1871269-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023132128.1871269-1-avri.altman@wdc.com>
References: <20231023132128.1871269-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Some platforms generate auto command error interrupt when it shouldn't,
e.g. auto-cmd12 while in close-ended ffu sequence.

I encounterd this issue while testing fwup on HP Chromebook x2, qualcomm
based QC-7c, code name for board - strongbad.

Instead of a quirk, hook the request function of the msm ops, so it'll
disable auto-cmd12 while close-ended ffu is in progress.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/mmc/host/sdhci-msm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 668e0aceeeba..c0d816c4f770 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2245,6 +2245,27 @@ static int sdhci_msm_start_signal_voltage_switch(struct mmc_host *mmc,
 	return -EAGAIN;
 }
 
+static void sdhci_msm_check_auto_cmd12(struct mmc_host *mmc,
+				       struct mmc_request *mrq)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	bool auto_cmd12 = (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12);
+
+	if (mrq->data && auto_cmd12) {
+		if (mmc_is_ffu_cmd(mrq->cmd))
+			host->flags &= ~SDHCI_AUTO_CMD12;
+		else
+			host->flags |= SDHCI_AUTO_CMD12;
+	}
+}
+
+static void sdhci_msm_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	sdhci_msm_check_auto_cmd12(mmc, mrq);
+
+	sdhci_request(mmc, mrq);
+}
+
 #define DRIVER_NAME "sdhci_msm"
 #define SDHCI_MSM_DUMP(f, x...) \
 	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
@@ -2638,6 +2659,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 					 MSM_MMC_AUTOSUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&pdev->dev);
 
+	host->mmc_host_ops.request = sdhci_msm_request;
+
 	host->mmc_host_ops.start_signal_voltage_switch =
 		sdhci_msm_start_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = sdhci_msm_execute_tuning;
-- 
2.42.0

