Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FB1C5519F
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 17:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 717EC22227
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 17:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UgyeXiIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgKLRgn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Nov 2020 12:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgKLRgn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Nov 2020 12:36:43 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D07C0613D4
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2020 09:36:41 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id a9so8625049lfh.2
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2020 09:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y2M/ICtrBydW1DMfoJDJlTMVxPe12uexJ4BgRTrbtQg=;
        b=UgyeXiIaLyilt3N0scimbuWzuGtA0nc+gH8lbtx85ICrB+LpLUvHMDabOId8pIlKCK
         S0FxifQ3ZRr/VYR5RKYsRCmENNmT6yrCLZkA82/54mAFwyr+j//XRW7iaMUCjgQaok8E
         c9hvr6dvjufD5aGbx8rh3Ia07weANipc5sQ+eRCSdpn0Gc+D1ajqTVbN5J+Ls9pA2+Dn
         996xKNDdbqAeaQvAEWrGQ7e5VrUmN84lac4Ab54UGwbq000cJ5RxDG90619BJVD2HDwC
         jjTmuPiEtDOEtEYXF3pljhhpOH2c7mHORNzrkBYp4CCqTUMJYSlXPwiHu1HiFhQ8A0Hw
         NZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y2M/ICtrBydW1DMfoJDJlTMVxPe12uexJ4BgRTrbtQg=;
        b=VRDe1d9OyazV+0qHgY0tKvnkiNMLtaep0nFQVf/NYTaB1uVzPN+vOI4zCAINrj3qIa
         ubSkSQJeDIzWDgFpkbVgdw+nxefo+Ci1pi7iMAwv0dsSxhsGIAqMMwh79QeX73KxRVgH
         BUsV9+n6tQ6A/KUwcQ76+rZiSQiZMgt6wfRBBDijtjuKhJ37GNAKCjg7C2Nv/jD8VXCn
         p9Dvkd2/21kpUs5RIoUfaVx99uLfGcE8lqHgVWGmmXkSyuG3dmTO70FciWhb4eVQ/+C9
         F0hqcpQ/IiP5IlnAlS0k5+FdG/7VBEVMRIRNk2br5crtRX8g5gI4aopiIQLOfxhU0TUp
         2psQ==
X-Gm-Message-State: AOAM533RHga5ybKfIWjLq87lPHqUhFkeqKOg2ktKSxOZAtIWzZe0aXRg
        kY67VrRyUlmT2m7ff8Dhs9TgCg==
X-Google-Smtp-Source: ABdhPJxYaPOUz/UWCYyRd7zTRFEqF8uSJ6godxRwnNXypkXHAAgUjSHU9MaJU0VmIbQ0wBY457LrZw==
X-Received: by 2002:a19:915c:: with SMTP id y28mr148928lfj.173.1605202600066;
        Thu, 12 Nov 2020 09:36:40 -0800 (PST)
Received: from eriador.lumag.spb.ru ([188.162.65.115])
        by smtp.gmail.com with ESMTPSA id a16sm513488lfg.16.2020.11.12.09.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 09:36:39 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Subject: [PATCH v2] mmc: sdhci-msm: detect if tassadar_dll is used by using core version
Date:   Thu, 12 Nov 2020 20:36:36 +0300
Message-Id: <20201112173636.360186-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Detect if tassadar_dll is required by using core version rather than
just specifying it in the sdhci_msm_variant_info.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 3451eb325513..9c7927b03253 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -248,7 +248,6 @@ struct sdhci_msm_variant_ops {
 struct sdhci_msm_variant_info {
 	bool mci_removed;
 	bool restore_dll_config;
-	bool uses_tassadar_dll;
 	const struct sdhci_msm_variant_ops *var_ops;
 	const struct sdhci_msm_offset *offset;
 };
@@ -2154,18 +2153,10 @@ static const struct sdhci_msm_variant_info sdm845_sdhci_var = {
 	.offset = &sdhci_msm_v5_offset,
 };
 
-static const struct sdhci_msm_variant_info sm8250_sdhci_var = {
-	.mci_removed = true,
-	.uses_tassadar_dll = true,
-	.var_ops = &v5_var_ops,
-	.offset = &sdhci_msm_v5_offset,
-};
-
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
 	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
 	{.compatible = "qcom,sdm845-sdhci", .data = &sdm845_sdhci_var},
-	{.compatible = "qcom,sm8250-sdhci", .data = &sm8250_sdhci_var},
 	{.compatible = "qcom,sc7180-sdhci", .data = &sdm845_sdhci_var},
 	{},
 };
@@ -2249,7 +2240,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	msm_host->restore_dll_config = var_info->restore_dll_config;
 	msm_host->var_ops = var_info->var_ops;
 	msm_host->offset = var_info->offset;
-	msm_host->uses_tassadar_dll = var_info->uses_tassadar_dll;
 
 	msm_offset = msm_host->offset;
 
@@ -2396,6 +2386,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	if (core_major == 1 && core_minor >= 0x49)
 		msm_host->updated_ddr_cfg = true;
 
+	if (core_major == 1 && core_minor >= 0x71)
+		msm_host->uses_tassadar_dll = true;
+
 	ret = sdhci_msm_register_vreg(msm_host);
 	if (ret)
 		goto clk_disable;
-- 
2.28.0

