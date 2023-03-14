Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C935C05027
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Mar 2023 20:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjCNUji (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Mar 2023 16:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjCNUj3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Mar 2023 16:39:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BC437704
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 13:39:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h8so23435775ede.8
        for <linux-mmc@vger.kernel.org>; Tue, 14 Mar 2023 13:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678826344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gAVzGC5admqQWUbt0SvNwXRFrLei9CHekAmYZ2wD2pE=;
        b=iEGaDl55qfyDycFXah/KYYvnNFfJlhE8QFNkKfpu+UkuOIJFyUAr/jtuFroupg2M0d
         5qZj+7snyHp7ocmSIRrghLGPxxS2RTBF6VaxOY286yXYU15gNWOrTv2hGrhl0ccUfCOE
         N4wWiN5NIF+aHTNM6/9zwDQrnlOdKLya9+rScVcdNLd4KdpEoqU2qjp2R+USlRqrMyKT
         rsib9f6bfzGEz7logItZ5Ex9QjD6Zbbp0BQbQYrqJw2zx5D93eqHp/emSwumSO12bXkn
         TdCsYjCxXB0qhEluMT78xtIjyOGVZswdIBGPXQ43qEnxPTbO/Cyg/qtCpIrpH9lpYCaM
         Pitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678826344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAVzGC5admqQWUbt0SvNwXRFrLei9CHekAmYZ2wD2pE=;
        b=SNQFldUkQzGnjInidg207DmexSCXJUfVdoBPP39UlR8GJBc/2lwYqg+N6GWT6Dx71G
         ILiO9hg5gpmemTeB+kpYdM7W2EHyOQuY0DiGFqytUgk3IvAoHogzHYfSE/bWLNTpmnHH
         mFdnMuRLRxAIRPV8rsTr/FqEOO3a/HewESfOBCgtEAxXXRpcYYrOAwPE+2StbPsMQZB1
         5DjoPDrY9kC/E8NsjRrZo3FaI0k1s2FRPIuB2TAOdSAcz2iQYQIa07Y3MidIiarERa3C
         3dfuSDQoPvlIkV4gxpn6dnREK/NOGUWfOvb233R3uI/Z4tKJrzp/W2lc6Tat1d+QySl6
         LOkw==
X-Gm-Message-State: AO0yUKXJunuF8tAxF0OJYq3jI3IxZFWE57ujud0CQdmjVW0uHsHkLKhg
        5wVegwq7+3YCcjU6fUYc8BJdWL1oi7ZvWkvvHEs=
X-Google-Smtp-Source: AK7set/1OFHFkb6DeEBisNYiLT9XArde2HBH9EOoHkExhOFJLozQUwbO2W6CA+VjNaQYQNt6+Kqkow==
X-Received: by 2002:a17:906:e093:b0:8b1:7e88:c20f with SMTP id gh19-20020a170906e09300b008b17e88c20fmr4486277ejb.15.1678826344267;
        Tue, 14 Mar 2023 13:39:04 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:642b:87c2:1efc:c8af])
        by smtp.gmail.com with ESMTPSA id k18-20020a1709060cb200b008d68d018153sm1579768ejh.23.2023.03.14.13.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:39:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] mmc: sdhci: drop useless sdhci_get_compatibility() !OF stub
Date:   Tue, 14 Mar 2023 21:39:01 +0100
Message-Id: <20230314203901.20803-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The sdhci_get_compatibility() uses OF functions which have stubs for !OF
case, thus entire CONFIG_OF ifdef can be dropped.  This also fixes
!CONFIG_OF W=1 warning:

  drivers/mmc/host/sdhci-pltfm.c:76:6: error: no previous prototype for ‘sdhci_get_compatibility’ [-Werror=missing-prototypes]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Drop the stub (Ulf)
---
 drivers/mmc/host/sdhci-pltfm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 328b132bbe57..673e750a8490 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -54,7 +54,6 @@ static bool sdhci_wp_inverted(struct device *dev)
 #endif /* CONFIG_PPC */
 }
 
-#ifdef CONFIG_OF
 static void sdhci_get_compatibility(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
@@ -72,9 +71,6 @@ static void sdhci_get_compatibility(struct platform_device *pdev)
 	    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 }
-#else
-void sdhci_get_compatibility(struct platform_device *pdev) {}
-#endif /* CONFIG_OF */
 
 void sdhci_get_property(struct platform_device *pdev)
 {
-- 
2.34.1

