Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAFCC433FE
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Dec 2021 10:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352058AbhLCKyh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Dec 2021 05:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351814AbhLCKyg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Dec 2021 05:54:36 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BABDC06173E
        for <linux-mmc@vger.kernel.org>; Fri,  3 Dec 2021 02:51:12 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x131so2495158pfc.12
        for <linux-mmc@vger.kernel.org>; Fri, 03 Dec 2021 02:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b35nb6YgyrbfZ2W4MAUEaXu8RLjP7Kjaeja9omZMEvQ=;
        b=i2PDwGGwTFxYR/KiYuCqdkHnwUJSRr+ELYHwpnK/N8IXcqulChnhQ2Rh4osaFIipXd
         uGaOtiV2jCo/RldWZWuRWwY7QRuRBiojACG1aA0f7ewBneViz4BdSibcQUXNUR9NBJX6
         K9K34rcyNjizkZSvrktZsN+QvTj2Jkw7flR4t8oufxK0aNDkjVIYD7PYvIFsX3gSuqtQ
         0p0VKRol8JPb5ngiHBZrjixEsW55rXYTAJ+y400OSft0+kjtfKKMr+uGbNJK49Ox6ba2
         sjh1aIKSxwvv20yJG7O6Jwxr8kzeg/llMCE96a+TRTtvMdPgYZzc8TDBWWn9n0/a1XZN
         8FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b35nb6YgyrbfZ2W4MAUEaXu8RLjP7Kjaeja9omZMEvQ=;
        b=1B4tspKPpPfNfZXgr6KLaJu/nFCJNb6Mq7LxE7h016ISw9lCrUQ6PqIS5MQUUJsqEp
         lGZB26FBKDUEAEeRiZwGo+9niqpMWAUyfhKCC/YxhPJ6g/8LN7oVRZMV5GkwKp+rh22q
         NhXlXge5b9HMc/z2xUFRcMYVxqNFJEOfQ/N61gBCOBrxAHelbSLPvTjbLJ3vqot5BtBq
         pps3glksWCrYRnxYCUo+23Z1SoDjUg4BFj8RXZAXdHwHorpBHASX6fm9c7aVMTrpAHnR
         s7f4qB/uwxGQDlWGuT6FI4Q7aJJR4j/JSUvIlLoO+DJM/wKGDb0UfADFi4Hjw+VHbWep
         mT5w==
X-Gm-Message-State: AOAM533+h5vYuOx4VCpeiO6nIhuN4gGu87kLTGHaX53E4/gHoM2XxmgM
        yRA/fFODQsiCNGNsvx0Tjj9PPX1poNyOvA==
X-Google-Smtp-Source: ABdhPJzfycdMkEB1E3U/G8yc2ucZ08F8632WSLgnc3LI/IzJTXwWGJsqsmxxwP4jWJ01SWPnT8A0EQ==
X-Received: by 2002:a62:b418:0:b0:4a0:3696:dec0 with SMTP id h24-20020a62b418000000b004a03696dec0mr18059257pfn.73.1638528671835;
        Fri, 03 Dec 2021 02:51:11 -0800 (PST)
Received: from jason-z170xgaming7.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id x18sm2868699pfh.210.2021.12.03.02.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 02:51:11 -0800 (PST)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        otis.wu@genesyslogic.com.tw, benchuanggli@gmail.com,
        Jason Lai <jasonlai.genesyslogic@gmail.com>
Subject: [PATCH 1/7] mmc: core: Cleanup printing of speed mode at card insertion
Date:   Fri,  3 Dec 2021 18:50:57 +0800
Message-Id: <20211203105103.11306-2-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211203105103.11306-1-jasonlai.genesyslogic@gmail.com>
References: <20211203105103.11306-1-jasonlai.genesyslogic@gmail.com>
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

