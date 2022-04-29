Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4242CC433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Apr 2022 22:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381315AbiD2WM0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Apr 2022 18:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381314AbiD2WMY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Apr 2022 18:12:24 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC02DC9AF
        for <linux-mmc@vger.kernel.org>; Fri, 29 Apr 2022 15:09:04 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso3038617pjb.5
        for <linux-mmc@vger.kernel.org>; Fri, 29 Apr 2022 15:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N/QIllet2sO5ytIOTpz7N/MbZoymNASzVzoHgwQd9ds=;
        b=WBnS6Imed8MhrDDQe17uOQPPjeD98ZW536sowUSPN2g8mkV7OJudTNICWQL0VoJgyF
         5VGtjG29qgJkdlt34PTo8v2bQnfqXV/ir/a2n51WLugm5Cv3IfZAS8I2pvoueQl9kzu5
         ZFvepRX7DJbxL3yWZKHbCJuc11GX5SFJZjdLNxDSY6Ml/+EONCpmOh3AtY/O272JVG0W
         ylXceMzSa0K6grbwu1kVnV+0vPaqNGmilY0W4YihHPtvxWAxLINBllEh2VekD8MJsL7r
         jAuJ3AFwdoRt/buFmtR+95tcKwcTz2ViaZ9MDYVr3ah7E9yx12lB8ckZ2Gb6HdJ4jvUM
         xzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N/QIllet2sO5ytIOTpz7N/MbZoymNASzVzoHgwQd9ds=;
        b=XKzwspjYl7rMhiSx1FyYEJHWfDVXv50zLLRflKCiJtJ2kUIXuBmygTlxCPWRICZs6s
         Lf3anZURqPU+/LmkXjbruij0sYqYNVpUSK9BE1w/7m9IffKYujPUGWDFEM39oTYnbm/C
         ZbwGBf8n71BxmsUFQ8nRBbJYJ1TyEw62QXaiRg2rAX4kieYus2IJFRW2nYeRR3f1LRJD
         qKdMzpDHcPA9ynBhagNI4AYy/+IdQ8lq4+BbWBKIWpwBseN3nmsahKE2QgKTwzSdyRlF
         cPp7O/A1N/nRicQAG4HKYgZNwKeP8FUv/0O24AhlMM5HyKMu9wch4WJVBeiET+1z8B5G
         KR8A==
X-Gm-Message-State: AOAM532O6XkpwJBAaoRCyhEpUcFknk7FClpsZbd40knT6wFehdj9o0UJ
        +rB9H9G42ti2xj+j12KHy5tQB05RGxsESw==
X-Google-Smtp-Source: ABdhPJx4L3grTpOzugZga8zMWulJpZrYlaCRwuLFI5+l3xNV5xWp+cHtfQ2McKzBWNGazJXnmOc0BQ==
X-Received: by 2002:a17:903:4093:b0:15c:e5eb:9545 with SMTP id z19-20020a170903409300b0015ce5eb9545mr1416763plc.62.1651270144084;
        Fri, 29 Apr 2022 15:09:04 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id n21-20020aa78a55000000b0050dc76281c2sm170020pfa.156.2022.04.29.15.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:09:03 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-mmc@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, robh@kernel.org
Subject: [PATCH 4/4] mmc: host/sdhci-msm: Add compatible string check for sm8150
Date:   Sat, 30 Apr 2022 03:38:33 +0530
Message-Id: <20220429220833.873672-5-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
References: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add sm8150 SoC specific compatible string check inside qcom
'sdhci-msm' controller driver.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 2de8d115a37a..fd8b4a9079ab 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2456,6 +2456,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
 	{.compatible = "qcom,sdm630-sdhci", .data = &sdhci_msm_v5_var},
 	{.compatible = "qcom,sm6125-sdhci", .data = &sdhci_msm_v5_var},
 	{.compatible = "qcom,sm6350-sdhci", .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sm8150-sdhci", .data = &sdhci_msm_v5_var},
 	{.compatible = "qcom,sm8250-sdhci", .data = &sdhci_msm_v5_var},
 	{.compatible = "qcom,sc7280-sdhci", .data = &sdhci_msm_v5_var},
 	/* Add entries where soc specific handling is required, here */
-- 
2.35.1

