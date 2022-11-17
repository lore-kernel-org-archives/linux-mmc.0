Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C82FC43219
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Nov 2022 18:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbiKQS1j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiKQS1d (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2022 13:27:33 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6D785161;
        Thu, 17 Nov 2022 10:27:29 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id i10so7225000ejg.6;
        Thu, 17 Nov 2022 10:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTb92251x+DtmUTSDWp2pFXRoCwhroQ3ngkruzpCgHo=;
        b=Nq6a4mCYFkvy9TVj0yPEuVKgBtpPb4BpXCbf8WERLSgME/hu4b8Lx28MSDcZLhXlr9
         833t52p/MuIKDAb5zBhNK4BqMqQ/4xkYocZU352vVyi4vZO9JW6k7be7rc5zfXLg/zXk
         Pj2laLyanNFuIgiQsQ3hdEN3cVuY8+ly9huqr9L0rRuTess59wIcfOgsYXsOSI5yRumO
         ox8U5GRPhobzkQEasTmiVQJpq3IeIdKVl6HghT/57hxWyCYpmyxa0zGhzm5/SU9KAOcT
         xJIeYS/SnLJWZPgaKG8nAuFxJW6LTPcNmzd2iAYC5IRLsG79VmSyhdF3jaKmuu7ui8lJ
         2gBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTb92251x+DtmUTSDWp2pFXRoCwhroQ3ngkruzpCgHo=;
        b=2f1fGRR56PWU3bGswiHzblEbEgAin/0Zc9hMblwDDb5Q9kqV0JF2Hqx3INAoWq0v3O
         KV+aa0m1QcuODXZs42KuPdFJH/Rl+Zj05iXUZGUm3G5mn5bUQTDECOjvSn/JgGI0MiAF
         Nsj24wDCHsJZR+UsR00dSYK2Urj625A7yMlviVj9OCaH3H7W0YKjPLp2dpYVgeG19p1a
         y6PRtfMgtrHzN/449DtLFDguhAnu9X41r49QJihLd0vyL56zZwx4nKEucwdRaZtXG8U9
         ZE3yPfryASPXA6OI4eoE0SVFOcF7+IFAqxP3QJyBmRMxh+eZ/1gSTLrdysVJoFn0eOEi
         SCkQ==
X-Gm-Message-State: ANoB5pn8rqhdr1EhHPyelt+bydkWwbglD8hdmM9MTpYEKiaaUGBlIdUb
        aS8ySFCc7oa9xHoLBcxWH8M=
X-Google-Smtp-Source: AA0mqf7xKeIvxXK3uLjE4xhHyQsblirdA5TbHaXa0Ef6XHK7gJHgewbrJn4bcOfQElKreFq5+S81ow==
X-Received: by 2002:a17:906:edce:b0:7ad:dd43:5d18 with SMTP id sb14-20020a170906edce00b007addd435d18mr3003227ejb.389.1668709648348;
        Thu, 17 Nov 2022 10:27:28 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i17-20020a1709061e5100b007addcbd402esm669232ejj.215.2022.11.17.10.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:27:27 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v11 4/6] mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
Date:   Thu, 17 Nov 2022 19:27:18 +0100
Message-Id: <20221117182720.2290761-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117182720.2290761-1-thierry.reding@gmail.com>
References: <20221117182720.2290761-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Prathamesh Shete <pshete@nvidia.com>

Create new SoC data structure for Tegra234 platforms.
Additional features, tap value configurations are added/
updated for Tegra234 platform hence separate Tegra194 and
Tegra234 SoC data.

Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index e2a8488d4fa9..bbe2bc238171 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1558,7 +1558,21 @@ static const struct sdhci_tegra_soc_data soc_data_tegra194 = {
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

