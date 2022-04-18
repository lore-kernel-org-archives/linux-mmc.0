Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC80C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Apr 2022 11:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiDRMBZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Apr 2022 08:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbiDRMBY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Apr 2022 08:01:24 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F258A1A3B5
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2022 04:58:45 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id j71so4969953pge.11
        for <linux-mmc@vger.kernel.org>; Mon, 18 Apr 2022 04:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k7kdy4w8KSfP2nJZjSwGWO5WOxOe85XxlLiYSqkUsQ4=;
        b=pgMX9DNqOtvkeens2zAOW/1JJSLcd21c4PNZIxVMynsdTVhV7lDySEIPKOjdpd8K6L
         an4hNT0FgnYv7AovBnG2bOcAUBR9fyenIFBLBs/SkJ6LlC+a5Kh8B/3Pd52fDRnlCBO4
         uFilrQ7/UKjF0GTniFLqsFlp169zc5nNEM5pgPSyUeY16TfN4odTNSQ7wGL6OsWgdTTu
         gDPHyXVPAqwdkMAwWTiUHO8sU8eSlkUFfPvYcbpzwtbYZyMD2vFl8tynF+mpcNtBHF54
         JTL09EWUGalIF7vVC1aGVBE9wpHW6uiEIscF+lUG9v6e2wlxviHNnYNbW5hP03AQXBJn
         Zutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k7kdy4w8KSfP2nJZjSwGWO5WOxOe85XxlLiYSqkUsQ4=;
        b=k4PJl/m2k60hiCgE/t5mH3YrKiAInEAziyXJ+4tJruE72QNvGbTtaPmmV6e1vaOnd8
         XmpMdkSytRUewJ3bHzzLo/mcQYdGhbIuDPHeODTmSsq2fR0RCnN6+DvycuizzwCwHlrS
         puovqzPl9elFTM4hVFtwLEjjCMe+5UOBoPBqZ4GvOHqiEmcvAtXIpURmaqqf2ByKsYJ/
         wQIFHbFeE6PTfQK4CiEkwzOg19WrDwf0pEsIUtViYzt001RW4PtOcAeXghtmxNv3HG3f
         rHFw3Ki4a6LlUKiqc/N4Iaw5Sp6d5XAmFf6S32e5BzIzeMfmXuuR1yGUVOAiIS67hkry
         +2ww==
X-Gm-Message-State: AOAM533LjtCnRM35ysqMPjzkm9wkiHyA275Psl5ZQUDv5LivZDIJzKWE
        ZnjyHfW0HgWPbV5MGavLhEQ=
X-Google-Smtp-Source: ABdhPJyLzzmytRV/GdMmk/H7RLCKdYclCzqDs+R5yEiWV9H84nCc4HChvsUW1IjN3SB08HbRRXWg0g==
X-Received: by 2002:a62:e518:0:b0:4fa:9333:ddbd with SMTP id n24-20020a62e518000000b004fa9333ddbdmr11955615pff.11.1650283125232;
        Mon, 18 Apr 2022 04:58:45 -0700 (PDT)
Received: from jason-z170xgaming7.genesyslogic.com.tw ([122.146.30.3])
        by smtp.gmail.com with ESMTPSA id u206-20020a6279d7000000b00505fdc42bf9sm12409749pfc.101.2022.04.18.04.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 04:58:45 -0700 (PDT)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, dlunev@chromium.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        Tim.Hsieh@genesyslogic.com.tw
Subject: [PATCH V4 3/6] mmc: core: Announce successful insertion of an SD UHS-II card
Date:   Mon, 18 Apr 2022 19:58:30 +0800
Message-Id: <20220418115833.10738-4-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220418115833.10738-1-jasonlai.genesyslogic@gmail.com>
References: <20220418115833.10738-1-jasonlai.genesyslogic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Updates in V4:
 - Make mmc_card_uhs2() take struct mmc_host* as in-param.

Update in previous version:
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
index eefe74bf1356..dd136ebb2a68 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -341,7 +341,9 @@ int mmc_add_card(struct mmc_card *card)
 	if (mmc_card_hs(card))
 		speed_mode = "high speed ";
 	else if (mmc_card_uhs(card))
-		speed_mode = "ultra high speed ";
+		speed_mode = "UHS-I speed ";
+	else if (mmc_card_uhs2(card->host))
+		speed_mode = "UHS-II speed ";
 	else if	(mmc_card_ddr52(card))
 		speed_mode = "high speed DDR ";
 	else if (mmc_card_hs200(card))
diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
index 48c4952512a5..ba6a80e9b360 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -89,5 +89,9 @@ static inline bool mmc_card_sd_express(struct mmc_host *host)
 		host->ios.timing == MMC_TIMING_SD_EXP_1_2V;
 }
 
+static inline bool mmc_card_uhs2(struct mmc_host *host)
+{
+	return host->ios.timing == MMC_TIMING_SD_UHS2;
+}
 #endif
 
-- 
2.35.1

