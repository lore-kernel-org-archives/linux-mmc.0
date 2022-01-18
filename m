Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C796C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Jan 2022 12:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbiARMoN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiARMoN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jan 2022 07:44:13 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1386CC061574
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jan 2022 04:44:13 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id n8so11050379plc.3
        for <linux-mmc@vger.kernel.org>; Tue, 18 Jan 2022 04:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yeECnpT9/+cnlgxlvvdwnIS1z4qnyOQPaY8ypGeXpP4=;
        b=Cx7bd/7vt3fB0wHZ1EoB5Xa24Wg4d9sefP035Eaygqd9YvTecmuaXHhmYlsb9JRah6
         HJLfDhI6m6kL8d+KdElr7CKt5Ne7RcKJ0awA9injq5s4KVRJLqvCf7fbpke2fwucZPva
         R1qBK3T6b0QkxDbBwlj6AqscEigEqwU5MUxBDdIHLlNlargD22XrrPRFFNJitSlgvwAp
         rg6gWG4GO5zLMdVVeevt913T9TssYx9J5H2SjpJr65kVqUXnH3LhnVlPICqfaZg/iVKm
         lLIoALbm0HpI+2qPQqgSpWXVG+RFQyMzNM3TMti7cW8ZyaHnPNfv6wJu0n92Q8lxDzKL
         +yfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yeECnpT9/+cnlgxlvvdwnIS1z4qnyOQPaY8ypGeXpP4=;
        b=lJkiVrO4KYZfZNgLTwS7tSFT/cbgSs28F4ndfmgUbYoqJpV896/P4XsV1yrq6Ny6wf
         Y1NH93SRvT3r8CT9y0MtS7QCzZ/uSYt0UXqTfhcM+GlXwR4XhBVnjZI/rgboTOiNoJzX
         tm0xSKT/gOjAfs25LlIE1+XTApEYIPEm1O6vOhjB6PGLBaIDvbz9pJWGKI4Nn2CJkX6j
         wW9LVxmi9POVClqOSOXTsvwE7UV75YARm6na/I32+GJyBVoXFKTGkt/RiefS7rfY/R38
         5RK0iEO+UDEv7CdMGWsnDywLvbu56F3ybB9D9G/gLySMFicHj07e/bPHGOhMKHYmiO68
         zjVg==
X-Gm-Message-State: AOAM5314Vyf6MqwE+m/h/x+BmblT+Nml6MwA9zE4+TDlfqQDhv6l/z14
        uWx+Gw+irZwUD32q7J1XEAtG8px5yd2rcw==
X-Google-Smtp-Source: ABdhPJx4KV24+4JsEgiQvbJCBLMsgbjvziF6tgH6RROFJZ4kPBdR9dYzky7cCP2AdipN9S7Mcpt/PA==
X-Received: by 2002:a17:902:704a:b0:14a:b62b:f41b with SMTP id h10-20020a170902704a00b0014ab62bf41bmr10612949plt.93.1642509852633;
        Tue, 18 Jan 2022 04:44:12 -0800 (PST)
Received: from jason-z170xgaming7.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id n10sm362005pfj.120.2022.01.18.04.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 04:44:12 -0800 (PST)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        otis.wu@genesyslogic.com.tw,
        Jason Lai <jasonlai.genesyslogic@gmail.com>
Subject: [PATCH v2 3/7] mmc: core: Announce successful insertion of an SD UHS-II card
Date:   Tue, 18 Jan 2022 20:43:51 +0800
Message-Id: <20220118124355.167552-4-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220118124355.167552-1-jasonlai.genesyslogic@gmail.com>
References: <20220118124355.167552-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

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
2.34.0

