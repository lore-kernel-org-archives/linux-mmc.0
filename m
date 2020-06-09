Return-Path: <SRS0=tDFP=7W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11358C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 08:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE01B207C3
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 08:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7HhynxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgFIIOt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgFIIOs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jun 2020 04:14:48 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FD1C05BD43
        for <linux-mmc@vger.kernel.org>; Tue,  9 Jun 2020 01:14:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id m2so1078460pjv.2
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2020 01:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=R2kBl3nTlS5O50qMXNJWOqTOo38lckUcQ6JLoF/73jY=;
        b=m7HhynxD3Z3Qhid9cr2AYRTd2D//6xQ6ctOLfJGHnycWbsv6LWUce+LhIvAVCX93lZ
         VJ+QPyaAytD5BqfUL+iIFScZD9gPBmtSs7FNcjb2dGRmooxCgumDr3yvrJNexEvcS4Wu
         DVEHEGj+v7wyeCWEP0G/jSlHr6dwi21x66rpRmA4ehklI0J0TQV3KIS1oXwekpYMwH1a
         j2SZ0iBCC+nRDoObJPz+jOQ5OkcxCpWI4RlnyYjNduqqNNyfth0TltThDOJwo51+IBuj
         PZuuqtMAwLpvaIuXSs9mud+oB+zp+CULsN/0W0AOl6F+O+wRyDKhEgadGin8iCAgv3oe
         rTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R2kBl3nTlS5O50qMXNJWOqTOo38lckUcQ6JLoF/73jY=;
        b=AbaIXKnjHdimLahVYxNxuQLsS8OH5YpFjQPXqorQdkvJIfck0TqZHt+zE5DGWCnw3P
         jlBazCDpD08eqDE0ph59Hlp3k/+d0PZ+rxAKpKARcD9aOpHDKoVhqKlUl7h1O4x6hCiY
         AUMC+uxAuJp7q/AER4zm4ZAwvabCacar/3Hma/s9WFX61Tbb167LFgAOmGLKDAa8WdmR
         ahFZRwdz/Fpm5ezgjys7k0RveZi6GmQrkyBp/De+mR1SaL4vi/1pzaV45yLmjbfYiCwU
         xEUZ5+ruJ8opT7gZdK9CRQnf0p0YDoLJqZwh+Fdaj1i6wxhUZBUEg5z2BcyAcr6KynAy
         C9IQ==
X-Gm-Message-State: AOAM532ycl5WpXCDCHTOJLEJ/pX942xkff1B3QI160R/J0UwUXiCmh6S
        3UDtky8xqPYpTpbWuRhdmaWsNy1F
X-Google-Smtp-Source: ABdhPJyPUjTr+S5GYf9GiDhBjtbUC4fC1P6V2d+Q+An9ms/Czyzai285ItRqrnM9aOENqVOo0ZbDQQ==
X-Received: by 2002:a17:90a:8a18:: with SMTP id w24mr3275489pjn.222.1591690487718;
        Tue, 09 Jun 2020 01:14:47 -0700 (PDT)
Received: from huyue2.ccdomain.com ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id s11sm8941196pfh.204.2020.06.09.01.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 01:14:46 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     ulf.hansson@linaro.org, dianders@chromium.org, mka@chromium.org
Cc:     linux-mmc@vger.kernel.org, huyue2@yulong.com, zhangwen@yulong.com
Subject: [PATCH] mmc: sdio: Fix 1-bit mode for SD-combo cards during suspend
Date:   Tue,  9 Jun 2020 16:14:31 +0800
Message-Id: <20200609081431.6376-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Commit 6b5eda369ac3 ("sdio: put active devices into 1-bit mode during
suspend") disabled 4-bit mode during system suspend. After this patch,
commit 7310ece86ad7 ("mmc: implement SD-combo (IO+mem) support") used
new sdio_enable_4bit_bus() instead of sdio_enable_wide() to support
SD-combo cards, also for card resume. However, no corresponding support
added during suspend. That is not correct. Let's fix it.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/mmc/core/sdio.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index ebb387a..2d2ae35 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -285,6 +285,27 @@ static int sdio_disable_wide(struct mmc_card *card)
 	return 0;
 }
 
+static int sdio_disable_4bit_bus(struct mmc_card *card)
+{
+	int err;
+
+	if (card->type == MMC_TYPE_SDIO)
+		goto out;
+
+	if (!(card->host->caps & MMC_CAP_4_BIT_DATA))
+		return 0;
+
+	if (!(card->scr.bus_widths & SD_SCR_BUS_WIDTH_4))
+		return 0;
+
+	err = mmc_app_set_bus_width(card, MMC_BUS_WIDTH_1);
+	if (err)
+		return err;
+
+out:
+	return sdio_disable_wide(card);
+}
+
 
 static int sdio_enable_4bit_bus(struct mmc_card *card)
 {
@@ -960,7 +981,7 @@ static int mmc_sdio_suspend(struct mmc_host *host)
 	mmc_claim_host(host);
 
 	if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host))
-		sdio_disable_wide(host->card);
+		sdio_disable_4bit_bus(host->card);
 
 	if (!mmc_card_keep_power(host)) {
 		mmc_power_off(host);
-- 
1.9.1

