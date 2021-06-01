Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A888C4708F
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Jun 2021 09:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECAF7613AB
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Jun 2021 09:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhFAJzu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Jun 2021 05:55:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38902 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhFAJzt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Jun 2021 05:55:49 -0400
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lo167-0004f1-G0
        for linux-mmc@vger.kernel.org; Tue, 01 Jun 2021 09:54:07 +0000
Received: by mail-wm1-f69.google.com with SMTP id r15-20020a05600c35cfb029017cc4b1e9faso916363wmq.8
        for <linux-mmc@vger.kernel.org>; Tue, 01 Jun 2021 02:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+OIrf2YpRvopTOP9GrsCcXEr+7TL2pNaPcwxG3gY5kg=;
        b=eycgx341N5zuxaxTiGalGpEILnisn7grCQzpIsja7cqZNuUyMR66qGmarENMWVYzOh
         zggk14yiXcDhoJ/MFI40228/u0mwQaGFWQfLK7mopuu6b0KYos/Ukw1yibopbDdLLQjM
         E4Rnp5ln3GVZShy+BvshP+xzsgWifTILuO56VLf8fz7XATUdfR0LswhyYr3JQOzo/uKL
         2304oIwripb+v0nw+ip4l9yv05UvC+98EGuIfr/uwAO6zlWuR3ieCJzl6k4cNBwYGwnW
         U/qWfsz2kgf5vq8TCASkJbo7h0DV2RIb9iaeV1fMTJFI2PA6hEWKQSn7tTP0z6bIdozF
         CKRA==
X-Gm-Message-State: AOAM531+HIK56spFWxcqcYDqs0RuGbh4stVjS4tTe63qRCYsVEcRyT+l
        iSOyjVI4C9SaOyyaYYo3IU78upBF/v0D89JfBbbD+xS4xenpiAM2d+xzzX2dlUkYlOq5+mKQYQ9
        /oyEQpYxbwv+ofSyoaVEqU+Zti3Ji1/jxMq1EFQ==
X-Received: by 2002:a05:6000:11c9:: with SMTP id i9mr26826362wrx.153.1622541247275;
        Tue, 01 Jun 2021 02:54:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEgSE7f74QpnJ54SuwC0JE/TVO2c38ODfUoM2T1GA4moNTgXFOXZDzv9q0xjvJnadZtjMS5w==
X-Received: by 2002:a05:6000:11c9:: with SMTP id i9mr26826353wrx.153.1622541247176;
        Tue, 01 Jun 2021 02:54:07 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id c7sm2018363wml.33.2021.06.01.02.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:54:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] mmc: sdhci-esdhc-imx: remove unused is_imx6q_usdhc
Date:   Tue,  1 Jun 2021 11:54:02 +0200
Message-Id: <20210601095403.236007-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The is_imx6q_usdhc() function is unused:

  drivers/mmc/host/sdhci-esdhc-imx.c:343:19: warning: unused function 'is_imx6q_usdhc'

Reported-by: kernel test robot <lkp@intel.com>
Fixes: f47c4bbfa283 ("mmc: sdhci-esdhc-imx: create struct esdhc_soc_data")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index fba4a963d12e..7336ae749137 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -324,11 +324,6 @@ static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
 	return data->socdata == &esdhc_imx53_data;
 }
 
-static inline int is_imx6q_usdhc(struct pltfm_imx_data *data)
-{
-	return data->socdata == &usdhc_imx6q_data;
-}
-
 static inline int esdhc_is_usdhc(struct pltfm_imx_data *data)
 {
 	return !!(data->socdata->flags & ESDHC_FLAG_USDHC);
-- 
2.27.0

