Return-Path: <SRS0=Afy4=DF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C549FC2D0A8
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Sep 2020 23:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917982076A
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Sep 2020 23:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U/ceRJP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgI1XTA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgI1XSm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2020 19:18:42 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A37C0613D6
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2020 14:59:42 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y74so2747330iof.12
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2020 14:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jjICLRW9zp7rjH1xxoqaPHr2CQZArUV9GhyHT31ELGc=;
        b=U/ceRJP4prYsl1z6Mjv27nfa9g31wiRYeH8gnIUfwpMuG/XMqA0qlOPjPZzGB/iHX1
         zpd2YB294YeuVT70cg+FF+9eHHR6d7d/xII2W6nKYbq34jXfPPFUUC4Ao+sVO/QRHAtA
         D6/oVD6slmKRA1hYYC0ausIGumCep2lg9f1sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jjICLRW9zp7rjH1xxoqaPHr2CQZArUV9GhyHT31ELGc=;
        b=MXtrOJzLaRiwyQLn0CfKymLV6cV1Hnl6eyKBB+mRKOF6oVxAu6lk53WZxDCahdDP0U
         Ifmt2BkOg4/4NF38h5t/S6FghuUWcqZhCYrSOcLqvWa9oyr+2XpPYkIbwBUoWEsPBSi5
         ZDFCjniyH9AyTJ4PmuEcYJUfn/w3ccPFnA618sEOFWK122ff28BPva031yTmNyo4VQiP
         D+1tNR91wKQECVqzrQW6azYPK72wU8Wiu6xfVjrAj1MHnsZOiWDLvOwxVDI4Ia0S2Suu
         2swC/0TQOnXcGmK3DZPdCRFQ5iegrOiv0ti5oFtR+hOah7ovkRRk4tb10LEGJO8VyUID
         7MTg==
X-Gm-Message-State: AOAM531t01E3MjcpERgSuxcY5lccyRyAxC+5Dcy0NGbW7aWkDh7mKpdO
        1EY23SfZTqxQFoQqZxnei7JYUvxOM9R6UX4F
X-Google-Smtp-Source: ABdhPJw0+Evjo5ZoC31YDnlrZyShOTdhQBJg05NH4MEG/JlH9UM2itcwa/hE5ffodBOww+6QviQhdg==
X-Received: by 2002:a02:3b27:: with SMTP id c39mr579779jaa.95.1601330382021;
        Mon, 28 Sep 2020 14:59:42 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
        by smtp.gmail.com with ESMTPSA id 64sm972782iob.36.2020.09.28.14.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:59:41 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc:     Shirish.S@amd.com, Akshu.Agrawal@amd.com,
        Nehal-bakulchandra.Shah@amd.com, chris.wang@amd.com,
        Raul E Rangel <rrangel@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: sdhci-acpi: AMDI0040: Set SDHCI_QUIRK2_PRESET_VALUE_BROKEN
Date:   Mon, 28 Sep 2020 15:59:20 -0600
Message-Id: <20200928154718.1.Icc21d4b2f354e83e26e57e270dc952f5fe0b0a40@changeid>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This change fixes HS400 tuning for devices with invalid presets.

SDHCI presets are not currently used for eMMC HS/HS200/HS400, but are
used for DDR52. The HS400 retuning sequence is:

    HS400->DDR52->HS->HS200->Perform Tuning->HS->HS400

This means that when HS400 tuning happens, we transition through DDR52
for a very brief period. This causes presets to be enabled
unintentionally and stay enabled when transitioning back to HS200 or
HS400. Some firmware has invalid presets, so we end up with driver
strengths that can cause I/O problems.

Fixes: 34597a3f60b1 ("mmc: sdhci-acpi: Add support for ACPI HID of AMD Controller with HS400")
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
I decided to abandon adding the preset_value_support for now. Enabling
presets for the AMD controller currently results in using invalid
presets for HS400. This is because sdhci_get_preset_value is using a
non-standard HS400 register that the AMD controller does not support.

I think preset_value_support also needs more thought. Since HS400
re-tuning requires switching to HS, DDR52, and HS200, if one of those
timings is not in the list, we would need to disable presets.

I chose this approach to avoid any additional complexity.

 drivers/mmc/host/sdhci-acpi.c | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 284cba11e2795..d335a34ad05b3 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -662,6 +662,43 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
 	    (host->mmc->caps & MMC_CAP_1_8V_DDR))
 		host->mmc->caps2 = MMC_CAP2_HS400_1_8V;
 
+	/*
+	 * There are two types of presets out in the wild:
+	 * 1) Default/broken presets.
+	 *    These presets have two sets of problems:
+	 *    a) The clock divisor for SDR12, SDR25, and SDR50 is too small.
+	 *       This results in clock frequencies that are 2x higher than
+	 *       acceptable. i.e., SDR12 = 25 MHz, SDR25 = 50 MHz, SDR50 =
+	 *       100 MHz.x
+	 *    b) The HS200 and HS400 driver strengths don't match.
+	 *       By default, the SDR104 preset register has a driver strength of
+	 *       A, but the (internal) HS400 preset register has a driver
+	 *       strength of B. As part of initializing HS400, HS200 tuning
+	 *       needs to be performed. Having different driver strengths
+	 *       between tuning and operation is wrong. It results in different
+	 *       rise/fall times that lead to incorrect sampling.
+	 * 2) Firmware with properly initialized presets.
+	 *    These presets have proper clock divisors. i.e., SDR12 => 12MHz,
+	 *    SDR25 => 25 MHz, SDR50 => 50 MHz. Additionally the HS200 and
+	 *    HS400 preset driver strengths match.
+	 *
+	 *    Enabling presets for HS400 doesn't work for the following reasons:
+	 *    1) sdhci_set_ios has a hard coded list of timings that are used
+	 *       to determine if presets should be enabled.
+	 *    2) sdhci_get_preset_value is using a non-standard register to
+	 *       read out HS400 presets. The AMD controller doesn't support this
+	 *       non-standard register. In fact, it doesn't expose the HS400
+	 *       preset register anywhere in the SDHCI memory map. This results
+	 *       in reading a garbage value and using the wrong presets.
+	 *
+	 *       Since HS400 and HS200 presets must be identical, we could
+	 *       instead use the the SDR104 preset register.
+	 *
+	 *    If the above issues are resolved we could remove this quirk for
+	 *    firmware that that has valid presets (i.e., SDR12 <= 12 MHz).
+	 */
+	host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+
 	host->mmc_host_ops.select_drive_strength = amd_select_drive_strength;
 	host->mmc_host_ops.set_ios = amd_set_ios;
 	host->mmc_host_ops.execute_tuning = amd_sdhci_execute_tuning;
-- 
2.28.0.709.gb0816b6eb0-goog

