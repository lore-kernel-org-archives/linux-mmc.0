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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973E3C4727C
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Sep 2020 23:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6144E20774
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Sep 2020 23:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fkSDlWy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgI1XTL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Sep 2020 19:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgI1XSm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2020 19:18:42 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28D9C0613D8
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2020 14:59:43 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id m17so2788754ioo.1
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2020 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3iVoZz4LPLXcD3ObX5Wdg7gmG0g3PTuNak4a1fGnsho=;
        b=fkSDlWy78hY5FJpMqklZKIdBafKlpwKwacui8jlbDg6A7yns39H/DbvJhAtgfKu7Yj
         /Qn0qDHBP6AIyNJYRAqT93zGfQyJxif6eSnaD1ZwcpdD0IrKao/9H8B0z1KAJl9q3T3z
         NwI9cNy2ZGiuCjWcyVNjKFHg2Vn7VX/7a4NOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3iVoZz4LPLXcD3ObX5Wdg7gmG0g3PTuNak4a1fGnsho=;
        b=S4CIvGPtT/xNMr4A/1cfTQOqQzjJBqdG0WtbmzbD6jJ/bmyYQoIgdSkRWGyAVFPWPn
         M5qYx8ryO/FiWDUJABiqZJZ3DBFt2Afp60n0PcjJxfLonJc7d+XVMACrMAUGyO0qzBwD
         0/D0zkVJGCh3gjeqljv5nOCP0aUDR9mSEjxaJS+rkT7tnX0epMaZHppqAtTPbrgIQJ5Y
         Tw4H7U4gwRmkJcRfux9k0XGS38VaGejrUubj/BLEhj4wu/UqOwC6ylTvayFPdDigX0Mh
         /ov+qNOtMVzDMUVI7j2TzMMI9OHU1K1lnClMEJAHWWeDuuA2U1rmMNviRCGR7I7AXtWO
         pd9w==
X-Gm-Message-State: AOAM533qnFu75t7Xk8ctgfT2SeoYQq9r+whPH59lt7q5IFDGjMR2TTSI
        FPwqAH/135E6C4tWb8PflcFbAnNSZlCeE2Ul
X-Google-Smtp-Source: ABdhPJzlEr/qw0libv0a7Eqb6Gy5PvyembzhqhHIRRsVf5kxgY5X0DIbHXD4jYKzt9vW0QaknS7GPQ==
X-Received: by 2002:a5d:8846:: with SMTP id t6mr247881ios.123.1601330383014;
        Mon, 28 Sep 2020 14:59:43 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
        by smtp.gmail.com with ESMTPSA id 64sm972782iob.36.2020.09.28.14.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:59:42 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc:     Shirish.S@amd.com, Akshu.Agrawal@amd.com,
        Nehal-bakulchandra.Shah@amd.com, chris.wang@amd.com,
        Raul E Rangel <rrangel@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: sdhci-acpi: AMDI0040: Allow changing HS200/HS400 driver strength
Date:   Mon, 28 Sep 2020 15:59:21 -0600
Message-Id: <20200928154718.2.Ic6b6031366f090393d00a53fd69e1ada31ceb29e@changeid>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
In-Reply-To: <20200928154718.1.Icc21d4b2f354e83e26e57e270dc952f5fe0b0a40@changeid>
References: <20200928154718.1.Icc21d4b2f354e83e26e57e270dc952f5fe0b0a40@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

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
---

 drivers/mmc/host/sdhci-acpi.c | 39 ++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index d335a34ad05b3..5c9a041af5b4b 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -545,10 +545,43 @@ struct amd_sdhci_host {
 
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
+	preset_driver_strength =
+		(preset & SDHCI_PRESET_DRV_MASK) >> SDHCI_PRESET_DRV_SHIFT;
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
2.28.0.709.gb0816b6eb0-goog

