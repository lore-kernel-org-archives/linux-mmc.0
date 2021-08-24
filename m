Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709F4C4320A
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 19:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57DAF613B1
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 19:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbhHXTLd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 15:11:33 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:58494
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233610AbhHXTLc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 15:11:32 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F168B4075E
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 19:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629831904;
        bh=imZyE0myVr/4RzrKTOaKGpxnnbHBTwOKB1lVbc5Dymc=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=waEQkliO7BNewVSmIKthMxcyx3rvT+azIZlVRePbrKQBX//WBRUnvtOW0iYgX8GUr
         QZ377WjkhsxaK7thebThED2JouNdKU27XJCN1m81rLFTkVxSUM+lMIUDjb9b5wz1Ru
         L1p8VzFlrLbO9XWbhCJFk/EimSTrtyLl4CDhXOgPx7RQ5DbSrfY6GOvlZ5SRTw4ZnW
         pnIqtOnihKU4EJ3BZnHJwXmpOFkw1Nf1MiL+G0dzFy9bOOM5QCpbzR9+WSjk9mOfu6
         cH8H4AyKLltE/1CucbCMrI+FgEWc5ViZGsTCYOPtnZ1dDnSJUS03QVOzx5M7vEZ/n/
         M3vjTcOmhAS1Q==
Received: by mail-wm1-f69.google.com with SMTP id 5-20020a1c00050000b02902e67111d9f0so4410647wma.4
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 12:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=imZyE0myVr/4RzrKTOaKGpxnnbHBTwOKB1lVbc5Dymc=;
        b=n/hbRJlTtIIiQ85/7IxNZK7qvx2LbofYJ89p2JGtDv0FhMsSp1nrR5Ke5oEPIl7HUH
         tqrblkB+24bXmGJecgiPtBCveZimshhaApaYLHGo9Izs/+Z5ki6xL0/BMHbfPhdIUpTV
         f9wioZKu63Kt5jT/VbAUgvx/1MD/GKHJKUpp6fDUGBEV4mU+2jv2dcEORUQXYCS3d4OQ
         i8DR8TWI9y4YjG6q+2r2XAUvXYnFDuj8+B4eeSxizJueFvavgVHFtB05wthareQkG3uE
         3yj6woyGXCxzLgfgooww6HFNByctCVfKx4P4LKt1qVdLo3JN5VYcQJmrzKiShzHX1yg8
         HTmg==
X-Gm-Message-State: AOAM531INQd+5Q60O+VdwS3TjCtB5jyUr13V9aoXpk445QY0pyMD/q0H
        hjyAx2eI0FOTtizWAgyJtWmq0KQj0XCjQ2+lxGRvB5Zf/AfA0fHcy6P28Mz7OvTMPfmxKqdlXDD
        9RiVR/sPXxL+ET/kzrFjEQ6wexMetDe6xCVpirg==
X-Received: by 2002:a1c:7413:: with SMTP id p19mr5591063wmc.30.1629831904684;
        Tue, 24 Aug 2021 12:05:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJza/ERSPVmnyN7SqaIwhIMDqCYelq2Xjc/rr4UPcc2KdmL1ksd3r2LvJdQvXH7L1vDQ5Ur3vw==
X-Received: by 2002:a1c:7413:: with SMTP id p19mr5591045wmc.30.1629831904577;
        Tue, 24 Aug 2021 12:05:04 -0700 (PDT)
Received: from [192.168.0.103] ([79.98.113.188])
        by smtp.gmail.com with ESMTPSA id n14sm14742395wrr.28.2021.08.24.12.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 12:05:04 -0700 (PDT)
Subject: Re: [PATCH 4/6] riscv: microchip: mpfs: fix board compatible
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
 <20210819154436.117798-4-krzysztof.kozlowski@canonical.com>
 <CAMuHMdX8dBiYadAN8OQpds_bMbLReJy+u6apGe=RZzfEE=BJbw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <c9c9d21f-e820-de1e-b5a6-cd6054dda3ec@canonical.com>
Date:   Tue, 24 Aug 2021 21:05:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX8dBiYadAN8OQpds_bMbLReJy+u6apGe=RZzfEE=BJbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 24/08/2021 17:29, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Thu, Aug 19, 2021 at 5:45 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@canonical.com> wrote:
>> According to bindings, the compatible must include microchip,mpfs.  This
>> fixes dtbs_check warning:
>>
>>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: /: compatible: ['microchip,mpfs-icicle-kit'] is too short
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> Thanks for your patch!
> 
>> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
>> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
>> @@ -10,7 +10,7 @@
>>
>>  / {
>>         model = "Microchip PolarFire-SoC Icicle Kit";
>> -       compatible = "microchip,mpfs-icicle-kit";
>> +       compatible = "microchip,mpfs-icicle-kit", "microchip,mpfs";
> 
> I have the same change in my local tree, but didn't get to submit it
> yet, so this part is fine ;-)
> 
>>
>>         chosen {
>>                 stdout-path = &serial0;
>> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
>> index b9819570a7d1..cb54da0cc3c4 100644
>> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
>> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
>> @@ -7,7 +7,7 @@ / {
>>         #address-cells = <2>;
>>         #size-cells = <2>;
>>         model = "Microchip MPFS Icicle Kit";
>> -       compatible = "microchip,mpfs-icicle-kit";
>> +       compatible = "microchip,mpfs-icicle-kit", "microchip,mpfs";
> 
> As this file is the SoC .dtsi, not the board DTS for the full
> Icicle Kit, the compatible value should be just "microchip,mpfs"
> (to be augmented by the board DTS).
> And "model" should be "Microchip PolarFire SoC".


Sounds good, I'll fix it in v2.


Best regards,
Krzysztof
