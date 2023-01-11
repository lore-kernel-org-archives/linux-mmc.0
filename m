Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09103C54EBC
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Jan 2023 12:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjAKMnw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Jan 2023 07:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjAKMnv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2023 07:43:51 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4017AE5;
        Wed, 11 Jan 2023 04:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673441030; x=1704977030;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=clvbpco3vRjdOez103L/Q2h8uRiPBYken5tnQCx83QA=;
  b=eMM9W5XPGTU91wZQ9jMixEC9+JrGk0caP9z1Kekiks7A+/K46SBAoHkI
   Y5eC+qY6KgzzAmRGdhIgVLtvr6LDrF4ZaQstEu5pnTd2Mg/oHSq5LLIQr
   zhXQiYGQafzsf8rtAh893fW21Xx8plmYxXCqLLZ1SbRiEvMAaXozPSo27
   yEoZ8DoqQUM3gOiSn6OxfFXgdCpRWIHYH1hVasFUDnLPc+1hns8hhAVku
   KBYyf2nLIkSABU8ro7rlX1dhOEIeUO8gz/e3HphRlCQ3ckFuU8iPxRP9F
   ecW3SxtaEQeY8bidmKXXhi2A8W64VehLA/V/KVp0TaXMJgQhA2O03aIxM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="385708569"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="385708569"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 04:43:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607347275"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607347275"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.37.49])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 04:43:47 -0800
Message-ID: <5b50ea6c-d2c6-4dff-9689-a67039fb86e2@intel.com>
Date:   Wed, 11 Jan 2023 14:43:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/8] mmc: sdhci-pxav2: Add support for PXA168
Content-Language: en-US
To:     Doug Brown <doug@schmorgal.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <20221229200411.295339-1-doug@schmorgal.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221229200411.295339-1-doug@schmorgal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29/12/22 22:04, Doug Brown wrote:
> This is a revival of an earlier patch series from 2013 to add support
> for the PXA168 SDHC controller, with an additional SDIO IRQ errata fix.
> It also cleans up the clock naming to be consistent with the existing DT
> schema shared with the pxav3 driver (in a backwards-compatible way).
> 
> Here is the original patch series this is based on:
> https://lore.kernel.org/linux-mmc/1363544206-3671-1-git-send-email-tanmay.upadhyay@einfochips.com/
> 
> Note that I left out the platform_specific_completion and clock gating
> changes from the original patches. They both seemed controversial, and
> don't seem necessary based on my testing. I've been running this code on
> a PXA168 for months without any issues.

For patch 1-7:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Changes in v3:
> - Use OF match data rather than of_match_device and of_device_is_compatible
> - Simplify some instances of pdev->dev that could have just been "dev"
> - Handle EPROBE_DEFER when getting the clock
> - Use devm_clk_get_optional_enabled for the core clock (it's simpler)
> - Clear sdio_mrq before calling mmc_request_done
> - Small tweaks to devicetree binding requested by Krzysztof
> 
> Changes in v2:
> - Fix mistakes in devicetree binding
> - Use cleaner code for pxav1_readw suggested by Adrian
> - Switch to request_done() and irq() for SDIO workaround CMD0 handling
> 
> Doug Brown (8):
>   mmc: sdhci-pxav2: add initial support for PXA168 V1 controller
>   mmc: sdhci-pxav2: enable CONFIG_MMC_SDHCI_IO_ACCESSORS
>   mmc: sdhci-pxav2: add register workaround for PXA168 silicon bug
>   mmc: sdhci-pxav2: change clock name to match DT bindings
>   mmc: sdhci-pxav2: add optional core clock
>   mmc: sdhci-pxav2: add SDIO card IRQ workaround for PXA168 V1
>     controller
>   mmc: sdhci-pxav2: add optional pinctrl for SDIO IRQ workaround
>   dt-bindings: mmc: sdhci-pxa: add pxav1
> 
>  .../devicetree/bindings/mmc/sdhci-pxa.yaml    |  19 ++-
>  drivers/mmc/host/Kconfig                      |   1 +
>  drivers/mmc/host/sdhci-pxav2.c                | 153 ++++++++++++++++--
>  3 files changed, 159 insertions(+), 14 deletions(-)
> 

