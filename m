Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F048C4167B
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Dec 2022 16:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiLVQDk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Dec 2022 11:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiLVQDi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2022 11:03:38 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF42718B0F;
        Thu, 22 Dec 2022 08:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671725017; x=1703261017;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CAqWqGE9GPwirTHE/aAhEyHKi+Iccdwhzf4D9CSvaEQ=;
  b=Cc2SvfP4VDMuXwfLkve5jzIr096Fk7P0Kx2/G5DbBYM15RMw7uamw0oK
   cLt509k8xIW8H+VVkVGk4A0FDMPP22LMYt81QXuUq0DGQoS8F9k6zAhTF
   OzOxg1Yebvmgc4fB4ygcYWEN1SFsPbK5mc7J09DRiUXd7qjllASQS1A4c
   qzsEahBi6jcrKGFQTnwbmVNMDR8W6FuLn7mkPTr8we+LjZAGCRgx5Gpz9
   se/O2A5kHOKjk4QqznT9z+3CbxEYpP3TpzZDHWqlvQmoM+Qy2z8C9vbTv
   brSTR0xJ4JZrLrZC2lbBAAvNmiaX9UGT6hLm+uXBu+gfhxDsm0SC6Intv
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="321336629"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="321336629"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 08:03:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="684222954"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="684222954"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.195])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 08:03:20 -0800
Message-ID: <c2d5fb16-2654-6406-63da-626d6d5029c3@intel.com>
Date:   Thu, 22 Dec 2022 18:03:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/8] mmc: sdhci-pxav2: add initial support for PXA168
 V1 controller
Content-Language: en-US
To:     Doug Brown <doug@schmorgal.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20221202031330.94130-1-doug@schmorgal.com>
 <20221202031330.94130-2-doug@schmorgal.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221202031330.94130-2-doug@schmorgal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/12/22 05:13, Doug Brown wrote:
> Add a new compatible string for the version 1 controller used in the
> PXA168, along with necessary quirks. Use a separate ops struct in
> preparation for a silicon bug workaround only necessary on V1.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> ---
>  drivers/mmc/host/sdhci-pxav2.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index f18906b5575f..2f9fa0ecbddd 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -101,6 +101,14 @@ static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
>  	writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
>  }
>  
> +static const struct sdhci_ops pxav1_sdhci_ops = {
> +	.set_clock     = sdhci_set_clock,
> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> +	.set_bus_width = pxav2_mmc_set_bus_width,
> +	.reset         = pxav2_reset,
> +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> +};
> +
>  static const struct sdhci_ops pxav2_sdhci_ops = {
>  	.set_clock     = sdhci_set_clock,
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> @@ -114,6 +122,9 @@ static const struct of_device_id sdhci_pxav2_of_match[] = {
>  	{
>  		.compatible = "mrvl,pxav2-mmc",
>  	},
> +	{
> +		.compatible = "mrvl,pxav1-mmc",
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_pxav2_of_match);
> @@ -208,7 +219,12 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
>  			host->mmc->pm_caps |= pdata->pm_caps;
>  	}
>  
> -	host->ops = &pxav2_sdhci_ops;
> +	if (match && of_device_is_compatible(dev->of_node, "mrvl,pxav1-mmc")) {
> +		host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ | SDHCI_QUIRK_32BIT_DMA_SIZE;
> +		host->ops = &pxav1_sdhci_ops;
> +	} else {
> +		host->ops = &pxav2_sdhci_ops;
> +	}

It would be better to put the information above in a structure and
get it with of_device_get_match_data() (instead of of_match_device).
Also drivers typically assume there is always a match since that
is the only way the driver ->probe() will get run.

>  
>  	ret = sdhci_add_host(host);
>  	if (ret)

