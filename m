Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEEDC77B75
	for <linux-mmc@archiver.kernel.org>; Fri,  5 May 2023 09:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjEEJdI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 May 2023 05:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEEJdH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 May 2023 05:33:07 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6AB9E4B;
        Fri,  5 May 2023 02:33:05 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-18f4a6d2822so16211529fac.1;
        Fri, 05 May 2023 02:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683279185; x=1685871185;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=foYZfjSWQ9XEg3+X0YFxAS8ZxcDOViTVK2FhC3WnFyg=;
        b=il6iKb1qzvz5Q1yr6xx8s9bkoU14M26iaWVNb8/Y8JfLrhGvTborle0wbnAwpTkehh
         XZsj6Dy1anFCHofGQ7IqXp9CAr8VhMyfEB7rRdysXZ/yfY4hz0d7xtDZbR+dNSz7+Hi+
         83xIIzrXBUONrW/q+skkMIoQLi2vmCvdHASp5FsIBtX5F11/LvNnxLoHSLJfx9ZTSKh4
         nX/99IzmVD3E1x4AifAQ//c/g0FnoWAoOzs7GFV1kR85eFUIYdsL3zcIxijTMLjuzee4
         idyPRmiaQ0y8QzW9wP9A+C/qxp5fbpeZd48ywCCDGkNEH9am8x+KYhrLCx6i1+ts0rbj
         GhLQ==
X-Gm-Message-State: AC+VfDwV4GK+7BXViFmsHb6RV6njyAn0oZqRkbSEN1iR7j8ck56omN0C
        2hCoBHdiP8ZZwkIzod8kYw==
X-Google-Smtp-Source: ACHHUZ7/Bvo6e4IS+A0BRBq1EW4h8UO56UACPEEq24rcsGRSiUq3y+9x2Vp5LVN0QW+75WL7Sc43iQ==
X-Received: by 2002:a9d:70cc:0:b0:6a4:42a4:3e69 with SMTP id w12-20020a9d70cc000000b006a442a43e69mr1292329otj.15.1683279184970;
        Fri, 05 May 2023 02:33:04 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d19-20020a056830005300b0068bd922a244sm600711otp.20.2023.05.05.02.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 02:33:04 -0700 (PDT)
Received: (nullmailer pid 1945758 invoked by uid 1000);
        Fri, 05 May 2023 09:33:03 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     haibo.chen@nxp.com
Cc:     linux-imx@nxp.com, ulf.hansson@linaro.org,
        cniedermaier@dh-electronics.com, krzysztof.kozlowski+dt@linaro.org,
        kernel@pengutronix.de, kernel@dh-electronics.com,
        adrian.hunter@intel.com, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
In-Reply-To: <20230505084955.238940-3-haibo.chen@nxp.com>
References: <20230505084955.238940-1-haibo.chen@nxp.com>
 <20230505084955.238940-3-haibo.chen@nxp.com>
Message-Id: <168327918323.1945739.8862496839976686617.robh@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: mmc: fsl-imx-esdhc: remove property
 "fsl,wp-controller"
Date:   Fri, 05 May 2023 04:33:03 -0500
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Fri, 05 May 2023 16:49:54 +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Driver do not use this property, so remove it here.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 5 -----
>  1 file changed, 5 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.example.dtb: mmc@70004000: Unevaluated properties are not allowed ('fsl,wp-controller' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230505084955.238940-3-haibo.chen@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

