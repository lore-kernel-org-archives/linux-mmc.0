Return-Path: <SRS0=bPLn=CF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699ACC433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 15:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3852E20707
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 15:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HcOa46Bg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgH0PlS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgH0PlS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2020 11:41:18 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F23C061232
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2020 08:41:18 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w186so3636584pgb.8
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2020 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAAg1wT74J1TPJUNvinItqB9ZDfNPLN786c1MlpJyJo=;
        b=HcOa46BgqN+2jqdrRcLqoGUNKCWiiC56FiwTZkCLIJQpGgLTSezUDkrs6g3rH3dvkK
         baaNuoyYgOtHoDWGgn9cwl83bP/Y7T+B2ksAhCsEj7XV98ZLGFv7t6Vailve/m+yykIn
         y/hJA/+Drd7ckQF7iuIEATvkgCIyNClTwOeGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAAg1wT74J1TPJUNvinItqB9ZDfNPLN786c1MlpJyJo=;
        b=Az1sFqg9hZun4WHIGkDutijeDBBKix8N6veQkf4eLX+Ady8dwPRjxkxZBkrLuBKS+R
         2Kx2XfICuiMAD82tNmvZNEH+Om5GUEJZBWi8COnPqxp1P0Pemcjv8EdukfhUe5aU4Rfs
         4cJaKJrz3m0fgPLg6ZnSi5Deij4z8VEdV+yO9mCH/Dz6knxRxpKczoaRpxEatRHlBeos
         ZP/afV2PmKPxVyW/Etd66OjhRr/tsc3xQnbL05Af7HwFcYOa484ZFNK8AUxRFZS8NfBF
         5mm9iStxogazuczlIVlF9ZebQwo5LJWeXRaZhURtK6nbjPC4oJAgxgr96hqMxpdWLkM9
         OOKg==
X-Gm-Message-State: AOAM532SYRVogNENTBaEixfhrBQ0Jg8mcoPH9RHbiXkhN554MdAGxqdb
        eBa3I2Yp5uyzjXnErTC2JovShA==
X-Google-Smtp-Source: ABdhPJxt8TMgiAOegn4WkDsoSiNkpDn4sIcrWZ/XR6jPZbmFJWUQipH2JkHFxL3Vln+YLYuqX3HtXw==
X-Received: by 2002:a63:7018:: with SMTP id l24mr14452680pgc.55.1598542877503;
        Thu, 27 Aug 2020 08:41:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id q34sm2642066pgl.28.2020.08.27.08.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:41:17 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     vbadigan@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH] mmc: sdhci-msm: We need to restore_dll_config for sc7180
Date:   Thu, 27 Aug 2020 08:41:05 -0700
Message-Id: <20200827084102.1.I7a5f56b411071eeecae84b7e33981d39170ccf2a@changeid>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Although sc7180 is supposed to have a hardware fix that means that we
don't have to restore the DLL config like we did with sdm845,
apparently the hardware fix doesn't work in all cases.  Until it's
understood under exactly which cases we the hardware fix malfunctions,
let's go back to restoring the DLL config whenever we do runtime
resume.  This is safe and gets things working again.

NOTE: we don't need to introduce a whole new "struct
sdhci_msm_variant_info" for sc7180 since it would be exactly the same
as the sdm845 one.  We'll just refer to that one.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/host/sdhci-msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index b7e47107a31a..a88db3f376bd 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2148,6 +2148,7 @@ static const struct sdhci_msm_variant_info sm8250_sdhci_var = {
 static const struct of_device_id sdhci_msm_dt_match[] = {
 	{.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
 	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
+	{.compatible = "qcom,sc7180-sdhci", .data = &sdm845_sdhci_var},
 	{.compatible = "qcom,sdm845-sdhci", .data = &sdm845_sdhci_var},
 	{.compatible = "qcom,sm8250-sdhci", .data = &sm8250_sdhci_var},
 	{},
-- 
2.28.0.297.g1956fa8f8d-goog

