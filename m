Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358F9C433EF
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Dec 2021 10:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351814AbhLCKyl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Dec 2021 05:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhLCKyj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Dec 2021 05:54:39 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D93C06173E
        for <linux-mmc@vger.kernel.org>; Fri,  3 Dec 2021 02:51:16 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id iq11so2042049pjb.3
        for <linux-mmc@vger.kernel.org>; Fri, 03 Dec 2021 02:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yeECnpT9/+cnlgxlvvdwnIS1z4qnyOQPaY8ypGeXpP4=;
        b=jwJN7MiPLTssIJO2FqRTIU+IZQITwJTssSasD0b72xH8s4FIs83rYtPrwtytwYDdgq
         6I5ftyCOPUnIuSg31pxm38oxq+xA0qEWbK5Mun5q01mLtAxSEY6/y0VH8Yp8OV1hW8Nc
         +gzzrNBXCdkIra0GhILrsb6dpL80cjUnMK+3UV6Y0bJD/dwjQxKLh/0vUCnmKWCKKBvn
         f9WcKVc6yDQIPKBMqw53eqHrDiJauTJSbidJXgN3jqJl6dRVLwf2mqhBL0NNEvCUG1CD
         iMktLBvCp12LRzca6bri7n78j/iVLV4AwUqS/76siGV2AxmHjGMFDqL7b6w5iCXuXJ0y
         9oNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yeECnpT9/+cnlgxlvvdwnIS1z4qnyOQPaY8ypGeXpP4=;
        b=jaamBz15VEXelLw9ff2hsZy1gmSzmXHw5cVSbRUK2O/9GhEL9w0D38q/cVsskNMNQ/
         HYjFqjmNLDv8KHBruIOXnJG2Qnz9OM8njcwn2+3/8CzpyhjJE6TaoiFRd7FblUeeiZoC
         xnwImieKGq69lTHKP7yACDRK90ARZhmNrOrrDcaEV81PaYeRdU0n1urtev6nacCxVzgE
         Fp5fbwrQ7I3jVoK9mjUUwJ9v4oqqvPGqbRTupEfPYmAQH4U5FF55J3VxmsqcCV38VnI/
         p1sCKrT19jdPgm4QyLTA/zhf2VHPnQL/hGP05v8DgRPlHi47tHgA+W9v4OwWL8NdJ3PA
         +1aQ==
X-Gm-Message-State: AOAM533f+N1mGjS63ux59W2Jk3TRiePWtLld+wLrfiDLl1TG2VYR/1+r
        QlPIN8bcfZvrH3HURDFS7a8=
X-Google-Smtp-Source: ABdhPJzavPBl8h75k49jqmNEvgObih5345n+LCSQshCf6LtEOGA9nEps7af8RfrvTq3B9H7QQv4Lzw==
X-Received: by 2002:a17:90b:4a83:: with SMTP id lp3mr13339713pjb.242.1638528675896;
        Fri, 03 Dec 2021 02:51:15 -0800 (PST)
Received: from jason-z170xgaming7.genesyslogic.com.tw (60-251-58-169.hinet-ip.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id x18sm2868699pfh.210.2021.12.03.02.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 02:51:15 -0800 (PST)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, jason.lai@genesyslogic.com.tw,
        otis.wu@genesyslogic.com.tw, benchuanggli@gmail.com,
        Jason Lai <jasonlai.genesyslogic@gmail.com>
Subject: [PATCH 3/7] mmc: core: Announce successful insertion of an SD UHS-II card
Date:   Fri,  3 Dec 2021 18:50:59 +0800
Message-Id: <20211203105103.11306-4-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211203105103.11306-1-jasonlai.genesyslogic@gmail.com>
References: <20211203105103.11306-1-jasonlai.genesyslogic@gmail.com>
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

