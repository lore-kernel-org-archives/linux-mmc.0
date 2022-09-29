Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8B8C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Sep 2022 11:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiI2LFj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Sep 2022 07:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiI2LFi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2022 07:05:38 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6027E92599
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2022 04:05:33 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 70so997964pjo.4
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2022 04:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yF0bUAb9e3HoD+z9QhDD/iTK1qOjet7jClHpQspWpbs=;
        b=TG+kTV4MscBuL/BeGN5x8R5RiLDNIyFFN5c6jSa6JPSNKBXl65277cbm+Z1C1HiOpY
         keyFP9EmFuc6eJJ+0dEB8pFAPd/1oM0Pv+AEh26OfyguHgIjOlUN9lCpXo48nkJFf+mP
         +18GSQgtLcghF1ouTFPFoFw5XS358kX7EMQgFMnPxgEwxDsfnWJBbHgFKgmSwCL1g5HV
         BAGdaHYNFS6J2zPP0WHItPjATKXuzOSMuPz8zfLKS0w6+a0vLZEvL1/m8ej75kYrEAXy
         Yf23Ir5ayE50dLGh3lUvAgyDzbU44t8hNAo+Pb4agxZuRry5zAmVofJ1fETUzMhD3OAE
         XScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yF0bUAb9e3HoD+z9QhDD/iTK1qOjet7jClHpQspWpbs=;
        b=4KXM2ujvWVL+6BqSb8h4OG3D00gSqdK9D+Ponmv6J+Wh76omWYd18zsv/DVClYXlvC
         lbpzS+k57mvtZk62Q/PLbrOSKdWiGvwJarbWq5a0WT7kQ8LjlFHdB60ydmBy71xClo8Y
         MYAKP4ezKPcAHwhc8pmNBWExNzgyIRSh1jOVoDJ+Q+UlGVAUgfvkDFj/SMkZj82nHmeP
         0/6uOEJ29rNaIIxgerHuWU2N/TCRtFYvLCos5Z4kRaFABKflcXEEd+UONPhl7ohIt/5A
         91Fpfttzj7Mm+JUrj0JOwEmQEBUpNTjK+vKZYfpVYYyZLEt987WkXawvGdYqqN1DA38N
         PbHQ==
X-Gm-Message-State: ACrzQf0y/vfGkkTsuDDe3UmJKxfq+nca/iAPFEWi9pn4i76zDnoXcPdd
        WFZUYR34WBbgNcTkCa/7q96TCT6Gb0f7y0KzHUou6Q==
X-Google-Smtp-Source: AMsMyM4LXTZNTpbaB2YmB8EbmJUv7BOvclWHiFwcjBsNhs0fFFq4epzNQM4I8A6yWcE4sNQYLNDKd0OitvJy0pbVQV0=
X-Received: by 2002:a17:90a:aa96:b0:205:bb67:a85f with SMTP id
 l22-20020a17090aaa9600b00205bb67a85fmr3093514pjq.202.1664449533446; Thu, 29
 Sep 2022 04:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220928165420.1212284-1-dinguyen@kernel.org> <CAPDyKFp5oPuOz9A=37pRTvq7JPtJRdduEgmU9g+eUm0K=dZjUg@mail.gmail.com>
 <0fff7922-7932-dda7-f476-32f4b0d09fa0@linaro.org>
In-Reply-To: <0fff7922-7932-dda7-f476-32f4b0d09fa0@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 29 Sep 2022 13:04:57 +0200
Message-ID: <CAPDyKFohA9gKu8qwR+YUCy46tepO3k7fQqcHPvjYMznDmckLzg@mail.gmail.com>
Subject: Re: [PATCHv4 1/3] dt-bindings: mmc: synopsys-dw-mshc: document "altr,sysmgr-syscon"
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>, jh80.chung@samsung.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 29 Sept 2022 at 11:39, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/09/2022 11:24, Ulf Hansson wrote:
> > On Wed, 28 Sept 2022 at 18:54, Dinh Nguyen <dinguyen@kernel.org> wrote:
> >>
> >> Document the optional "altr,sysmgr-syscon" binding that is used to
> >> access the System Manager register that controls the SDMMC clock
> >> phase.
> >>
> >> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> >> ---
> >> v4: add else statement
> >> v3: document that the "altr,sysmgr-syscon" binding is only applicable to
> >>     "altr,socfpga-dw-mshc"
> >> v2: document "altr,sysmgr-syscon" in the MMC section
> >> ---
> >>  .../bindings/mmc/synopsys-dw-mshc.yaml        | 31 +++++++++++++++++--
> >>  1 file changed, 28 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> >> index ae6d6fca79e2..b73324273464 100644
> >> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> >> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
> >> @@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >>
> >>  title: Synopsys Designware Mobile Storage Host Controller Binding
> >>
> >> -allOf:
> >> -  - $ref: "synopsys-dw-mshc-common.yaml#"
> >> -
> >>  maintainers:
> >>    - Ulf Hansson <ulf.hansson@linaro.org>
> >>
> >> @@ -38,6 +35,34 @@ properties:
> >>        - const: biu
> >>        - const: ciu
> >>
> >> +  altr,sysmgr-syscon:
> >> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >> +    items:
> >> +      - items:
> >> +          - description: phandle to the sysmgr node
> >> +          - description: register offset that controls the SDMMC clock phase
> >> +    description:
> >> +      Contains the phandle to System Manager block that contains
> >> +      the SDMMC clock-phase control register. The first value is the pointer
> >> +      to the sysmgr and the 2nd value is the register offset for the SDMMC
> >> +      clock phase register.
> >> +
> >> +allOf:
> >> +  - $ref: "synopsys-dw-mshc-common.yaml#"
> >> +
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            const:
> >> +              - altr,socfpga-dw-mshc
> >> +    then:
> >> +      required:
> >> +        - altr,sysmgr-syscon
> >> +    else:
> >> +      properties:
> >> +        altr,sysmgr-syscon: false
> >
> > So this change will not be backwards compatible with existing DTBs. I
> > noticed that patch2 updates the DTS files for the arm64 platforms, but
> > there seems to be some arm32 platforms too. Isn't this going to be a
> > problem?
> >
>
> The backwards compatibility is actually expressed by the driver. If the
> driver keeps ABI, we can change bindings so that all DTS are being
> updated to pass the checks.

Right.

So, I should probably have responded to patch3 instead, as backwards
compatibility doesn't seem to be supported, unless I am mistaken. But
let's move the discussion over to that thread instead.

>
> On the other hand, the commit should express why it changes the bindings
> in incompatible way - this is lacking here.
>
> Best regards,
> Krzysztof
>

Kind regards
Uffe
