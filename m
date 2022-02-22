Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF37C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Feb 2022 03:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbiBVDkS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Feb 2022 22:40:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiBVDkS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2022 22:40:18 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCC7240B8
        for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2022 19:39:54 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s16so15909483pgs.13
        for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2022 19:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RSUTOvHR9x81DktuWwrA5BNOEcj+VMAMwFa5FNnQGgo=;
        b=O8hZg3EUmQGmSnyYk5Eo9OnJ8Mmm79l2v3PymvtLXPHvFjEBcWF+u9Z6rDfK3K6zP/
         BWuqDaJTIG8dsqSupDdCD4dEzlpmEwsv8C5yNJfmOigqQUnIQn3O/4xcpcr/1MNiacY2
         uyp+wRlyab4CqvRpuv/DtkIwIlPqP9ma+z86Amoljc5mKBJlVXYARVVWvQMx6VZH38ZM
         XMFsbIxq7bIpadSu6cpqMaGWIGpDLAu6CW0WABhy0Nz0Rqft4XwK8lORmY3IsE3r/HE9
         1KCui2FqpC0BQm7by7AwDhmi7uFGu0MJEp5WmO78Fwz8YoYP2xhdI3I0ewZSBx73xxkz
         j7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RSUTOvHR9x81DktuWwrA5BNOEcj+VMAMwFa5FNnQGgo=;
        b=SauGKHz9FzrzXlx4tFykp4ccRMoeKg3b3pEGh4y5bBFDqghLXbBpKQNE2YhQ4I0u6T
         4MB6Ytxw8+1O47espNasIPAPy6N71pFwmAI9MvTSMK8xynhP+NQ0dFedLfjFkX7DpqgI
         ki+LwY55TNhZyIzGia/A2uNjMm1tyKT3ebKrbRzwOub3wK6vCT+MUunggJviZBagtgRG
         U0ZgzIf63fJ7II7se2LLvLdUsmCjOCZmyj4aIFNAq8BpZcdgFoFq5JmtedOH44jO7K+m
         gbMgMXkyhQJANFnLIB5dddG0na4lkEo7IzGeBDX0hB5IZcQw+jCXxIt8T+WThNBG6aCI
         ZuRg==
X-Gm-Message-State: AOAM530fMRXJy9ij5UFhOgQEkvqU7BmcdKKDmoi3yOP+Oss61no3uwWi
        h4UJh51i+bmXHD/d6DeNJS4=
X-Google-Smtp-Source: ABdhPJwK9RxJPbv8WdAjLlN2wSmWI4OHB1eDctY+/TzsUVguanCEgFX/1HGQ/SiJHMWZoqtzfZG0Wg==
X-Received: by 2002:a05:6a00:b51:b0:4c7:c1a3:3911 with SMTP id p17-20020a056a000b5100b004c7c1a33911mr22916096pfo.13.1645501193640;
        Mon, 21 Feb 2022 19:39:53 -0800 (PST)
Received: from localhost.localdomain (220-128-190-163.hinet-ip.hinet.net. [220.128.190.163])
        by smtp.gmail.com with ESMTPSA id ng16sm703542pjb.12.2022.02.21.19.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 19:39:53 -0800 (PST)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, dlunev@chromium.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, otis.wu@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com
Subject: [PATCH V3 1/7] mmc: core: Cleanup printing of speed mode at card insertion
Date:   Tue, 22 Feb 2022 11:39:25 +0800
Message-Id: <20220222033931.237638-2-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
References: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

The current print of the bus speed mode in mmc_add_card() has grown over
the years and is now difficult to parse. Let's clean up the code and also
take the opportunity to properly announce "DDR" for eMMCs as
"high speed DDR", which is according to the eMMC spec.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 58a60afa650b..eefe74bf1356 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -299,6 +299,7 @@ int mmc_add_card(struct mmc_card *card)
 {
 	int ret;
 	const char *type;
+	const char *speed_mode = "";
 	const char *uhs_bus_speed_mode = "";
 	static const char *const uhs_speeds[] = {
 		[UHS_SDR12_BUS_SPEED] = "SDR12 ",
@@ -337,27 +338,30 @@ int mmc_add_card(struct mmc_card *card)
 		break;
 	}
 
+	if (mmc_card_hs(card))
+		speed_mode = "high speed ";
+	else if (mmc_card_uhs(card))
+		speed_mode = "ultra high speed ";
+	else if	(mmc_card_ddr52(card))
+		speed_mode = "high speed DDR ";
+	else if (mmc_card_hs200(card))
+		speed_mode = "HS200 ";
+	else if (mmc_card_hs400es(card))
+		speed_mode = "HS400 Enhanced strobe ";
+	else if (mmc_card_hs400(card))
+		speed_mode = "HS400 ";
+
 	if (mmc_card_uhs(card) &&
 		(card->sd_bus_speed < ARRAY_SIZE(uhs_speeds)))
 		uhs_bus_speed_mode = uhs_speeds[card->sd_bus_speed];
 
-	if (mmc_host_is_spi(card->host)) {
-		pr_info("%s: new %s%s%s card on SPI\n",
-			mmc_hostname(card->host),
-			mmc_card_hs(card) ? "high speed " : "",
-			mmc_card_ddr52(card) ? "DDR " : "",
-			type);
-	} else {
-		pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
-			mmc_hostname(card->host),
-			mmc_card_uhs(card) ? "ultra high speed " :
-			(mmc_card_hs(card) ? "high speed " : ""),
-			mmc_card_hs400(card) ? "HS400 " :
-			(mmc_card_hs200(card) ? "HS200 " : ""),
-			mmc_card_hs400es(card) ? "Enhanced strobe " : "",
-			mmc_card_ddr52(card) ? "DDR " : "",
+	if (mmc_host_is_spi(card->host))
+		pr_info("%s: new %s%s card on SPI\n",
+			mmc_hostname(card->host), speed_mode, type);
+	else
+		pr_info("%s: new %s%s%s card at address %04x\n",
+			mmc_hostname(card->host), speed_mode,
 			uhs_bus_speed_mode, type, card->rca);
-	}
 
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_card_debugfs(card);
-- 
2.35.1

