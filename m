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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EE1C433DF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 10:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 863672076C
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Jun 2020 10:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9x9UET9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgFHKaX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Jun 2020 06:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbgFHKaX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jun 2020 06:30:23 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126DAC08C5C3
        for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2020 03:30:23 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o8so8549282pgm.7
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2020 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EC/WA6P32Eef6z5fj8HzvaUSiBLzq2KKkc64KbpK0uk=;
        b=q9x9UET9lnOw8s9O1VjwQnTZj6oWTE7E1twMOOc8RuklSBFGyDnrt0RET2puJNVoJQ
         5g+qTOHqNZRs59TSCap2lwj0PWSYaj2fCS37U8iUY8+sqFgVEm377q4LoYWwRXHj4kWp
         GfyfqzY9mqVjgmMI1YJEeJkHZeTdQS3bXGwAyf88wzWOfBP+gxF7uKXTdXyJmASu84ZT
         cOFQrtEnOgWMK/7pXhGA1fiUl+Fjp7G4Ir+x2IRzdglBs0iAkhCaAWtD7Gm60eFaBxcs
         mSALJQkM8CFC/ZSDrKrOb5nXXVN8MRTdmB4+NMfGD/4bAoQPvZQvHMwauJqxI+73nwsq
         SQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EC/WA6P32Eef6z5fj8HzvaUSiBLzq2KKkc64KbpK0uk=;
        b=bH2F7hIsQ8RtBmm6x2mN45THGX3x5WgQ1uTX5B/ssAZJoDeW62fLg+rxP+135sXYXJ
         +R9zOZ73PzPgZgcZIE6koJWw2X68rz1btc602v8h2UArk7syihWC3cnWU5witvLr5C8T
         gQvAkgd0LSTKtZYF/CXoPakFXXrlrZtzsYxE+60+8dRzk6+1hUWsHoAa5nD7M/pewnji
         IUXEtLdZqAUZqt7xCJ8f252Aay3YVltaW0swMbMh8o4033fV13kfJspkZkAuNSmkCg0g
         XqXaMpJhqpyLtwMfVb6td8idpbiPqS8oOx28VS2fOIuImfpmHxAglwOUBI/OJBLq5WgV
         w2Vw==
X-Gm-Message-State: AOAM533aQvdYDMYo5j6myofPvC9Gv2OCgM7l8ucBT7hJ64TXOu2uH1KF
        UYIrCgmf+/pT5qPh5wV36kw=
X-Google-Smtp-Source: ABdhPJydDjs2e42uf/hnIaAquUuzsIlgzdl9AoZZy9McSciE0NDXHhdHnBWvnuxjfc/hbpJ2P7rWuA==
X-Received: by 2002:a63:c44b:: with SMTP id m11mr18818476pgg.404.1591612222533;
        Mon, 08 Jun 2020 03:30:22 -0700 (PDT)
Received: from huyue2.ccdomain.com ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id v8sm6640046pfn.217.2020.06.08.03.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 03:30:21 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     ulf.hansson@linaro.org, dianders@chromium.org, mka@chromium.org
Cc:     linux-mmc@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH v2] mmc: sdio: Enable SDIO 4-bit bus if not support SD_SCR_BUS_WIDTH_4 for SD combo card
Date:   Mon,  8 Jun 2020 18:30:09 +0800
Message-Id: <20200608103009.5000-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

If the card type is SD combo(MMC_TYPE_SD_COMBO) and the memory part does
not support wider bus(SD_SCR_BUS_WIDTH_4), nothing will be done except
return 0. However, we should check whether IO part support wider bus or
not. We should use available IO ability if supported.

In addition, there's a duplicated check to MMC_CAP_4_BIT_DATA since
sdio_enable_wide() will include that check. And we can also save one
call site to sdio_enable_wide() after this change.

Change-Id: Iaeb31fba4050ec9d248c415bef6696d38332afe6
Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v2: commit message changed.

 drivers/mmc/core/sdio.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 1e42c6b..59f197d 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -367,25 +367,23 @@ static int sdio_enable_4bit_bus(struct mmc_card *card)
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

