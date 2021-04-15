Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EEDC43460
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 08:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9EEE6124B
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 08:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhDOIol (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 04:44:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38422 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhDOIok (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Apr 2021 04:44:40 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWxbk-0000JQ-Rt
        for linux-mmc@vger.kernel.org; Thu, 15 Apr 2021 08:44:16 +0000
Received: by mail-ed1-f72.google.com with SMTP id w15-20020a056402268fb02903828f878ec5so4789170edd.5
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 01:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9YAO2kP+UwcFk07vAzhKIghy5JKErNSIyCSfT/ZaQms=;
        b=NzZH8vza7BZ9qWRslB8GsSulQCyxMG+6K52IGsWEhTUIifmPph30JVmf1DkCJ8Bep7
         tqSxYP7+TmiCxc7QTcj09LJnl+fU7CWN/4IjqWmrMTqeTdW/g4qwLhN6N3ICj/KlXjiI
         2CJLer1ODBef7oc5POiuJP79Fo8eoNDraXJjWTKxBBSwDBh0d7d2KIp1z4xqfSUfJr4Z
         2ldtIXWP/ELPl2MGendsCvc00b31hc02CG4lRR38yTBSOmn+VCa7BN5jD71r38zajBcb
         4jELA3hlU3mlzNbwnPBEBXZeMTqTk2ysWKRp3GdQMQNrZJOX1K5uuYIE/YEYP5LkSWz6
         gmVg==
X-Gm-Message-State: AOAM533kZwFsJKWTZEVx7pXGaib65SULbnPUCqru5Tx6W2z1RvfXOdaX
        nkytxw9JKfBvwimTRxqibBqjF/TM/okq50v8omEioV37/KuwTbWwSrc8A8/SGVEH1NvdY9/VgQ7
        tPqYwbHLGbNPKYAWk6AmDIDEA9bgatA4wCva9xw==
X-Received: by 2002:aa7:d84b:: with SMTP id f11mr2762945eds.149.1618476256233;
        Thu, 15 Apr 2021 01:44:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZkslZUZjN5xuGAWGmBMeXcV0Db6KIDdfQofIUygJyUe1yu2Eif2ogeojONnfAUrCCjyD9tQ==
X-Received: by 2002:aa7:d84b:: with SMTP id f11mr2762931eds.149.1618476256083;
        Thu, 15 Apr 2021 01:44:16 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id k26sm1419360ejk.29.2021.04.15.01.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 01:44:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v2 2/3] mmc: sdhci-s3c: correct kerneldoc of sdhci_s3c_drv_data
Date:   Thu, 15 Apr 2021 10:44:11 +0200
Message-Id: <20210415084412.51125-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
References: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Correct the name of sdhci_s3c_drv_data structure in kerneldoc:

  drivers/mmc/host/sdhci-s3c.c:143: warning:
    expecting prototype for struct sdhci_s3c_driver_data. Prototype was for struct sdhci_s3c_drv_data instead

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. None
---
 drivers/mmc/host/sdhci-s3c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 8e1dca625620..a07a8f011741 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -130,7 +130,7 @@ struct sdhci_s3c {
 };
 
 /**
- * struct sdhci_s3c_driver_data - S3C SDHCI platform specific driver data
+ * struct sdhci_s3c_drv_data - S3C SDHCI platform specific driver data
  * @sdhci_quirks: sdhci host specific quirks.
  * @no_divider: no or non-standard internal clock divider.
  *
-- 
2.25.1

