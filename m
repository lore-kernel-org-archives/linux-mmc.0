Return-Path: <SRS0=IgIp=CG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF89AC433E6
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 23:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 880A320838
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 23:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="m0nMr+yf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgH1XYV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Aug 2020 19:24:21 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2982 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgH1XYU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2020 19:24:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4991f80001>; Fri, 28 Aug 2020 16:23:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 28 Aug 2020 16:24:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 28 Aug 2020 16:24:20 -0700
Received: from [10.2.174.186] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 23:24:17 +0000
Subject: Re: [PATCH 4.19 1/7] sdhci: tegra: Remove
 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra210
To:     Sasha Levin <sashal@kernel.org>
CC:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <stable@vger.kernel.org>
References: <1598653517-13658-1-git-send-email-skomatineni@nvidia.com>
 <1598653517-13658-2-git-send-email-skomatineni@nvidia.com>
 <20200828231536.GU8670@sasha-vm>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <dc6bfd08-baaf-e1ad-6b3f-77ff82d110bb@nvidia.com>
Date:   Fri, 28 Aug 2020 16:23:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828231536.GU8670@sasha-vm>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598657016; bh=TyI6d2Ju+76mqOnwS5pcHvlDKt8Y0bBRO/8b8AY+sio=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=m0nMr+yfVLhgIys6rwPF6LX8naSK2+gxL0PP7QhiyvQPFO863yuJ+SaQacGrCHG1H
         xEsHzIaIWsNQ4oh28IGenzYpHSIs570ezt5RjJqwy2odFXi7RAlFQbd7L6UAV7LuOT
         sRN4VtmzWSXN6H0ZUtj2xKBxCQ8LbZhPENXYZ+qolIpcHa7hRo3KLdJeSq2J6y9GJk
         yCZFe8pkti8C9ORNSf0COFrb5SYp4k7KZQhZ7b7Ejx8qmMZAgD8xpjBNJecaFEqD0g
         OnxoaqullDImlBSPCFcF/JKOG1v8WaD4GIUsAgA87YTlaAL7ikfqa1pHUQU7bj3kh8
         HE2iWChSJyW1g==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 8/28/20 4:15 PM, Sasha Levin wrote:
> On Fri, Aug 28, 2020 at 03:25:11PM -0700, Sowjanya Komatineni wrote:
>> commit b5a84ecf025a ("mmc: tegra: Add Tegra210 support")
>
> What does this line above represent?
>
SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK is set incorrectly in above commit

when Tegra210 support was added.


>> SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK is set for Tegra210 from the
>> beginning of Tegra210 support in the driver.
>>
>> Tegra210 SDMMC hardware by default uses timeout clock (TMCLK)
>> instead of SDCLK and this quirk should not be set.
>>
>> So, this patch remove this quirk for Tegra210.
>>
>> Fixes: b5a84ecf025a ("mmc: tegra: Add Tegra210 support")
>> Cc: stable <stable@vger.kernel.org> # 4.19
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>
