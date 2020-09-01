Return-Path: <SRS0=T3o1=CK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600F2C433E6
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 16:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B6E2078B
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Sep 2020 16:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KhhAk5gh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbgIAQZS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:25:18 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12001 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbgIAQZR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Sep 2020 12:25:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4e75bd0000>; Tue, 01 Sep 2020 09:24:29 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 09:25:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 01 Sep 2020 09:25:15 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 1 Sep
 2020 16:25:14 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 1 Sep 2020 16:25:14 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.173.243]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f4e75e90002>; Tue, 01 Sep 2020 09:25:14 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v2 4.19 0/7] Fix timeout clock used by hardware data timeout
Date:   Tue, 1 Sep 2020 09:24:43 -0700
Message-ID: <1598977490-1826-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598977469; bh=Cca7bmR9nIFI8RrnEW7AxQ+a0Yt3pOge7xAtLBFuFro=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=KhhAk5ghNn9CVbz2nDtZ/upYcVOlEq/7WUvwHzozImSaYVFuyjQIaJaDUJZsDhWLN
         KcH+q5CaSBA+ezDYjtoQqMJVHEIrTmo9tqqy/+hGolz+jeGBdEsQAiQdCPUPQ+qlZI
         e8vVmlzPe7Moaou5MswgqOT+1x7RdP5ttkzMryQyUBFJ0jkTO3spOkLMe/6EWXhjBL
         jWVKNKAezvPxsiNgBqMxM/Mw9SuYMfcUBCeoLn1vXSIc4JE/A2LQ8LgXdNnMHdG4JP
         pTf7ujxwcM557G+JvJbvhNFYbvXe79CdwDtgCO7uUvPh9RTqta4TjF27dSFWJbTryT
         uPZnV1XSlwFCw==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Tegra210/Tegra186/Tegra194 has incorrectly enabled
SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK from the beginning of their support.

Tegra210 and later SDMMC hardware default uses sdmmc_legacy_tm (TMCLK)
all the time for hardware data timeout instead of SDCLK and this TMCLK
need to be kept enabled by Tegra sdmmc driver.

This series includes manual backport patches to fix this for stable
kernel #4.19

Note:
Patch series v2 is same as v1 except updated commit message in all patches
properly for backporting.

Sowjanya Komatineni (7):
  sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra210
  sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra186
  dt-bindings: mmc: tegra: Add tmclk for Tegra210 and Tegra186
  arm64: tegra: Add missing timeout clock to Tegra210 SDMMC
  arm64: tegra: Add missing timeout clock to Tegra186 SDMMC nodes
  arm64: tegra: Add missing timeout clock to Tegra194 SDMMC nodes
  sdhci: tegra: Add missing TMCLK for data timeout

 .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 23 +++++++++-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           | 20 +++++----
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           | 15 ++++---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 28 ++++++------
 drivers/mmc/host/sdhci-tegra.c                     | 50 +++++++++++++++++++++-
 5 files changed, 106 insertions(+), 30 deletions(-)

-- 
2.7.4

