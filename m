Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56CAC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Apr 2022 11:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiDRMBW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Apr 2022 08:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235342AbiDRMBV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2022 08:01:21 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6501A805
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2022 04:58:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n33-20020a17090a5aa400b001d28f5ee3f9so2367657pji.4
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2022 04:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RSUTOvHR9x81DktuWwrA5BNOEcj+VMAMwFa5FNnQGgo=;
        b=mkN7QSFSqj05HaDj6DWIWnlZapqYjRs9xHPkXzK58OqcoQwifjcsxAGGVBflS3sqEq
         Qmzlt98zVaVYhhGFEaUAOOtgy+HZSHFSTk7eiV9qfVJIHt6MuKzkzKi/gYfig0e/pEWS
         wiH+2FWo3ItPSfJw6Bbxg7JHmqp9g33cGk+IGgI8+J6VypGacdLfXtU2r+gm0oSZ/I1o
         bA9zF8vvEvf5dNIlhsef08JDTgu1DXJMBG2iv9yQL6RA3i/0493N6Mcsb7wFLzSQJba5
         qE3nAJxV1AJj35A8N/uf8fvib1EcMU1mO7hYH4XmlKJKnx0ReRHJ6yzl5n3gmpHld11U
         WXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RSUTOvHR9x81DktuWwrA5BNOEcj+VMAMwFa5FNnQGgo=;
        b=3/0pw+vPAV5HWrPVNmMAfML10veW+RZwKXrdn0pt4DjjFqJEA58QNJRDHhBMzmAhWG
         BPLXwRjxm9Eb8cHajQ2E9XWppzyt/aSvG3mZNzdLk+SyKsiHZiVMZfcUdQxGFQDojlmW
         vMAiut7+OrOKbUt2m9dw0R9cOZoke8cHx2KcVqTVPVJemCusQrQl33nsxfbGdlsTNZqe
         BQes0GvembeOeHLp4o5MBaUq1683vGxDILwkhZ49594fZ27es9pRsiVaLdHDbqB63hbB
         yGxVB1T7EZMD9kNpE2pcR15W/KMBLl5XcK6/oTt17lPlBtJfzLjluvp/O2kXlGEmvpi+
         R6zA==
X-Gm-Message-State: AOAM5304fLz2/vTXdNsktYFK7dI+rMVPUhs5QRMep8Waj8ZuHPbygXqt
        yY2Na2cOms/t6gMqgm7VoDw7d7xQIhU=
X-Google-Smtp-Source: ABdhPJxJjTP9sIla8K38dELxACG1yiJlUcrCFtup9j8SpBI2r9gOonapnfffZXjKuzpIqDYLexpM6Q==
X-Received: by 2002:a17:903:284:b0:158:8e21:2108 with SMTP id j4-20020a170903028400b001588e212108mr10153361plr.37.1650283121093;
        Mon, 18 Apr 2022 04:58:41 -0700 (PDT)
Received: from jason-z170xgaming7.genesyslogic.com.tw ([122.146.30.3])
        by smtp.gmail.com with ESMTPSA id u206-20020a6279d7000000b00505fdc42bf9sm12409749pfc.101.2022.04.18.04.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 04:58:40 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, dlunev@chromium.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        Tim.Hsieh@genesyslogic.com.tw
Subject: [PATCH V4 1/6] mmc: core: Cleanup printing of speed mode at card insertion
Date:   Mon, 18 Apr 2022 19:58:28 +0800
Message-Id: <20220418115833.10738-2-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418115833.10738-1-jasonlai.genesyslogic@gmail.com>
References: <20220418115833.10738-1-jasonlai.genesyslogic@gmail.com>
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

