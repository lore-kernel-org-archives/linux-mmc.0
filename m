Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4907CC54EBC
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Jan 2023 12:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjAKMoR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Jan 2023 07:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjAKMoR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Jan 2023 07:44:17 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642CFFD;
        Wed, 11 Jan 2023 04:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673441056; x=1704977056;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OcRQrZ8hqZPvC+BoWCd3tVNbJAoi1+4hYANPS5DxSZU=;
  b=XhgAVzN+FnwmpBy7XBD4gpRiZUtN86rghMXfRY5VXkwPCm1JabRJsJ59
   xeLSrfvi+Bh8tJa55dCr+dWUxQk4x2+w3AyrFlYYLNDYppwM3kGmTmQG1
   N9je8f75soGToyQiq1zi02vTK3WAM1m2amSTJt69yj6bVQpD7rCZmmk6f
   Zo9ePf+6FRMwnkTq8gliJILQYwF7aAtjoErg3skmG7yq0cFiDcBr+wAne
   dchQDj665Jt2bPOrmZvwZ9w9XEVoauMTa3mrrUlMQaSNBAdlUyk6kNdIV
   5+Eb2cTyFX+vH/wwyd+rSqNBduC7J65uEM3EL3s0k+VM2P6qzOWI0f1zI
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="385708621"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="385708621"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 04:44:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607347411"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607347411"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.37.49])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 04:44:13 -0800
Message-ID: <1acd4e02-93db-88bc-2230-e230214fe591@intel.com>
Date:   Wed, 11 Jan 2023 14:44:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v3 8/8] dt-bindings: mmc: sdhci-pxa: add pxav1
Content-Language: en-US
To:     Doug Brown <doug@schmorgal.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221229200411.295339-1-doug@schmorgal.com>
 <20221229200411.295339-9-doug@schmorgal.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221229200411.295339-9-doug@schmorgal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29/12/22 22:04, Doug Brown wrote:
> Add a compatible for the pxav1 controller in the PXA168, along with
> optional pinctrl properties to use for an errata workaround.
> 
> Signed-off-by: Doug Brown <doug@schmorgal.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Doesn't apply cleanly anymore

> ---
>  .../devicetree/bindings/mmc/sdhci-pxa.yaml    | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> index 1c87f4218e18..09455f9fa8de 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Marvell PXA SDHCI v2/v3 bindings
> +title: Marvell PXA SDHCI v1/v2/v3
>  
>  maintainers:
>    - Ulf Hansson <ulf.hansson@linaro.org>
> @@ -34,6 +34,7 @@ allOf:
>  properties:
>    compatible:
>      enum:
> +      - mrvl,pxav1-mmc
>        - mrvl,pxav2-mmc
>        - mrvl,pxav3-mmc
>        - marvell,armada-380-sdhci
> @@ -61,6 +62,22 @@ properties:
>        - const: io
>        - const: core
>  
> +  pinctrl-names:
> +    description:
> +      Optional for supporting PXA168 SDIO IRQ errata to switch CMD pin between
> +      SDIO CMD and GPIO mode.
> +    items:
> +      - const: default
> +      - const: state_cmd_gpio
> +
> +  pinctrl-0:
> +    description:
> +      Should contain default pinctrl.
> +
> +  pinctrl-1:
> +    description:
> +      Should switch CMD pin to GPIO mode as a high output.
> +
>    mrvl,clk-delay-cycles:
>      description: Specify a number of cycles to delay for tuning.
>      $ref: /schemas/types.yaml#/definitions/uint32

