Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEF3C432BE
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 15:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E2DF61151
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 15:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbhHXPim (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:38:42 -0400
Received: from mail-vk1-f181.google.com ([209.85.221.181]:44941 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbhHXPim (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 11:38:42 -0400
Received: by mail-vk1-f181.google.com with SMTP id n200so5627126vke.11;
        Tue, 24 Aug 2021 08:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8W/b4Zs7QlTFiLiHqg4R1eNWEYzfOGp8NKoTU4rVhKA=;
        b=RPeurstyYiWf/UhoO+FkDXR0YD7x6jifnJTYErbm91f9WiOWytWrMCGaibfFbzckre
         cJ4tLbKN7B5Sgnf234ok95WkZ05PmYoAE8fwJ2QjlY2Y17M5R0l2Ktv9OU1v88AnIopm
         DSxjbiv4bO2+4Rz6ngl1eBUEgRD8R0AHpbwIbi+FUD+mcWTGdtnE3uLOzI5xoFBfX/lB
         vWIrHBbBM4KYtbQQ9fer9C4JmceploOqpVXFS/UphtcdpSx1AJ9fUkc/ydBFtmXkPCr1
         ChSpSW0kJmkxWisgpplrZCfaOzLLhN/lz47KLWLKI83ElIwo7WJschSIj9Dr8TxZwSlR
         jOsw==
X-Gm-Message-State: AOAM531pCHLdOaONbHRlY3zIweQmV59AODZ2XXP4pe/D6n602fXqGGbf
        Ns4XVhhzkyR7pmertaeX03H4YaZDOfaQdZhCgHU=
X-Google-Smtp-Source: ABdhPJw7X4YBRuB9DCRyn1OtJxsT/kOHIFh2YwXUt+EqIC8Jx4d0sSzrsnrXnQx1sQoSqUrpfEzwwX8ZXeMi/JsubkE=
X-Received: by 2002:a1f:2c97:: with SMTP id s145mr22706660vks.24.1629819477568;
 Tue, 24 Aug 2021 08:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com> <20210819154436.117798-5-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210819154436.117798-5-krzysztof.kozlowski@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 24 Aug 2021 17:37:46 +0200
Message-ID: <CAMuHMdWN3Y9Ca9J-iJFpmDAYKpNH5GQuf3yFdyyb2rem8z_spg@mail.gmail.com>
Subject: Re: [PATCH 5/6] riscv: microchip: mpfs: drop duplicated MMC/SDHC node
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Atish Patra <atish.patra@wdc.com>,
        Yash Shah <yash.shah@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>,
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

On Thu, Aug 19, 2021 at 5:45 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
> Devicetree source is a description of hardware and hardware has only one
> block @20008000 which can be configured either as eMMC or SDHC.  Having
> two node for different modes is an obscure, unusual and confusing way to
> configure it.  Instead the board file is supposed to customize the block
> to its needs, e.g. to SDHC mode.
>
> This fixes dtbs_check warning:
>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: sdhc@20008000: $nodename:0: 'sdhc@20008000' does not match '^mmc(@.*)?$'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Thanks for your patch!

> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> @@ -43,8 +43,16 @@ &serial3 {
>         status = "okay";
>  };
>
> -&sdcard {
> +&mmc {
>         status = "okay";
> +
> +       disable-wp;
> +       cap-sd-highspeed;
> +       card-detect-delay = <200>;
> +       sd-uhs-sdr12;
> +       sd-uhs-sdr25;
> +       sd-uhs-sdr50;
> +       sd-uhs-sdr104;
>  };
>
>  &emac0 {
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> index cb54da0cc3c4..c4ccd7e4d3eb 100644
> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> @@ -262,25 +262,7 @@ serial3: serial@20104000 {
>                         status = "disabled";
>                 };
>
> -               emmc: mmc@20008000 {
> -                       compatible = "cdns,sd4hc";
> -                       reg = <0x0 0x20008000 0x0 0x1000>;
> -                       interrupt-parent = <&plic>;
> -                       interrupts = <88 89>;

Note that the other node has only a single interrupt.
Which one is correct?

> -                       pinctrl-names = "default";
> -                       clocks = <&clkcfg 6>;
> -                       bus-width = <4>;
> -                       cap-mmc-highspeed;
> -                       mmc-ddr-3_3v;
> -                       max-frequency = <200000000>;
> -                       non-removable;
> -                       no-sd;
> -                       no-sdio;
> -                       voltage-ranges = <3300 3300>;
> -                       status = "disabled";
> -               };
> -
> -               sdcard: sdhc@20008000 {
> +               mmc: mmc@20008000 {
>                         compatible = "cdns,sd4hc";
>                         reg = <0x0 0x20008000 0x0 0x1000>;
>                         interrupt-parent = <&plic>;
> @@ -288,13 +270,6 @@ sdcard: sdhc@20008000 {
>                         pinctrl-names = "default";
>                         clocks = <&clkcfg 6>;
>                         bus-width = <4>;

I think bus-width should be moved to the board .dts, too.

> -                       disable-wp;
> -                       cap-sd-highspeed;
> -                       card-detect-delay = <200>;
> -                       sd-uhs-sdr12;
> -                       sd-uhs-sdr25;
> -                       sd-uhs-sdr50;
> -                       sd-uhs-sdr104;
>                         max-frequency = <200000000>;
>                         status = "disabled";
>                 };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
