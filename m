Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F44C636C8
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8431361244
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 04:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhGVDVW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 23:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhGVDVV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 23:21:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B225C0613C1;
        Wed, 21 Jul 2021 21:01:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so3686111pjo.3;
        Wed, 21 Jul 2021 21:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TtTlmiOOwP/kifcL3jT81MRGQUXvmXHChazVkWTU6qM=;
        b=Qy7ys9tujk9AZ1EG3DwpC2b2wx7wIFQIDGYkUq5YV9czDjcN8Tbe/ZT6f+e5Npz1xs
         8QeunHq0aGbxOykDJueV5O4kV/64flhSlUL3Nu7hgmtzByv/bglveFepc8lQhBROjMC/
         u2TBkVC2JGPVlXCEqotbh5g321qft3NnmJsneV4ebxEOADQgLeEiOQtKUkErW7a0ywdm
         A5corv29xheef2oeyhZxg7Bglg5eqhomuTtk3WC8mlCYVqpf6ySPhnPuxuH9gRkAztif
         sY1APAYmE2bQVwU8Mevj3h/cne0ig0XA+VbS0xTGGYChvHeHddYwfVgLAs4OESsuMtAr
         uuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TtTlmiOOwP/kifcL3jT81MRGQUXvmXHChazVkWTU6qM=;
        b=kd4kIXSAON6ZMosTqpHHFWI/dcBaxicBGFhQwCBcnhBilWjTrgU5Vd6VuJBaiUya9Q
         yzK7jeGBYYjpKzvjexQ0dwX4f9VMIWEgwhO6LyWHrMmAflOBSFLPKfBjveXuvunYlfoM
         6ANatHwKxpUMUW3xkafiss6/m6x2ezqTdH+jhQtpLCFX8exiCRjSvgQuNDZ2ICduW7Ah
         RC3LwYOW7HY0C0rWGxw/y0o1L4vlov0iHMu+Te+xDQS6y/8BXy8YLtziD2Oao+tSJhnW
         CnD7+mKrHisUwKmDBxYsKziLYSQBSVy5Pxl6W+wEV+s1sA/6kaVx10d8wdhEvnU8b7jc
         792g==
X-Gm-Message-State: AOAM5326bhotGbc/89zR8Qx/jzD5kNyt//CXak92N+QTKdO0dV4pyUgi
        2kajvCjfnans1590iTM3W4l0shIUb6zCOQ==
X-Google-Smtp-Source: ABdhPJxg2Yto7mp3a7TrVIaYsjoCj9NFCmUhe5HMCNvlPjX/PnU4uhC+MYscZS/kVgqA67fOZOoNWQ==
X-Received: by 2002:a17:902:db0c:b029:12b:8daa:cf8c with SMTP id m12-20020a170902db0cb029012b8daacf8cmr13852586plx.78.1626926516586;
        Wed, 21 Jul 2021 21:01:56 -0700 (PDT)
Received: from jason-z170xgaming7.mshome.net (218-35-143-223.cm.dynamic.apol.com.tw. [218.35.143.223])
        by smtp.gmail.com with ESMTPSA id c19sm1663479pfp.184.2021.07.21.21.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 21:01:56 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogiv.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.2 02/29] mmc: core: UHS-II support, modify power-up sequence
Date:   Thu, 22 Jul 2021 12:00:57 +0800
Message-Id: <20210722040124.7573-2-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
References: <20210722040124.7573-1-jasonlai.genesyslogic@gmail.com>
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
index f194940c5974..722b61811f1e 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1318,33 +1318,52 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
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
@@ -2233,7 +2252,11 @@ void mmc_start_host(struct mmc_host *host)

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
2.32.0

