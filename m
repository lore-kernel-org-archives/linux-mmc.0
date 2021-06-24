Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD9BC49EA5
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 16:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B05D1613DC
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 16:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhFXQd3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Jun 2021 12:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhFXQd2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jun 2021 12:33:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87191C061574;
        Thu, 24 Jun 2021 09:31:08 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bb10-20020a17090b008ab029016eef083425so6238593pjb.5;
        Thu, 24 Jun 2021 09:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RT5dzZftBebY2VOviVkfQ45/MM67CQrK4oo7y7p6OG0=;
        b=tJbie+vJZ7aFEOnM7n2nhQUuEowCHMuiAhZKobMJ1IWm2818LP+iS584rYMuKq7WcE
         tacamuymP3RotbIwUZDpeaXsp1EcDo23sywrdX2dgsdn0tH/X6EZpPs8m1WZR151yw9N
         KcceZpaaU7wStGnhAQ6YcFbj54yVURk4R7ON/Ff52J3/4y22wTz+jEpOlAzkhF0pGew7
         FMcXybyAGxfmr8I64BIZKhT+QwUDK8TjjxzNonp51KC11LFQtYYJKT0eCUB2mpLrg8kB
         Una9dQe6+zW404yUPWM2JYfW0PpolL/mLasVSS58v0k7TRXEZ8Sn0bGo/5viCPXa4hfv
         Y25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RT5dzZftBebY2VOviVkfQ45/MM67CQrK4oo7y7p6OG0=;
        b=XIMAvtGJsKoVfikjjciOAVq9Vbb4cG9CL7cdKuuHBop2Yx/Ik+3F7ueNp7Nt6YrIrd
         TTjiWo2kJRwlMggR0oXjOqBRM8BAw9QZSLmIVi4E3htz254n2npkNZ7KtrGZmgS7n14n
         JSxDaWnRbd/PMZGsLG9a/d79lp1mcVglq7j/WGkcLcQXFW6WGDuLemT8bSDK1DvT66xr
         pe8cutauOKsVnxc0WmPetWNbMb8TfQahpZa2FZYFy6rMoXIF8awQqc4FWWZKnzs9MpXq
         cY6gugdUEG4WQYV788Yc9CttZGKcAmBWBwY6oajQEgn+iPmhQtBCspfzZkoVgdEzhA7y
         x8kg==
X-Gm-Message-State: AOAM533GHvssG1zlV3S6Lv63xpneoV66V2IHPzAv4wFGvRHvt0tvQlzZ
        xxj1fPzgvK6pVNFNsu0lr6VqyTxBr9bvsx8/
X-Google-Smtp-Source: ABdhPJwAC42oBuh4tNxF1+OHN+rm3D4FDqNuecZ6SN7HNqwN2AvlO34xsMha9fHY0+hzAGse0T8/oA==
X-Received: by 2002:a17:90b:153:: with SMTP id em19mr9847379pjb.21.1624552267912;
        Thu, 24 Jun 2021 09:31:07 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id w11sm2889539pgp.60.2021.06.24.09.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 09:31:07 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci: Fix warning message when accessing RPMB in HS400 mode
Date:   Thu, 24 Jun 2021 12:30:45 -0400
Message-Id: <20210624163045.33651-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

When an eMMC device is being run in HS400 mode, any access to the
RPMB device will cause the error message "mmc1: Invalid UHS-I mode
selected". This happens as a result of tuning being disabled before
RPMB access and then re-enabled after the RPMB access is complete.
When tuning is re-enabled, the system has to switch from HS400
to HS200 to do the tuning and then back to HS400. As part of
sequence to switch from HS400 to HS200 the system is temporarily
put into HS mode. When switching to HS mode, sdhci_get_preset_value()
is called and does not have support for HS mode and prints the warning
message and returns the preset for SDR12. The fix is to add support
for MMC and SD HS modes to sdhci_get_preset_value().

This can be reproduced on any system running eMMC in HS400 mode
(not HS400ES) by using the "mmc" utility to run the following
command: "mmc rpmb read-counter /dev/mmcblk0rpmb".

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/host/sdhci.c | 4 ++++
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index bf238ade1602..6b39126fbf06 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1812,6 +1812,10 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
 	u16 preset = 0;
 
 	switch (host->timing) {
+	case MMC_TIMING_MMC_HS:
+	case MMC_TIMING_SD_HS:
+		preset = sdhci_readw(host, SDHCI_PRESET_FOR_HIGH_SPEED);
+		break;
 	case MMC_TIMING_UHS_SDR12:
 		preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR12);
 		break;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0770c036e2ff..960fed78529e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -253,6 +253,7 @@
 
 /* 60-FB reserved */
 
+#define SDHCI_PRESET_FOR_HIGH_SPEED	0x64
 #define SDHCI_PRESET_FOR_SDR12 0x66
 #define SDHCI_PRESET_FOR_SDR25 0x68
 #define SDHCI_PRESET_FOR_SDR50 0x6A

base-commit: 7426cedc7dad67bf3c71ea6cc29ab7822e1a453f
-- 
2.17.1

