Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D15BEB64D7
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Jun 2023 12:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjF3MAc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 30 Jun 2023 08:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjF3MAb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Jun 2023 08:00:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106D61FCC
        for <linux-mmc@vger.kernel.org>; Fri, 30 Jun 2023 05:00:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so3014689e87.0
        for <linux-mmc@vger.kernel.org>; Fri, 30 Jun 2023 05:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688126424; x=1690718424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=14D7DHntwp60GlIftqa4afNY/9x1F06cw0RktL6nRlU=;
        b=fy1MI5UX56UXUrFu0J8cpIXdjPPG33um5E6owC4D67V1Th2H/9dmoDZEfyc3eJNVZ7
         osU0qAc2Xi57FirxHF5YqGd/hc5tj/CJlsuik/Gq0BuXz0PT5WZtci84yu5fxT3Jqpol
         NIMKFmVYK1kYjJzsvyxeriMC+MG9wcmUnq+Ih7aWAbteTAKBc/mFVJGDYyPFasA9umI4
         0uzO4XU0LlMVN0RPwJ2eYXHzwkTznWgNbbamO3EEU7kLPQcohvAYjeMZ5qZJc40c5UcK
         SLYIdstt45fjDisPwcRBFDCAI5uGYk9BV5n2zkauKfPAj9NI3whdpXKQI4LJ1HSJzFOx
         t2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688126424; x=1690718424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14D7DHntwp60GlIftqa4afNY/9x1F06cw0RktL6nRlU=;
        b=dQQ4oYhubFGVLhXr8F1zM6MhBTfLyE9HEAWeJ0FALH/lKHPhaPwgqIaGC94JGHYk52
         tGyhKNfOkcEDblc89b9tCgXFJ6dZuKoLZgCNrY1nOlUfsaQFiBY8oeiwbgXus5/6r6sS
         +p6HYRMOwsuBej8qXQ88EW8rsxcjOiedJNYEvlJzwSDAAAlpVRHmNYYGXrnVLvxsvvGb
         ozrsWOQHTEj+sWv0Cqi2e/J8BboESqJ7yJTqM2Aqq75awHJY6fXvPxnJZjXivXqhcdqe
         MkZyMcvvsMXhdUEMz4t7+g2NTY87GOZPqaX5FCcke+VDTvjaTxIsNW9BRQGY51WfPtOa
         LB+w==
X-Gm-Message-State: ABy/qLZcVsrrHs1A5eH/ceKhUwltuxGYeV/M1uSKsccEVNVO+kj0INxU
        /hgbv4NoXUVvK1VtrWmatHVm1IQSj2d55e8Z8HM=
X-Google-Smtp-Source: APBJJlGqSfsXzaw++zzvdLROw7Yo3+uXOyWcPd+8UphTz1qVhnp35rk2owNCFJzRjQI6NL3Z38Tbiw==
X-Received: by 2002:a05:6512:3146:b0:4fa:5255:4fa3 with SMTP id s6-20020a056512314600b004fa52554fa3mr1912440lfi.5.1688126423715;
        Fri, 30 Jun 2023 05:00:23 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g24-20020ac25398000000b004efae490c51sm488936lfh.240.2023.06.30.05.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 05:00:22 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: Revert "mmc: core: Allow mmc_start_host() synchronously detect a card"
Date:   Fri, 30 Jun 2023 14:00:15 +0200
Message-Id: <20230630120015.363982-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

It has turned out that some mmc host drivers were not ready to deal with
this change. Let's fix those host drivers first, then we can give this a
new try.

Fixes: 2cc83bf7d411 (mmc: core: Allow mmc_start_host() synchronously detect a card)
Cc: Dennis Zhou <dennis@kernel.org>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ec4108a3e5b9..3d3e0ca52614 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2199,8 +2199,10 @@ int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *gpt_sector)
 }
 EXPORT_SYMBOL(mmc_card_alternative_gpt_sector);
 
-static void __mmc_rescan(struct mmc_host *host)
+void mmc_rescan(struct work_struct *work)
 {
+	struct mmc_host *host =
+		container_of(work, struct mmc_host, detect.work);
 	int i;
 
 	if (host->rescan_disable)
@@ -2272,14 +2274,6 @@ static void __mmc_rescan(struct mmc_host *host)
 		mmc_schedule_delayed_work(&host->detect, HZ);
 }
 
-void mmc_rescan(struct work_struct *work)
-{
-	struct mmc_host *host =
-		container_of(work, struct mmc_host, detect.work);
-
-	__mmc_rescan(host);
-}
-
 void mmc_start_host(struct mmc_host *host)
 {
 	host->f_init = max(min(freqs[0], host->f_max), host->f_min);
@@ -2292,8 +2286,7 @@ void mmc_start_host(struct mmc_host *host)
 	}
 
 	mmc_gpiod_request_cd_irq(host);
-	host->detect_change = 1;
-	__mmc_rescan(host);
+	_mmc_detect_change(host, 0, false);
 }
 
 void __mmc_stop_host(struct mmc_host *host)
-- 
2.34.1

