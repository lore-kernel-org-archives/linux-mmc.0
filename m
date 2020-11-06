Return-Path: <SRS0=Gh8q=EM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239B2C5517A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF26A2075A
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Nov 2020 02:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDQpvOMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgKFC2F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Nov 2020 21:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgKFC2E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Nov 2020 21:28:04 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85020C0613D2
        for <linux-mmc@vger.kernel.org>; Thu,  5 Nov 2020 18:28:03 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id z24so2783394pgk.3
        for <linux-mmc@vger.kernel.org>; Thu, 05 Nov 2020 18:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EHuG0Jy6EGEK8AT49rN0FT6QR3rLE0SQJ7N5PHZrNUg=;
        b=lDQpvOMhfEckH3aBCoY6dQHdQP0xQtt0xKcmT1nRLxjH7bXA8rS3lbs6NtH7dRNnL+
         YA5TG/iE0b+21OXTzpOqdaZAry5qDp7DDN/Lc6B68/zzJVNSz+s84vNduVd+9dVbpCeb
         ccIEnyX/3qdwHqHj9HD63ICzvuj07svIXfulJ2H3vKNG0OAG+tkEgVbh30Z8HBWsJWhs
         n45BQqr1FlTFU25LfMuoA2Q/bRr8Tq9LmWktyJoBXVEETCQtjnOVKVJse67v3HvuTFsr
         pinxLTapW7lBb9eQD37sgsJRokbw/mbIQYyE0+0nHp0ae2ZnPaFCMrXnTCmdjQNJZ/Fn
         XQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EHuG0Jy6EGEK8AT49rN0FT6QR3rLE0SQJ7N5PHZrNUg=;
        b=aKuc66jNZVAJ1bKANYk/Sl+0PxKGrEQpSkNdwStoVvCXrhMHTzyjH+5i0K7h68edm+
         6L+vBeco7znEGR0pWWMW5qB0x90n5WVnhmk+wzCJGEYarIuA+E8Gst6TWSUWQuXRNbr5
         8ljyA9m7e78FWveIjN6RBQKQew/bkNaNfbiiJJvxdhYdyJNZYsN+bkQGB9+dU0zuS9tc
         h3n5uT69wiWnXmZUO+qEV9Bu1c+QghUj9/cMX2okulpZzbm0oVq9eg8WzNWGZVnRzkau
         zr6in4S5lXBL+lNKFK5SopX6tFEWFys5wdX7Jf9jrNz+sxTMk8v0pf5IITWFj6B9THim
         LrkQ==
X-Gm-Message-State: AOAM530rzdRu4kfRPuKWQlvLzuKB8dJmJo2ZPy/mPGfUluKw+Qhl1/VM
        gRTSC3avDHFQ1bPhpEcQZ79BrQ==
X-Google-Smtp-Source: ABdhPJyuAUYh9S8nNtqsyW6D2p9vq1O6UCtYHz2DUeavZTjWzEmAmN3e9YJz24uoDKohv6uE53fNOA==
X-Received: by 2002:a63:fd08:: with SMTP id d8mr5270959pgh.406.1604629683072;
        Thu, 05 Nov 2020 18:28:03 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:02 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 02/27] mmc: core: UHS-II support, modify power-up sequence
Date:   Fri,  6 Nov 2020 11:27:01 +0900
Message-Id: <20201106022726.19831-3-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

According to Fig. 3-35 in "SD Host Controller Simplified Spec. Ver4.20":
- Prepare vdd1, vdd2 and ios.timing for using after/in step (2)
- chip_select is not used in UHS-II, used to return to the legacy flow

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/core/core.c      | 61 +++++++++++++++++++++++++-----------
 drivers/mmc/core/regulator.c | 14 +++++++++
 2 files changed, 56 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d42037f0f10d..5541ed956c4d 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1315,33 +1315,52 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
 	if (host->ios.power_mode == MMC_POWER_ON)
 		return;
 
-	mmc_pwrseq_pre_power_on(host);
+	if (host->flags & MMC_UHS2_SUPPORT) {
+		/* TODO: handle 'ocr' parameter */
+		host->ios.vdd = fls(host->ocr_avail) - 1;
+		host->ios.vdd2 = fls(host->ocr_avail_uhs2) - 1;
+		if (mmc_host_is_spi(host))
+			host->ios.chip_select = MMC_CS_HIGH;
+		else
+			host->ios.chip_select = MMC_CS_DONTCARE;
+		host->ios.timing = MMC_TIMING_UHS2;
+	} else {
+		mmc_pwrseq_pre_power_on(host);
 
-	host->ios.vdd = fls(ocr) - 1;
-	host->ios.power_mode = MMC_POWER_UP;
-	/* Set initial state and call mmc_set_ios */
-	mmc_set_initial_state(host);
+		host->ios.vdd = fls(ocr) - 1;
+		host->ios.power_mode = MMC_POWER_UP;
+		/* Set initial state and call mmc_set_ios */
+		mmc_set_initial_state(host);
 
-	mmc_set_initial_signal_voltage(host);
+		mmc_set_initial_signal_voltage(host);
 
-	/*
-	 * This delay should be sufficient to allow the power supply
-	 * to reach the minimum voltage.
-	 */
-	mmc_delay(host->ios.power_delay_ms);
+		/*
+		 * This delay should be sufficient to allow the power supply
+		 * to reach the minimum voltage.
+		 */
+		mmc_delay(host->ios.power_delay_ms);
 
-	mmc_pwrseq_post_power_on(host);
+		mmc_pwrseq_post_power_on(host);
 
+	}
 	host->ios.clock = host->f_init;
-
 	host->ios.power_mode = MMC_POWER_ON;
+
 	mmc_set_ios(host);
 
-	/*
-	 * This delay must be at least 74 clock sizes, or 1 ms, or the
-	 * time required to reach a stable voltage.
-	 */
-	mmc_delay(host->ios.power_delay_ms);
+	if (host->flags & MMC_UHS2_SUPPORT)
+		/*
+		 * This delay should be sufficient to allow the power supply
+		 * to reach the minimum voltage.
+		 */
+		/*  TODO: avoid an immediate value */
+		mmc_delay(10);
+	else
+		/*
+		 * This delay must be at least 74 clock sizes, or 1 ms, or the
+		 * time required to reach a stable voltage.
+		 */
+		mmc_delay(host->ios.power_delay_ms);
 }
 
 void mmc_power_off(struct mmc_host *host)
@@ -2316,7 +2335,11 @@ void mmc_start_host(struct mmc_host *host)
 
 	if (!(host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)) {
 		mmc_claim_host(host);
-		mmc_power_up(host, host->ocr_avail);
+
+		/* Power up here will make UHS2 init ugly. */
+		if (!(host->caps & MMC_CAP_UHS2))
+			mmc_power_up(host, host->ocr_avail);
+
 		mmc_release_host(host);
 	}
 
diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 609201a467ef..629e25bc8cb7 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -249,6 +249,7 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 
 	mmc->supply.vmmc = devm_regulator_get_optional(dev, "vmmc");
 	mmc->supply.vqmmc = devm_regulator_get_optional(dev, "vqmmc");
+	mmc->supply.vmmc2 = devm_regulator_get_optional(dev, "vmmc2");
 
 	if (IS_ERR(mmc->supply.vmmc)) {
 		if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
@@ -268,6 +269,19 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 		dev_dbg(dev, "No vqmmc regulator found\n");
 	}
 
+	if (IS_ERR(mmc->supply.vmmc2)) {
+		if (PTR_ERR(mmc->supply.vmmc2) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_dbg(dev, "No vmmc2 regulator found\n");
+	} else {
+		ret = mmc_regulator_get_ocrmask(mmc->supply.vmmc2);
+		if (ret > 0)
+			mmc->ocr_avail_uhs2 = ret;
+		else
+			dev_warn(dev, "Failed getting UHS2 OCR mask: %d\n",
+				 ret);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
-- 
2.28.0

