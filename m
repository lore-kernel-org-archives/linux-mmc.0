Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153E8C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Nov 2022 06:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiK2Gbs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Nov 2022 01:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK2Gbr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2022 01:31:47 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8404FF8F;
        Mon, 28 Nov 2022 22:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669703506; x=1701239506;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2ZevteJEeuBWIB8ThPdy5oJKhP3is8ThlHKOG6tF9XU=;
  b=Sr32CTI19u5MXq8pk9Zp+BXJw+3hKWWWy7RrbSArbd3Q28lBniESSusG
   9La2YnBraO9SxvqksjNKjaiFCA4qJQpgH2Sltk7yocl6uyzfva3kMD+lq
   VVPgfZDMhpUboBhj0Z5p3uroZWnwat4jmEShtKzO+evIwPArF0XUxYygg
   lHhMYcRAcYT8s05+jeC6g5WhYNaplekinThRKXPc7JxK1zL6mfgsQ1KuP
   qKwZ1TQpglzj0z/iBnZUbfpqOgveEo01v2JnzoOmTI8WzpwW5iVDoQC/9
   uiEvwmR9/yUAR8cxf15KMlUK0P9RN0IDt5HW12+ub3unxRk/h1Si0nRmm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="312661910"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="312661910"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 22:31:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="749707908"
X-IronPort-AV: E=Sophos;i="5.96,202,1665471600"; 
   d="scan'208";a="749707908"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.34.177])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 22:31:43 -0800
Message-ID: <117f119b-96d3-342d-f03e-1176653be133@intel.com>
Date:   Tue, 29 Nov 2022 08:31:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH 3/8] mmc: sdhci-pxav2: add register workaround for PXA168
 silicon bug
To:     Doug Brown <doug@schmorgal.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <20221128024407.224393-1-doug@schmorgal.com>
 <20221128024407.224393-4-doug@schmorgal.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221128024407.224393-4-doug@schmorgal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 28/11/22 04:44, Doug Brown wrote:
> The PXA168 has a documented silicon bug that results in a data abort
> exception when accessing the SDHCI_HOST_VERSION register on SDH2 and
> SDH4 through a 16-bit read. Implement the workaround described in the
> errata, which performs a 32-bit read from a lower address instead. This
> is safe to use on all four SDH peripherals.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> ---
>  drivers/mmc/host/sdhci-pxav2.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index 2f9fa0ecbddd..d76131b8986b 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -80,6 +80,18 @@ static void pxav2_reset(struct sdhci_host *host, u8 mask)
>  	}
>  }
>  
> +static inline u16 pxav1_readw(struct sdhci_host *host, int reg)
> +{
> +	u32 temp;
> +	/* Workaround for data abort exception on SDH2 and SDH4 on PXA168 */
> +	if (reg == SDHCI_HOST_VERSION) {
> +		temp = readl(host->ioaddr + SDHCI_HOST_VERSION - 2) >> 16;
> +		return temp & 0xffff;

Isn't this the same as just:

		return readl(host->ioaddr + SDHCI_HOST_VERSION - 2) >> 16;

> +	}
> +
> +	return readw(host->ioaddr + reg);
> +}
> +
>  static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
>  {
>  	u8 ctrl;
> @@ -102,6 +114,7 @@ static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
>  }
>  
>  static const struct sdhci_ops pxav1_sdhci_ops = {
> +	.read_w        = pxav1_readw,
>  	.set_clock     = sdhci_set_clock,
>  	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>  	.set_bus_width = pxav2_mmc_set_bus_width,

