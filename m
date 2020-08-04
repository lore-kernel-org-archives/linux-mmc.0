Return-Path: <SRS0=Gx1C=BO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B59C433E5
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Aug 2020 04:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B88F2177B
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Aug 2020 04:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dlh20VQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgHDE3k (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:29:40 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4366 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbgHDE3c (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Aug 2020 00:29:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f28e3fa0000>; Mon, 03 Aug 2020 21:28:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Aug 2020 21:29:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Aug 2020 21:29:31 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Aug
 2020 04:29:26 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 4 Aug 2020 04:29:26 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.167.221]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f28e4260000>; Mon, 03 Aug 2020 21:29:26 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
Subject: [PATCH v2 0/6] Fix timeout clock used by hardware data timeout
Date:   Mon, 3 Aug 2020 21:29:17 -0700
Message-ID: <1596515363-27235-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596515322; bh=REKrDQIX2fbhaB+vRDALQXRankEEOSbLXL0Gz0gOA8U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=dlh20VQUOCM+d/QvzJO693PHzaoMM86UVDWX5zSdjE1eS5A3ZznXV0XEEHqqzSAxi
         HIyqZ1HG9x66eGDYdtaLhySzepsXSjUgtsNy2gTcUPUhHqUPfrHi272NP/1VkgnwJX
         1tW8q2UmLl9eS7EJKsCGTpQsdBsZ7zl77Rd1zkC88u3wTIU+bTC5xe9VAxkLbXXUb7
         U6OpIN0xl7gVqN4dAQA0Tsin9IxUz7JeI/PoR6hlrLxkAfzcK2anMIEVA4jU6Pflym
         xj1q+zGefKHDpefXxyuKbouTL9dfXrTOIhuwDo7M0dzqc3unGQeaQb/nPJ0ulHy9EF
         I56iMqJsD0iPA==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Tegra210/Tegra186/Tegra194 has incorrectly enabled
SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK from the beginning of their support.

Tegra210 and later SDMMC hardware default uses sdmmc_legacy_tm (TMCLK)
all the time for hardware data timeout instead of SDCLK and this TMCLK
need to be kept enabled by Tegra sdmmc driver.

This series includes patches to fix this for Tegra210/Tegra186/Tegra194.

These patches need to be manually backported for 4.9, 4.14, 4.19, 5.4

Will send patches to backport separately once these patches are ack'd.

Delta between patch versions:
[v2]:	Includes minor fix
	- Patch-0006: parentheses around operand of '!'

Sowjanya Komatineni (6):
  sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra210
  sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra186
  arm64: tegra: Add missing timeout clock to Tegra210 SDMMC
  arm64: tegra: Add missing timeout clock to Tegra186 SDMMC nodes
  arm64: tegra: Add missing timeout clock to Tegra194 SDMMC nodes
  sdhci: tegra: Add missing TMCLK for data timeout

 arch/arm64/boot/dts/nvidia/tegra186.dtsi | 20 +++++++++------
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 15 ++++++-----
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 20 +++++++++------
 drivers/mmc/host/sdhci-tegra.c           | 43 ++++++++++++++++++++++++++++++--
 4 files changed, 74 insertions(+), 24 deletions(-)

-- 
2.7.4

