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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1ACC432BE
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Aug 2021 11:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4397F60FE8
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Aug 2021 11:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbhHaLC0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 Aug 2021 07:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhHaLCV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Aug 2021 07:02:21 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1764C061575
        for <linux-mmc@vger.kernel.org>; Tue, 31 Aug 2021 04:01:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d5so5741155pjx.2
        for <linux-mmc@vger.kernel.org>; Tue, 31 Aug 2021 04:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Y7ivpWUU7sN0mLtTRtSTnTmujt6c6Iud30UaDT46dk=;
        b=S2VWvqRO+VQY/YW7qA8NJG9JZLKCmHQ0inBWSPMIOsv5ZTAGWTB/FiFYOD5c7AAYMN
         VeOjpq/Z5NoEXvgfmsMe7zufNfst0xVQJ3DvyPoY8liOZ8UP9TFmFIMYHiTfLXO5+xvF
         BUKvQPTwLy8h0J8CsBZrZaQrS2WwiFWWBe2mTKDxftUq0IfqcqjnTmIYgBwtKry62iel
         E0OvUY6re9fX1fY4nwF8pS7Rga5strWCeIXU0WfP5fxOxpKNTtDK1gOj/EMi2ixGH9jw
         stkr5vUY4NEUOs7+asK/Fob4CgZ1Ngw8at98u8jFKbxxfZk4pfYFpJdb6Tq+iUaOkqWQ
         Ckkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Y7ivpWUU7sN0mLtTRtSTnTmujt6c6Iud30UaDT46dk=;
        b=nHxu0Ng1wbpmTaZUxOscC6163L9XEy8F6prQjnS2qI0QZ9drL/MrfPJmrcc+3etf4W
         vfw+jMCUCsLGDjmd18UWm8ER/0VTQrMp5+8XutdgpfGrdsgtYmGTRTe21Ryo1tjrcuTr
         ZfNC+PSia9VDp69baykwu7sV5ukgLDIWDizYZ1YnvhJ9AaUbrp8nsrlTfkJemo7q4UTP
         qY5rnaUrmnQkHnHvrq/p2JrThj3nIeeIlthzhVYWo5Qbxn73PcvcFN6OioXTcD1KZQda
         +3vm/YlwKFx56YZIKBY4c8pCtbaQgmvXg3zzA6rJp3KRpoTOWwapiCn5JteSvFMv2syz
         fX1Q==
X-Gm-Message-State: AOAM530IO4zrRUaGYpwH9Eak1Z8bOu4ujZ1YLvn8dbKWRw23kMzCAHn9
        r9iDXDHqt70+MoG0VoJghmKrOtAxVlujOw==
X-Google-Smtp-Source: ABdhPJz1gd9BKCYyFgkNZoiLlemqpKWrPJj6O2ghra4KnIFcNJFuYdWayYqil3u04mFjbhVj3tgylg==
X-Received: by 2002:a17:902:bf46:b029:12c:75f6:f643 with SMTP id u6-20020a170902bf46b029012c75f6f643mr4245466pls.6.1630407685561;
        Tue, 31 Aug 2021 04:01:25 -0700 (PDT)
Received: from localhost.localdomain (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id 6sm2760210pjz.8.2021.08.31.04.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 04:01:25 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     Jason Lai <jason.lai@genesyslogic.com.tw>,
        linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
Subject: [PATCH 1/7] mmc: core: Cleanup printing of speed mode at card
Date:   Tue, 31 Aug 2021 19:01:20 +0800
Message-Id: <20210831110120.50508-1-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jason Lai <jason.lai@genesyslogic.com.tw>

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
2.32.0

