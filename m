Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C4FC433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Apr 2022 22:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381300AbiD2WMV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Apr 2022 18:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381284AbiD2WMT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Apr 2022 18:12:19 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CF3DC9A2
        for <linux-mmc@vger.kernel.org>; Fri, 29 Apr 2022 15:08:56 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k14so7517983pga.0
        for <linux-mmc@vger.kernel.org>; Fri, 29 Apr 2022 15:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fn2AqSrDktu9onw+xJqRpycXOFpgfT+y+eBhGZX0B1o=;
        b=IG945+9+87GJjDBoc4SK4z5/C0j/QS5H4YBj4P1yoXFP0zgLq/lZzMNjdYh5V4iqxV
         YKSRRRaShZc1KM7plw6uKeakwfRPBgK4itHafkGR6kqLPKJQXypuw3bn/S0VeyycjrAU
         vm2KkWl1+12CqUSEWn6ZC0s1zCNhBfB/YsFfCw9s33n1b0C9PohMLRP+rQd+OGHbqHex
         rju/o7My9FjLJyeKKE4osyZIyFfNazqUWF2nW2j8Cuv121KbSykKVs609IQIyWsVeHkL
         BOpI5qMmiDMlTkQz81Ulhissqg+aeCOXC5C9P3IZOG3iHPM7G+rB5kUZVNgTz+zMGS9W
         TsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fn2AqSrDktu9onw+xJqRpycXOFpgfT+y+eBhGZX0B1o=;
        b=qtZX4/7W5ahTpZ81BOX5+bwj7ZJXh+uFazgeZe8gZ5bPrFG8SBC9nSKABNqzBmLcTT
         ZtZEJR6LkgMDlYz77Sv/qkFeKTCaZeBlkQtXT8cWYFmaGcl5KMvWAlnpsbO7I5IE8Y4H
         1jeQtCwJw0E5jaZqiAlpUGVCfmU0Wyh0YgsZr+BaOxhJWkyuNXXKJC2rZ+3Nep0oGiYQ
         YOWAmV5hAFwHw7FsfqeEmlz6HEq5N6ldkSCvNTnGkrbkn7J5kx2cwVbVmVd/z+0GKH9Q
         R8iVwdOVCiXdgWTYYrWLSxGS1j09ysoSSf5SuNE9Q2jG1Qpy6ZLPLlLLtooRyJE71N79
         rU0w==
X-Gm-Message-State: AOAM531Y/cdPKzg9MmzSbg2tuz+7z+kUoMotaD1fHS+dRfi9MYlzT0c/
        TWv3B1mj7DvBoqCpfnjf3YfPry2qUIbHUw==
X-Google-Smtp-Source: ABdhPJzi6qLlidSSflnORETma01551eA6GrtpzUGwF3DC2DSxAkAeUnnYNlERW0/1Ch9Gkfe0tbO4g==
X-Received: by 2002:a63:1918:0:b0:3ab:8c08:6774 with SMTP id z24-20020a631918000000b003ab8c086774mr1052886pgl.226.1651270135669;
        Fri, 29 Apr 2022 15:08:55 -0700 (PDT)
Received: from localhost.localdomain ([223.233.64.97])
        by smtp.gmail.com with ESMTPSA id n21-20020aa78a55000000b0050dc76281c2sm170020pfa.156.2022.04.29.15.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 15:08:55 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-mmc@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, robh@kernel.org
Subject: [PATCH 2/4] mmc: host/sdhci-msm: Add SoC specific compatibles
Date:   Sat, 30 Apr 2022 03:38:31 +0530
Message-Id: <20220429220833.873672-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
References: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Since Qualcomm device-trees already use SoC specific compatibles
for describing the 'sdhci-msm' nodes, it makes sense to add the support
for the same in the driver as well.

Keep the old deprecated compatible strings still in the driver,
to ensure backward compatibility with older device-trees.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/mmc/host/sdhci-msm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 50c71e0ba5e4..2de8d115a37a 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2434,8 +2434,31 @@ static const struct sdhci_msm_variant_info sdm845_sdhci_var = {
 };
 
 static const struct of_device_id sdhci_msm_dt_match[] = {
+	 /* Following two entries are deprecated (kept only for backward compatibility) */
 	{.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
 	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
+	/* Add entries for sdcc versions less than 5.0 here */
+	{.compatible = "qcom,apq8084-sdhci", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,msm8226-sdhci", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,msm8916-sdhci", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,msm8953-sdhci", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,msm8974-sdhci", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,msm8992-sdhci", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,msm8994-sdhci", .data = &sdhci_msm_mci_var},
+	{.compatible = "qcom,msm8996-sdhci", .data = &sdhci_msm_mci_var},
+	/*
+	 * Add entries for sdcc version 5.0 here. For SDCC version 5.0.0,
+	 * MCI registers are removed from SDCC interface and some registers
+	 * are moved to HC.
+	 */
+	{.compatible = "qcom,qcs404-sdhci", .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sdx55-sdhci",  .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sdm630-sdhci", .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sm6125-sdhci", .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sm6350-sdhci", .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sm8250-sdhci", .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sc7280-sdhci", .data = &sdhci_msm_v5_var},
+	/* Add entries where soc specific handling is required, here */
 	{.compatible = "qcom,sdm845-sdhci", .data = &sdm845_sdhci_var},
 	{.compatible = "qcom,sc7180-sdhci", .data = &sdm845_sdhci_var},
 	{},
-- 
2.35.1

