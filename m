Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2954AC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F42152077D
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkPU8GVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgGJLHp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgGJLHo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:07:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945D2C08C5CE;
        Fri, 10 Jul 2020 04:07:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x72so2397535pfc.6;
        Fri, 10 Jul 2020 04:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XOFeEnxeFd3DTgaPl4GKh005ARvuiNKhOn7oW5FdfWA=;
        b=mkPU8GVR/yDq0XPj/516OIDXgA96qCnU4BWC7k2KfShqtnBia8e1z9CMjuca2lE1e+
         N95N12QLmfteMfdRPlCDnEG2Bbv8PoINu7Yf9cwjsExFnK4KK50HsheboxiA5/wnRcqE
         +DCPagF7PKOKzpc/mSkXZXCwv33dxV99ZU0aYyvPQuSUjVzaS9FZJKU/mNrhjG+DVQ5I
         5VC2Z8Rvx0eZiCobwODBQ94hlgjU73cdHJ2558KMAtqMGNnX5oiSAa0ijumyVg/5llX1
         ejOr5WTJXiVTjYrVgJxSFrpdcot4MYtiprK1ffXfkZSVDxantUTqmmDlVrm67ksqoufC
         H9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XOFeEnxeFd3DTgaPl4GKh005ARvuiNKhOn7oW5FdfWA=;
        b=uIHHnMwlZu+N6Ia7S/RGfsUZcj7azmJCFBJea9+1Ht9TLuw0xw4i+Gos4agOIPAWjR
         fxW8MPv8gaWIgCjHisI+oDvsI0IqYQyy3iUfN2R61FQvUgswQO2eqtcapyZKiBDoRbb3
         X62hTXZKaJIOraZcwHpVv+o4wOt2/RIxRHBcdQDWUjruiwVjAUEqhmRay2u9j6mdhncd
         D2hJlAPfrXeMnlvatm114d79R2Dj2VWNbNbYZjYjaavdIR0vzzfuAikIrQlzoMGYo1YU
         vpBZbvd9jgBgszMlvWlsSJksPdt4x0nb2+eC+dI7chX4dah2gLsNMIenhiTbe1PC+vix
         lceQ==
X-Gm-Message-State: AOAM533InLDXuhkCmYFhzaKJV0BU12eht7PGtKiIcFDzMFwCluLTJly0
        +V7YfeJOb4DCyqS3PULlYeE6Edqd
X-Google-Smtp-Source: ABdhPJwXOI8A1cjuOAhhHZ9joN+0ndyfu3R4Ng9Xxtc9ejEveyqoNyn5igxbGK8yKXhEM1Maqp67jg==
X-Received: by 2002:a62:ce46:: with SMTP id y67mr58779108pfg.118.1594379264093;
        Fri, 10 Jul 2020 04:07:44 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id k3sm5463656pjl.15.2020.07.10.04.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:07:43 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 02/21] mmc: core: UHS-II support, modify power-up sequence
Date:   Fri, 10 Jul 2020 19:08:19 +0800
Message-Id: <20200710110819.28965-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

According to Fig. 3-35 in "SD Host Controller Simplified Spec. Ver4.20":
- Prepare vdd1, vdd2 and ios.timing for using after/in step (2)
- chip_select is not used in UHS-II, used to return to the legacy flow

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/core/core.c      | 62 ++++++++++++++++++++++++------------
 drivers/mmc/core/regulator.c | 14 ++++++++
 2 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8d2b808e9b58..85c83c82ad0c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1315,33 +1315,51 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
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
-
-	mmc_pwrseq_post_power_on(host);
+		/*
+		 * This delay should be sufficient to allow the power supply
+		 * to reach the minimum voltage.
+		 */
+		mmc_delay(host->ios.power_delay_ms);
 
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
@@ -2307,7 +2325,11 @@ void mmc_start_host(struct mmc_host *host)
 
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
index 96b1d15045d6..05556225d9ac 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -247,6 +247,7 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 
 	mmc->supply.vmmc = devm_regulator_get_optional(dev, "vmmc");
 	mmc->supply.vqmmc = devm_regulator_get_optional(dev, "vqmmc");
+	mmc->supply.vmmc2 = devm_regulator_get_optional(dev, "vmmc2");
 
 	if (IS_ERR(mmc->supply.vmmc)) {
 		if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
@@ -266,6 +267,19 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
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
2.27.0

