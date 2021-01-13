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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD03C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 12:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32FDD233FA
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 12:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbhAMMIK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 07:08:10 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45794 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbhAMMIK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 07:08:10 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10DC6V28110714;
        Wed, 13 Jan 2021 06:06:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610539591;
        bh=bj1OIoKh7MPlLtR7S7imc28nG0Aa6DWPD3zetxMh0ds=;
        h=Subject:CC:References:From:Date:In-Reply-To;
        b=HnHcHYqSMFoLSi7sKS0j1SNbdWGt6tKxfo2AkwgAzKZWtANnGgxdk8mPNIsZawEaR
         aF0w0WEmi0ZC1vEV+/Jj1rE49YX2UH3P5h0dGJ+EaD/JVaudUwTWhvROuKfkNZLwWm
         CV0xTU08fO0fi7SPMYLVMVJY8kb7Q5jrWgPhrj94=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10DC6VXh041122
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jan 2021 06:06:31 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 Jan 2021 06:06:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 Jan 2021 06:06:30 -0600
Received: from [10.250.232.169] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10DC6QGE055184;
        Wed, 13 Jan 2021 06:06:27 -0600
Subject: Re: [PATCH 2/2] mmc: sdhci_am654: Add Support for TI's AM64 SoC
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
 <20210113115908.3882-3-a-govindraju@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <a74e6fbf-5a46-e666-83ee-b0e967362630@ti.com>
Date:   Wed, 13 Jan 2021 17:36:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210113115908.3882-3-a-govindraju@ti.com>
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
> From: Faiz Abbas <faiz_abbas@ti.com>
> 
> Add support for the controller present on the AM64x SoC.
> 
> There are instances:
> sdhci0: 8bit bus width, max 400 MBps
> sdhci1: 4bit bus width, max 100 MBps
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---

Very sorry forgot to add RESEND tag in the subject. The link to the
original patch,
https://lore.kernel.org/patchwork/patch/1364589/

Thanks,
Aswath

>  drivers/mmc/host/sdhci_am654.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index a64ea143d185..7a34649b0754 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -514,6 +514,26 @@ static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
>  	.flags = IOMUX_PRESENT,
>  };
>  
> +static const struct sdhci_pltfm_data sdhci_am64_8bit_pdata = {
> +	.ops = &sdhci_j721e_8bit_ops,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +};
> +
> +static const struct sdhci_am654_driver_data sdhci_am64_8bit_drvdata = {
> +	.pdata = &sdhci_am64_8bit_pdata,
> +	.flags = DLL_PRESENT | DLL_CALIB,
> +};
> +
> +static const struct sdhci_pltfm_data sdhci_am64_4bit_pdata = {
> +	.ops = &sdhci_j721e_4bit_ops,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +};
> +
> +static const struct sdhci_am654_driver_data sdhci_am64_4bit_drvdata = {
> +	.pdata = &sdhci_am64_4bit_pdata,
> +	.flags = IOMUX_PRESENT,
> +};
> +
>  static const struct soc_device_attribute sdhci_am654_devices[] = {
>  	{ .family = "AM65X",
>  	  .revision = "SR1.0",
> @@ -737,6 +757,14 @@ static const struct of_device_id sdhci_am654_of_match[] = {
>  		.compatible = "ti,j721e-sdhci-4bit",
>  		.data = &sdhci_j721e_4bit_drvdata,
>  	},
> +	{
> +		.compatible = "ti,am64-sdhci-8bit",
> +		.data = &sdhci_am64_8bit_drvdata,
> +	},
> +	{
> +		.compatible = "ti,am64-sdhci-4bit",
> +		.data = &sdhci_am64_4bit_drvdata,
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_am654_of_match);
> 

