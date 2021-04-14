Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969B5C433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 15:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D89611EE
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Apr 2021 15:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350086AbhDNPNO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Apr 2021 11:13:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41092 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349855AbhDNPNO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Apr 2021 11:13:14 -0400
Received: from mail-ej1-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWhCF-0002IP-MC
        for linux-mmc@vger.kernel.org; Wed, 14 Apr 2021 15:12:51 +0000
Received: by mail-ej1-f70.google.com with SMTP id s7so532642ejy.6
        for <linux-mmc@vger.kernel.org>; Wed, 14 Apr 2021 08:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=COhBZ6btGRsjvqs/la8SVt6/jjZQ184vl6dkwyCMK0o=;
        b=efwOp7Ju6xMexlGUfktI0VicH49At5IM5dGEpOC74BsICbk3xxRdifgdT2rNjJT563
         VO7xxLp1B3U9SjuBkEZv4iN7v6mtDYEbxw9I+iEvWQdnSmdZmEfvpnCOfJ+uv8H/A0EW
         6tDDyqnwym+T80SVOiCzMG79YM1zI/u3DeHOqRuZy7huGyNkQAOtJY7//mU9qRp6aRN1
         fD+Lhp88DsHloNXYLuUvqA3l+ij1oxSZ/wms3sQpDasvSaPBUMjDqn+g82z7gGrMZXTe
         oR8ubq2xwqHoUFg588hQCWchMvREvFgoZP3+TF4qjgEMfUEykn5K06QrG8Ei30lQg4Ua
         MsPw==
X-Gm-Message-State: AOAM532mmazFFGE6blImR0xpdcZWQctlUspAYnC2dnsbsw/xn9QkVrPG
        myz64uVlobWIq2EvY0tYpIj0w6fkRzMEUV1HJTFE8hvOYkzqBw2/v3BE9wlhS6DATcix6prqLBd
        bTwLqbKzgafccDXy/t2lMXnmS1eD/G+fN8s0xuw==
X-Received: by 2002:a05:6402:2209:: with SMTP id cq9mr25756428edb.216.1618413171472;
        Wed, 14 Apr 2021 08:12:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoEnBh0pgDGjY81tHu+mQ80T5OJ5Q2koCwc3xWYjWc3lu5/63JtbuO1Ft0H2LIiJa4xQSZEg==
X-Received: by 2002:a05:6402:2209:: with SMTP id cq9mr25756401edb.216.1618413171329;
        Wed, 14 Apr 2021 08:12:51 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id o9sm6608022ejg.56.2021.04.14.08.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:12:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/3] mmc: sdhci-s3c: correct kerneldoc of sdhci_s3c_drv_data
Date:   Wed, 14 Apr 2021 17:12:41 +0200
Message-Id: <20210414151242.102313-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414151242.102313-1-krzysztof.kozlowski@canonical.com>
References: <20210414151242.102313-1-krzysztof.kozlowski@canonical.com>
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

