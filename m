Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD981C4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D9B61246
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbhHXO5v (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbhHXO5u (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 10:57:50 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EA7C061764
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:06 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id i28so38167625ljm.7
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q47KpM04JtXbjrX4Th8KJJ2WJfmQTigKdxRxjyOEcFo=;
        b=irzcDqLfZcL8M9bY1pfhENXo7KmRfT4Wa6liQxiru7DlQIPrr1a1jcv+sdlnVTnfNF
         kTz3nq4Terj5e/D8wMuUpLch/sXpwIiGVaq/EdRAeC7Xgc2CuBuDMHzM5AJFzczgmdbP
         kK7r68SgojvNOSfuRDLqBqnDF/bg+ugza3KEjo6vIH50Eb9gFaSWJIgIhUwGtgtTwIoh
         C3nNBskl60FUC8rW3xPt7l7xfXwFnzHL2r+nJvVQhdav3DmrDGvkOqQgLLTDWOPBM67c
         cYhCheaEK39sFD1rWMqyYpBsWve18iBR7JNHv2FHSYV37DsIH86p5FEl5d21EtJAxhuN
         moRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q47KpM04JtXbjrX4Th8KJJ2WJfmQTigKdxRxjyOEcFo=;
        b=aH74w6VSYfWszpTvswSNMXwcy1FPxLqgDo0a8MDPkyd86qX1w+oz3FRiaiyPCTIsc6
         6tKsxuhrlsjzMjuA1KYhWv8y1tQs3Q7oIRXN02Qv1dnrN5VIOokapQdWqnSlkhaXy4FJ
         LfoyBMlj8pRWFbFxPh+I7EUEZ5zSbCTwnn8ugtShShtSrvst3ncBNIxtxC1xom4REDU4
         scV4KngjTAqvydhepFgpFdZYOdUPz27UKzr9GIiGYfeO6bB2r306d/KXdatPwYWToTVN
         zBTuzAi/HcVhMreHXQSyriEkrYQ1sbxoR6PPwWMT2yShYSZeEd5lxLiMkL/reSNMEQC3
         /5Og==
X-Gm-Message-State: AOAM532my2ZTbLpJngpf938idv87A4Va47BaycXyNyenQp6Z7CJK0WF3
        WpmuAlgIIza3jQWqdMTytNoCFq2+WKFAoNiIflIOzQ==
X-Google-Smtp-Source: ABdhPJwfFJKHpnxXv8/1gum9S+upuN8rQP4xRwN2p75hcpwjG5NXTI3vyGKYLQMErsI6Eqom9XZxt10tCGCE/VjFsV0=
X-Received: by 2002:a2e:84ca:: with SMTP id q10mr18815903ljh.182.1629817024632;
 Tue, 24 Aug 2021 07:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210817090313.31858-1-biju.das.jz@bp.renesas.com> <20210817090313.31858-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20210817090313.31858-2-biju.das.jz@bp.renesas.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 16:56:27 +0200
Message-ID: <CAPDyKFrTKSLS8+Wsgj1m_2FtidQJ629ZJXswtxn3JbahozSHOg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: mmc: renesas,sdhi: Fix dtbs-check warning
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 17 Aug 2021 at 11:03, Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Fix dtbs-check warning pinctrl-names:0:'default' was expected
> for r8a77470-iwg23s-sbc.dts file.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v3->v4:
>  * Removed duplicate clock-names for sdhi-r7sxxxx SoC's
>  Ref:- https://patchwork.kernel.org/project/linux-renesas-soc/patch/20210804161325.26996-2-biju.das.jz@bp.renesas.com/
> v3:
>  * New patch to fix the dtbs-check warnings
>  Ref:- https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210804091940.23983-1-biju.das.jz@bp.renesas.com/
> ---
>  .../devicetree/bindings/mmc/renesas,sdhi.yaml | 60 ++++++++++++-------
>  1 file changed, 37 insertions(+), 23 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 677989bc5924..43584f4f4c7e 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -9,9 +9,6 @@ title: Renesas SDHI SD/MMC controller
>  maintainers:
>    - Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> -allOf:
> -  - $ref: "mmc-controller.yaml"
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -104,14 +101,46 @@ properties:
>    pinctrl-1:
>      maxItems: 1
>
> -  pinctrl-names:
> -    minItems: 1
> -    items:
> -      - const: default
> -      - const: state_uhs
> +  pinctrl-names: true
>
>    max-frequency: true
>
> +allOf:
> +  - $ref: "mmc-controller.yaml"
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,sdhi-mmc-r8a77470
> +    then:
> +      properties:
> +        pinctrl-names:
> +          items:
> +            - const: state_uhs
> +    else:
> +      properties:
> +        pinctrl-names:
> +          minItems: 1
> +          items:
> +            - const: default
> +            - const: state_uhs
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - renesas,sdhi-r7s72100
> +              - renesas,sdhi-r7s9210
> +    then:
> +      required:
> +        - clock-names
> +      description:
> +        The internal card detection logic that exists in these controllers is
> +        sectioned off to be run by a separate second clock source to allow
> +        the main core clock to be turned off to save power.
> +
>  required:
>    - compatible
>    - reg
> @@ -119,21 +148,6 @@ required:
>    - clocks
>    - power-domains
>
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        enum:
> -          - renesas,sdhi-r7s72100
> -          - renesas,sdhi-r7s9210
> -then:
> -  required:
> -    - clock-names
> -  description:
> -    The internal card detection logic that exists in these controllers is
> -    sectioned off to be run by a separate second clock source to allow
> -    the main core clock to be turned off to save power.
> -
>  unevaluatedProperties: false
>
>  examples:
> --
> 2.17.1
>
