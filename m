Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386A7C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Sep 2021 17:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E9260FBF
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Sep 2021 17:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243942AbhIFRL6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Sep 2021 13:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243931AbhIFRL6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2021 13:11:58 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F94CC06175F
        for <linux-mmc@vger.kernel.org>; Mon,  6 Sep 2021 10:10:53 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m4so12307540ljq.8
        for <linux-mmc@vger.kernel.org>; Mon, 06 Sep 2021 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4mmRqWH9FmfPYxUKvRbn5V1v9mP3NzsGHd5mH5mhOcM=;
        b=csHzkOvc+wtXwzCLGIGf5fcuc8ANBD823C9xk5KWC5dK+FbKg8vk83BWBEeSrxrllI
         jzOL5RfckAvDaToS2aF019YLAXyGWQwc2eym1nc0JvJyPoHhWiiZ0md5USZXavRrtT1c
         awnroW8kr+zHdfkoJ6LW/asKjprklqV+FZyuZDG8we6hQaP1NtJrIFWI2Iz14aHFRPq2
         srfx4UDITI1QgOu2GJQG6APK4ex6BM7dmLG+o44Ri8cl18Y7Dxy23u6+IK3tYTGMYoJd
         mLtsoLdLM3W0ZwhVMB+/dIG6nF/CqRyR1BRGPCAY17gJc3/iHBYuWPrYAiuhd6dCDW/n
         uxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4mmRqWH9FmfPYxUKvRbn5V1v9mP3NzsGHd5mH5mhOcM=;
        b=oZF9hBhm4N5nsejLP5SCNno2ovX9riPwD3HoThh+kiDjGyT/BjLdNGyKjn4xSs/V6N
         7e/GNv6AQiJ6omup2atxuIf0hQ+hSKGyTe2HEKa738hSZBQczV5lPQv1UvjP7Wj/a5kP
         B6dtnoJb+CpJNzRDTeB91xmWF2F6lZfXLhThedH84vGub1CKcFyqe8U0Gga6HzuvcCxF
         Twgi9wf9TxwcArtBCSCo7atMwIETNOyK28UM1ql6lPU/ksjj0aAEaYCSgozHpiw2pAWV
         a/Fir/9iF+trXVYXr+fJXXyIuGXCAU5uAjtE44VxjKzodeafb6MpGtqMKzOKOkyDjZ7c
         Q38A==
X-Gm-Message-State: AOAM533PjHaeb9NQK6QpQOO4NKEe2ztzt+67gjFcdTx0rOH3taAwYdAC
        5haNtUagKq7aAXaSoTQVo/x7p5Vp5GbuqDV00M6cew==
X-Google-Smtp-Source: ABdhPJysVoEfhX4+GoPgW0jucP/iP8OeiLdfs2kPS3Ae8x/doisyNjE0me2SwVWUxd5suoycyqfgomRweBFiACxh0lk=
X-Received: by 2002:a2e:b610:: with SMTP id r16mr11493045ljn.367.1630948251396;
 Mon, 06 Sep 2021 10:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210901091852.479202-1-maxime@cerno.tech> <20210901091852.479202-31-maxime@cerno.tech>
In-Reply-To: <20210901091852.479202-31-maxime@cerno.tech>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Sep 2021 19:10:15 +0200
Message-ID: <CAPDyKFrZr-+QeVE7DtZqVWDLFgLi1wYOzTMngD9JYXJBQ-ZtLA@mail.gmail.com>
Subject: Re: [PATCH v2 30/52] dt-bindings: mmc: Convert MMC Card binding to a schema
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 1 Sept 2021 at 11:19, Maxime Ripard <maxime@cerno.tech> wrote:
>
> MMC Cards can have an optional Device Tree binding to add
> non-discoverable properties.
>
> Now that we have the DT validation in place, let's convert the device
> tree bindings for that driver over to a YAML schema.
>
> Some of these properties were already described in the MMC controller
> binding, even though they are not generic and do not apply to any
> device, so we took the occasion to fix this.
>
> Cc: linux-mmc@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>

Queued for v5.16 on the temporary devel branch, thanks!

Kind regards
Uffe


> ---
>
> Changes from v1:
>   - Fixed additionalProperties
> ---
>  .../devicetree/bindings/mmc/mmc-card.txt      | 30 ------------
>  .../devicetree/bindings/mmc/mmc-card.yaml     | 48 +++++++++++++++++++
>  .../bindings/mmc/mmc-controller.yaml          |  6 ---
>  3 files changed, 48 insertions(+), 36 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-card.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc-card.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.txt b/Documentation/devicetree/bindings/mmc/mmc-card.txt
> deleted file mode 100644
> index 8d2d71758907..000000000000
> --- a/Documentation/devicetree/bindings/mmc/mmc-card.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -mmc-card / eMMC bindings
> -------------------------
> -
> -This documents describes the devicetree bindings for a mmc-host controller
> -child node describing a mmc-card / an eMMC, see "Use of Function subnodes"
> -in mmc.txt
> -
> -Required properties:
> --compatible : Must be "mmc-card"
> --reg        : Must be <0>
> -
> -Optional properties:
> --broken-hpi : Use this to indicate that the mmc-card has a broken hpi
> -              implementation, and that hpi should not be used
> -
> -Example:
> -
> -&mmc2 {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&mmc2_pins_a>;
> -       vmmc-supply = <&reg_vcc3v3>;
> -       bus-width = <8>;
> -       non-removable;
> -
> -       mmccard: mmccard@0 {
> -               reg = <0>;
> -               compatible = "mmc-card";
> -               broken-hpi;
> -       };
> -};
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-card.yaml b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> new file mode 100644
> index 000000000000..b17d454442b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/mmc-card.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/mmc-card.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MMC Card / eMMC Generic Device Tree Bindings
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>
> +
> +description: |
> +  This documents describes the devicetree bindings for a mmc-host controller
> +  child node describing a mmc-card / an eMMC.
> +
> +properties:
> +  compatible:
> +    const: mmc-card
> +
> +  reg:
> +    const: 0
> +
> +  broken-hpi:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Use this to indicate that the mmc-card has a broken hpi
> +      implementation, and that hpi should not be used.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mmc {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        card@0 {
> +            compatible = "mmc-card";
> +            reg = <0>;
> +            broken-hpi;
> +        };
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 25ac8e200970..513f3c8758aa 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -333,12 +333,6 @@ patternProperties:
>                subnode describes. A value of 0 denotes the memory SD
>                function, values from 1 to 7 denote the SDIO functions.
>
> -      broken-hpi:
> -        $ref: /schemas/types.yaml#/definitions/flag
> -        description:
> -          Use this to indicate that the mmc-card has a broken hpi
> -          implementation, and that hpi should not be used.
> -
>      required:
>        - reg
>
> --
> 2.31.1
>
