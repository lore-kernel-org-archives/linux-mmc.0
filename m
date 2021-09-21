Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E55C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 11:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD9761100
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Sep 2021 11:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhIUL7B (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Sep 2021 07:59:01 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:45184
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232276AbhIUL7B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2021 07:59:01 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EE6A240267
        for <linux-mmc@vger.kernel.org>; Tue, 21 Sep 2021 11:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632225450;
        bh=Edrk8YB/JSUDN6TkY8ir7fMmkzEbx6D96lPgLtCkIX0=;
        h=To:References:From:Subject:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=qcBfR45+D2cnz8JbPwwcmSxWCUS3nLrqJ9KmgIxLMzffuuOTCirpTRs3SVPuE+cBf
         TuLZN0aUNupFCVY04dQUaYGUvY1ho8fqh6624BrvhrCAMaLIjiAAMFWSaFe7C/8Fem
         GlqVjgpEuknIg/4AeDi5vUs7kt2WLrgosH6f7WGL1CGJ9lsYo36OlsxIgjxYLLlH/y
         2lj4GY+nuvqRcfsKG2pYClZFhDHlU+Lug0EWrXdOgy9mn0SxW6WzUp5JX9dJS2DVI0
         Zx6mzjrBaj6CBD4VoNT7lVqFBNYKsU+9/fSu/kyTi+hkbJp2tLQjJHgyVMm68zcY3x
         cEjd6SqB7ZFhw==
Received: by mail-wr1-f72.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso3547894wrg.1
        for <linux-mmc@vger.kernel.org>; Tue, 21 Sep 2021 04:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Edrk8YB/JSUDN6TkY8ir7fMmkzEbx6D96lPgLtCkIX0=;
        b=lSmxhs+pk+OrZvbdtiIHV3ejXsCuv3M0WJgcfjyiR5024P6wAdc6DJwOMfOzlS2xW7
         RHUhpzoyBkRFeAEnha+fX0f3I+crKFgzu4fCeNk8ShUVZuzsTJD7/Hr4/ugrQBOfAGMF
         8jV1H0ihfjk5HhLoJdDAzmkb2FOJS2DsWRbiN2AvJuOA0UmyStqajr/+f1dqXt5SiUOL
         dp3omGVGtqKL/p5KYJKcf14IlE9tLiICRtOHcPWHt4hJsieNUNAhO4l7miWddokfxl2t
         jHM3jyeMWKmr/iuWe45d5NxMUyWKQHVtaAI5kvpr9L5Ykmw1Wd/nPp5hxG9KMMEOoOJR
         WwWg==
X-Gm-Message-State: AOAM533o55ta40vYFyLs5CQ5qY4RhLcAJtI8zvjsTTGdYJSmPLHUuWsQ
        Fmx3v1p/dryH/tDAuOaxZP1QqNyXQnOf1gx6VCOXkchaYIMTYyiASJbJt0VYccrkd4COdGL7AGF
        ShGZngqA310MC29zBBTf8wSKj9K0e7USMksI1Ag==
X-Received: by 2002:a5d:4b10:: with SMTP id v16mr34257869wrq.176.1632225450427;
        Tue, 21 Sep 2021 04:57:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywrtK6qK54rP6gUN9u5o1jj6AXZs8KZz+kX4eWk6zyX0PcrVcN3qgGUnuD3nSi/IKh/sHT2Q==
X-Received: by 2002:a5d:4b10:: with SMTP id v16mr34257845wrq.176.1632225450222;
        Tue, 21 Sep 2021 04:57:30 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id k4sm18725530wrv.24.2021.09.21.04.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 04:57:29 -0700 (PDT)
To:     Conor.Dooley@microchip.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, geert@linux-m68k.org,
        yamada.masahiro@socionext.com, piotrs@cadence.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
 <20210920150807.164673-4-krzysztof.kozlowski@canonical.com>
 <b83355ee-cce3-0a7d-a048-147dcb44b012@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH v3 4/6] riscv: dts: microchip: drop duplicated MMC/SDHC
 node
Message-ID: <d79c4aee-2c57-91a8-3bc5-b8d989ed41e1@canonical.com>
Date:   Tue, 21 Sep 2021 13:57:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b83355ee-cce3-0a7d-a048-147dcb44b012@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 21/09/2021 12:40, Conor.Dooley@microchip.com wrote:
> On 20/09/2021 16:08, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> Devicetree source is a description of hardware and hardware has only one
>> block @20008000 which can be configured either as eMMC or SDHC.  Having
>> two node for different modes is an obscure, unusual and confusing way to
>> configure it.  Instead the board file is supposed to customize the block
>> to its needs, e.g. to SDHC mode.
>>
>> This fixes dtbs_check warning:
>>    arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: sdhc@20008000: $nodename:0: 'sdhc@20008000' does not match '^mmc(@.*)?$'
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>
>> ---
>>
>> Changes since v1:
>> 1. Move also bus-width, suggested by Geert.
>> ---
>>   .../microchip/microchip-mpfs-icicle-kit.dts   | 11 +++++++-
>>   .../boot/dts/microchip/microchip-mpfs.dtsi    | 28 +------------------
>>   2 files changed, 11 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
>> index 07f1f3cab686..fc1e5869df1b 100644
>> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
>> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
>> @@ -51,8 +51,17 @@ &serial3 {
>>          status = "okay";
>>   };
>>
>> -&sdcard {
>> +&mmc {
>>          status = "okay";
>> +
>> +       bus-width = <4>;
>> +       disable-wp;
>> +       cap-sd-highspeed;
>> +       card-detect-delay = <200>;
>> +       sd-uhs-sdr12;
>> +       sd-uhs-sdr25;
>> +       sd-uhs-sdr50;
>> +       sd-uhs-sdr104;
>>   };
>>
>>   &emac0 {
>> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
>> index 5084b93188f0..83bc14860960 100644
>> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
>> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
>> @@ -262,39 +262,13 @@ serial3: serial@20104000 {
>>                          status = "disabled";
>>                  };
>>
>> -               emmc: mmc@20008000 {
>> -                       compatible = "cdns,sd4hc";
>> -                       reg = <0x0 0x20008000 0x0 0x1000>;
>> -                       interrupt-parent = <&plic>;
>> -                       interrupts = <88 89>;
>> -                       pinctrl-names = "default";
>> -                       clocks = <&clkcfg 6>;
>> -                       bus-width = <4>;
>> -                       cap-mmc-highspeed;
>> -                       mmc-ddr-3_3v;
>> -                       max-frequency = <200000000>;
>> -                       non-removable;
>> -                       no-sd;
>> -                       no-sdio;
>> -                       voltage-ranges = <3300 3300>;
>> -                       status = "disabled";
>> -               };
>> -
>> -               sdcard: sdhc@20008000 {
>> +               mmc: mmc@20008000 {
>>                          compatible = "cdns,sd4hc";
>>                          reg = <0x0 0x20008000 0x0 0x1000>;
>>                          interrupt-parent = <&plic>;
>>                          interrupts = <88>;
>>                          pinctrl-names = "default";
>>                          clocks = <&clkcfg 6>;
>> -                       bus-width = <4>;
>> -                       disable-wp;
>> -                       cap-sd-highspeed;
>> -                       card-detect-delay = <200>;
>> -                       sd-uhs-sdr12;
>> -                       sd-uhs-sdr25;
>> -                       sd-uhs-sdr50;
>> -                       sd-uhs-sdr104;
>>                          max-frequency = <200000000>;
>>                          status = "disabled";
>>                  };
>> --
>> 2.30.2
>>
> Hi Krzysztof,
> Seems I missed most of this series other than the new vendor name in the V1.

Unfortunately your name does not appear as maintainer for these files
and get_maintainers.pl brings it only sometimes as a --git fallback.
Also few addresses from that --git fallback are non working, so I am not
always Cc-ing them. Sorry for that, I'll try to Cc you on next Microchip
RISC-V submissions, however you should probably add a proper platform
maintainer entry (similarly to ARM/ARM64 subarchitectures).


> 
> We have been redoing the device tree for the mpfs/icicle kit partly dye 
> to some changes we made to the design. Previously SD and eMMC were 
> different FPGA designs but now both are in the same design and managed 
> by the bootloader, depending on where it finds the image to boot from.
> Since then we've just been using the following single entry in the .dtsi:
> 
>          mmc: mmc@20008000 { /* Common node entry for emmc/sd */
>              compatible = "cdns,sd4hc";
>              reg = <0x0 0x20008000 0x0 0x1000>;
>              clocks = <&clkcfg CLK_MMC>;
>              interrupt-parent = <&plic>;
>              interrupts = <PLIC_INT_MMC_MAIN PLIC_INT_MMC_WAKEUP>;

I'll switch to 2 interrupts.

>              bus-width = <4>;
>              cap-mmc-highspeed;
>              cap-sd-highspeed;
>              no-1-8-v;
>              disable-wp;
>              max-frequency = <200000000>;
>              status = "disabled";

I understand you prefer then the mmc node to be active? Before the DT
had SDHC one enable, so my patch did not introduce changes (except
mentioned interrupt).

I can change it to mmc above with your explanation.


Best regards,
Krzysztof
