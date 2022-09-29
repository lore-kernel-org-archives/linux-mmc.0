Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5C3C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Sep 2022 09:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiI2JZG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Sep 2022 05:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiI2JZE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2022 05:25:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ADD3A4A3
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2022 02:25:02 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 70so782249pjo.4
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2022 02:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1u95457ImSK7IT/OW0kMB2C3/yW1UVlDtXtAOxPIYzE=;
        b=poGnVSGusP35IFp3mFe4IaXLOyomB2ncxVguPLDQDDC4AskRehuKsH6dCXZRF+DLdA
         UFuVZvkzfIk/SuGZ9FEUAQ1GykDklyYkscSD63TxhY3653Ghgv38kXFfbtnWzTDKN3dC
         vlboM3r0DZdINx0t04k7LmROOWsd0OUBqSeoZZYCxsf8g0ydW86C5KVGaKdtFAXV14Uq
         /OeEXvCV1M4P+Cq1yIr4Rerx/YbK8EjEH/JfG1jvVDTstSuO/xiyyaX8Iy2aG1eCa6Bd
         leoWdi0vimI559jxe3IU7f1FM9fVUB0GORj6LVkXqfs1kpPkC+dwrsJ3AC5PSJdbjET6
         IKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1u95457ImSK7IT/OW0kMB2C3/yW1UVlDtXtAOxPIYzE=;
        b=Z8O+gyDLBOsMBkgd0c0pvyC1aMl0YyDFTX0PbYT3Yxn75SfsxPsV0Fv72oEHpB1Mcu
         twi7QPBMnMumNlOLCkv5u+bgoHNFQK3AufQf9nLr975GWVndUNr6VTO5Y+RnKt9GVoBc
         ay5Qu030uOPWDVGxDtr9a5o7mFaGfIcHWo1xtNGwUtyxXx3Z9hBC/OHHIV87UIvj8+Pk
         zUKufTd1iR4oXCBItxbRUnFcDik/+jMsKsHd+6mVe0zMPU+dghdmdaWNxkJ1jE++tgXZ
         Tc/0G2v7x2R1sNRRXYHe8YxUS7y/mSBCEX4kKDl070XDpQFwNhpTLisajF9V8ldrAj9L
         kCgw==
X-Gm-Message-State: ACrzQf0eMUBMNthqlEgdFhM3dOHe8M56xa0gygNWdG5+j48R761jaGkM
        MTm7RWA8uAYumjp99uWbai1whe1dZYzi9aRTTZUrkr5XiZE=
X-Google-Smtp-Source: AMsMyM5nEwK755O4EVFdHZ1YVXdjoPdmRUI4r48lBSfsjdgk2YUg7wxh9pzlZVDPVSun9kbE66thrfuzqWfxlW7MWCA=
X-Received: by 2002:a17:90a:aa96:b0:205:bb67:a85f with SMTP id
 l22-20020a17090aaa9600b00205bb67a85fmr2654224pjq.202.1664443502430; Thu, 29
 Sep 2022 02:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220928165420.1212284-1-dinguyen@kernel.org>
In-Reply-To: <20220928165420.1212284-1-dinguyen@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Sep 2022 11:24:24 +0200
Message-ID: <CAPDyKFp5oPuOz9A=37pRTvq7JPtJRdduEgmU9g+eUm0K=dZjUg@mail.gmail.com>
Subject: Re: [PATCHv4 1/3] dt-bindings: mmc: synopsys-dw-mshc: document "altr,sysmgr-syscon"
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     jh80.chung@samsung.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 28 Sept 2022 at 18:54, Dinh Nguyen <dinguyen@kernel.org> wrote:
>
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
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> index ae6d6fca79e2..b73324273464 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> @@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>
>  title: Synopsys Designware Mobile Storage Host Controller Binding
>
> -allOf:
> -  - $ref: "synopsys-dw-mshc-common.yaml#"
> -
>  maintainers:
>    - Ulf Hansson <ulf.hansson@linaro.org>
>
> @@ -38,6 +35,34 @@ properties:
>        - const: biu
>        - const: ciu
>
> +  altr,sysmgr-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to the sysmgr node
> +          - description: register offset that controls the SDMMC clock phase
> +    description:
> +      Contains the phandle to System Manager block that contains
> +      the SDMMC clock-phase control register. The first value is the pointer
> +      to the sysmgr and the 2nd value is the register offset for the SDMMC
> +      clock phase register.
> +
> +allOf:
> +  - $ref: "synopsys-dw-mshc-common.yaml#"
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const:
> +              - altr,socfpga-dw-mshc
> +    then:
> +      required:
> +        - altr,sysmgr-syscon
> +    else:
> +      properties:
> +        altr,sysmgr-syscon: false

So this change will not be backwards compatible with existing DTBs. I
noticed that patch2 updates the DTS files for the arm64 platforms, but
there seems to be some arm32 platforms too. Isn't this going to be a
problem?

> +
>  required:
>    - compatible
>    - reg
> --
> 2.25.1
>

Kind regards
Uffe
