Return-Path: <SRS0=bPLn=CF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95358C433E3
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 02:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761042087C
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 02:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="O5cTArAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgH0C6l (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Aug 2020 22:58:41 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19985 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgH0C6l (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Aug 2020 22:58:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4720e70001>; Wed, 26 Aug 2020 19:56:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 26 Aug 2020 19:58:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 26 Aug 2020 19:58:40 -0700
Received: from [10.2.174.186] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 02:58:39 +0000
Subject: Re: [PATCH v5 0/7] Fix timeout clock used by hardware data timeout
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <1598472314-30235-1-git-send-email-skomatineni@nvidia.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <2cdf3627-19cc-eca0-7872-d1a2d4f070f5@nvidia.com>
Date:   Wed, 26 Aug 2020 19:58:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1598472314-30235-1-git-send-email-skomatineni@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598496999; bh=evzB4FoRprFPYV5hVd/oisQBSOdob+Bb6961eYXLFo4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=O5cTArAVrnw8dzzc1QbD7sLMasLA9j4u/Zu3kT12wNZxMiSfAsOwuRNEtq0jTf/JU
         46zX8GCF+8E9ePFv8/cPKz5vS4JHL/JurOVg0LZK/Jc+NtTMCI8PaQBOluB/qbFN4O
         kFxcHeA2Fh55r35Ih66NvL/iWGV6GfZ9L7+0+xnnCO/FBaDUoqyJHhLKN2xzeklvx6
         F9WqBGXzNws1A1ZQjBOTcRNoQb7FARJZM8tRq544hAoeQitXB/XzTcuo/50+oukxUw
         h9IRyPR2AsIrM85I3vL1OtjmCFyItGkjbHhRH13z+5DGf+JnW6JdcQuG/thtH1RNTi
         TTsEHHFc7VF5A==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Sorry please ignore this series.

Wrong patches from my system went out.

Will send as v6.

Thanks

Sowjanya

On 8/26/20 1:05 PM, Sowjanya Komatineni wrote:
> Tegra210/Tegra186/Tegra194 has incorrectly enabled
> SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK from the beginning of their support.
>
> Tegra210 and later SDMMC hardware default uses sdmmc_legacy_tm (TMCLK)
> all the time for hardware data timeout instead of SDCLK and this TMCLK
> need to be kept enabled by Tegra sdmmc driver.
>
> This series includes patches to fix this for Tegra210/Tegra186/Tegra194.
>
> These patches need to be manually backported for 4.9, 4.14 and 4.19.
>
> Will send patches to backport separately once these patches are ack'd.
>
> Delta between patch versions:
> [v5]:	Include below changes based on v4 feedback
> 	- updated dt-binding doc to be more clear
> 	- updated Tegra sdhci driver to retrieve sdhci and tmclk clocks
> 	  based on no. of clocks in sdhci device node as old device trees
> 	  do not use sdhci clock name and this allows proper clock retrival
> 	  irrespective of sdhci and tmclk clocks order in device tree.	
> 	- Added separate quirk for identifying SoC's supporting separate
> 	  timeout clock to be more clear.
>
> [v4]:	Include additional dt-binding patch
>
> [v3]:	Same as v2 with fixes tag
>
> [v2]:	Includes minor fix
> 	- Patch-0006: parentheses around operand of '!'
>
> Sowjanya Komatineni (7):
>    sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra210
>    sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra186
>    dt-bindings: mmc: tegra: Add tmclk for Tegra210 and later
>    arm64: tegra: Add missing timeout clock to Tegra210 SDMMC
>    arm64: tegra: Add missing timeout clock to Tegra186 SDMMC nodes
>    arm64: tegra: Add missing timeout clock to Tegra194 SDMMC nodes
>    sdhci: tegra: Add missing TMCLK for data timeout
>
>   .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 32 +++++++-
>   arch/arm64/boot/dts/nvidia/tegra186.dtsi           | 20 +++--
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi           | 15 ++--
>   arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 20 +++--
>   drivers/mmc/host/sdhci-tegra.c                     | 91 +++++++++++++++++++---
>   5 files changed, 143 insertions(+), 35 deletions(-)
>
