Return-Path: <SRS0=lEQw=EC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB54C4363A
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 08:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BEA22224E
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 08:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m1iPMNbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444496AbgJ0Iqf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Oct 2020 04:46:35 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:42980 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443776AbgJ0Iqf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Oct 2020 04:46:35 -0400
Received: by mail-yb1-f202.google.com with SMTP id u13so650439ybk.9
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2020 01:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=PHSX1yllEEpVL2wWXaBXv4UsLFRKnniRVSM8yQzP6OY=;
        b=m1iPMNbsZU6ojEjWigu9LT/5yPvJjM04VR/kS0RL5z9vq3o9VCW73xMXjIZ/z+Zxli
         DRtbo1uHbLFT6+jCQTzU6htk6OOyzobJ0yKRlPfQ2VyJvKAFgMjlQ21gOn7feYQk+E9G
         FLqmP/quCVYamrqTocJHlq5UbZQxySc/i+WOEF+DJ3iwVq6loaJd6rMyyBH7wvpf0HvY
         oQHZQFDTcxIFCtjbm5DhdmDomnfyzKAQTBNL6tnF65JD8cKSCcVe/WyJHEgE8ISOpSiS
         PR8QgJZjQTSgy0RNMrsXbBUvnVhe1zwkvASaOcgxkL70NcPqCeur/fSJKrA54JaNgBF1
         f1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=PHSX1yllEEpVL2wWXaBXv4UsLFRKnniRVSM8yQzP6OY=;
        b=KosPVarsRtt3zx51zCd29RzmP2JZjiMTSmuOq90txxkiYR34tLosRBTOexdd2kPSGB
         Fr/lVebJtUjAmueDxANtnzbIkgglcTFzapZBMli4SVGyJ2hp6rongSkjlQP+fudmyIeu
         SRToUT755IpBau6s9krR7eSZHhZJdDCj1KcuwcjbAgHbGg4/XYwysowrakzzHTi1D9KK
         VlpkBgDD2q4lR9vJNNgWfjS4P279LMsS/Jd2ap0ZqrY46/FSrAUyUjboJBbzY8oafyLH
         pKAEOF9v/5QMQLpgb096vNudvfeDrOhrfu2h0KPJhd8Z/DHanhKMBdRq7QwbGGFsQSQN
         pStA==
X-Gm-Message-State: AOAM530pkNLkSafBvrd/h/Uqf2VCGFBe+Oi8v0BBDRccX7ctKDe9PUMo
        KHh59shbb9p4aJ7S8dGGPBKSDpOTY2iHt2gS
X-Google-Smtp-Source: ABdhPJzPQYm2BKWiGbDrkKkG4U863wayoLMRNAjsIj9mJSWCQTlU+OiLZWyK3vb37VpvVRDOrl6kajVX0900EfL0
Sender: "victording via sendgmr" <victording@victording.syd.corp.google.com>
X-Received: from victording.syd.corp.google.com ([2401:fa00:9:14:f693:9fff:fef4:fa73])
 (user=victording job=sendgmr) by 2002:a25:4e55:: with SMTP id
 c82mr1622346ybb.416.1603788393692; Tue, 27 Oct 2020 01:46:33 -0700 (PDT)
Date:   Tue, 27 Oct 2020 19:46:12 +1100
Message-Id: <20201027084612.528301-1-victording@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH v2] mmc: sdhci-acpi: AMDI0040: Allow changing HS200/HS400
 driver strength
From:   Victor Ding <victording@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Victor Ding <victording@google.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Raul E Rangel <rrangel@chromium.org>

This change will allow platform designers better control over signal
integrity by allowing them to tune the HS200 and HS400 driver strengths.

The driver strength was previously hard coded to A to solve boot
problems with certain platforms. This driver strength does not
universally apply to all platforms so we need a knob to adjust it.

All older platforms currently have the SDR104 preset hard coded to A in
the firmware. This means that switching from the hard coded value in
the kernel to reading the SDR104 preset is a no-op for these platforms.
Newer platforms will have properly set presets. So this change will
support both new and old platforms.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: Victor Ding <victording@google.com>

---

Changes in v2:
By Victor Ding <victording@google.com>
 - Rebased the patch by using FIELD_GET for preset value bit masks.
 - (No functional changes).

The original patch was developed by Raul E Rangel.
https://patchwork.kernel.org/project/linux-mmc/patch/20200928154718.2.Ic6b6031366f090393d00a53fd69e1ada31ceb29e@changeid/

 drivers/mmc/host/sdhci-acpi.c | 39 ++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 54205e3be9e8..225cb34cf1b9 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2012, Intel Corporation.
  */
 
+#include <linux/bitfield.h>
 #include <linux/init.h>
 #include <linux/export.h>
 #include <linux/module.h>
@@ -545,10 +546,42 @@ struct amd_sdhci_host {
 
 static int amd_select_drive_strength(struct mmc_card *card,
 				     unsigned int max_dtr, int host_drv,
-				     int card_drv, int *drv_type)
+				     int card_drv, int *host_driver_strength)
 {
-	*drv_type = MMC_SET_DRIVER_TYPE_A;
-	return MMC_SET_DRIVER_TYPE_A;
+	struct sdhci_host *host = mmc_priv(card->host);
+	u16 preset, preset_driver_strength;
+
+	/*
+	 * This method is only called by mmc_select_hs200 so we only need to
+	 * read from the HS200 (SDR104) preset register.
+	 *
+	 * Firmware that has "invalid/default" presets return a driver strength
+	 * of A. This matches the previously hard coded value.
+	 */
+	preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR104);
+	preset_driver_strength = FIELD_GET(SDHCI_PRESET_DRV_MASK, preset);
+
+	/*
+	 * We want the controller driver strength to match the card's driver
+	 * strength so they have similar rise/fall times.
+	 *
+	 * The controller driver strength set by this method is sticky for all
+	 * timings after this method is called. This unfortunately means that
+	 * while HS400 tuning is in progress we end up with mismatched driver
+	 * strengths between the controller and the card. HS400 tuning requires
+	 * switching from HS400->DDR52->HS->HS200->HS400. So the driver mismatch
+	 * happens while in DDR52 and HS modes. This has not been observed to
+	 * cause problems. Enabling presets would fix this issue.
+	 */
+	*host_driver_strength = preset_driver_strength;
+
+	/*
+	 * The resulting card driver strength is only set when switching the
+	 * card's timing to HS200 or HS400. The card will use the default driver
+	 * strength (B) for any other mode.
+	 */
+	return preset_driver_strength;
+
 }
 
 static void sdhci_acpi_amd_hs400_dll(struct sdhci_host *host, bool enable)
-- 
2.29.0.rc2.309.g374f81d7ae-goog

