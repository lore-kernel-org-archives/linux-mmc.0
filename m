Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8A8C636F9
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 15:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiLBP1G (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Dec 2022 10:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiLBP04 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2022 10:26:56 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735A5D03A9;
        Fri,  2 Dec 2022 07:26:55 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id v8so6950737edi.3;
        Fri, 02 Dec 2022 07:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCJXfYzTI2dyLGbCy2BhHsRfkj/QAMNTLWYIlL2SJZ0=;
        b=hSRF5F3oUfAiQnRWAfNrjCkA2x0vFkvX3Xh8Xo+larZW6oE0taUlK1CsKplyHMUqvp
         0W8ksnnKDt6WQ4QEmCxSI7Ndx4rwXjpKpJyX99Qlv8nMV9WVuOwoZWRYvyN7J5d07o1/
         /GLNQHGeCUdCgrsY+5fwuJ5ocfyZrSwKDaJGJSEZc4sLB/7OKUeWODwerIXmXNexgnnu
         T67JP1TywcNmjJa3JWfjmMA2c7xqdjwyqhMD2jYZalCrdyK3JOl+uJpexc9zSdhRhHup
         venRjrPshSEPRlOWYuE+g/FOB9R/Sxjo1kzyUQXVP7ysMcOWRhZU9Ni2xBYMUGyR+70c
         K96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCJXfYzTI2dyLGbCy2BhHsRfkj/QAMNTLWYIlL2SJZ0=;
        b=d0towj+2aByh5gPg82mBOkFztV3aJ6brXToqTcaOQ6yQzqQOYnLPyJ5HfINYVrXYNf
         r/EbsvdtxR+oFT0Crc63QHQ8f7nWBRDq/DQewxr7JFrCxukG1ad0MOysG2DBeIT75bxr
         JamSXsBSdhau5cCoYp7s3aYdcrgxWYm9eJLO0S8rkMdgfVSQUg7KCiFtCUxC1BPjPLdK
         KXGXhG61v+R0tsTnHYLls+L5iPFp5Rr7WFtTUx+i/3SmKr+hg4QHmLlu1jgjZye96NyD
         gPIDi5NOMxFaG0cs2mOOYdT6M5hryoL9dKNbPE7JtXobSrd/yT1iQ+Ja8FT28rPgr9iR
         zxRA==
X-Gm-Message-State: ANoB5pktzjKJ63iU68CtysmezY64TNL8ywYiftrDaqJKwZQGly6Fnhkp
        ECfFwaWQQr+eOSHpEeSwgfg=
X-Google-Smtp-Source: AA0mqf6fGwGlYMveTxFx5oIgPKUlZyWXB66dY7F1HfxGeQpDVnjRaFtUuebSZkAkbRc4dY2dNZBh4w==
X-Received: by 2002:a50:fc10:0:b0:464:2afe:ae18 with SMTP id i16-20020a50fc10000000b004642afeae18mr66132715edr.183.1669994813911;
        Fri, 02 Dec 2022 07:26:53 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090676c200b00770812e2394sm3104389ejn.160.2022.12.02.07.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 07:26:53 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: [PATCH v12 4/6] mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
Date:   Fri,  2 Dec 2022 16:26:42 +0100
Message-Id: <20221202152644.29450-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221202152644.29450-1-thierry.reding@gmail.com>
References: <20221202152644.29450-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Prathamesh Shete <pshete@nvidia.com>

Create new SoC data structure for Tegra234 platforms. Additional
features, tap value configurations are added/updated for Tegra234
platform hence separate Tegra194 and Tegra234 SoC data.

Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index afa9cbf9cb6f..f3f5a4abcafb 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1553,7 +1553,21 @@ static const struct sdhci_tegra_soc_data soc_data_tegra194 = {
 	.max_tap_delay = 139,
 };
 
+static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
+	.pdata = &sdhci_tegra186_pdata,
+	.dma_mask = DMA_BIT_MASK(39),
+	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
+		    NVQUIRK_HAS_PADCALIB |
+		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
+		    NVQUIRK_ENABLE_SDR50 |
+		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_HAS_TMCLK,
+	.min_tap_delay = 95,
+	.max_tap_delay = 111,
+};
+
 static const struct of_device_id sdhci_tegra_dt_match[] = {
+	{ .compatible = "nvidia,tegra234-sdhci", .data = &soc_data_tegra234 },
 	{ .compatible = "nvidia,tegra194-sdhci", .data = &soc_data_tegra194 },
 	{ .compatible = "nvidia,tegra186-sdhci", .data = &soc_data_tegra186 },
 	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
-- 
2.38.1

