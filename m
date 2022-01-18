Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B02C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Jan 2022 12:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiARMoJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiARMoJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jan 2022 07:44:09 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE7DC061574
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jan 2022 04:44:08 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id n11so22287151plf.4
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jan 2022 04:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b35nb6YgyrbfZ2W4MAUEaXu8RLjP7Kjaeja9omZMEvQ=;
        b=F6azLcCJsEoWu6lmCAbi4k3i+CI2fnoPOh5FFHZQHL+9E8giDKuOtT+oCEsKqwRwHP
         Aw1GA0fY/gTLGDqzVtbc7nPs9yy+490nsQURY9ZkYzGIOAgIhyqg/+1jK1MAvgksI1mO
         ff2fVvzeWgTjv+c5SlvSExe6PjrTS9k7sGjqemeptAD/fknI1QKMNvYkHYDuS6LNBBbY
         ryjOjreT4nEl9F7vOMmypk4HTxP45w+UzGAkcNZE2jKk8zT6fcwF9stVUID7gOd8Nj+H
         XDaRE9ZtG1TuSSw0vx1APojql43P7rh/dbMF7s+tI4VgrKliqxRX8hqlank4jIIK0/oS
         /Mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b35nb6YgyrbfZ2W4MAUEaXu8RLjP7Kjaeja9omZMEvQ=;
        b=MzfAnfqmloSqr8XBJ6MSJYbxqhVvoQ3m+G+oysTbFxttbSJKewvSMRuXaJYixyHTzb
         ZPgB9Hy+tIGfADbOyImlXEZoz8VLyur8MHy3j3aa8OSvBL9boAPGcPD1I/e9qI7rYwvm
         8yCHgJnzZglBxQE0da+2rM+ExASAuGGxjtKJ5qdfAkSk4S3D1chSZ3zBjR3XbjG03ZJz
         hhriO2RTv114STgjtGBBdU2asdVWxbRybScIKwnVgD75hLXlqzLxKHd7B2Iqt/mGj0ZW
         CNyjOV3uCpn/3EHfOYpKq5QTUOvWsUJAa7XnmbzRtXW9iAZkIMxAKf1gfrn+4H09FyhY
         gBNw==
X-Gm-Message-State: AOAM5301c9NOZ6EJpyb7STfBVqI1kEQF7FVaCM8oCk35FFB6N8Eekw/X
        zFwfHIki81qBETTfsO0TyUc=
X-Google-Smtp-Source: ABdhPJwDnBHlqgM9Uuo1M+YZ+rNfzvySpAhyFRi7ezi52mSdAI8ruw+V233boZIpTxqGaVH8v+MXbw==
X-Received: by 2002:a17:90a:2ec4:: with SMTP id h4mr8759752pjs.173.1642509848472;
        Tue, 18 Jan 2022 04:44:08 -0800 (PST)
Received: from jason-z170xgaming7.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id n10sm362005pfj.120.2022.01.18.04.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 04:44:08 -0800 (PST)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        otis.wu@genesyslogic.com.tw,
        Jason Lai <jasonlai.genesyslogic@gmail.com>
Subject: [PATCH v2 1/7] mmc: core: Cleanup printing of speed mode at card insertion
Date:   Tue, 18 Jan 2022 20:43:49 +0800
Message-Id: <20220118124355.167552-2-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220118124355.167552-1-jasonlai.genesyslogic@gmail.com>
References: <20220118124355.167552-1-jasonlai.genesyslogic@gmail.com>
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
index 4383c262b..27ba3c749 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -311,6 +311,7 @@ int mmc_add_card(struct mmc_card *card)
 {
 	int ret;
 	const char *type;
+	const char *speed_mode = "";
 	const char *uhs_bus_speed_mode = "";
 	static const char *const uhs_speeds[] = {
 		[UHS_SDR12_BUS_SPEED] = "SDR12 ",
@@ -349,27 +350,30 @@ int mmc_add_card(struct mmc_card *card)
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
2.34.0

