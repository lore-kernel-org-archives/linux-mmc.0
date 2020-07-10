Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F518C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F822077D
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 11:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaHGgEEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgGJLKm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgGJLKm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jul 2020 07:10:42 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1557CC08C5CE;
        Fri, 10 Jul 2020 04:10:42 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w17so2108072ply.11;
        Fri, 10 Jul 2020 04:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bgoBg0vT86NrsTuwHUuY0qnUVNcClhUjdRlVz8Y7TKE=;
        b=DaHGgEEGmlzpgsVxpafL78K63f9pg8pK4DQJ0e3sdMT6FZBcAGWs9J0qbf3jm6YWBE
         7HJwFSW/t4BmyEDmuOGu58XH0gUxO/BVf+TUKsx/1buK1NPIGaMWNqpus/C9uOsZk6Zh
         A1jEgRnKGUbc/58IgVq67VvXpqcQ64pVI26KOaOqI5KqnCZmSrifUhPTXercRJuQErXH
         Ve+nvU5A2aMs8ro5YZsjyxSavNJNI0Prwog/nJJMUKUez7C4gMT9LQsMaZv2O1s5A9oT
         7j8fA31ziMkvsLrq1mXIgVp8iaczoWZWwWt5geyHVBNIgnIF8L6rKEA9Gfi2mqvbfDOl
         dWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bgoBg0vT86NrsTuwHUuY0qnUVNcClhUjdRlVz8Y7TKE=;
        b=p+48yTUtaBGsW+kUFqpLOEs2k3c8yn7M+QFk/Dl11HjmJHvMxrtWOLux9aJdcJjhyr
         0L5EM2wn0nu3EzwylZXUPbJUolRHs83yuRg11OJzq/e5FPLK8rzYzYzR7AYqWcmJLeQh
         +2PRrOzS1UYithVjdkfkGGR2J9SvaQMT39siCt1CGGuwcbF2a7bLWbm5ztpkRP17HnSE
         J47mli8MkLR0n2fM6Dfl5r7fVJcNfT/igdX8onVv9vmMhySBvFJz0AMpYzddxsJKsv5a
         8JU2sdkCvXrTPH4fEH+bcMdyYWy4oRV3EaIX+FdNfeyt0fRHU5y1sRfVuE09yvhDpb4k
         45eA==
X-Gm-Message-State: AOAM532F1jXlrET9paf3uo6PFAWJzs+Re4om20ALM9sHouHX8pC+HHY3
        Oxca8JXI+ajymqgT1d9gZNk=
X-Google-Smtp-Source: ABdhPJzDYSM4rpL4ZeqAOMHMe5vZeTQCKN7wlVZY5xSQgL1/S5yx6OECT09VkBYdQ9aM1Cjpw6222Q==
X-Received: by 2002:a17:902:7d8f:: with SMTP id a15mr18410159plm.37.1594379441641;
        Fri, 10 Jul 2020 04:10:41 -0700 (PDT)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id v15sm5415890pgo.15.2020.07.10.04.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:10:41 -0700 (PDT)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        greg.tu@genesyslogic.com.tw, Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH V3 14/21] mmc: sdhci: UHS-II support, handle vdd2 in case of power-off
Date:   Fri, 10 Jul 2020 19:11:21 +0800
Message-Id: <20200710111121.29671-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

Configure a regulator for VDD2 in case of power-off.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/host/sdhci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7f2537648a08..d38d734ec83f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2333,6 +2333,11 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (!IS_ERR(mmc->supply.vmmc) &&
 		    ios->power_mode == MMC_POWER_OFF)
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		if (IS_ENABLED(CONFIG_MMC_SDHCI_UHS2) &&
+		    host->mmc->caps & MMC_CAP_UHS2 &&
+		    !IS_ERR(mmc->supply.vmmc2) &&
+		    ios->power_mode == MMC_POWER_OFF)
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc2, 0);
 		return;
 	}
 
-- 
2.27.0

