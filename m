Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA415C433E1
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 07:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1BC1204FD
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 07:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XfIj7G4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgHYHjv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:39:51 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17265 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbgHYHju (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2020 03:39:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f44c0370000>; Tue, 25 Aug 2020 00:39:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Aug 2020 00:39:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 25 Aug 2020 00:39:49 -0700
Received: from [10.26.74.41] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 07:39:42 +0000
Subject: Re: [PATCH v4 3/7] dt-bindings: mmc: tegra: Add tmclk for Tegra210
 and later
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <1598296557-32020-1-git-send-email-skomatineni@nvidia.com>
 <1598296557-32020-4-git-send-email-skomatineni@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <64f1b068-d935-ae47-e5f3-fa318196a5af@nvidia.com>
Date:   Tue, 25 Aug 2020 08:39:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1598296557-32020-4-git-send-email-skomatineni@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598341175; bh=0xmlVzVjCdyLV1AnfSQ918bzgENv4gOD4+okuss+xJk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XfIj7G4H0xTpGl2IgChp5HG/WcgT5qIic+yVtzUw6ExSGLFRI/ZtypWGTe8+C3Nzt
         nti+eZgjJijD/uqo4bMRoQcvrrcb+1yU5MnHFPehNNZN8rcRiMYodpSkKJIX3sWt6+
         hIuoMVE1V1U+7vPqXO4VMUWYf8bI4ePPH4Gqhod0qiYB+u9pE3+A0acIyTMaD/EHSC
         jzAaho3KwuEEMXX0kxJ3R9W0eowowsEjH0B+QGjsPuZtwgBHXGPLGXrpb/b6Ub8OxW
         GhR/KwHzT3yIPCzf6nDEXbRPbbxFKop+nJqlamWAxVdCGIo1ThSQfm44d5TlktttX7
         dK/Om5HMMrO+w==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 24/08/2020 20:15, Sowjanya Komatineni wrote:
> Tegra210 and later uses separate SDMMC_LEGACY_TM clock for data
> timeout.
> 
> So, this patch adds "tmclk" to Tegra sdhci clock property in the
> device tree binding.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 23 +++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> index 2cf3aff..9603d05 100644
> --- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
> @@ -17,6 +17,8 @@ Required properties:
>    - "nvidia,tegra194-sdhci": for Tegra194
>  - clocks : Must contain one entry, for the module clock.
>    See ../clocks/clock-bindings.txt for details.
> +  Must also contain "tmclk" entry for Tegra210, Tegra186, and Tegra194.
> +  Tegra210 and later uses separate SDMMC_LEGACY_TM clock for data timeout.

Maybe we should make this a bit clearer ...

- clocks : For Tegra210, Tegra186 and Tegra194 must contain two entries;
           one for the module clock and one for the timeout clock. For
           all other Tegra devices, must contain a single entry for the
           module clock. See ../clocks/clock-bindings.txt for details.
- clock-names: For Tegra210, Tegra186 and Tegra194 must contain the
               strings 'sdhci' and 'tmclk' to represent the module and
               timeout clocks, respectively. For all other Tegra devices
               must contain the string 'sdhci' to represent the module
               clock.

Cheers
Jon

-- 
nvpublic
