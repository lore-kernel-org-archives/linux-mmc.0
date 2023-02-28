Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A731C7EE2E
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Feb 2023 10:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjB1Kh2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Feb 2023 05:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjB1Kh1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Feb 2023 05:37:27 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263C02CFEE
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2023 02:37:24 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so5043019wmq.1
        for <linux-mmc@vger.kernel.org>; Tue, 28 Feb 2023 02:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677580642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lKLt5HIsJYb5tC1Ze6Ub0RmLxOUiKi6jayItAZSyIM=;
        b=BTeATDIzH8pSJTPac/KQ21euFT5RmcMyyQTBEhEoJN5VoFwakQQFA9OuLlcJG1QKLj
         Qet0sixga45OLRBGRL/b4NNXBRbPT8z6toZyQmScoXSYk68PuxMsn0P3W1tOslck9B6Z
         ULXmZyhYYFILvvPaUzfsLGm5ffGjgk+exMDz5FRD2EKCsdlrLdd0GRpAy+NDELehJqAH
         Y1FGqFuHkpprnHZDltSyfZBp0e/ppkuI9UPDoXmV1g69IdzrkfkxW/7N7EXkQa9HIzeo
         YnfsdrBzpv9cGw+7RFaEwo+IJ28yGcSqKVgGeK+baEXXenrLjeAOgpfTcFmVl1mqHa8P
         3oUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677580642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lKLt5HIsJYb5tC1Ze6Ub0RmLxOUiKi6jayItAZSyIM=;
        b=4FKIGEiULl+g/awWkvz+pKrYAWzP8HTAniZdwy9s8elsR46ew2vOMNXHghpobb1KG4
         5QVNBRN2EwzX3ne09D7CcvXbkwW9NCuKkyhcA/K7MUvtdwn1Vd7Fbgo82c2kthGoh3F3
         QltJDy8LIb20cr3O0O13nbfb4jpxTp1hqyqnHd7PWV0G+i5P+Dkl8+d7KsKrUvjOnjwT
         EJoI6Ts5gtSrU63Pk6GObkhX6tplwA35NpLutG0yhfZvbUiKbSw18PPVg4yWGTcPP7Lw
         fsR2KiSdoBkXJR+e5oDG7L/qLqJbH8Al2JGP2/euTl6NUG9QIhx0wr3QPOuqA8GL8kVR
         NKJw==
X-Gm-Message-State: AO0yUKXXiWP3tgjxK+ez8Vf3DSrjJW+/iNFiG8Feftoe8kOKsE+7fxNl
        M3aHSgIHXb4AAqicpZeDaYPZxWPRsa3rbd5l
X-Google-Smtp-Source: AK7set8qggFOBYVcZUD3defWyyZDeiDIyNcZq9p6rsu+MxCJELx7V2LcYKz+ScO7nG86StUj+oQy8g==
X-Received: by 2002:a05:600c:4fd3:b0:3eb:36fa:b791 with SMTP id o19-20020a05600c4fd300b003eb36fab791mr1806286wmq.31.1677580642550;
        Tue, 28 Feb 2023 02:37:22 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d45cf000000b002c703d59fa7sm9329642wrs.12.2023.02.28.02.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 02:37:22 -0800 (PST)
Message-ID: <54f51fa0-7821-b67b-b782-eb9a35b7bba9@linaro.org>
Date:   Tue, 28 Feb 2023 11:37:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 4/4] dt-bindings: syscon: Add StarFive syscon doc
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f8d2b665-ce5d-81f8-8c55-81f1a4cb62b9@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 28/02/2023 10:05, William Qiu wrote:
> 
> 
> On 2023/2/28 6:29, Rob Herring wrote:
>> On Tue, Feb 21, 2023 at 10:44:02AM +0800, William Qiu wrote:
>>>
>>>
>>> On 2023/2/21 7:43, Rob Herring wrote:
>>>> On Wed, Feb 15, 2023 at 07:32:49PM +0800, William Qiu wrote:
>>>>> Add documentation to describe StarFive System Controller Registers.
>>>>>
>>>>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>>>>> ---
>>>>>  .../bindings/soc/starfive/jh7110-syscon.yaml  | 51 +++++++++++++++++++
>>>>>  MAINTAINERS                                   |  5 ++
>>>>>  2 files changed, 56 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..fa4d8522a454
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
>>>>> @@ -0,0 +1,51 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/soc/starfive/jh7110-syscon.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: StarFive JH7110 SoC system controller
>>>>> +
>>>>> +maintainers:
>>>>> +  - William Qiu <william.qiu@starfivetech.com>
>>>>> +
>>>>> +description: |
>>>>> +  The StarFive JH7110 SoC system controller provides register information such
>>>>> +  as offset, mask and shift to configure related modules such as MMC and PCIe.
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - enum:
>>>>> +          - starfive,jh7110-stg-syscon
>>>>> +          - starfive,jh7110-sys-syscon
>>>>> +          - starfive,jh7110-aon-syscon
>>>>
>>>> Is 'syscon' really part of what the blocks are called? Is just 'stg', 
>>>> 'sys' and 'aon' not unique enough?
>>>>
>>>> Rob
>>> Hi Rob,
>>>
>>> In StarFive SoC, we do have syscrg/aoncrg/stgcrg, which is uesd to be the clock
>>> controller, so 'syscon' is added to avoid confusion.
>>
>> You've only added to my confusion. 'syscrg' and 'sys-syscon' are 2 
>> different h/w blocks and unrelated to each other? Or 'syscrg' is the 
>> clock portion of 'sys-syscon'? In that case, 'syscrg' should be a child 
>> of 'sys-syscon' or possibly just all one node. Please provide details on 
>> the entire h/w block so we can provide better input on the bindings.
>>
>> Rob
> 
> Hi Rob,
> 
> It's my description that's problematic.'syscon' here refers to the hardware module
> inside our JH7110, which is different from the syscon interface in linux. The syscon
> I added now uses the syscon interface of linux to read and write the syscon register
> in our JH7110. So we decided to name it that way.

You didn't really answer Rob's questions.

Also, syscon is Linux term, so are you sure hardware module is called
like this? Hardware engineers took pure Linux name and used it?

Best regards,
Krzysztof

