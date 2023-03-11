Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDD7C6FD1F
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 11:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCKLMs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 06:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCKLMr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 06:12:47 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4FD138473
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 03:12:42 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id ec29so30726676edb.6
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 03:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OtoSadEYa8Ss/aLG2RB4W5+eHjvVyH51L/bxtSrvPMA=;
        b=Nuwpg9/ECvGlnZViVbgeVL56DNY24+RGeMn76jRHFMkBgxNCWgtU1mkNx+kP2kSD2F
         bsVkGDEyG/e/e4kFaB4ukrBLKSquN3fGXh5Sb7E64ED8miiw99LeYeRhBlZvg6QofQm9
         qKhoiyPLDgP7E2YhPV4YJ3gRplSJViLvnEfFMZ2klmykaYqsbLi5a0MYk3o8MefX0ed3
         mBFaa6dybsxiLvuMKcm4vQ5WXr45KQaK39WazXdxnEFDVFkNx4uuq5VhK7Zj8xQcm4KG
         XUsw0SyosEFOdw2W817tmi8fvGCf9WC7SWlHz5QOAIKanfl6AJRCHp4pk+8k3n6t56yn
         k0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtoSadEYa8Ss/aLG2RB4W5+eHjvVyH51L/bxtSrvPMA=;
        b=qLtduVY5lwfZ8aPBUusgZYS8SGtoMIWGS8+qPcOJmHJXwVsScaXPzCFqAheSSiG7nh
         MEMAyHtmihBsUDLe8hJAayJkcrExuylli46sgY8VbtroWtSvFSYywcwV+JvnZ2Ig07dG
         OzGGdh3NS8V7wSXNrBq+wOvbgWdZkIzS+ZdxQHB9himdmyFxyxEIYsdTsbm0+db5syoJ
         rB6mrbQ8YVv1icAOM4ydaFB/TMx9LgOy9FMa60YwzFtIHbLpzVI0DyllZIogbmQtKHEi
         D+OEnxyvI7fdLNKrIllepDeTDPZwuhVzg6dj7E7CkjoWwFPFvQF/zCfaskKmHHlYO2FS
         xoVw==
X-Gm-Message-State: AO0yUKXgsXgsSW4Qe0YyzosgFyPft2csS+LI1YEpdPJ46sHGsEvYN/Lw
        uUs9j+vJ1KJaHuTibVGDnxHXbg==
X-Google-Smtp-Source: AK7set8B/eLT6NjOMWrhe2BBeVH13qrTXez8NyanZsqG0kQ35nJOv6OOlb3cez7x9QZOJsYmos/qKQ==
X-Received: by 2002:a05:6402:1854:b0:4ac:b614:dd00 with SMTP id v20-20020a056402185400b004acb614dd00mr23528925edy.30.1678533160796;
        Sat, 11 Mar 2023 03:12:40 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id a70-20020a509ecc000000b004c09f0ba24dsm1043803edf.48.2023.03.11.03.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:12:40 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] mmc: sdhci: add static to !OF stub
Date:   Sat, 11 Mar 2023 12:12:38 +0100
Message-Id: <20230311111238.251000-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The sdhci_get_compatibility() is not used outside of the unit:

  drivers/mmc/host/sdhci-pltfm.c:76:6: error: no previous prototype for ‘sdhci_get_compatibility’ [-Werror=missing-prototypes]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mmc/host/sdhci-pltfm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 328b132bbe57..245e56324dff 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -73,7 +73,7 @@ static void sdhci_get_compatibility(struct platform_device *pdev)
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 }
 #else
-void sdhci_get_compatibility(struct platform_device *pdev) {}
+static void sdhci_get_compatibility(struct platform_device *pdev) {}
 #endif /* CONFIG_OF */
 
 void sdhci_get_property(struct platform_device *pdev)
-- 
2.34.1

