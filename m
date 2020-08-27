Return-Path: <SRS0=bPLn=CF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CA4C433EB
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 03:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A7F2080C
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 03:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Xmd3ZB8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgH0Du3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Aug 2020 23:50:29 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18228 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgH0Du3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Aug 2020 23:50:29 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f472d770000>; Wed, 26 Aug 2020 20:50:15 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 26 Aug 2020 20:50:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 26 Aug 2020 20:50:29 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 03:50:27 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 27 Aug 2020 03:50:27 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.174.186]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f472d830001>; Wed, 26 Aug 2020 20:50:27 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v6 0/7] Fix timeout clock used by hardware data timeout
Date:   Wed, 26 Aug 2020 20:49:54 -0700
Message-ID: <1598500201-5987-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598500215; bh=3oWMyh7UrR3SghOEg2r/+ZZhpDX0XPq207eBnYJe02o=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=Xmd3ZB8ZRizeh/kHUTAQ//tTDT/rdNp/3WFcYZ/quo2H/1tSggordYshZnOS/i3t5
         0detwCt41VDqwgX1DfwH6N+2hj3yHPuFh+SkNRXWH9NLlXvkw6T+oLSoeRfdJoOt5m
         ImxVfxMGX/RZvxGwF5+EDtdFBpawm/Ym/nsWTJULVMVSMu3JLAmfNX3NvVXpwwgoPp
         6hjthctGs5s1m5FQFttAEWf2XUFnXE2USk78DvWkGRtwHyDeiJvbLQKbOFCERqpKsj
         KmGpJrtJRwejYYrmh6KvY48+cseiLxdV20MHsWpZM4VaN4OguJGEK/EmDyZcTXySX0
         8i0BMC8KYTb8g==
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

These patches need to be manually backported for 4.9, 4.14 and 4.19.

Will send patches to backport separately once these patches are ack'd.

Delta between patch versions:
[v6]:	v5 is sent out mistakenly with incorrect patches.
	v6 includes proper patches addressing v4 feedback
	- updated dt-binding doc to be more clear
	- updated Tegra sdhci driver to retrieve sdhci and tmclk clocks
	  based on no. of clocks in sdhci device node as old device trees
	  do not use sdhci clock name and this allows proper clock retrival
	  irrespective of sdhci and tmclk clocks order in device tree.	  
	- Added separate quirk for identifying SoC's supporting separate
	  timeout clock to be more clear.

[v5]:	Include below changes based on v4 feedback
	- updated dt-binding doc to be more clear
	- updated Tegra sdhci driver to retrieve sdhci and tmclk clocks
	  based on no. of clocks in sdhci device node as old device trees
	  do not use sdhci clock name and this allows proper clock retrival
	  irrespective of sdhci and tmclk clocks order in device tree.	  
	- Added separate quirk for identifying SoC's supporting separate
	  timeout clock to be more clear.

[v4]:	Include additional dt-binding patch

[v3]:	Same as v2 with fixes tag

[v2]:	Includes minor fix
	- Patch-0006: parentheses around operand of '!'

Sowjanya Komatineni (7):
  sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra210
  sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra186
  dt-bindings: mmc: tegra: Add tmclk for Tegra210 and later
  arm64: tegra: Add missing timeout clock to Tegra210 SDMMC
  arm64: tegra: Add missing timeout clock to Tegra186 SDMMC nodes
  arm64: tegra: Add missing timeout clock to Tegra194 SDMMC nodes
  sdhci: tegra: Add missing TMCLK for data timeout

 .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 32 +++++++-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           | 20 +++--
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           | 15 ++--
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 20 +++--
 drivers/mmc/host/sdhci-tegra.c                     | 92 +++++++++++++++++++---
 5 files changed, 144 insertions(+), 35 deletions(-)

-- 
2.7.4

