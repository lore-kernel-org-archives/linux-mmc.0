Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0ACC77B79
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Apr 2023 14:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjDQOyt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Apr 2023 10:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDQOys (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Apr 2023 10:54:48 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9740386BE
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 07:54:42 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-552ae3e2cbeso48451267b3.13
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 07:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681743282; x=1684335282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R41AeUQLg4hcYgCBHVVzM5K8dJVEmg+tpTKo/58aTE0=;
        b=qp/RU/tZ8c9QibLLkfuRZKc4VV/Y3Sze5ebucqBO8DQnBcO1id9Z69kTSpJrNAhaJM
         6F/IR4pN7tefusqUJQ+W6669dl47+KPFRVh/07RGgRXA2UGEO9Iw4tiRHiyYa/fklI6p
         bHRDdpWYPnTS3KDarFqUzqHHuLCz22szD2xRPjoRbIZnYdIA9Qp3yghz/Obj7ZZKbNJE
         26MAaDWTRR67eU1Qj5Mb/WkRgkFwVC7keg2Himobd51My/K7Uo7loMevYKvKtjj53k9W
         xehufYih/4KwkiH3FOQR8zkNPAlEFvbJlvnBLlhmGegXWKew+Bg1sY5X8jMiRzEfDjIt
         qmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681743282; x=1684335282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R41AeUQLg4hcYgCBHVVzM5K8dJVEmg+tpTKo/58aTE0=;
        b=hrXe/mfU0ttZziYTMNtk8/wAEqX3Rx7s4wY6Nxza/BuE+ihriRF/dWZuuXmEBSu3yT
         nAGoCh4dgUt40G2TvZksTjm2b2YFi0HqPWCwssj/v72/BbeFDhSAtwYzX9VWcSCj8b8k
         UdVpOmDOieokBaAxM3QJ6+yFVWE11SB2Hvx+oPUwRmO94xU54I4t8D0MGy87a1sl9Cyr
         D3w75MkexuBDc+YGvWzQSB7FQ5zwpa9mOtFchpoXg8SaggbESkOgC19SwvJzYNxw/Hos
         3l9mXgyOThTwmOmKRONkdof4mTkFi/xf5UfDzDt4ViMTTQuld9mks+kDO/Dxyjvxl+1A
         oAYw==
X-Gm-Message-State: AAQBX9epLmUMyIVCb6EUDXyzjtDPboWtz9GAxr8TA55m9Yj2XuMhR/H0
        FkkxhAky3XobTDgfcybh8WWNrg83O2t7DkAH8Lcoqg==
X-Google-Smtp-Source: AKy350bxc+yUnTMvf2f3Qjl/DLWjDhm1D86ReqCMeZQnOQNdBoVdL/OgE4TnolqgRqvLHc/aS6MlBtb231Frx6uhovQ=
X-Received: by 2002:a81:af1e:0:b0:52e:e095:d840 with SMTP id
 n30-20020a81af1e000000b0052ee095d840mr9538060ywh.0.1681743281393; Mon, 17 Apr
 2023 07:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230410184526.15990-1-blarson@amd.com> <20230410184526.15990-3-blarson@amd.com>
In-Reply-To: <20230410184526.15990-3-blarson@amd.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 17 Apr 2023 16:54:05 +0200
Message-ID: <CAPDyKFr5g3NiarFVMtjUHMvjdcKc4m-EpcKZctfgNSQpK9e_-Q@mail.gmail.com>
Subject: Re: [PATCH v13 02/15] dt-bindings: mmc: cdns: Add AMD Pensando Elba SoC
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        vaishnav.a@ti.com, will@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 10 Apr 2023 at 20:46, Brad Larson <blarson@amd.com> wrote:
>
> AMD Pensando Elba ARM 64-bit SoC is integrated with this IP and
> explicitly controls byte-lane enables.
>
> Signed-off-by: Brad Larson <blarson@amd.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v12_changes:
> - Drop 'resets: false' in the amd,pensando-elba-sd4hc else properties. Passed
>   dtbs_check and dt_binding_check with both versions.
>
> v11 changes:
> - Remove resets description and reset-names
> - Add descriptions for amd,pensando-elba-sd4hc reg items
>
> v10 changes:
> - Move reset-names property definition next to existing resets prop
> - Move allOf to the bottom and set resets/reset-names required only for pensando
> - Fix reg maxItems for existing, must be 1
>
> v9 changes:
> - Add reset-names and resets properties
> - Add if/then on property amd,pensando-elba-sd4hc to set reg property
>   values for minItems and maxItems
>
> ---
>  .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 27 ++++++++++++++++---
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index adacd0535c14..6c40611405a0 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -9,19 +9,18 @@ title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
>  maintainers:
>    - Masahiro Yamada <yamada.masahiro@socionext.com>
>
> -allOf:
> -  - $ref: mmc-controller.yaml
> -
>  properties:
>    compatible:
>      items:
>        - enum:
> +          - amd,pensando-elba-sd4hc
>            - microchip,mpfs-sd4hc
>            - socionext,uniphier-sd4hc
>        - const: cdns,sd4hc
>
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 2
>
>    interrupts:
>      maxItems: 1
> @@ -120,6 +119,26 @@ required:
>    - interrupts
>    - clocks
>
> +allOf:
> +  - $ref: mmc-controller.yaml
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amd,pensando-elba-sd4hc
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - description: Host controller registers
> +            - description: Elba byte-lane enable register for writes
> +      required:
> +        - resets
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
> +
>  unevaluatedProperties: false
>
>  examples:
> --
> 2.17.1
>
