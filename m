Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5264C6FD19
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Mar 2023 08:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCIIrH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Mar 2023 03:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjCIIrH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Mar 2023 03:47:07 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC35A5C13F
        for <linux-mmc@vger.kernel.org>; Thu,  9 Mar 2023 00:47:03 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id ay14so3910456edb.11
        for <linux-mmc@vger.kernel.org>; Thu, 09 Mar 2023 00:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678351622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cGqSi8rJkPEYNb50K8BZLZGOLTylgAMP+xBcfwszraY=;
        b=uWrOPunOG/IX7IXgMC9nNzBAL3RVSJDMIQAhPRLPF7D7yJ63ZEUf6n4B9kZXT8EJra
         5+lMkJFQGjwuxI/vKqAjH7GCS7/mokXszHTPnV4wsXEkyAViezjc+qd0H9KpnnQXibsk
         cexqB/EpVgwEZTQVDS1OjOmQtO5/c7FKZHQdDC+TJb2EGxdpf/ulhTWLcngwpatM0bqU
         xKMAnSRae3omimeoZUwNa0/Zu6XM4MK1h1k+wy2uTIii0U4oLtklUv/mrZXkWWz1KHg3
         yXLIz1kjPyFqXSHnvpKygQSNhB+OrnXxWB4gRxWbTafxbX/LvQUFLue7GldjnhLB5oAv
         Frow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGqSi8rJkPEYNb50K8BZLZGOLTylgAMP+xBcfwszraY=;
        b=IK6BrgqSy/2KAi8W+R1YxXEtPzjIAPSB+xlK7vy6oxlNRpuw+d/WFaHb6sHJJ/Jc9R
         2xgtLkQoT8KP4/KLInDT2sL2Tn05y+Dikt1jWg89xNKEoJGD7/ps1fGOXdRN++QsERle
         AU2aVfsAg2sp636vWwne7Kcwvc+1Q9MQfBhdikow0qzfHX3u2sO9HqBZsd+nfC3IS5Rf
         MAF9CJ4U7zRy86gDCtTbAaB/D75mDwn3og8WvJzYl9/2DzU2ovAtXDt4dyf9JPcfw1Qe
         6FAKaagw4ckrJkXNPO0QRIpvmXTXFm0pQnreLu+bp0HxiVpRUuCYYVIDUHs292FXTieL
         2CtQ==
X-Gm-Message-State: AO0yUKUdPYXmbiAmkwGZkzuq5QB05wkiHZKJZsbMh1HWKlObRnSD4QmD
        6oVnbdPhNbD8Fiv1z/R3z5weXw==
X-Google-Smtp-Source: AK7set8c8UmjoKmMwhvKXt6i586YTl/YQ9n2bzrcv3YZRo7O7HO0PDCg9C2uNGptPLP5DV9WQJiM/Q==
X-Received: by 2002:a05:6402:2028:b0:4af:70a5:55ee with SMTP id ay8-20020a056402202800b004af70a555eemr18130112edb.3.1678351622391;
        Thu, 09 Mar 2023 00:47:02 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id a25-20020a509b59000000b004c0eac41829sm9183008edj.63.2023.03.09.00.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 00:47:01 -0800 (PST)
Message-ID: <2691debf-0596-c265-468f-bb66d19f6db0@linaro.org>
Date:   Thu, 9 Mar 2023 09:46:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v10 05/15] dt-bindings: soc: amd: amd,pensando-elbasr: Add
 AMD Pensando SoC System Controller
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>
Cc:     adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, broonie@kernel.org,
        catalin.marinas@arm.com, davidgow@google.com,
        devicetree@vger.kernel.org, fancer.lancer@gmail.com,
        gerg@linux-m68k.org, gsomlo@gmail.com, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        lee@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, p.yadav@ti.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, rdunlap@infradead.org, robh+dt@kernel.org,
        samuel@sholland.org, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, will@kernel.org, yamada.masahiro@socionext.com
References: <e82ca6f6-0870-f9b0-172f-bc6d54a9749b@linaro.org>
 <20230307021822.71245-1-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230307021822.71245-1-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 07/03/2023 03:18, Brad Larson wrote:
> On 06/03/2023 09:35, Krzysztof Kozlowski wrote:
>>> On 06/03/2023 05:07, Brad Larson wrote:
>>>> Support the AMD Pensando SoC Controller which is a SPI connected device
>>>> providing a miscellaneous set of essential board control/status registers.
>>>> This device is present in all Pensando SoC based designs.
>>>>
>>>> Signed-off-by: Brad Larson <blarson@amd.com>
>>>> ---
>>>>
>>>> v10 changes:
>>>> - Property renamed to amd,pensando-ctrl
>>>> - Driver is renamed and moved to soc/drivers/amd affecting binding
>>>> - Delete cs property, driver handles device node creation from parent num-cs
>>>>   fixing schema reg error in a different way
>>>>
>>>> v9 changes:
>>>> - Instead of four nodes, one per chip-select, a single
>>>>   node is used with reset-cells in the parent.
>>>> - No MFD API is used anymore in the driver so it made
>>>>   sense to move this to drivers/spi.
>>>> - This driver is common for all Pensando SoC based designs
>>>>   so changed the name to pensando-sr.c to not make it Elba
>>>>   SoC specific.
>>>> - Added property cs for the chip-select number which is used
>>>>   by the driver to create /dev/pensr0.<cs>
>>>>
>>>> ---
>>>>  .../bindings/soc/amd/amd,pensando-ctrl.yaml   | 60 +++++++++++++++++++
>>>>  1 file changed, 60 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml b/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
>>>> new file mode 100644
>>>> index 000000000000..36694077b2e6
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/soc/amd/amd,pensando-ctrl.yaml
>>>
>>> Your subject suggests this is pensando-elbasr but you write everywhere
>>> pensando-ctrl. Confusing. Pick one.
>>
>> Actually pensando-ctrl is for sure not correct, because it misses the
>> name of the SoC (you call it everywhere "elba").
> 
> The reason I dropped elba as part of the name is this driver and its associated 
> SPI attached device (cpld or fpga depending on the board design) will be used
> across a series of SoCs starting with Elba.  Implying its Elba specific is misleading.

Compatibles must be specific.
https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
If this is SoC part it must match SoC. What is misleading in this? Why
Pensando is different than all other SoCs (I am really getting tired
everytime asking why people think their solution is special)?

If this is not part of the SoC, then your commit msg is misleading.
Maybe bindings as well, so rework it.

Best regards,
Krzysztof

