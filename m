Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D63C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Feb 2022 03:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbiBVDkc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 21 Feb 2022 22:40:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiBVDkc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2022 22:40:32 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30813240B8
        for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2022 19:40:08 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ck4-20020a17090afe0400b001bc64ee7d3cso1183870pjb.4
        for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2022 19:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xyYy0qN9Go4w6lNy+4hV42fbw4ce7eNrtB+9mtkTWo=;
        b=JQvJe6lTVYppAtNeHOwzX+rvDoBJXp//zDt11/DcRjxfeC54r4+nHogkdQ79MrynMT
         yf8T+6mxbe6RdrvMVAyuuFXmPjSfBth3Or+YMy+0XbEjlyGsCyk9ulpTqLEmfgtgJgxv
         K9pHVXdFXWWjnor2+i2gxHZr0OgVTISkOGzqqmFNUDDB5czp0RwjfNnAu3Bd6MYywlsc
         Fa8FfuCFN6fBLaQ8gzm0Of8QKNbNw1fSS1gyOoHokCZVZW1UZkL/g0cVsqKdk/JlKJ2k
         SVcF0oRfB0I22eMwrjy3Ya3C2BzQ8p9+OEdlELr0IVhjYe1ru7GkDCJawouSApqP3fYU
         e1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0xyYy0qN9Go4w6lNy+4hV42fbw4ce7eNrtB+9mtkTWo=;
        b=LDEJeXwsaufK7z9vCXnykRDAzn8GM0Usmdy0ks9RPg7kv2wQQgC1JfvwcdO+29UH7n
         KHdMer2aUwi3Uc1+fqMYVVRbLxQOkp3nXBU13lLyBG+0vQLw/BOjumHIzA6o0MNYBIXr
         SZdgpWn1zFtZpbhItZOLUZXggxVFlZ0OHyOCrx9Xu0BmQWqg1CK65V6bYSmBoIr16kvC
         822H86MiPkqaP3fKwKXmC0ZIHZ19LuikmN0KG4GWsXeQdpuLIZOLQfAOTKw50y26rsdu
         xrxekj5sFrsQSBb4r4w0qxvNE/rU9fLSa9VD8thLTRVMeISEUvCBc7IdK3CDlqN5B4SS
         wb2w==
X-Gm-Message-State: AOAM531rsac/N6b8TlOEEQYxlaf/nHh8reIGzBa6XT00nclEuFlBfVnj
        MLPnqKv0sZrZ7KT0F0QjgxY=
X-Google-Smtp-Source: ABdhPJzumBFTOxY0GDEVriWKqPWyYCxcDz0lhxkM0CcRSl2iHDMGpVBOGjgkArYkbTeD4vwC1asUSg==
X-Received: by 2002:a17:90a:aa0a:b0:1b4:e1e3:9651 with SMTP id k10-20020a17090aaa0a00b001b4e1e39651mr2030918pjq.235.1645501207759;
        Mon, 21 Feb 2022 19:40:07 -0800 (PST)
Received: from localhost.localdomain (220-128-190-163.hinet-ip.hinet.net. [220.128.190.163])
        by smtp.gmail.com with ESMTPSA id ng16sm703542pjb.12.2022.02.21.19.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 19:40:07 -0800 (PST)
From:   Jason Lai <jasonlai.genesyslogic@gmail.com>
To:     ulf.hansson@linaro.org, takahiro.akashi@linaro.org,
        adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, dlunev@chromium.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, otis.wu@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com
Subject: [PATCH V3 3/7] mmc: core: Announce successful insertion of an SD UHS-II card
Date:   Tue, 22 Feb 2022 11:39:27 +0800
Message-Id: <20220222033931.237638-4-jasonlai.genesyslogic@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
References: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
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
index eefe74bf1356..cceedc7a7213 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -341,7 +341,9 @@ int mmc_add_card(struct mmc_card *card)
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
index 48c4952512a5..2c2ad9d63c0b 100644
--- a/drivers/mmc/core/host.h
+++ b/drivers/mmc/core/host.h
@@ -89,5 +89,9 @@ static inline bool mmc_card_sd_express(struct mmc_host *host)
 		host->ios.timing == MMC_TIMING_SD_EXP_1_2V;
 }
 
+static inline bool mmc_card_uhs2(struct mmc_card *card)
+{
+	return card->host->ios.timing == MMC_TIMING_SD_UHS2;
+}
 #endif
 
-- 
2.35.1

