Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3E8C47080
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Jun 2021 09:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B8BC6139A
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Jun 2021 09:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhFAJzv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Jun 2021 05:55:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38926 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhFAJzv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Jun 2021 05:55:51 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lo168-0004gJ-NY
        for linux-mmc@vger.kernel.org; Tue, 01 Jun 2021 09:54:08 +0000
Received: by mail-wr1-f71.google.com with SMTP id k11-20020adfe3cb0000b0290115c29d165cso1661565wrm.14
        for <linux-mmc@vger.kernel.org>; Tue, 01 Jun 2021 02:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P84Q3P77QPurEsVerB80kS5Kb6uIBsDdK0mS7TTN5Ls=;
        b=SIBH9Oojg2zDpgbkSksJrX37tGR++75NTVcP9tJlVYRHTQO6TPlKhADvLyHstanXxy
         ZdMNuvU3LdG1HfG7gMW+8OF/r2zizkgR79kGumOennvhf09xivlFEBt4nt5NpqxCShrN
         rm8deSliTRsqTUpF0u0feMlHNPaskDJ2zwS/LPsAfr3lhsUM+29NGFLXDuk4q1F395b7
         ncKFZKHZUBvjJsmerr4iGf0acZlK2HEWwu4I6spSoXlL57kddmv2I/kG+wQkfftqXpVw
         Qm40HvQOkhFKk6+urmLZa8Yt9wyoYFrxemkZXdV7eYR4B0sN8/ctqvD6UThIyVth5UmG
         G9kQ==
X-Gm-Message-State: AOAM533THv6og75aFoQIAm0r/jL99FnCzt6OoHl8/b2MjkBSStWsunZK
        Lpdnzqo12xLBPl6U3LGYHblTspETujJWCDITtxT+Pt/BMMiLNCt889hgLiEVXIOzOGarFk/XfQq
        XUarjaqDoYldG08PmlwpBHt28HNwxE99BIX1Y9w==
X-Received: by 2002:adf:c392:: with SMTP id p18mr5967452wrf.373.1622541248293;
        Tue, 01 Jun 2021 02:54:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRXf0Kyx8EiU6f8ShfqUFg8yihrjM9vJAYd72HYDtdzKblhZwGcYeC5Mg2gYKZnCmpkWc00w==
X-Received: by 2002:adf:c392:: with SMTP id p18mr5967433wrf.373.1622541248201;
        Tue, 01 Jun 2021 02:54:08 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id c7sm2018363wml.33.2021.06.01.02.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 02:54:07 -0700 (PDT)
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
Subject: [PATCH 2/2] mmc: sdhci-sprd: use sdhci_sprd_writew
Date:   Tue,  1 Jun 2021 11:54:03 +0200
Message-Id: <20210601095403.236007-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210601095403.236007-1-krzysztof.kozlowski@canonical.com>
References: <20210601095403.236007-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The sdhci_sprd_writew() was defined by never used in sdhci_ops:

    drivers/mmc/host/sdhci-sprd.c:134:20: warning: unused function 'sdhci_sprd_writew'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mmc/host/sdhci-sprd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 5dc36efff47f..11e375579cfb 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -393,6 +393,7 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
+	.write_w = sdhci_sprd_writew,
 	.write_b = sdhci_sprd_writeb,
 	.set_clock = sdhci_sprd_set_clock,
 	.get_max_clock = sdhci_sprd_get_max_clock,
-- 
2.27.0

