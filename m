Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B4EC25B6F
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Oct 2023 07:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjJZH64 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Oct 2023 03:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344466AbjJZH6y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Oct 2023 03:58:54 -0400
X-Greylist: delayed 362 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 Oct 2023 00:58:51 PDT
Received: from gw.atmark-techno.com (gw.atmark-techno.com [13.115.124.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267A2191
        for <linux-mmc@vger.kernel.org>; Thu, 26 Oct 2023 00:58:50 -0700 (PDT)
Received: from gw.atmark-techno.com (localhost [127.0.0.1])
        by gw.atmark-techno.com (Postfix) with ESMTP id BF60C6013D
        for <linux-mmc@vger.kernel.org>; Thu, 26 Oct 2023 16:52:48 +0900 (JST)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by gw.atmark-techno.com (Postfix) with ESMTPS id 0C7DA6013B
        for <linux-mmc@vger.kernel.org>; Thu, 26 Oct 2023 16:52:48 +0900 (JST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-27d4606e8d8so599376a91.1
        for <linux-mmc@vger.kernel.org>; Thu, 26 Oct 2023 00:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698306767; x=1698911567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+lAIq6u9pTYK8uuKU3nuhyjh5nuKNcKCButdhJ6GhKA=;
        b=XxT0KG/7dfzX7yY87O1ORPV4VUHz1OzbR+heX2JvMUAqrekPEj21iAn5r5hxBC1J4G
         eD4OaCQAI5izan9xhs/B1KMLYr4giwS6zGLR/GXAOHQlIQ8TFN7tVgVflpXA3du4CtF4
         QSDFo2skoGYh/znk1mS6pGKWMkDtdcBigmcK+poLSLvaq9oULsEzGp4+MGUCqeVM0jlR
         TgU1H41XpGbXuBdBjcnLGNoOIMNA0pbu6ETcPRVKfCMCXbBpG26UsqauaNWKYjnHYFgI
         diC42gq3CrcFFHG4yZphTzvVTqRyZ9RG6uhF/aX4ul2XGLk1TgW37g0TFzqkZHPU6M3B
         e/Pw==
X-Gm-Message-State: AOJu0YxTBEnOd7qhBHAcf8dgB4oPmIAIRdnCsqy+LsrhS5+ZjT8bFZuC
        OvANseYWwOXN2g8prru/7YqZ674yY60eAcEjaufxel2ETvbRgQOB1V9ADqIpeiCTEBypMOCSBgZ
        Ai2Q09A8+T30+cwVI5f3Ml2+2ThKPYmTz
X-Received: by 2002:a17:90a:5308:b0:27d:1521:11a1 with SMTP id x8-20020a17090a530800b0027d152111a1mr18119156pjh.31.1698306767109;
        Thu, 26 Oct 2023 00:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYjAebEebd5s3f2Q/gDhYTnmbig3+22DHmCgM72YUnNgQa1fDDTe+PmrXhOW2eC4l/isBOCA==
X-Received: by 2002:a17:90a:5308:b0:27d:1521:11a1 with SMTP id x8-20020a17090a530800b0027d152111a1mr18119145pjh.31.1698306766820;
        Thu, 26 Oct 2023 00:52:46 -0700 (PDT)
Received: from pc-zest.atmarktech (76.125.194.35.bc.googleusercontent.com. [35.194.125.76])
        by smtp.gmail.com with ESMTPSA id g19-20020a170902869300b001b9e86e05b7sm10417565plo.0.2023.10.26.00.52.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Oct 2023 00:52:46 -0700 (PDT)
Received: from [::1] (helo=pc-zest.atmark.tech)
        by pc-zest.atmarktech with esmtp (Exim 4.96)
        (envelope-from <dominique.martinet@atmark-techno.com>)
        id 1qvvAb-001jsj-13;
        Thu, 26 Oct 2023 16:52:45 +0900
From:   Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dominique Martinet <dominique.martinet@atmark-techno.com>,
        stable@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alex Fetters <Alex.Fetters@garmin.com>
Subject: [PATCH] mmc: truncate quirks' oemid to 8 bits
Date:   Thu, 26 Oct 2023 16:52:30 +0900
Message-Id: <20231026075230.414685-1-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We now only capture 8 bits for oemid in card->cid.oemid, so quirks that
were filling up the full 16 bits up till now would no longer apply.

Work around the problem by only checking for the bottom 8 bits when
checking if quirks should be applied

Fixes: 84ee19bffc93 ("mmc: core: Capture correct oemid-bits for eMMC cards")
Link: https://lkml.kernel.org/r/ZToJsSLHr8RnuTHz@codewreck.org
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Cc: stable@vger.kernel.org
Cc: Avri Altman <avri.altman@wdc.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alex Fetters <Alex.Fetters@garmin.com>
---
Notes:
 - mmc_fixup_device() was rewritten in 5.17, so older stable kernels
   will need a separate patch... I suppose I can send it to stable
   after this is merged if we go this way
 - struct mmc_cid's and mmc_fixup's oemid fields are unsigned shorts,
   we probably just want to make them unsigned char instead in which
   case we don't need that check anymore?
   But it's kind of nice to have a wider type so CID_OEMID_ANY can never
   be a match.... Which unfortunately my patch makes moot as
   ((unsigned short)-1) & 0xff will be 0xff which can match anything...
 - this could also be worked around in the _FIXUP_EXT macro that builds
   the fixup structs, but we're getting ugly here... Or we can just go
   for the big boom and try to fix all MMC_FIXUP() users in tree and
   call it a day, but that'll also be fun to backport.

 drivers/mmc/core/quirks.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 32b64b564fb1..27e0349e176d 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -211,8 +211,9 @@ static inline void mmc_fixup_device(struct mmc_card *card,
 		if (f->manfid != CID_MANFID_ANY &&
 		    f->manfid != card->cid.manfid)
 			continue;
+		/* Only the bottom 8bits are valid in JESD84-B51 */
 		if (f->oemid != CID_OEMID_ANY &&
-		    f->oemid != card->cid.oemid)
+		     (f->oemid & 0xff) != (card->cid.oemid & 0xff))
 			continue;
 		if (f->name != CID_NAME_ANY &&
 		    strncmp(f->name, card->cid.prod_name,
-- 
2.39.2


