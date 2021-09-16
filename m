Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAE9C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Sep 2021 17:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A2C610A6
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Sep 2021 17:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245194AbhIPRIw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Sep 2021 13:08:52 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:59214
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349628AbhIPRGg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Sep 2021 13:06:36 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D7255402D3
        for <linux-mmc@vger.kernel.org>; Thu, 16 Sep 2021 17:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631811914;
        bh=ZHRoqPl1cOVXSfVcApJkxd3VnTYZBp5y1yAkPPBCN0A=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=qTF+EbNI/zArJNagC/G5kFsFXrl5AXtpjoQn6Bp952X7ZukIQGexyzvJ7Cvgl8tpo
         36WYND3k0NZ33xJ+IjOQTfX7pwzklr4RtcF0hzu4J0LFravKBl5SdfWxdi1jCzxRGz
         cuJtwIYo5BvZFjlWrlBRObryvqgNuW+leanKxbNbYTbxljE+3eilk9rfbcAqkd/PCz
         uOgHP1pVNOqYS+DwzMlvgpfcsXfGIHpuhSBnTVQQEcRzlMjecrpyz7edhlKTFE4RS8
         Vwu/yM6nvZuuNS4YQBtsc9SRj7i6DtMOEmUs4cyXs2UCZRgyzQQrNY00C/LcWz6rZl
         fHpbIkOGufJ/Q==
Received: by mail-wm1-f69.google.com with SMTP id c2-20020a7bc8420000b0290238db573ab7so2814493wml.5
        for <linux-mmc@vger.kernel.org>; Thu, 16 Sep 2021 10:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHRoqPl1cOVXSfVcApJkxd3VnTYZBp5y1yAkPPBCN0A=;
        b=c+wELAnLzpEw9op9o02qTwRi5l8WTdeHY9jyKxBDyRQgpLJNb/n3vyz7ms0qQzmSnH
         kpFEmHChEqjD/7wXe1hmapWO0KKUqZrZpQrn64Z5PVoOqtH6lWtzs/f+isbl4UW5dlP/
         bUqGKJjPjP4bTTII/jMfWy5rSMYBJNoh98okXFjbSPpTopBGdjKbLo//uxcuAtGFtn5E
         6gLahDg9tQfA1kApEtdqYpAL5ybX/QoBIOEYXw94/EvLZFuc/gDvxpeFLSMRcLPQsLvS
         EqMeg9e/IiSiKw1WCPf0WbB3nl6zHxUA1K7cJEbByMnzf7yYN/xslsrokgipi54BeZYN
         /pkg==
X-Gm-Message-State: AOAM530sEd+YqT1LoQtklSfm3lJWAdGvB9JNjNXJFx+BLJt7XXKm2zd0
        DvS3AVZ4Lj3uoqG6E++vM3ugZhNraXS33+HwCTQgeXryUZ6IPQCSlyRibi1+Di+uMLKefo3Px+y
        kwd2owwpIMJGaAF1vD1wExth+wcPK/2GxzHPgqg==
X-Received: by 2002:a1c:403:: with SMTP id 3mr6101156wme.161.1631811914211;
        Thu, 16 Sep 2021 10:05:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwv7qQi8MCpMfWAMFcZfF4aplV7ax8EdJu7wjofiWEf9bor5D979kr8z1OijUkT1SwPR4Ln6Q==
X-Received: by 2002:a1c:403:: with SMTP id 3mr6101135wme.161.1631811914068;
        Thu, 16 Sep 2021 10:05:14 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id l15sm8025724wme.42.2021.09.16.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 10:05:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci-s3c: drop unneeded MODULE_ALIAS
Date:   Thu, 16 Sep 2021 19:05:11 +0200
Message-Id: <20210916170511.137915-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/mmc/host/sdhci-s3c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 862f033d235d..9085f3932443 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -791,4 +791,3 @@ module_platform_driver(sdhci_s3c_driver);
 MODULE_DESCRIPTION("Samsung SDHCI (HSMMC) glue");
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:s3c-sdhci");
-- 
2.30.2

