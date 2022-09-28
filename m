Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42857C6FA86
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Sep 2022 22:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbiI1Whz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Sep 2022 18:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbiI1Wha (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2022 18:37:30 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA26FF3CB;
        Wed, 28 Sep 2022 15:37:25 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id cm7-20020a056830650700b006587fe87d1aso9073563otb.10;
        Wed, 28 Sep 2022 15:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=o9gZyjiSadqdv6mxfxQft+qOXfye+FPw5i97r+Tzn8A=;
        b=anVPY9iSbIp6kplQjdn1U1/v8AticV+/uCjQt1tXDRu5RPCxiUXOdzGJtQPSbSkUaw
         8Os3TPMRdhFHlbUXAz8xSGnLU6LnY5azg5e8wE0PsrVeNzs/0Rtk7AGoWR7v1VwDNgBy
         QEWHDO+lFFLik8idUMfL6MUPU+2iNhkSuyzPnfHLJPEfEPVjgQf+cYwTGeImy1k2jEI4
         ki7iIoc4j4YheysYR86qkY/JnTPqTvmQ7UyNFeClemouGklb7eWIWHuaQyBBSZ2H75Ib
         FPv/I9Wp0aTq3LOLffYtTULtsP/wj8H9TlPd1f4EnbftUdez+m9JLulOuDebWiAyD5qh
         7xbg==
X-Gm-Message-State: ACrzQf1IuTG93o6gFAhMFIKdGx/EXv80xIWSr1zRcGH7F77xKJfLe60i
        Fi+ejcYo0XjCpMSXO4zhkf6dF/hG4Q==
X-Google-Smtp-Source: AMsMyM5H9jK6oqeqXok/cqzftUY221G7BgEdMfyoyL+nY6rOhKsS2nbUIDTFWV3cljSso/Od/TG9SA==
X-Received: by 2002:a9d:394:0:b0:65c:3f7f:a6b7 with SMTP id f20-20020a9d0394000000b0065c3f7fa6b7mr28605otf.179.1664404644667;
        Wed, 28 Sep 2022 15:37:24 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w7-20020a4aa987000000b0044b491ccf97sm2385428oom.25.2022.09.28.15.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:37:23 -0700 (PDT)
Received: (nullmailer pid 87026 invoked by uid 1000);
        Wed, 28 Sep 2022 22:37:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, jh80.chung@samsung.com,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
In-Reply-To: <20220928165420.1212284-1-dinguyen@kernel.org>
References: <20220928165420.1212284-1-dinguyen@kernel.org>
Subject: Re: [PATCHv4 1/3] dt-bindings: mmc: synopsys-dw-mshc: document "altr,sysmgr-syscon"
Date:   Wed, 28 Sep 2022 17:37:22 -0500
Message-Id: <1664404642.110424.87025.nullmailer@macbook.herring.priv>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 28 Sep 2022 11:54:18 -0500, Dinh Nguyen wrote:
> Document the optional "altr,sysmgr-syscon" binding that is used to
> access the System Manager register that controls the SDMMC clock
> phase.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v4: add else statement
> v3: document that the "altr,sysmgr-syscon" binding is only applicable to
>     "altr,socfpga-dw-mshc"
> v2: document "altr,sysmgr-syscon" in the MMC section
> ---
>  .../bindings/mmc/synopsys-dw-mshc.yaml        | 31 +++++++++++++++++--
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml: allOf:1:if:properties:compatible:contains:const: ['altr,socfpga-dw-mshc'] is not of type 'integer', 'string'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml: ignoring, error in schema: allOf: 1: if: properties: compatible: contains: const
Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.example.dtb:0:0: /example-0/mmc@12200000: failed to match any schema with compatible: ['snps,dw-mshc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

