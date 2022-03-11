Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74748C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Mar 2022 10:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347822AbiCKKeh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Mar 2022 05:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347940AbiCKKef (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Mar 2022 05:34:35 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60059F4610
        for <linux-mmc@vger.kernel.org>; Fri, 11 Mar 2022 02:33:31 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so7207666wmj.2
        for <linux-mmc@vger.kernel.org>; Fri, 11 Mar 2022 02:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHzWauNR3dX3JRCdUQ2Wh7sQFhVa1g70Y/fsse/k3yk=;
        b=OgmwPVe3iTZnA/fxf5BvpufbW18UFWKBkE6DauL5sDY3H5EGsXZuQnYiUcls3Xp/Yb
         ngodX1pS/phKVnyzuXFIoy84AfunMsefM49Ss1BSHYZl6/FrupaTRIDnlfY0f8IBKgXd
         7Sb27GyhcyaZiEt0ybiWuBKbtISdNMGVC5OqP/hs6OCZ0k6uAggfx7ulG284ELodkOSO
         b9BmifiA+AEWhfDJsB+JV8hPlwMmAQCKiHeN5IdCpB9fFof9PgSNmRPrZHLq2qijnyLW
         kIzOHxQUZjxBbpRfgPQRVk0EUp+1ki1OYhihN8GHetTjVQ0uIC4DknrszIyxGchHGiaL
         VVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tHzWauNR3dX3JRCdUQ2Wh7sQFhVa1g70Y/fsse/k3yk=;
        b=xrIE2liCdQuXAopJ3LF9SxXr7KKIlbwQDI0QwQZwtg6hf7E/Yirxe0wKFmosY202lX
         /j2vsvxyHlwO2OTNvipJPOmVxRT47tNxhqOQ0bOzhMd76uEkDoA9W0UYkrpnf91ZPmMQ
         ZzOfzypw7Z8XxDtlzW4tl+7vH3xV973MHFA1zSSzga3zMCQP+QZNGZtZhsPCrhnOsZEH
         Oidjfl+Y0voe/ehrpbpD5BeX/X4wNNdNUzp6PR77YNqsPX4U2PMP+9AdSCasT56YAsHV
         948JK9uzGCoOwNwT5mIkzrAYa/ylzCvnVURbUC5WAi023YbGVIyglj//KmSotWERk5ws
         wV1w==
X-Gm-Message-State: AOAM532LuDXJ/oEJO+3oR19zAyDD9K8BrNWmTSkacZx4a1rgLyTbnNQt
        6wWNw75xx8hU/ofVv5m78l9wKQ==
X-Google-Smtp-Source: ABdhPJwR2NyG/o0epriqRgWZiafPO4iha8N9ZD/x+FYDnBCO3aAzDwH1hjTV0yNCeh6rbGezo3zDgQ==
X-Received: by 2002:a05:600c:4615:b0:386:9f67:8c63 with SMTP id m21-20020a05600c461500b003869f678c63mr15020537wmo.12.1646994809922;
        Fri, 11 Mar 2022 02:33:29 -0800 (PST)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e10-20020a056000178a00b0020393321552sm2264138wrg.85.2022.03.11.02.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 02:33:29 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        matthias.bgg@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2] mmc: mtk-sd: Silence delay phase calculation debug log
Date:   Fri, 11 Mar 2022 11:33:20 +0100
Message-Id: <20220311103320.3072171-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The driver prints the following log everytime data is written to RPMB:
mtk-msdc 11230000.mmc: phase: [map:ffffffff] [maxlen:32] [final:10]

dev_info is used to print that log but it seems that log is only
useful for debbuging. Use dev_dbg instead of dev_info.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

