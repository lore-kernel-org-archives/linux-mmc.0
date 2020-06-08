Return-Path: <SRS0=G9E5=7V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA55FC433DF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 08:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B605B20656
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 08:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4uThnaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgFHIGh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbgFHIGe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jun 2020 04:06:34 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C7CC08C5C3
        for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2020 01:06:34 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b7so4733593pju.0
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2020 01:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xdvIYaSYRN0iBQvKoB6lnmWB7QLF2DNRpHW6cM2KMb8=;
        b=o4uThnaauCkVIXf/5gOFqTM0HykIVQUOz3BmWfBQ+Dzahm5jG9Olr7H5YECRRPh1lQ
         V2UjGSBSx15/e7/drIgx/yXv0SxWlNI2uEpMQG77Pbz/Cw6dY0N6kMvP0T+in8kXE4Ke
         qw3ltjgOYCwg3ibkd/+ASvBIwu6CBtoUxD2sTAFK7dBAtRD9BO3vnC5rO5guSwBnqoEE
         ZyQqKMOAhsXG8W+J3sYDfMzYqACYFCOZMsU+jV510D9tXc0uMWh5bDziTic8MeTGcsjd
         fRQcwkbl14Aq8RHKY8ogMxSWJSOmwqFCBFItmxNEB+esFoQiKPAmqSX3efzx03XlqfGw
         PRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xdvIYaSYRN0iBQvKoB6lnmWB7QLF2DNRpHW6cM2KMb8=;
        b=BLj9VWNMH5gyeDblkKS+xEXFdtzpt6kp8w9i6MAaaYAyCKAxsJkB3w409INeyN/REt
         hGlYzOxZrZlMeSn/RUrUzv1qEXUfxtN8QQubgvrlR2Q0PNg4+GlRMvFyRL882MxrQDjq
         xQCMUvJLzaqgAufKeBBbrIDH42CKBT1OEcwY/dFbXnQkE6SNIyfQtFe6q5ETdZ6f2nN7
         6hSVdx58J2jqITecc45IvRZ9+3NnrWDCoeFjqzcMpwaGhFxib6wGXQUdazl34h0Zl178
         szu/FK8rfaR94tQ9rKjvEDXuEWMrYyBbIG7lher3t6LoyxZ97RnFyX48FoRdxu7W804v
         PTGQ==
X-Gm-Message-State: AOAM530ZsOcwlmEk94FElV+RV/s9zbxFsqQAyH9CyIH2iBwCk0LS1x+a
        Ln4tO6QBHXIcsa9uC//7v8Q=
X-Google-Smtp-Source: ABdhPJzUEmYTv10Y2SGhiGweRlxCajQdBupLRyX3S4HqvZvq2spJEatPZg5se1kLGcH7wWms9XfBrg==
X-Received: by 2002:a17:90b:3612:: with SMTP id ml18mr13726429pjb.153.1591603593715;
        Mon, 08 Jun 2020 01:06:33 -0700 (PDT)
Received: from huyue2.ccdomain.com ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id b4sm6418168pfg.75.2020.06.08.01.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 01:06:32 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     ulf.hansson@linaro.org, dianders@chromium.org, mka@chromium.org
Cc:     linux-mmc@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] mmc: sdio: Enable SDIO 4-bit bus if not support SD_SCR_BUS_WIDTH_4 for SD combo card
Date:   Mon,  8 Jun 2020 16:06:19 +0800
Message-Id: <20200608080619.9388-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

If the card type is SD combo and the memory part does not support wider
bus(SD_SCR_BUS_WIDTH_4), nothing will be done except return 0. However,
we should check whether SDIO part support wider bus or not just like
the behavior about enabling high speed mode in sdio_enable_hs().

In addition, there's a duplicated check to MMC_CAP_4_BIT_DATA since
sdio_enable_wide() will include that check. And we can also save one
call site to sdio_enable_wide() after this change.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/core/sdio.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index ebb387a..cacc863 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -290,25 +290,23 @@ static int sdio_enable_4bit_bus(struct mmc_card *card)
 {
 	int err;
 
+	err = sdio_enable_wide(card);
+	if (err <= 0)
+		return err;
 	if (card->type == MMC_TYPE_SDIO)
-		err = sdio_enable_wide(card);
-	else if ((card->host->caps & MMC_CAP_4_BIT_DATA) &&
-		 (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
+		goto out;
+
+	if (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4) {
 		err = mmc_app_set_bus_width(card, MMC_BUS_WIDTH_4);
-		if (err)
+		if (err) {
+			sdio_disable_wide(card);
 			return err;
-		err = sdio_enable_wide(card);
-		if (err <= 0)
-			mmc_app_set_bus_width(card, MMC_BUS_WIDTH_1);
-	} else
-		return 0;
-
-	if (err > 0) {
-		mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
-		err = 0;
+		}
 	}
+out:
+	mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
 
-	return err;
+	return 0;
 }
 
 
-- 
1.9.1

