Return-Path: <SRS0=IgIp=CG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B41C2BB4D
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 22:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025392137B
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 22:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PP/TFib0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgH1W0M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:26:12 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4816 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbgH1WZ5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2020 18:25:57 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4983f40001>; Fri, 28 Aug 2020 15:23:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 28 Aug 2020 15:25:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 28 Aug 2020 15:25:52 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 22:25:49 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 28 Aug 2020 22:25:49 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.174.186]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f49846c0001>; Fri, 28 Aug 2020 15:25:49 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 4.19 2/7] sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra186
Date:   Fri, 28 Aug 2020 15:25:12 -0700
Message-ID: <1598653517-13658-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598653517-13658-1-git-send-email-skomatineni@nvidia.com>
References: <1598653517-13658-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598653429; bh=lT7YcGmL3IhY8bIt314LfvWDDMFXdYJrD7HRj0ViZgg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=PP/TFib0vdYqKdhIDbbr+VB5ZgufCEliabi/q+c5uWs5gBCSwaiHDXOcrcG2HHGpu
         3yEhU4qp0nQum+baJfTCur3Bbi+4TF6OWv0zLWdWJtABg+Hj3oEPxV6H4qsQToMLyo
         mo0ndGG5kR/Ps6yNN72qmbwwxN8a7ZdvJRJV/fIg/WJigmbHLd79Z7M9oFoNgAY2xz
         yvWGPN4gmhhtzbz16UccvGfS66ngOFFjgv4yLQGtnh8za9RvISbL4+/sB4oPuHuYA8
         G/CDZIi212paMi6/u3m51u1m57AniRaDta7ydnqym8cJR7MuAUSH+1NoC9HMAwm2ag
         6HUxjdOkHlO0A==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

commit 4346b7c7941d ("mmc: tegra: Add Tegra186 support")

SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK is set for Tegra186 from the
beginning of its support in driver.

Tegra186 SDMMC hardware by default uses timeout clock (TMCLK) instead
of SDCLK and this quirk should not be set.

So, this patch remove this quirk for Tegra186.

Fixes: 4346b7c7941d ("mmc: tegra: Add Tegra186 support")
Cc: stable <stable@vger.kernel.org> # 4.19
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 731956e..5a7c032 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -437,7 +437,6 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 
 static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
-		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
 		  SDHCI_QUIRK_SINGLE_POWER_WRITE |
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
-- 
2.7.4

