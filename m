Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BD7C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 13:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED1F61039
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 13:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346733AbhIXNfU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 09:35:20 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59818
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345769AbhIXNfG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Sep 2021 09:35:06 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 83A3040292
        for <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2021 13:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632490412;
        bh=XKzcwZuGjS/78EnzwfC5NLVDtJ4nskm07UNCWnFZuVI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=vGBJYhCRiA7zVmNnSG0ktqTG3xgW4SN9ZyiulTA5inQ/1YPM+AmmdD+YnEa2QAvxN
         0AExaOdRY4rnhp6GnG8oymNhAMRj94w4liJQiPsIaBoLmSiiMaXi4MkvgRuaMyPMqD
         IO1WjdTqfFMmSItio2BQI2/XuaU6e0Qy2TC56Jic7dO4nd9bblW/fPF+P5Sh8SUrJq
         +v89xKglXwYjw8bNT2jVdPv7E1Pfhuixvm4/pZIKsmjmyH/puSEWKFWf34lPJpYwtk
         y8T/2Er8uyNkCYz9y2D7cD6Sj7gQupvfwmtG6/C0+fx39NSzQxpnBE4nYMhSRyT901
         kfQI2tcrp9H2g==
Received: by mail-wr1-f72.google.com with SMTP id r7-20020a5d6947000000b0015e0f68a63bso8074129wrw.22
        for <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2021 06:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XKzcwZuGjS/78EnzwfC5NLVDtJ4nskm07UNCWnFZuVI=;
        b=8Nz11iKHEbIoFh8Hp2lA/nm7SAkiX9cpHlIX484/APuJfPTB8HPVaCpG7iYdicLfxQ
         uisPrKfMCRCuftK/bJ5G+GpUkDmItTdN/oWDKLuZy48h+TURYvux47x2V/LMum+lh32A
         6J16NDqp9J6BfNbL6nggkpEqIFWnTQMTcdBKLw9/gXpwXJPjWJuW8/gqaRPwWhTljGJz
         KnEV1wrNRV/M4P/kZf8wHxT68WjnDTzwHWBa4aif38BRpHB1XQODmbDniVepDoDAObLd
         TxmHuR46NFs7o6sQR0HL9eCSqjiSc6OSARvIxd0xDS+2iqfqpHETq3JSQfhHtWvuttqr
         1p8Q==
X-Gm-Message-State: AOAM5309alzyqdJg9jaJdtLXf5fZJZy864ZSg4KGBCPy0j/Q6M42DP6b
        8qTb3yHLY414qGshMbetPj78sPKvbz4A5g1GxkJ6L4eUjhManKLNo1s5ormkVMDzBpAzoHmw8/1
        UrPDR6gzcmn/PI4jUxkAjoNiKRzJBLyex823zCg==
X-Received: by 2002:a05:6000:1567:: with SMTP id 7mr11418487wrz.84.1632490411880;
        Fri, 24 Sep 2021 06:33:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwejRfNkpbo05/gq3EhCAin4mt4r31Piv7+agmXlRHuJktohhgGDajWxZvlAJGT9ZJUgdgE0g==
X-Received: by 2002:a05:6000:1567:: with SMTP id 7mr11418468wrz.84.1632490411764;
        Fri, 24 Sep 2021 06:33:31 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id n7sm8259677wra.37.2021.09.24.06.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:33:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci-s3c: Describe driver in KConfig
Date:   Fri, 24 Sep 2021 15:32:57 +0200
Message-Id: <20210924133257.112017-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Describe better which driver applies to which SoC, to make configuring
kernel for Samsung SoC easier.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mmc/host/Kconfig | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 71313961cc54..e4c1648e364e 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -315,15 +315,17 @@ config MMC_SDHCI_TEGRA
 	  If unsure, say N.
 
 config MMC_SDHCI_S3C
-	tristate "SDHCI support on Samsung S3C SoC"
+	tristate "SDHCI support on Samsung S3C/S5P/Exynos SoC"
 	depends on MMC_SDHCI
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  often referrered to as the HSMMC block in some of the Samsung S3C
-	  range of SoC.
+	  (S3C2416, S3C2443, S3C6410), S5Pv210 and Exynos (Exynso4210,
+	  Exynos4412) SoCs.
 
-	  If you have a controller with this interface, say Y or M here.
+	  If you have a controller with this interface (thereforeyou build for
+	  such Samsung SoC), say Y or M here.
 
 	  If unsure, say N.
 
-- 
2.30.2

