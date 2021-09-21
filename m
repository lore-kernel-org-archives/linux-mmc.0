Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85F2C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 11:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C504D60F56
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 11:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhIULsC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Sep 2021 07:48:02 -0400
Received: from mail-vs1-f43.google.com ([209.85.217.43]:42704 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhIULsB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2021 07:48:01 -0400
Received: by mail-vs1-f43.google.com with SMTP id z62so19881811vsz.9;
        Tue, 21 Sep 2021 04:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32w66s9nGR0myw/PUWAuk6HxhY9nPwbFGQyXVEOk8kc=;
        b=vswgv3C2lwiwBcw/LgivXjxOlqnkLHHX16ieDTDh82XktAnPhWs6ZrOUoRURwo8/fX
         11OyVtRhoxF0a7qnYB0zvqeIHBEqOrASTC+lqjgwdK0ieCJS/ciKO2Apt8SsaH8QvHhS
         QYej185oSumpFbHGpQ+xz7mi8g5Q3lMVFjPsdFS7LSgnMuKl5JvmJW8ECcH3d+X9t9mR
         WyJXVzPpoRcl9a4IPX5CNH8YxX7eB/05guZTeU+8R4T0q/qyiExl7Zktg/0XJoX70VVA
         lNuDXUCgcKitSudLAdcmBWD5s9vkpeT3ffLe0TCQ1CJlP3/8GNE9RCyUEIx0lBjtnWnr
         eXRA==
X-Gm-Message-State: AOAM530B0edRiXuec3DsPH3t2/iGUz0uvEN4YzOh+kMa1n8XS/JDbIXr
        hCY6XHkmlLPPZErlVxPWX+qCJIxGJ2Iz+Rr91cg=
X-Google-Smtp-Source: ABdhPJye1i8aFM/j00ORdKt9DIgrNHrCPlMSCXq8HNDzH1ddHulVLAIUqAuRnCTX57TKQLrpNhL5Jrdhn4r9BvG/rjA=
X-Received: by 2002:a67:2c58:: with SMTP id s85mr2943626vss.35.1632224793210;
 Tue, 21 Sep 2021 04:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com> <20210920150807.164673-3-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210920150807.164673-3-krzysztof.kozlowski@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Sep 2021 13:46:22 +0200
Message-ID: <CAMuHMdWFhHgT0vqcZnZ4kaMs3jSYtVM4asEkMv3T-xdadiimAQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] riscv: dts: microchip: fix board compatible
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Krzysztof,

On Mon, Sep 20, 2021 at 5:09 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> According to bindings, the compatible must include microchip,mpfs.  This
> fixes dtbs_check warning:
>
>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: /: compatible: ['microchip,mpfs-icicle-kit'] is too short
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> @@ -10,7 +10,7 @@
>
>  / {
>         model = "Microchip PolarFire-SoC Icicle Kit";
> -       compatible = "microchip,mpfs-icicle-kit";
> +       compatible = "microchip,mpfs-icicle-kit", "microchip,mpfs";
>
>         aliases {
>                 ethernet0 = &emac1;
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> index 93730afe6c58..5084b93188f0 100644
> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> @@ -7,7 +7,7 @@ / {
>         #address-cells = <2>;
>         #size-cells = <2>;
>         model = "Microchip MPFS Icicle Kit";

Note that "model" should be "Microchip PolarFire SoC"
(with/without a hyphen? seems like the occurrence in
 microchip-mpfs-icicle-kit.dts is the only one with a hyphen)

> -       compatible = "microchip,mpfs-icicle-kit";
> +       compatible = "microchip,mpfs";
>
>         chosen {
>         };

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
