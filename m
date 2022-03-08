Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDC7C433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Mar 2022 09:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbiCHJu1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Mar 2022 04:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345476AbiCHJu0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2022 04:50:26 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EFE344C6
        for <linux-mmc@vger.kernel.org>; Tue,  8 Mar 2022 01:49:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so1057741wmj.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Mar 2022 01:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4AMWeZkxp95RTDe+wPDPpAGms0iHGajzkgE4/KUX8bI=;
        b=H8aMYJdR1rsOnt5DsE/e5rdF/g5CVV/ImrAKuw+9/cPZfWZFiO38RKfkOvUCOzHRn8
         XqHP7+POHekXwKNA2LJVFDHwX+y+rUUhqpN+UDJJiOP9kpvWRKUzcDrjA7dZDZ6ZFcuG
         lR77zCxBUR8/BaJhSXHGHagB54eapbQhSvnO7oaIsLzsZIo+g5XDnNZ/tR3IA39RQ3Ue
         1mX0ri0O8X/Doruf5c5kTxOKzZiu3HcYBDifhFyTMf4rpLsMed0VvxDc2+rIjKVUehDs
         /FB/JGFsa5DbFlN2zWnoxDd/1EIYwRbp1nGtO5+Xrc0XJn6TmBBRWsZIqqDuKUB9YT8l
         SkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4AMWeZkxp95RTDe+wPDPpAGms0iHGajzkgE4/KUX8bI=;
        b=JCzeYOaipfcjau9mJDKS6Ey0rN+1jJxwRxgMx2Ghmzc5cqZ+QFoF2mWuT7Ce+D1xFx
         SZ/e2YVCaL1ygvizTr3NMl1ePkBgYhmbho6K9voXbztSPKDZMwxODWkiW2bsC4sB5rXm
         9JWrSXNy0GYX9fLGt1lcq4VgCI7HJvMZwk40ZaBJghob/MHSvMCYwWfuevi6TsFpGwa/
         kB2Bu7aKbM9e5eY2CEzu7MaBhQ0EHMhEu9ZuQ3f0nMaTS63/JE7lOctThtYBJOsC6X0j
         hghaoqYmPh1F1qUUrs7IEXg0gI/aNPtvKkkQ7Jwu71JpZqP2puwzZYhVYfUs2rP5gdCg
         P75Q==
X-Gm-Message-State: AOAM531M8OLcKv3gSEm9NMj26VmUFtyVBhu8yBjQOs3+yRpGAihm77lJ
        F92RiTzNAo93FWgssqkyPseK4G0rrCiKN+9U
X-Google-Smtp-Source: ABdhPJygU94zXAM1Uu54IBoLXA1LSudb52qrcnlJ03Lk9v6Rot2IWk4fYtPCBHBO4UAJEig/w3RXCg==
X-Received: by 2002:a1c:f616:0:b0:37d:1e1c:f90a with SMTP id w22-20020a1cf616000000b0037d1e1cf90amr2688313wmc.148.1646732967642;
        Tue, 08 Mar 2022 01:49:27 -0800 (PST)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d40c1000000b001f1dd6ea504sm8014205wrq.59.2022.03.08.01.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 01:49:27 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH] mmc: mtk-msdc: change a log level
Date:   Tue,  8 Mar 2022 10:49:24 +0100
Message-Id: <20220308094924.2868042-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

We write data to RPMB, we get many time the following log:
mtk-msdc 11230000.mmc: phase: [map:ffffffff] [maxlen:32] [final:10]

dev_info is used to print that log but it seems that log is only
useful for debbuging. Use dev_dbg instead of dev_info.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/mmc/host/mtk-sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index d5a9c269d492..05c8b4de46f3 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1914,8 +1914,8 @@ static struct msdc_delay_phase get_best_delay(struct msdc_host *host, u32 delay)
 		final_phase = (start_final + len_final / 3) % PAD_DELAY_MAX;
 	else
 		final_phase = (start_final + len_final / 2) % PAD_DELAY_MAX;
-	dev_info(host->dev, "phase: [map:%x] [maxlen:%d] [final:%d]\n",
-		 delay, len_final, final_phase);
+	dev_dbg(host->dev, "phase: [map:%x] [maxlen:%d] [final:%d]\n",
+		delay, len_final, final_phase);
 
 	delay_phase.maxlen = len_final;
 	delay_phase.start = start_final;
-- 
2.34.1

