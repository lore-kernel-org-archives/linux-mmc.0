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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3DAC432BE
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Aug 2021 11:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62DD660F6B
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Aug 2021 11:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbhHaLC4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 Aug 2021 07:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhHaLCz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Aug 2021 07:02:55 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AE0C061575
        for <linux-mmc@vger.kernel.org>; Tue, 31 Aug 2021 04:02:00 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id w7so15127324pgk.13
        for <linux-mmc@vger.kernel.org>; Tue, 31 Aug 2021 04:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J7ZX5cWq/OCrI2PmtgCFKZxObJ0fq4sVzKxoaxZ4qkM=;
        b=fm+zE4KE1BdrQqK4f7m5nRZ6LSOroWDywcddzD650TFEJr0mA1x4lZsD2R7vfkbK/J
         LQVQyKixt8ZWBbyWuHeJ9knnSDam3kiubwDPWYozIG8+MLJJ2LVEwGpQ70jUHzxoMcIe
         d4Q/pYIRg30OBdTxZjzIhx2L7kggkjEgq67DdZotj48bJB+P6VfeVFWES49RkKd1Bbkp
         OZp4Ov6H3mEQ14ogrcwHjtTyy0hjP7YywSJr2/rN83WI9ORbKufbA6cKXEsLb/MYWwd1
         adz587T5tQwuqHKwnapePuLM8x322i0IYPtWmy0n2qJ/WG6shR7xuf9bSXp8LBBz7HEn
         zoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J7ZX5cWq/OCrI2PmtgCFKZxObJ0fq4sVzKxoaxZ4qkM=;
        b=qJahVxy/aOUr48dytLSsO2KusNWbGa3boxXHBNE3HENZtu1WyXiI5nYCo3HkkyIKXw
         +vzXZFMbpmRcV+gsknsb8Phbtg1V04VajRPmnMQ3OE2qA8ncQyKDqnYaWa5ISsFXPJgR
         +DeOrWlMgILVh7beSWmLOJQWxs2P5YjHls2NqBG0vdsVXW9U5kEA6EJwYa7hHNm1t3iV
         wQEtGAjoH2aPIHGst8v9LR7MiT+e2v9yG/CMFZoGdUuqueErDVgUHd9ntO6fK1jS/Rce
         rTMY8fvRSqhHMlNOZMM9I2X2D2AVd/xVwweWdsBv2B49sNNY1BdQDIkWEvJEBOvd9drc
         GL/Q==
X-Gm-Message-State: AOAM533Td31Hza6Fj0R0SnBBQeMYIZWU7/u4tyuTPzYUf2CaLeVsKea5
        HIxrOoFq+DWwWGRvNnbH0ubrqHc1Qp/Lhw==
X-Google-Smtp-Source: ABdhPJwvDklBXdh3+8G67E5fLrSsRN1qdtFEG1eM0+ZZNaYgLRyEr3YMTmJ2be3oAcdo4MSpquBL8A==
X-Received: by 2002:a63:f94c:: with SMTP id q12mr25892581pgk.171.1630407719853;
        Tue, 31 Aug 2021 04:01:59 -0700 (PDT)
Received: from localhost.localdomain (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id i20sm5952653pfa.185.2021.08.31.04.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 04:01:59 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     Jason Lai <jason.lai@genesyslogic.com.tw>,
        linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
Subject: [PATCH 3/7] mmc: core: Announce successful insertion of an SD
Date:   Tue, 31 Aug 2021 19:01:55 +0800
Message-Id: <20210831110155.50616-1-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Jason Lai <jason.lai@genesyslogic.com.tw>

From: Ulf Hansson <ulf.hansson@linaro.org>

To inform the users about SD UHS-II cards, let's extend the print at card
insertion with a "UHS-II" substring. Within this change, it seems
reasonable to convert from using "ultra high speed" into "UHS-I speed", for
the UHS-I type, as it should makes it more clear.

Note that, the new print for UHS-II cards doesn't include the actual
selected speed mode. Instead, this is going to be added from subsequent
change.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/bus.c  | 4 +++-
 drivers/mmc/core/host.h | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 27ba3c749..8fd46b5f5 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -353,7 +353,9 @@ int mmc_add_card(struct mmc_card *card)
 	if (mmc_card_hs(card))
 		speed_mode = "high speed ";
 	else if (mmc_card_uhs(card))
-		speed_mode = "ultra high speed ";
+		speed_mode = "UHS-I speed ";
+	else if (mmc_card_uhs2(card))
+		speed_mode = "UHS-II speed ";
 	else if	(mmc_card_ddr52(card))
 		speed_mode = "high speed DDR ";
 	else if (mmc_card_hs200(card))
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index ba407617e..c243d3096 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -83,5 +83,9 @@ static inline bool mmc_card_sd_express(struct mmc_host *host)
 		host->ios.timing == MMC_TIMING_SD_EXP_1_2V;
 }
 
+static inline bool mmc_card_uhs2(struct mmc_card *card)
+{
+	return card->host->ios.timing == MMC_TIMING_SD_UHS2;
+}
 #endif
 
-- 
2.32.0

