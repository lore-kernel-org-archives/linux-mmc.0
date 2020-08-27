Return-Path: <SRS0=bPLn=CF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9793C433E5
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 17:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3BAC2087E
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 17:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hFWZkDU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgH0RV2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:21:28 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3029 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgH0RV1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2020 13:21:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f47eb1c0001>; Thu, 27 Aug 2020 10:19:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 10:21:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 27 Aug 2020 10:21:26 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 17:21:23 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 27 Aug 2020 17:21:23 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.174.186]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f47eb930000>; Thu, 27 Aug 2020 10:21:23 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <skomatineni@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v7 0/7] Fix timeout clock used by hardware data timeout
Date:   Thu, 27 Aug 2020 10:20:54 -0700
Message-ID: <1598548861-32373-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598548764; bh=e1JLqlJk7EjViWZ1Uf+05+ElVBscJJUBK0gRnJRnjq8=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=hFWZkDU7nDfzmjlOiH8cz/4JnoSH/V8iDoIQ/1t0eZ/jVjxatQl6b/WK2qQtlX3Bn
         EaoJWO5he50tZfh4AQB5c/Rrp7wEr5UUHVKp4f1tG8D1HN9TYK2kv8+mKQBckbZxCo
         lO08yu/sIfeoDxnUn4+TCcSJR+KpazKJI488Oq6dNWR3qpVxKMm+ojx7r30Qnfax5I
         GFsm/zRwYxoFZixNSHKkzL4mZoDXGjaHcydCSSq2nIJZWRMI22YkMGjlFjPsYc+/J2
         qwxUHStVJy6lYMvjrEFTnOqW7YZWT5pU/FBfB7UWMIX8BF9zJmp6FHUtP/37FApOnt
         6J9uDjz7c88Aw==
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

These patches need to be manually backported to 4.19.

Will send patches for 4.19 backport separately.

Delta between patch versions:
[v7]:	v7 has below change
	- v6 has implementation for retrieving tmclk irrespective of
	  clocks order. But based in internal discussion with Thierry
	  this is not required as typically order specified in DT
	  bindings is the order validator want to see in DT.

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

 .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 32 +++++++++++--
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           | 20 ++++----
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           | 15 +++---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 20 ++++----
 drivers/mmc/host/sdhci-tegra.c                     | 55 ++++++++++++++++++++--
 5 files changed, 113 insertions(+), 29 deletions(-)

-- 
2.7.4

