Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6658C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 12:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73FBB233FA
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 12:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbhAMMHH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 07:07:07 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45672 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbhAMMHH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 07:07:07 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10DC5S9J110473;
        Wed, 13 Jan 2021 06:05:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610539528;
        bh=GOrB5ikmVuIto2NNZ101lV3tZAxQ3E85RChJCsKmQqQ=;
        h=Subject:CC:References:From:Date:In-Reply-To;
        b=DdWLXEpQpHcyWJjrYrAVCqEbXkFjyAhqQ26dpnKQ5323zXIDHHJUyg8ZLyxMsaIBC
         V9VrLgsZ4EZ2BMVM1AVsbRg+hCS/09Pb22VKkt+JySwh1t4OipWy/dHp1AImPc4M5C
         2LAUeCvrWm9hc/TqoW2pBLPo1R/6hDMdTRn/zh4Q=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10DC5Ssv039471
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jan 2021 06:05:28 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 Jan 2021 06:05:28 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 Jan 2021 06:05:28 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10DC5NCK014947;
        Wed, 13 Jan 2021 06:05:24 -0600
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-am654: Add compatible string
 for AM64 SoC
CC:     Sekhar Nori <nsekhar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>
References: <20210113115908.3882-1-a-govindraju@ti.com>
 <20210113115908.3882-2-a-govindraju@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <e2673346-36bf-2590-ff09-cda0668d08c8@ti.com>
Date:   Wed, 13 Jan 2021 17:35:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210113115908.3882-2-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 13/01/21 5:29 pm, Aswath Govindraju wrote:
> Add compatible string for AM64 SoC in device tree binding of AM654 SDHCI module
> as the same IP is used.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Very sorry forgot to add RESEND tag in the subject. The link to the
original patch,
https://lore.kernel.org/patchwork/patch/1361560/

Thanks,
Aswath

>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> index 1ae945434c53..34e53db29428 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> @@ -21,6 +21,8 @@ properties:
>        - ti,j721e-sdhci-4bit
>        - ti,j7200-sdhci-8bit
>        - ti,j721e-sdhci-4bit
> +      - ti,am64-sdhci-8bit
> +      - ti,am64-sdhci-4bit
>  
>    reg:
>      maxItems: 2
> 

