Return-Path: <SRS0=CLt1=6O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144CDC8300C
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Apr 2020 09:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D1D214D8
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Apr 2020 09:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Og8/7JTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgD3JRI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgD3JRI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2020 05:17:08 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C5DC035494
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2020 02:17:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e25so5692160ljg.5
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2020 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ff43pht+qFHl5p036giswtCScSev0q0blJQXIZAKC20=;
        b=Og8/7JTJYJemv2CsNUPSFYiakr+xBKDCkgdArRX5Xqf35BpVUW/YTXupVdJW7jepfl
         hemhXC/stNJ6O0+mecD9PPxCkdboCy2YVdazPoDE+VCy6Eu+mIRVWgL+4pPHUoU1gMLn
         /k/a5OJZBXk0ZSHQqEljU7pfPnb6JkEuoLY/uKj41xmUjQYu3pt3XbaMqUQTXv4qYQsQ
         MXYKcGgCOijeKWwGWzCXWy0n+phZinbiR1QSgqVQ0z3rXkP8dpg+qLmPJFuXCVha8ZSS
         0m+I2G0mrv7jsuOiP0zjy4g10oRfkMdM7Ei6yyMpXbglrPvczNFdn2+32+FCNIc1Dgdg
         9OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ff43pht+qFHl5p036giswtCScSev0q0blJQXIZAKC20=;
        b=VRnxIEJTmfGyhXVJAtNRkOGt6/mVvowuJXLLOQcaU8AEToEHKRllq6YHqwtU+nOGjC
         pXNtWv73sVpCjSXf/YYH6ioXxTkt9YImOkzF5Yzq36UOD+2zkGr9Yrtk5VZKeIY9//hB
         NQS8ulkiXqgrD1CK8zBIx6Wo2N4+Q4MnfzmEvyZSy6YC4s5CPmWm/8i+JdQM+8gdcyHk
         iCFpbPC/ScQJz0a0TE2uoCC2aeJYoUY401m/aRDH9nviBCCiNKDCOO2uZGczjA+YI+5p
         cAWCnhMmXsSeOOI+yW9HnFokfHsqhlZSMu4y9P0l1xsWnahI6khv62211Kf2ei3DsF1e
         +GkQ==
X-Gm-Message-State: AGi0PuYKZ4bgWW9i7zpvgOLVUowqbIn5vLs+3YKxLCcrqvg8JkU2Ozed
        aUx+Tamnc/geyxJzbs6nCQ/Hz58HDfs=
X-Google-Smtp-Source: APiQypI4IAdq5+e05nE8kgL8WQZa2DSx7F72JWKaL9wKVw6y33UQxZsjKluwOrxRzqWBKQ6Pn7r7Uw==
X-Received: by 2002:a2e:9791:: with SMTP id y17mr1631612lji.174.1588238225886;
        Thu, 30 Apr 2020 02:17:05 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id x29sm4417818lfn.64.2020.04.30.02.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 02:17:05 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 4/4] mmc: sdio: Align the initialization commands in retry path for UHS-I
Date:   Thu, 30 Apr 2020 11:16:40 +0200
Message-Id: <20200430091640.455-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430091640.455-1-ulf.hansson@linaro.org>
References: <20200430091640.455-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

According to the comment in mmc_sdio_reinit_card(), some SDIO cards may
require a "[CMD5,5,3,7] init sequence", which isn't always obeyed in
mmc_sdio_init_card(). Especially, when we end up retrying the UHS-I
specific initialization, there is a missing CMD5.

Let's update the code to make the behaviour consistent and let's also take
the opportunity to clean up the code a bit, to avoid open coding.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio.c | 53 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 853ac65f0485..435de47a6ee0 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -543,13 +543,33 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
 	return err;
 }
 
-static void mmc_sdio_resend_if_cond(struct mmc_host *host, u32 ocr,
-				    struct mmc_card *card)
+static int mmc_sdio_pre_init(struct mmc_host *host, u32 ocr,
+			     struct mmc_card *card)
 {
+	if (card)
+		mmc_remove_card(card);
+
+	/*
+	 * Reset the card by performing the same steps that are taken by
+	 * mmc_rescan_try_freq() and mmc_attach_sdio() during a "normal" probe.
+	 *
+	 * sdio_reset() is technically not needed. Having just powered up the
+	 * hardware, it should already be in reset state. However, some
+	 * platforms (such as SD8686 on OLPC) do not instantly cut power,
+	 * meaning that a reset is required when restoring power soon after
+	 * powering off. It is harmless in other cases.
+	 *
+	 * The CMD5 reset (mmc_send_io_op_cond()), according to the SDIO spec,
+	 * is not necessary for non-removable cards. However, it is required
+	 * for OLPC SD8686 (which expects a [CMD5,5,3,7] init sequence), and
+	 * harmless in other situations.
+	 *
+	 */
+
 	sdio_reset(host);
 	mmc_go_idle(host);
 	mmc_send_if_cond(host, ocr);
-	mmc_remove_card(card);
+	return mmc_send_io_op_cond(host, 0, NULL);
 }
 
 /*
@@ -640,7 +660,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	if (rocr & ocr & R4_18V_PRESENT) {
 		err = mmc_set_uhs_voltage(host, ocr_card);
 		if (err == -EAGAIN) {
-			mmc_sdio_resend_if_cond(host, ocr_card, card);
+			mmc_sdio_pre_init(host, ocr_card, card);
 			retries--;
 			goto try_again;
 		} else if (err) {
@@ -712,7 +732,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	err = sdio_read_cccr(card, ocr);
 	if (err) {
-		mmc_sdio_resend_if_cond(host, ocr_card, card);
+		mmc_sdio_pre_init(host, ocr_card, card);
 		if (ocr & R4_18V_PRESENT) {
 			/* Retry init sequence, but without R4_18V_PRESENT. */
 			retries = 0;
@@ -813,28 +833,7 @@ static int mmc_sdio_reinit_card(struct mmc_host *host)
 {
 	int ret;
 
-	/*
-	 * Reset the card by performing the same steps that are taken by
-	 * mmc_rescan_try_freq() and mmc_attach_sdio() during a "normal" probe.
-	 *
-	 * sdio_reset() is technically not needed. Having just powered up the
-	 * hardware, it should already be in reset state. However, some
-	 * platforms (such as SD8686 on OLPC) do not instantly cut power,
-	 * meaning that a reset is required when restoring power soon after
-	 * powering off. It is harmless in other cases.
-	 *
-	 * The CMD5 reset (mmc_send_io_op_cond()), according to the SDIO spec,
-	 * is not necessary for non-removable cards. However, it is required
-	 * for OLPC SD8686 (which expects a [CMD5,5,3,7] init sequence), and
-	 * harmless in other situations.
-	 *
-	 */
-
-	sdio_reset(host);
-	mmc_go_idle(host);
-	mmc_send_if_cond(host, host->card->ocr);
-
-	ret = mmc_send_io_op_cond(host, 0, NULL);
+	ret = mmc_sdio_pre_init(host, host->card->ocr, NULL);
 	if (ret)
 		return ret;
 
-- 
2.20.1

