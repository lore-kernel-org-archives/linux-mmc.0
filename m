Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1CFC64ED6
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Feb 2023 11:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjB1L3h (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Feb 2023 06:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjB1L3d (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Feb 2023 06:29:33 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88DFF971
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2023 03:29:09 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso8830950wmi.4
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2023 03:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677583712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oOBHN8SOWfG+6E39W2LRb5Mdzz3QwZLD1qrh4jZE1NY=;
        b=Ag74R7l9pGf3aD9fmSORY5jTnHtW5Ti/+uDtY+oI0soLyi5X24HUuTq0geN35auA7/
         paINEYop5l3gS5/N8IYQhngW16h5NO32M6RuFIxrO7+8dOKVcpc+mnYIdIKunamBpjUP
         gKBR9N4o9PQj7M+yEOBrpr3+g+Hnj0A2P9DUlpU0QMldjArH9BMjp8fggYwl1Ux/YLO2
         DEQ5nvlWQ8V5qt44dQRQnvhUp6+i5pgOB4iAvRcSiiAY+kMNJBoTEeXtb+dFABkYM/Ig
         UTwlSK2+DzrdrcKg3pPniZSoC+pYom93m4UMNJ71TSziZ1o0G8swohICA9akBJ1114hg
         aeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677583712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOBHN8SOWfG+6E39W2LRb5Mdzz3QwZLD1qrh4jZE1NY=;
        b=JV4VLTxR2JBAO2ICNY4W1tNr97ZZS6kF3DbJjmVouOgZHeP2V/n1JraP1uor8IAcg/
         DIhLaaZMyuBrrNdK8AOF4bn2mIUKlQo9b/79aiCrU9k4Tk9yD01S/BFwxIi9yJnaY8gg
         sYH94Clb9L5I+lKDw0DZ6o6vFJ+hPQuWgsfjU5q9HI/lc8SCsQDUn9aNmSPENByJLOoa
         8a64d0Sjojx+7dAsbfQxG17iV/UL/3sUyxUrp1QuwvIxivO5XGNBnBcxIGYj3wQbu08R
         5NLWJyXTfFNW+Lq/GBU4+D7oc1dWyRUKdLtA/gPjoNPmZ6Ke8RBB0riZK0/+xAlEj0iL
         wyyQ==
X-Gm-Message-State: AO0yUKVaprEbJ2PgtI03rho3RHPoQIV9t53puaZsg+Tz9gGfiD1N5t5x
        MfMUKmh84AXk+LZnZQd/oJHEtGLNcHRGeD8I
X-Google-Smtp-Source: AK7set9i1nyEmV4xklLiWUberN1IuWUGxUCefGBaFmf86XSGGwOVTlVC376se2dRpHJO97E6LEOKBw==
X-Received: by 2002:a05:600c:4f85:b0:3eb:383c:1876 with SMTP id n5-20020a05600c4f8500b003eb383c1876mr1983616wmq.6.1677583712514;
        Tue, 28 Feb 2023 03:28:32 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e26-20020a7bc2fa000000b003eb39e60ec9sm9135043wmk.36.2023.02.28.03.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 03:28:32 -0800 (PST)
Message-ID: <a0168d89-3c30-55e1-cf4c-37f7fe90aae4@linaro.org>
Date:   Tue, 28 Feb 2023 12:28:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 4/4] dt-bindings: syscon: Add StarFive syscon doc
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     William Qiu <william.qiu@starfivetech.com>,
        Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-5-william.qiu@starfivetech.com>
 <20230220234335.GA615198-robh@kernel.org>
 <348796cc-72d9-4dcf-9f09-4c2aa55cb858@starfivetech.com>
 <20230227222904.GC1048218-robh@kernel.org>
 <f8d2b665-ce5d-81f8-8c55-81f1a4cb62b9@starfivetech.com>
 <54f51fa0-7821-b67b-b782-eb9a35b7bba9@linaro.org>
 <CAJM55Z85fitjBOcCLqad9W-a7h3iN9bxtctVGzPgqCbf5fWobw@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJM55Z85fitjBOcCLqad9W-a7h3iN9bxtctVGzPgqCbf5fWobw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 28/02/2023 12:02, Emil Renner Berthing wrote:
> On Tue, 28 Feb 2023 at 11:40, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 28/02/2023 10:05, William Qiu wrote:
>>>
>>>
>>> On 2023/2/28 6:29, Rob Herring wrote:
>>>> On Tue, Feb 21, 2023 at 10:44:02AM +0800, William Qiu wrote:
>>>>>
>>>>>
>>>>> On 2023/2/21 7:43, Rob Herring wrote:
>>>>>> On Wed, Feb 15, 2023 at 07:32:49PM +0800, William Qiu wrote:
>>>>>>> Add documentation to describe StarFive System Controller Registers.
>>>>>>>
>>>>>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>>>>>> ---
>>>>>>>  .../bindings/soc/starfive/jh7110-syscon.yaml  | 51 +++++++++++++++++++
>>>>>>>  MAINTAINERS                                   |  5 ++
>>>>>>>  2 files changed, 56 insertions(+)
>>>>>>>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..fa4d8522a454
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
>>>>>>> @@ -0,0 +1,51 @@
>>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>>> +%YAML 1.2
>>>>>>> +---
>>>>>>> +$id: http://devicetree.org/schemas/soc/starfive/jh7110-syscon.yaml#
>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>> +
>>>>>>> +title: StarFive JH7110 SoC system controller
>>>>>>> +
>>>>>>> +maintainers:
>>>>>>> +  - William Qiu <william.qiu@starfivetech.com>
>>>>>>> +
>>>>>>> +description: |
>>>>>>> +  The StarFive JH7110 SoC system controller provides register information such
>>>>>>> +  as offset, mask and shift to configure related modules such as MMC and PCIe.
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    items:
>>>>>>> +      - enum:
>>>>>>> +          - starfive,jh7110-stg-syscon
>>>>>>> +          - starfive,jh7110-sys-syscon
>>>>>>> +          - starfive,jh7110-aon-syscon
>>>>>>
>>>>>> Is 'syscon' really part of what the blocks are called? Is just 'stg',
>>>>>> 'sys' and 'aon' not unique enough?
>>>>>>
>>>>>> Rob
>>>>> Hi Rob,
>>>>>
>>>>> In StarFive SoC, we do have syscrg/aoncrg/stgcrg, which is uesd to be the clock
>>>>> controller, so 'syscon' is added to avoid confusion.
>>>>
>>>> You've only added to my confusion. 'syscrg' and 'sys-syscon' are 2
>>>> different h/w blocks and unrelated to each other? Or 'syscrg' is the
>>>> clock portion of 'sys-syscon'? In that case, 'syscrg' should be a child
>>>> of 'sys-syscon' or possibly just all one node. Please provide details on
>>>> the entire h/w block so we can provide better input on the bindings.
>>>>
>>>> Rob
>>>
>>> Hi Rob,
>>>
>>> It's my description that's problematic.'syscon' here refers to the hardware module
>>> inside our JH7110, which is different from the syscon interface in linux. The syscon
>>> I added now uses the syscon interface of linux to read and write the syscon register
>>> in our JH7110. So we decided to name it that way.
>>
>> You didn't really answer Rob's questions.
>>
>> Also, syscon is Linux term, so are you sure hardware module is called
>> like this? Hardware engineers took pure Linux name and used it?
> 
> Yes, from the documentation I could find[1] there are CRG blocks
> (Clock and Reset Generator) and SYSCON blocks:
> SYS CRG
> STG CRG
> AON CRG
> SYS SYSCON
> STG SYSCON
> AON SYSCON
> 
> The CRG blocks contain registers to control clocks and resets that
> follow a pattern used by the clock and reset drivers. The SYSCON
> blocks just seem to contain registers to control whatever didn't fit
> in any other blocks, but might be vaguely related to the peripherals
> that run off clocks controlled by the corresponding CRG block.

The memory map [1] suggests these are indeed separate address spaces,
e.g. AON CRG, AON SYSCON and AON GPIO, but now I would argue that this
might be still one device - AON (or STG, SYS). Just like PCIE0 has four
address spaces, it does not mean you have four separate PCIE0 devices.
You have only one PCIE0, just like you have only one AON, one STG and
one SYS (System).

[1] https://doc-en.rvspace.org/JH7110/TRM/JH7110_TRM/system_memory_map.html


Best regards,
Krzysztof

