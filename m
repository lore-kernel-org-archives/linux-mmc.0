Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79838C0032E
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Oct 2023 11:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjJYLcl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Oct 2023 07:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjJYLck (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Oct 2023 07:32:40 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B1F10A
        for <linux-mmc@vger.kernel.org>; Wed, 25 Oct 2023 04:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1698233558; x=1729769558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hl4PrdPXJrjE4ec1/3ATbOlzGHhALw4UwttrTZBRSPI=;
  b=XMaaFu9FhjqOPYLjGSjAGDY0/shO0hcv7nOgJqjvmB5vbokN3UQ88xEN
   T7cbh3nzLW+3e8BB25p/XMShFDIP2SrS588xZDCtkL/AQzlymaMej+ofy
   Zu3trxMPsGC3Iv/XiODUaEQzXPxY8gBwju3h+S2KZA3+N4Iz6mFpNhQpx
   gkGKvESe0vLooLQ/S067fAVqq9VQtBMTXTB0nAISwpNwrqI34abNCr11Y
   8FNVIDC6EiBIasP2FxZiQwRv19kPhwtKHabBzZ64WFZqetww1wTxzUs2k
   wolB4OdqAIPLuglHQTACHMatywSqEJsa/dKKDQxfKQ9F7GFZPb0QFTXaY
   A==;
X-CSE-ConnectionGUID: uS4KPFKpTJuLHJlc0TTYXQ==
X-CSE-MsgGUID: 2pGZdP1URFCMdI1jDlUlxA==
X-IronPort-AV: E=Sophos;i="6.03,250,1694707200"; 
   d="scan'208";a="580252"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Oct 2023 19:32:37 +0800
IronPort-SDR: yC4uJCYjclt/JVmGFK8nBxrAgzbRngEy4wceJlwo1xuC+/Yp+quhRgPFzPEsL96BX2IzqlpgPY
 GciXHT7MQzM0bQOwChV2TeFlDr3rD6fHuSq3UbgSVwMYAe6Y2MEl8EudcEefcd57vm1vo0iL2i
 CtzD0ZuBQWZ4dc+md3Azy1dydEMRx1Y/9MKJrP0YZipPKph4N0RfWLNs6+LBWxagorZ77k1Fjl
 w2CLmGnQBhGRKbw7qwZf+R+SiUWzLmDwTqP3HBJREDR1fVuep819A41p7vh+WZZlo1PVf4l+z/
 UQk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Oct 2023 03:44:30 -0700
IronPort-SDR: txTDt/K8kUAi3ZSqZiKVFfaMjlyHMfLJvGwHoovhtVJ5IzwRau4cCYB29dkAtSJJ24yRWOJ8zu
 R5y9bd9UYdYYbEa/Wfm73VMOvm5Pp3/wwCo1Ssn6rap7SstMa0YB4POgTjUgCGtU0elAZ/3NdM
 Fjb2J1lpllK8m54kUJ1q+yyQvtZ73FFSannOrHE6wqifvrX1jEPcO5dX1FVwuvnhCWrWWgeV1Y
 teB3MtcCD1O8hCTCZszk8GjCTXjJayJ93Uftmtir7lq/03gRQSM6IRWs2FWBW8z9dMtGlELcR4
 MQE=
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Oct 2023 04:32:37 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH v3 2/2] mmc: host: msm: Disable auto-cmd12 during ffu
Date:   Wed, 25 Oct 2023 14:30:35 +0300
Message-Id: <20231025113035.1881418-3-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025113035.1881418-1-avri.altman@wdc.com>
References: <20231025113035.1881418-1-avri.altman@wdc.com>
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
 drivers/mmc/host/sdhci-msm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 668e0aceeeba..99d6cac335a4 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/mmc/mmc.h>
+#include <linux/mmc/host.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
@@ -2245,6 +2246,27 @@ static int sdhci_msm_start_signal_voltage_switch(struct mmc_host *mmc,
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
@@ -2638,6 +2660,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 					 MSM_MMC_AUTOSUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&pdev->dev);
 
+	host->mmc_host_ops.request = sdhci_msm_request;
+
 	host->mmc_host_ops.start_signal_voltage_switch =
 		sdhci_msm_start_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = sdhci_msm_execute_tuning;
-- 
2.42.0

