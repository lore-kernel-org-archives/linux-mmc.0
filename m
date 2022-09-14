Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594C4ECAAD3
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Sep 2022 06:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiINGhS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Sep 2022 02:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiINGhS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Sep 2022 02:37:18 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF303D5B3;
        Tue, 13 Sep 2022 23:37:17 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 9so2852259pfz.12;
        Tue, 13 Sep 2022 23:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=UxjaxV6o3A1Me2CC2IL94ZaOteKvRdGDVyUfYdgY54A=;
        b=fk0bfsYF5GORsHtfgl3ajACU6dihG3ei5WqS6drL44t7255nRLpMuUK0D79EgWfJgP
         9NI+jIZY5FzK7Qa+UphPvKQW4PZY8inC3L5HLsZHT9Lfi9E99GgL3+FUsu+AdZ8xCrDi
         sbbYd/okGZn6YeKlQLNDy7YrlpsEfDS0ppezsqX9WFuaQbisvHjgBNTw57UpENf04tdM
         OZ9xDl5GssM+Y+dENOyS4bvhcNiDFTEB3d8i5h3LYBiwY/2P9fi9A+R5obNNH9nSoXJj
         Qh78wp/h/v0r1e2Y85B/x7oiWz7RIxZ1CwPwqTqZzOtHl+3zi7INCvLcM7Ucw/cWmZc3
         Wraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UxjaxV6o3A1Me2CC2IL94ZaOteKvRdGDVyUfYdgY54A=;
        b=IZg2tS1b96VVvNNjGikbyyaRzp8Hb7C042XhkieSAt2N24pu46sLav00d3G7H9faoj
         9lWQdJeclMH84ziH+CObcwAZOJZaEuhQsNRjF4q2bNOEj9VSYs7nI79k1NfTMmAX3iLy
         /34EdwRYYvS4Jx3NWe4FnPCanRMAexj9gG10lXbdWPWUH1XxlnsZ96TKjV3OpZrDKeRl
         f4SGQ2OslURTS2cPTZuTQZj5WftJKKv/02g2bADYuXr1fNFWjov2Ui7TnYKVxDAHTvYa
         z6/c0MasO+hcsT2BmQbM5TaIeb1P+G8WzXLFnV/P/P8rfPsHIAqd6x+PFk0TTXRrwDgz
         BMUQ==
X-Gm-Message-State: ACgBeo2E8FXXLDFONTJ7bt5qTgBuZNgP4RVnofgb8mLi0DiqtUrkOb//
        bZZUZFL/EG7WJidAUbOEhxc=
X-Google-Smtp-Source: AA6agR7bFqJ1KLPIvWO8zbweBd/wcrXJKtBfAodqUSV1dd/sLpgsnRPYOAARV2gn+FxooCd4gz8gyQ==
X-Received: by 2002:a05:6a00:2290:b0:541:f19:5197 with SMTP id f16-20020a056a00229000b005410f195197mr22004954pfe.42.1663137436900;
        Tue, 13 Sep 2022 23:37:16 -0700 (PDT)
Received: from xm06403pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id b23-20020a63d317000000b00429c5270710sm9055783pgg.1.2022.09.13.23.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 23:37:16 -0700 (PDT)
From:   Wenchao Chen <wenchao.chen666@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        megoo.tang@gmail.com, lzx.stg@gmail.com
Subject: [PATCH] mmc: sdhci-sprd: Fix the limitation of div
Date:   Wed, 14 Sep 2022 14:37:02 +0800
Message-Id: <20220914063702.20283-1-wenchao.chen666@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Wenchao Chen <wenchao.chen@unisoc.com>

Because the bit field size of the divider coefficient register is 1023, it is
limited before returning the value.

Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
---
 drivers/mmc/host/sdhci-sprd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index f33e9349e4e6..46c55ab4884c 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -205,14 +205,14 @@ static inline u32 sdhci_sprd_calc_div(u32 base_clk, u32 clk)
 	if ((base_clk / div) > (clk * 2))
 		div++;
 
-	if (div > SDHCI_SPRD_CLK_MAX_DIV)
-		div = SDHCI_SPRD_CLK_MAX_DIV;
-
 	if (div % 2)
 		div = (div + 1) / 2;
 	else
 		div = div / 2;
 
+	if (div > SDHCI_SPRD_CLK_MAX_DIV)
+		div = SDHCI_SPRD_CLK_MAX_DIV;
+
 	return div;
 }
 
-- 
2.17.1

