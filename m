Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9315C433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jan 2021 08:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729F8221FB
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jan 2021 08:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbhARIqe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jan 2021 03:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387625AbhARIq2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jan 2021 03:46:28 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E768C061575;
        Mon, 18 Jan 2021 00:45:48 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id w1so8747053pjc.0;
        Mon, 18 Jan 2021 00:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wL40GBtfiNYs/0GH+AFmz+V/sciBn4bLLFUI24iwtlQ=;
        b=XgeTkabXbnIVyIx6vN41vaWFx1SH3fUFm2rfZZeLheVoDEJx3LaSzEceSDs+8ZukFQ
         93Hntgx4LwS6hPmOMmVe+96LOAh1KMRJEndIzIO2fTNUFT7wARozY5kY3Wkw8e9ubO1l
         MDWbbzXuUJpTV+BllQaPHBi/OhwZS8YbF6ipRMGZ068fuNwDtgoj2ojJgNKyzdTzlUyO
         91tB0kvA3nD1llSv7U4TxMjrwcFW+uh6HAC7xm6cH5Oj2gJtK4EnomZWMG0c4bF3TD6N
         /WxPyUWSJva1uN+ym8yxWF6ykqXCxHw50es+pDBFBm57xjYoj/9tjj/8+p0Ld77LDv1w
         KeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wL40GBtfiNYs/0GH+AFmz+V/sciBn4bLLFUI24iwtlQ=;
        b=J1opBft0b9Idb2qeQR29PofOxRxBGL6zFSFQYsfNeCoJCwN+Cd2OJfkDsppHxtIGAo
         XF6HSbrrF9O6Jrngk1z05SvlfnLKxWJP1Iis8wFFbVpzTCjuptT85/theCUV8vLpPGQg
         dnBKNMpYwEAhUrHrM+g9wWprXfP2ImJ7TSNl80dwjBHnkVGjFiWznGGLRWbsbEzBoEBe
         DleWKrK2vGfYhnP4iRUVTbkrgyBkdDtTqBYiR247E8v5Nwc/wHizZXvnhBGaP9QXb3Jf
         C/ZD4KspHBVKYodNZmSe53m4WZeKBm3p2zooI35AYLobhLbWN9rem2kZDYEa82T41uCh
         C/0A==
X-Gm-Message-State: AOAM5301JXunnCqChg0kauwUDg1enpN5R7DUoKCxExmm0Mj8AStv09Ud
        lEghDLzhmcKz/GvrbtUAkz8=
X-Google-Smtp-Source: ABdhPJxfg6VQg31u41aN9H48Ck4d0nteRw7q7cscCJWbC2IyQzaytwWsb6pSs4lyPMpglSUKJFDAdQ==
X-Received: by 2002:a17:902:d2cb:b029:de:757c:1f0c with SMTP id n11-20020a170902d2cbb02900de757c1f0cmr15050355plc.40.1610959547882;
        Mon, 18 Jan 2021 00:45:47 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id o7sm16587735pfp.144.2021.01.18.00.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 00:45:47 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        pali@kernel.org, huyue2@yulong.com, zhangwen@yulong.com,
        zbestahu@163.com
Subject: [PATCH v2] mmc: core: remove unused host parameter of mmc_sd_get_csd()
Date:   Mon, 18 Jan 2021 16:45:20 +0800
Message-Id: <20210118084520.241-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

The host parameter is not used in the body of mmc_sd_get_csd(),
so let's remove it. Update related code at the same time.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v2: fix minor commit message.

 drivers/mmc/core/sd.c   | 4 ++--
 drivers/mmc/core/sd.h   | 2 +-
 drivers/mmc/core/sdio.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 6f054c4..6fa51a6 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -860,7 +860,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
 	return err;
 }
 
-int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card)
+int mmc_sd_get_csd(struct mmc_card *card)
 {
 	int err;
 
@@ -1046,7 +1046,7 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	if (!oldcard) {
-		err = mmc_sd_get_csd(host, card);
+		err = mmc_sd_get_csd(card);
 		if (err)
 			goto free_card;
 
diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
index 497c026..1af5a03 100644
--- a/drivers/mmc/core/sd.h
+++ b/drivers/mmc/core/sd.h
@@ -10,7 +10,7 @@
 struct mmc_card;
 
 int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr);
-int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card);
+int mmc_sd_get_csd(struct mmc_card *card);
 void mmc_decode_cid(struct mmc_card *card);
 int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 	bool reinit);
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 694a212..0fda778 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -751,7 +751,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	 * Read CSD, before selecting the card
 	 */
 	if (!oldcard && card->type == MMC_TYPE_SD_COMBO) {
-		err = mmc_sd_get_csd(host, card);
+		err = mmc_sd_get_csd(card);
 		if (err)
 			goto remove;
 
-- 
1.9.1

