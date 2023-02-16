Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E85BC636D6
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Feb 2023 10:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBPKbI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Feb 2023 05:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBPKbH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Feb 2023 05:31:07 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEDE518ED;
        Thu, 16 Feb 2023 02:30:49 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id A88B124E1E1;
        Thu, 16 Feb 2023 18:30:36 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 16 Feb
 2023 18:30:36 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 16 Feb
 2023 18:30:35 +0800
Message-ID: <4b9edac8-20bf-be1c-6b32-69b7f7616ad5@starfivetech.com>
Date:   Thu, 16 Feb 2023 18:30:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 4/4] dt-bindings: syscon: Add StarFive syscon doc
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-5-william.qiu@starfivetech.com>
 <41bcc545-6eda-6c30-c600-d97ef009abf2@linaro.org>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <41bcc545-6eda-6c30-c600-d97ef009abf2@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 2023/2/16 18:23, Krzysztof Kozlowski wrote:
> On 15/02/2023 12:32, William Qiu wrote:
>> Add documentation to describe StarFive System Controller Registers.
>> 
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - starfive,jh7110-stg-syscon
>> +          - starfive,jh7110-sys-syscon
>> +          - starfive,jh7110-aon-syscon
> 
> Maybe keep them ordered alphabetically?
> 

I'm sorting by register address, or I can keep them ordered
alphabetically，which is better?
>> +      - const: syscon
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    syscon@10240000 {
>> +        compatible = "starfive,jh7110-stg-syscon", "syscon";
>> +        reg = <0x10240000 0x1000>;
>> +    };
> 
> Keep only one example. All others are the same.
> 
Will update in next version.
Thanks for taking times to review this patch series.

Best regards
William
> 
> Best regards,
> Krzysztof
> 
