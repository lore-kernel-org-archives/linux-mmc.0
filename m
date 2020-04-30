Return-Path: <SRS0=CLt1=6O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B103CC8300B
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Apr 2020 09:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C68D2137B
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Apr 2020 09:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gy1jjxtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgD3JRF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgD3JRE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2020 05:17:04 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330C5C035495
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2020 02:17:03 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f18so5640698lja.13
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2020 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89RWgm3Up3ro7S0Yk5yseNEuoMg10aAHaWqeBrHIt/g=;
        b=Gy1jjxtW2kqnP8wl1z0ZePoqRxHvAmq/BvkprWs+HY3KgER1UNhmbkrUE7RD0LPgKY
         uQtnZBz1J2mSeu+eT0etLN/FfcwGvsrKL4Nrx5zOfWwpjtrdUrOmR5LvHJTno8WFY1k3
         x5OrsN21NVJFhFWc6Jc1u0idkK5MhkHDkviaR36/JUS11GwLtlMbbWzWdLn1mqqlHkxk
         qoKHmX++K4izXqqhMg9SiOPnBduBWKoAjdSwopuGIeT+I7EmZMA9t0pQAKvTM/7TrJkQ
         9akLeyXPv/jMDk5GbMhZIhuk1XGs8Ikdd5/BrlBTuB01ck/qt+eY5t8JYwesIAbi7Twf
         47fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89RWgm3Up3ro7S0Yk5yseNEuoMg10aAHaWqeBrHIt/g=;
        b=ec1X/RyFTRt3DKw7sLu3Nz88+0N5B9jOHvNSZmOe8ND99kx9ImzN9ItvolF0xJCmJ7
         AwI14k3yH4QuGaMjw2aer89p5fOMHfoP25U09I+YfSOPsHLes6H4DJmWQv1WCFVcwv6G
         Gj9TAk/XVQqPVrBJ4aRgLefNdQAf3EJy4PBZd5EPXwaHotPW/AlUvpL5x/4ux/GJVU4B
         Gk3hBMVSI2nt328XVB8eNp2I9OX7Lv+b+LYhY9ob07k7krirRAat8AlonE8Yjm1FTPs/
         KSo72iHVhi67bo91IJdN9WmEqKamps0FwwurSkLFhbX763Oqs1o0QeJkDsAMQ0c0DY1p
         8lRw==
X-Gm-Message-State: AGi0PuZl5e5JcwXMGFmlyV6NZqRjDGbco0LByA8FB313HvKbUn2mnKLK
        PjKgYBRHm66h9OgX4OP4K2Ye3ndI4VE=
X-Google-Smtp-Source: APiQypJmzs15jBI6elZWL1N97UEwVf7+JRqsPJCAid1U0Zizuu6vh6vZY2dgafQFqaaUTqSk+T5ZsA==
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr1644456ljp.52.1588238220685;
        Thu, 30 Apr 2020 02:17:00 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-181-7.NA.cust.bahnhof.se. [98.128.181.7])
        by smtp.gmail.com with ESMTPSA id x29sm4417818lfn.64.2020.04.30.02.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 02:17:00 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/4] mmc: sdio: Fix several potential memory leaks in mmc_sdio_init_card()
Date:   Thu, 30 Apr 2020 11:16:38 +0200
Message-Id: <20200430091640.455-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430091640.455-1-ulf.hansson@linaro.org>
References: <20200430091640.455-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Over the years, the code in mmc_sdio_init_card() has grown to become quite
messy. Unfortunate this has also lead to that several paths are leaking
memory in form of an allocated struct mmc_card, which includes additional
data, such as initialized struct device for example.

Unfortunate, it's a too complex task find each offending commit. Therefore,
this change fixes all memory leaks at once.

Cc: <stable@vger.kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio.c | 58 +++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index d35679e6e6aa..20eed28ea60d 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -584,7 +584,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	err = mmc_send_io_op_cond(host, ocr, &rocr);
 	if (err)
-		goto err;
+		return err;
 
 	/*
 	 * For SPI, enable CRC as appropriate.
@@ -592,17 +592,15 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	if (mmc_host_is_spi(host)) {
 		err = mmc_spi_set_crc(host, use_spi_crc);
 		if (err)
-			goto err;
+			return err;
 	}
 
 	/*
 	 * Allocate card structure.
 	 */
 	card = mmc_alloc_card(host, NULL);
-	if (IS_ERR(card)) {
-		err = PTR_ERR(card);
-		goto err;
-	}
+	if (IS_ERR(card))
+		return PTR_ERR(card);
 
 	if ((rocr & R4_MEMORY_PRESENT) &&
 	    mmc_sd_get_cid(host, ocr & rocr, card->raw_cid, NULL) == 0) {
@@ -610,19 +608,15 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 
 		if (oldcard && (oldcard->type != MMC_TYPE_SD_COMBO ||
 		    memcmp(card->raw_cid, oldcard->raw_cid, sizeof(card->raw_cid)) != 0)) {
-			mmc_remove_card(card);
-			pr_debug("%s: Perhaps the card was replaced\n",
-				mmc_hostname(host));
-			return -ENOENT;
+			err = -ENOENT;
+			goto mismatch;
 		}
 	} else {
 		card->type = MMC_TYPE_SDIO;
 
 		if (oldcard && oldcard->type != MMC_TYPE_SDIO) {
-			mmc_remove_card(card);
-			pr_debug("%s: Perhaps the card was replaced\n",
-				mmc_hostname(host));
-			return -ENOENT;
+			err = -ENOENT;
+			goto mismatch;
 		}
 	}
 
@@ -677,7 +671,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	if (!oldcard && card->type == MMC_TYPE_SD_COMBO) {
 		err = mmc_sd_get_csd(host, card);
 		if (err)
-			return err;
+			goto remove;
 
 		mmc_decode_cid(card);
 	}
@@ -704,7 +698,12 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 			mmc_set_timing(card->host, MMC_TIMING_SD_HS);
 		}
 
-		goto finish;
+		if (oldcard)
+			mmc_remove_card(card);
+		else
+			host->card = card;
+
+		return 0;
 	}
 
 	/*
@@ -730,16 +729,14 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 		goto remove;
 
 	if (oldcard) {
-		int same = (card->cis.vendor == oldcard->cis.vendor &&
-			    card->cis.device == oldcard->cis.device);
-		mmc_remove_card(card);
-		if (!same) {
-			pr_debug("%s: Perhaps the card was replaced\n",
-				mmc_hostname(host));
-			return -ENOENT;
+		if (card->cis.vendor == oldcard->cis.vendor &&
+		    card->cis.device == oldcard->cis.device) {
+			mmc_remove_card(card);
+			card = oldcard;
+		} else {
+			err = -ENOENT;
+			goto mismatch;
 		}
-
-		card = oldcard;
 	}
 	card->ocr = ocr_card;
 	mmc_fixup_device(card, sdio_fixup_methods);
@@ -800,16 +797,15 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 		err = -EINVAL;
 		goto remove;
 	}
-finish:
-	if (!oldcard)
-		host->card = card;
+
+	host->card = card;
 	return 0;
 
+mismatch:
+	pr_debug("%s: Perhaps the card was replaced\n", mmc_hostname(host));
 remove:
-	if (!oldcard)
+	if (oldcard != card)
 		mmc_remove_card(card);
-
-err:
 	return err;
 }
 
-- 
2.20.1

