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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1341CC4338F
	for <linux-mmc@archiver.kernel.org>; Sun,  1 Aug 2021 11:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C4461040
	for <linux-mmc@archiver.kernel.org>; Sun,  1 Aug 2021 11:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhHALqh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 1 Aug 2021 07:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhHALqh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 1 Aug 2021 07:46:37 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6A8C06175F;
        Sun,  1 Aug 2021 04:46:29 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id z3so15130999plg.8;
        Sun, 01 Aug 2021 04:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xuasN2nPmOUeEGVnE4hDkJbU9sMt+zlOyYRMH9VVQ9M=;
        b=uCnxAHyo6xWVruF772lNLh3pkfyraHyfWYIWJ1xrbQIqbq1FkuCS7BWORfLQWdrcEk
         x8FSWNFRzzgFfPtddpwsX0hR2YwbLJoePCUgktwpUaG9TM5EWFB3JQI+DZSqV4rTFC7g
         XOB3acBmrTFusOLND7hqY4bmO5avmVnOqBj5mwzjRy9KoEWxA6zVEsBH1uRebTU7lZu9
         Fn4A1EkUNXfaL+gPzwZWpRE2AS54dg94EIdilnpTJEHaqQFWyiXuc74I0hIpBh4frXNC
         nT2W+y4jGrVlNhuaVe3/OG0Nz3HXVCWlQr9/iwd8SofgAaYY5HmWV+OsYezUAvfCQIAJ
         cjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xuasN2nPmOUeEGVnE4hDkJbU9sMt+zlOyYRMH9VVQ9M=;
        b=RplyRFg2sQrZlRt65MtiyxFvQW1YhYjuik4mP8yYQgD3KrbOxAbhayZj5qT8RYkkV+
         ItWEW45r7+NpHH7DvZS1pwWaOHuM6/Yisg+Z1lSYdVhaMap94LD+W6rDVfszIo+R99CN
         2fUjymRLj3ROG6+8yU6JA7ODHH3QKoY1zhpScWCKpEPxyRVunfKZuOAHZu9UHvDCt5oZ
         Uva3U4XzCQ6TXU9h6bp5gx7qnkv4IhcwcQvGyx8QNLPgIuevdscpGSjDlb7IvI2aNvh5
         PQbgJRwhbIlvBTBVw/fcSkKGPtd8hmWBAbzJRtiVrR/VF50s3jC+h3/Q9UxCHkKDaKBQ
         DEAw==
X-Gm-Message-State: AOAM531WJqcY8eBNkvRPijx0TvjWkj7vTiv39jqliccwlhnCSQbJpqyE
        0wA7KzsqmAg36Q2eH3zUNGDEkN7x3vyT+w==
X-Google-Smtp-Source: ABdhPJxjFvXAZHqStljrXRzsijyuHNFgBKDcZojlXpv7c/Rez7YvBrAPxRiO93hx2hWv0pTTnnU3ew==
X-Received: by 2002:a65:6108:: with SMTP id z8mr1354883pgu.179.1627818389051;
        Sun, 01 Aug 2021 04:46:29 -0700 (PDT)
Received: from glados.. ([2601:647:6480:2358:feaa:14ff:fe71:bf70])
        by smtp.gmail.com with ESMTPSA id b8sm856736pjo.51.2021.08.01.04.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 04:46:28 -0700 (PDT)
From:   Thomas Hebb <tommyhebb@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Hebb <tommyhebb@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ricky Wu <ricky_wu@realtek.com>,
        Rui Feng <rui_feng@realsil.com.cn>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: rtsx: fix long reads when clock is prescaled
Date:   Sun,  1 Aug 2021 04:46:14 -0700
Message-Id: <2fef280d8409ab0100c26c6ac7050227defd098d.1627818365.git.tommyhebb@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For unexplained reasons, the prescaler register for this device needs to
be cleared (set to 1) while performing a data read or else the command
will hang. This does not appear to affect the real clock rate sent out
on the bus, so I assume it's purely to work around a hardware bug.

During normal operation, the prescaler is already set to 1, so nothing
needs to be done. However, in "initial mode" (which is used for sub-MHz
clock speeds, like the core sets while enumerating cards), it's set to
128 and so we need to reset it during data reads. We currently fail to
do this for long reads.

This has no functional affect on the driver's operation currently
written, as the MMC core always sets a clock above 1MHz before
attempting any long reads. However, the core could conceivably set any
clock speed at any time and the driver should still work, so I think
this fix is worthwhile.

I personally encountered this issue while performing data recovery on an
external chip. My connections had poor signal integrity, so I modified
the core code to reduce the clock speed. Without this change, I saw the
card enumerate but was unable to actually read any data.

Writes don't seem to work in the situation described above even with
this change (and even if the workaround is extended to encompass data
write commands). I was not able to find a way to get them working.

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>

---

 drivers/mmc/host/rtsx_pci_sdmmc.c | 36 ++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 4ca937415734..58cfaffa3c2d 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -542,9 +542,22 @@ static int sd_write_long_data(struct realtek_pci_sdmmc *host,
 	return 0;
 }
 
+static inline void sd_enable_initial_mode(struct realtek_pci_sdmmc *host)
+{
+	rtsx_pci_write_register(host->pcr, SD_CFG1,
+			SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_128);
+}
+
+static inline void sd_disable_initial_mode(struct realtek_pci_sdmmc *host)
+{
+	rtsx_pci_write_register(host->pcr, SD_CFG1,
+			SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_0);
+}
+
 static int sd_rw_multi(struct realtek_pci_sdmmc *host, struct mmc_request *mrq)
 {
 	struct mmc_data *data = mrq->data;
+	int err;
 
 	if (host->sg_count < 0) {
 		data->error = host->sg_count;
@@ -553,22 +566,19 @@ static int sd_rw_multi(struct realtek_pci_sdmmc *host, struct mmc_request *mrq)
 		return data->error;
 	}
 
-	if (data->flags & MMC_DATA_READ)
-		return sd_read_long_data(host, mrq);
+	if (data->flags & MMC_DATA_READ) {
+		if (host->initial_mode)
+			sd_disable_initial_mode(host);
 
-	return sd_write_long_data(host, mrq);
-}
+		err = sd_read_long_data(host, mrq);
 
-static inline void sd_enable_initial_mode(struct realtek_pci_sdmmc *host)
-{
-	rtsx_pci_write_register(host->pcr, SD_CFG1,
-			SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_128);
-}
+		if (host->initial_mode)
+			sd_enable_initial_mode(host);
 
-static inline void sd_disable_initial_mode(struct realtek_pci_sdmmc *host)
-{
-	rtsx_pci_write_register(host->pcr, SD_CFG1,
-			SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_0);
+		return err;
+	}
+
+	return sd_write_long_data(host, mrq);
 }
 
 static void sd_normal_rw(struct realtek_pci_sdmmc *host,
-- 
2.32.0

