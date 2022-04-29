Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7250FC43217
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Apr 2022 22:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381296AbiD2WMV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Apr 2022 18:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381314AbiD2WMU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Apr 2022 18:12:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFBCDC9B0
        for <linux-mmc@vger.kernel.org>; Fri, 29 Apr 2022 15:09:00 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u9so7656312plf.6
        for <linux-mmc@vger.kernel.org>; Fri, 29 Apr 2022 15:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MoViicfii9p6utWoae7ElSIZUS07VgE/0ju82SmR24M=;
        b=k7HcWctvtlxZkalvnAZe0Z5u5NOvNI94X3lEw6NY1VMBjEzPyVc1CrHbTxTLGTkZrE
         SrzihBdRRB441L87xO29eXdylrY5XRz9RfsoK7jc97uXxY3sZ++1ES/lN5qsMvbYBnWT
         AZAjM5U+7f70eK/wKjZhIagWjQkF53uolMKAKWuTe80FQ/1c+z2fuDR2/bWu7hecXeKU
         48A96M2TMQcjDl5drYDR5a14TtAN0oP8Pwmri/Ue5JxDhXNIezxWgdhILbMt5c9SIG6q
         jTnyMCuYWg6yB4XKGsAyxnaeCTepcpz0EDLZrc0TwQOWbk2qWhSaiZIcli85i4P5S1MV
         9iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MoViicfii9p6utWoae7ElSIZUS07VgE/0ju82SmR24M=;
        b=aiP4tSU5IMWS1IMYy6bTHzVzkI2WPFHREoQf6oSISO0dWzA465yir9+dKRWetewqL4
         MUFOryKBVWHe4Pj5ecLgGeqCMfJfNw3ZH8gifzzIla1mj5Nr+tWcvI96xAuqZVXeJmEQ
         1jMhTdAVqoQfKzvk4Z0z7se8lAgdnH5VQuJjB8DOUAMtbr9cBr24mCM5EOrOekLPI1nn
         UpOYwQZJiE7Mo/bmm2xwFVpgZvp8VeNDMZOh0CRPI3Rvgr5bgm25hk6cxQcbVJMekJpm
         cIPXQh9qOZ7+6WBAFhngWZ/VGj6HKnQutHCjUlqTWnWOOJ55GZq9LmKlyq6z5LxK+SVd
         um6w==
X-Gm-Message-State: AOAM531Ztoxv6Pa6K2eyqtX8uVEYTBPNU+c39h+b9rqVfAnlWNIn5KLI
        OdahFJFChUdZtsU1r+RP9fkLR8avFBjYBg==
X-Google-Smtp-Source: ABdhPJxZ+EEi2RSJizGrNsZtppHOgq1GzCFOC9SGroJ2295J2M1o09ttfhXrciO0rwIXevRIfOUwBA==
X-Received: by 2002:a17:902:e743:b0:15e:8ddd:c7bd with SMTP id p3-20020a170902e74300b0015e8dddc7bdmr126045plf.128.1651270139817;
        Fri, 29 Apr 2022 15:08:59 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id n21-20020aa78a55000000b0050dc76281c2sm170020pfa.156.2022.04.29.15.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:08:59 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-mmc@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, robh@kernel.org
Subject: [PATCH 3/4] dt-bindings: mmc: sdhci-msm: Add compatible string for sm8150
Date:   Sat, 30 Apr 2022 03:38:32 +0530
Message-Id: <20220429220833.873672-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
References: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add sm8150 SoC specific compatible strings for qcom-sdhci
controller.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index c33f173e3b6c..4eb213b3e551 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -35,6 +35,7 @@ properties:
               - qcom,sdx55-sdhci
               - qcom,sm6125-sdhci
               - qcom,sm6350-sdhci
+              - qcom,sm8150-sdhci
               - qcom,sm8250-sdhci
           - enum:
               - qcom,sdhci-msm-v4 # for sdcc versions less than 5.0
-- 
2.35.1

