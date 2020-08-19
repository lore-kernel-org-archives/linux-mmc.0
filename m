Return-Path: <SRS0=2cKM=B5=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632AFC433E3
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Aug 2020 19:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 260E7207DA
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Aug 2020 19:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LPU/vpuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHSTAp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgHSTA3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Aug 2020 15:00:29 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1B8C061757
        for <linux-mmc@vger.kernel.org>; Wed, 19 Aug 2020 12:00:29 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id z6so25848229iow.6
        for <linux-mmc@vger.kernel.org>; Wed, 19 Aug 2020 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Owe3WEEvN9p/SYMSQvZJkkHHqglCi0hIPyzh+2BeQeI=;
        b=LPU/vpuKH6lF8j9fkQ+U37K1cxGX01IWf50Lm5BMckr6n2jcH6/IwaBluNUPB8u6A6
         YmfOYuUQ+4qG/sIQzpSsU6k8/PPQeJOXepBq9YWizgTL7aOOxChObtay2nnFp8fBHqMa
         LvpW2if8LPASDFMYEfhb27dlexQT60nn9d3dY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Owe3WEEvN9p/SYMSQvZJkkHHqglCi0hIPyzh+2BeQeI=;
        b=eZ9zsDBS4CtCfaZ/lrBA8y6af0oRFFOKItoOJcyB+ySuUOfcpqTC+pgowWNpUZJ73Y
         JlcDm2QvJs8eVYv9bmkWPgzOwdhhJFiUkuovJ95YP/CkBrQHPev4vTuBxydIDMerLlRx
         r34Wy2QnLTpfzqFfnZLKfjcjVOpPR+JGO0pVzUM0c5cEgV9ZXjEz4Q3w3GoqFj4Vjz54
         ULP01wP1MFlLYiAdzGcADnyu0BGTxWKk30J8cYDThmuf10Nj3vGWEQB9yUM1vs0ZQKie
         xWvIqkmuLF9ahgSDQwQGXU+2EkGOjosblkv2RtPMx7hWc8OEYYjEYwgkOSdzQQFfaj2u
         sTlg==
X-Gm-Message-State: AOAM531c6X5i+xjwWa8jUWNCgPYdrczMotUYyXnFM4EzOw8zVLRsPifl
        GwjSASapHZwonfUv6/Rfd6WjVw==
X-Google-Smtp-Source: ABdhPJxlQIhqwdlp+5bS1sr/NWQ+A3RkYtMPqT6c/FrqOtmmG3vhCgjjUIAV1mW2KmDJKGmmY3bIZA==
X-Received: by 2002:a05:6602:2183:: with SMTP id b3mr20596969iob.20.1597863628789;
        Wed, 19 Aug 2020 12:00:28 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
        by smtp.gmail.com with ESMTPSA id e19sm13692266iow.33.2020.08.19.12.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 12:00:28 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     adrian.hunter@intel.com
Cc:     Akshu.Agrawal@amd.com, chris.wang@amd.com,
        Nehal-bakulchandra.Shah@amd.com,
        Raul E Rangel <rrangel@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci-acpi: Fix HS400 tuning for AMDI0040
Date:   Wed, 19 Aug 2020 13:00:19 -0600
Message-Id: <20200819125832.v2.1.Ie8f0689ec9f449203328b37409d1cf06b565f331@changeid>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The AMD eMMC Controller can only use the tuned clock while in HS200 and
HS400 mode. If we switch to a different mode, we need to disable the
tuned clock. If we have previously performed tuning and switch back to
HS200 or HS400, we can re-enable the tuned clock.

Previously the tuned clock was not getting disabled when switching to
DDR52 which is part of the HS400 tuning sequence.

Fixes: 34597a3f60b1 ("mmc: sdhci-acpi: Add support for ACPI HID of AMD Controller with HS400")
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Changes in v2:
- Added static to amd_sdhci_execute_tuning

 drivers/mmc/host/sdhci-acpi.c | 68 +++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 48ecbd0b180d8..a832d917e2fe3 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -535,6 +535,11 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_qcom_sd = {
 	.caps    = MMC_CAP_NONREMOVABLE,
 };
 
+struct amd_sdhci_host {
+	bool	tuned_clock;
+	bool	dll_enabled;
+};
+
 /* AMD sdhci reset dll register. */
 #define SDHCI_AMD_RESET_DLL_REGISTER    0x908
 
@@ -555,26 +560,67 @@ static void sdhci_acpi_amd_hs400_dll(struct sdhci_host *host)
 }
 
 /*
- * For AMD Platform it is required to disable the tuning
- * bit first controller to bring to HS Mode from HS200
- * mode, later enable to tune to HS400 mode.
+ * The initialization sequence for HS400 is:
+ *     HS->HS200->Perform Tuning->HS->HS400
+ *
+ * The re-tuning sequence is:
+ *     HS400->DDR52->HS->HS200->Perform Tuning->HS->HS400
+ *
+ * The AMD eMMC Controller can only use the tuned clock while in HS200 and HS400
+ * mode. If we switch to a different mode, we need to disable the tuned clock.
+ * If we have previously performed tuning and switch back to HS200 or
+ * HS400, we can re-enable the tuned clock.
+ *
  */
 static void amd_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_acpi_host *acpi_host = sdhci_priv(host);
+	struct amd_sdhci_host *amd_host = sdhci_acpi_priv(acpi_host);
 	unsigned int old_timing = host->timing;
+	u16 val;
 
 	sdhci_set_ios(mmc, ios);
-	if (old_timing == MMC_TIMING_MMC_HS200 &&
-	    ios->timing == MMC_TIMING_MMC_HS)
-		sdhci_writew(host, 0x9, SDHCI_HOST_CONTROL2);
-	if (old_timing != MMC_TIMING_MMC_HS400 &&
-	    ios->timing == MMC_TIMING_MMC_HS400) {
-		sdhci_writew(host, 0x80, SDHCI_HOST_CONTROL2);
-		sdhci_acpi_amd_hs400_dll(host);
+
+	if (old_timing != host->timing && amd_host->tuned_clock) {
+		if (host->timing == MMC_TIMING_MMC_HS400 ||
+		    host->timing == MMC_TIMING_MMC_HS200) {
+			val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+			val |= SDHCI_CTRL_TUNED_CLK;
+			sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
+		} else {
+			val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+			val &= ~SDHCI_CTRL_TUNED_CLK;
+			sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
+		}
+
+		/* DLL is only required for HS400 */
+		if (host->timing == MMC_TIMING_MMC_HS400 &&
+		    !amd_host->dll_enabled) {
+			trace_printk("%s: Enabling DLL\n", __func__);
+			sdhci_acpi_amd_hs400_dll(host);
+			amd_host->dll_enabled = true;
+		}
 	}
 }
 
+static int amd_sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	int err;
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_acpi_host *acpi_host = sdhci_priv(host);
+	struct amd_sdhci_host *amd_host = sdhci_acpi_priv(acpi_host);
+
+	amd_host->tuned_clock = false;
+
+	err = sdhci_execute_tuning(mmc, opcode);
+
+	if (!err && !host->tuning_err)
+		amd_host->tuned_clock = true;
+
+	return err;
+}
+
 static const struct sdhci_ops sdhci_acpi_ops_amd = {
 	.set_clock	= sdhci_set_clock,
 	.set_bus_width	= sdhci_set_bus_width,
@@ -602,6 +648,7 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
 
 	host->mmc_host_ops.select_drive_strength = amd_select_drive_strength;
 	host->mmc_host_ops.set_ios = amd_set_ios;
+	host->mmc_host_ops.execute_tuning = amd_sdhci_execute_tuning;
 	return 0;
 }
 
@@ -613,6 +660,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_amd_emmc = {
 			  SDHCI_QUIRK_32BIT_ADMA_SIZE,
 	.quirks2	= SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
 	.probe_slot     = sdhci_acpi_emmc_amd_probe_slot,
+	.priv_size	= sizeof(struct amd_sdhci_host),
 };
 
 struct sdhci_acpi_uid_slot {
-- 
2.28.0.220.ged08abb693-goog

