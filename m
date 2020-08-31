Return-Path: <SRS0=ypud=CJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA8FC433E7
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 21:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E77208CA
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 21:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OS9gs7zA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgHaVLA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Aug 2020 17:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgHaVKg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Aug 2020 17:10:36 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2E8C061575
        for <linux-mmc@vger.kernel.org>; Mon, 31 Aug 2020 14:10:35 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d190so6619953iof.3
        for <linux-mmc@vger.kernel.org>; Mon, 31 Aug 2020 14:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fct3OniIAh7vq4PmVo6V6yOdFXmba0zXgaN8XqOugb8=;
        b=OS9gs7zA6vnWaXIdgW4oTD/29+9QNuHo5Y+QT5MuPNicJHhOcRmGlh+T1zGfudkOME
         dKws0e3uJnOS3WV3S3sD6O0y315yxtmuBUq/8pFEA+owp3gliITgFSBKSCeJCJMBlRQz
         C4DgV+AJ1pGIhAVDSwGxQcuoCGB8+vA0GHOe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fct3OniIAh7vq4PmVo6V6yOdFXmba0zXgaN8XqOugb8=;
        b=X8n0b6EYJV7QlxZHAzBz4F1COFbwQZ9P2Fo+6LA9kuArxWOTNeogPdv2jSPjawLcWi
         gTvVkSwFTS5aVcRmtofsLueW2v78/ILG1YMXB2tf538//fNHsGDrYBtVod4cbMNipNJ7
         cJPCcgI/QRVWgVF8lV8MQG83mQ4eHiNPE+g+W4XI/qI7oOH89qW4Q/Af5ONQRbXV+Zjk
         ilKfu9m8uFW2JFlSTNak0dxEvup+mHnzLpin4Cu+ZFZPaCa0zMmAu8zPhFt7sLdxY6ot
         XnzU05ERnSEbZLi0+iG/YKJ9M72/vfelp8hBpMmpfL5ltiG9vhohcEVl0oO+ywt7FK2v
         g/Lw==
X-Gm-Message-State: AOAM531Dqf0oFTK8x4dqq02o3IvQfXH+M0Ju9flCBffUI4BbiVHmcseU
        MW3Q5e43JZgBxRKGshx8JgaMAg==
X-Google-Smtp-Source: ABdhPJwlJ/rs0nG0HBgLhylpvYBhuBlWkXOCzKi3WbxNowDljJgS3+8Nvv2ps1fh0YXLqokwqRAeYw==
X-Received: by 2002:a02:65c2:: with SMTP id u185mr2914044jab.35.1598908234755;
        Mon, 31 Aug 2020 14:10:34 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
        by smtp.gmail.com with ESMTPSA id w13sm4090144iox.10.2020.08.31.14.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 14:10:34 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     adrian.hunter@intel.com
Cc:     Nehal-bakulchandra.Shah@amd.com, chris.wang@amd.com,
        Akshu.Agrawal@amd.com, Raul E Rangel <rrangel@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci-acpi: Clear amd_sdhci_host on reset
Date:   Mon, 31 Aug 2020 15:10:32 -0600
Message-Id: <20200831150517.1.I93c78bfc6575771bb653c9d3fca5eb018a08417d@changeid>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

commit 61d7437ed1390 ("mmc: sdhci-acpi: Fix HS400 tuning for AMDI0040")
broke resume for HS400. When the system suspends the eMMC controller is
powered down. So on resume we need to reinitialize the controller.
amd_sdhci_host was not getting cleared, so the DLL was never re-enabled
on resume. This results in HS400 being non-functional.

This change clears the tuned_clock flag, clears the dll_enabled flag and
disables the DLL on reset.

Fixes: 61d7437ed1390 ("mmc: sdhci-acpi: Fix HS400 tuning for AMDI0040")

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
- Performed 100+ suspend/resume cycles without issue.
- Also verified tuning continues to work.

 drivers/mmc/host/sdhci-acpi.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 962f074ca1742..284cba11e2795 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -551,12 +551,18 @@ static int amd_select_drive_strength(struct mmc_card *card,
 	return MMC_SET_DRIVER_TYPE_A;
 }
 
-static void sdhci_acpi_amd_hs400_dll(struct sdhci_host *host)
+static void sdhci_acpi_amd_hs400_dll(struct sdhci_host *host, bool enable)
 {
+	struct sdhci_acpi_host *acpi_host = sdhci_priv(host);
+	struct amd_sdhci_host *amd_host = sdhci_acpi_priv(acpi_host);
+
 	/* AMD Platform requires dll setting */
 	sdhci_writel(host, 0x40003210, SDHCI_AMD_RESET_DLL_REGISTER);
 	usleep_range(10, 20);
-	sdhci_writel(host, 0x40033210, SDHCI_AMD_RESET_DLL_REGISTER);
+	if (enable)
+		sdhci_writel(host, 0x40033210, SDHCI_AMD_RESET_DLL_REGISTER);
+
+	amd_host->dll_enabled = enable;
 }
 
 /*
@@ -596,10 +602,8 @@ static void amd_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 		/* DLL is only required for HS400 */
 		if (host->timing == MMC_TIMING_MMC_HS400 &&
-		    !amd_host->dll_enabled) {
-			sdhci_acpi_amd_hs400_dll(host);
-			amd_host->dll_enabled = true;
-		}
+		    !amd_host->dll_enabled)
+			sdhci_acpi_amd_hs400_dll(host, true);
 	}
 }
 
@@ -620,10 +624,23 @@ static int amd_sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return err;
 }
 
+static void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
+{
+	struct sdhci_acpi_host *acpi_host = sdhci_priv(host);
+	struct amd_sdhci_host *amd_host = sdhci_acpi_priv(acpi_host);
+
+	if (mask & SDHCI_RESET_ALL) {
+		amd_host->tuned_clock = false;
+		sdhci_acpi_amd_hs400_dll(host, false);
+	}
+
+	sdhci_reset(host, mask);
+}
+
 static const struct sdhci_ops sdhci_acpi_ops_amd = {
 	.set_clock	= sdhci_set_clock,
 	.set_bus_width	= sdhci_set_bus_width,
-	.reset		= sdhci_reset,
+	.reset		= amd_sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
-- 
2.28.0.402.g5ffc5be6b7-goog

