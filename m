Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FD1C433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 19 May 2021 15:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA24B611AB
	for <linux-mmc@archiver.kernel.org>; Wed, 19 May 2021 15:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354767AbhESPdS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 May 2021 11:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348767AbhESPdS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 May 2021 11:33:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EE3361019;
        Wed, 19 May 2021 15:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621438318;
        bh=Pp9uCW3AaAAFucW1ZRdceT5C99Ft/a24sAcuMTGRUXY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kIKVE2P5nKYPHnG2bFtf4tnvkTCj65MGByQTK264OliAYsMCG4OP93Od5lMfH6Ejc
         dcDkCE0un+7CmLcU5Q+GfI/LjvCTB90WGTl+aA+AYQJIX8gAg0eYpQg9ZkIHvFQ9QE
         JQYygsTkWA8hb21nY5ZiJWVK4iYSjvILsVVFKyCaDZg5yLMVgOOm3bB+16SlqmPmdM
         GdB0aMgR2GwCWJh8d04pRswa2knntYoP3kMvZqcb/eeuGiYvEb2pz1qFFAsfjQI8JK
         FDNznrk+b5KVTMIF8NPiTXYoIu5IbCUOq6fl4p6lcFjlV2Ccnx5+9BU12mvo4+Sm+d
         aEj2dnE+kEHVQ==
Received: by mail-ej1-f49.google.com with SMTP id p24so19343344ejb.1;
        Wed, 19 May 2021 08:31:58 -0700 (PDT)
X-Gm-Message-State: AOAM531xQkcRVjGaFKy4g3yDtxmgYRtO5KveULKXVwVzV+cmPOmjZ4Gt
        /XteMomoD0/TjBwnMIAv0us9QIQe47akIfwnAA==
X-Google-Smtp-Source: ABdhPJxRe9+ca4zAjdafpMbaymsXWbQ36cV4d4yEdABSodXTvmV76Z+Qq00tM83/XvGOlQVzFpmRfOf9lOZBUZwSQ6w=
X-Received: by 2002:a17:907:76b8:: with SMTP id jw24mr13264887ejc.359.1621438316913;
 Wed, 19 May 2021 08:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210519024630.1902477-1-robh@kernel.org>
In-Reply-To: <20210519024630.1902477-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 19 May 2021 10:31:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLb+v8a9WFqMTj8iomG3e-rdg-LMHQsD6G9EACPNXBpEg@mail.gmail.com>
Message-ID: <CAL_JsqLb+v8a9WFqMTj8iomG3e-rdg-LMHQsD6G9EACPNXBpEg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Drop the "sdhci" compatible example
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, May 18, 2021 at 9:46 PM Rob Herring <robh@kernel.org> wrote:
>
> The "sdhci" compatible is not documented though used as a fallback in a
> few cases. It is also not supported by a Linux driver. Just remove the
> example as part of ridding examples of undocumented bindings.

v2 comming, this also needs the compatible string for
brcm,bcm43xx-fmac updated...

>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mmc/mmc-controller.yaml  | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index e141330c1114..6bf97cdd9507 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -357,22 +357,6 @@ dependencies:
>  additionalProperties: true
>
>  examples:
> -  - |
> -    mmc@ab000000 {
> -        compatible = "sdhci";
> -        reg = <0xab000000 0x200>;
> -        interrupts = <23>;
> -        bus-width = <4>;
> -        cd-gpios = <&gpio 69 0>;
> -        cd-inverted;
> -        wp-gpios = <&gpio 70 0>;
> -        max-frequency = <50000000>;
> -        keep-power-in-suspend;
> -        wakeup-source;
> -        mmc-pwrseq = <&sdhci0_pwrseq>;
> -        clk-phase-sd-hs = <63>, <72>;
> -    };
> -
>    - |
>      mmc3: mmc@1c12000 {
>          #address-cells = <1>;
> --
> 2.27.0
>
