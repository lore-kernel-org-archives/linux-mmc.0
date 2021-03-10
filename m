Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C396C433E6
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 09:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F172164FFA
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 09:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhCJJin (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Mar 2021 04:38:43 -0500
Received: from regular1.263xmail.com ([211.150.70.200]:44760 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbhCJJiQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Mar 2021 04:38:16 -0500
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id 34BED1C5D;
        Wed, 10 Mar 2021 17:37:34 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P24304T139685251299072S1615369053264450_;
        Wed, 10 Mar 2021 17:37:34 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <6df6f007d349241a15ee878e4b443baf>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <7573e8c1-3f55-9925-bc14-534455f1ffa3@rock-chips.com>
Date:   Wed, 10 Mar 2021 17:37:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Cc:     shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v3 2/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Add rockchip
 support
To:     Johan Jonker <jbx6244@gmail.com>, Rob Herring <robh@kernel.org>
References: <1615254990-192784-1-git-send-email-shawn.lin@rock-chips.com>
 <1615254990-192784-2-git-send-email-shawn.lin@rock-chips.com>
 <20210310030122.GA1664258@robh.at.kernel.org>
 <9f8b3be6-d87e-d944-d5db-67f3bcf0fad0@gmail.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <9f8b3be6-d87e-d944-d5db-67f3bcf0fad0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 2021/3/10 15:00, Johan Jonker wrote:
> On 3/10/21 4:01 AM, Rob Herring wrote:
>> On Tue, Mar 09, 2021 at 09:56:29AM +0800, Shawn Lin wrote:
>>> This patch adds rockchip support in sdhci-of-dwcmhsc.yaml
>>>
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>> ---
>>>
>>> Changes in v3: None
>>>
>>>   .../bindings/mmc/snps,dwcmshc-sdhci.yaml           | 24 ++++++++++++++++++++++
>>>   1 file changed, 24 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>>> index f99fb9f..43989f2 100644
>>> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>>> @@ -16,6 +16,7 @@ allOf:
>>>   properties:
>>>     compatible:
>>>       enum:
> 
>>> +      - rockchip,dwcmshc-sdhci
> 
> Compatible strings are supposed to be SoC orientated.
> What SoC was this change for? rk3568 ?
> Could Shawn confirm that?

Yes. We are inclined to use this controller from now on for a
long time for up-coming SoCs. Should we tag compatible for rk3568
specified? One of the negative things I could come up with is that we
do this for dwmmc-rockchip, but we end up doing nothing else,
except for adding new compatible string again and again in Document.

> 
>           - rockchip,rk3568-dwcmshc-sdhci ??
> 
> Could Rob advise here?
> 
>>>         - snps,dwcmshc-sdhci
>>>   
>>>     reg:
>>> @@ -31,12 +32,24 @@ properties:
>>>       items:
>>>         - description: core clock
>>>         - description: bus clock for optional
>>> +      - description: axi clock for rockchip specified
>>> +      - description: block clock for rockchip specified
>>> +      - description: timer clock for rockchip specified
>>> +
>>>   
>>>     clock-names:
>>>       minItems: 1
>>>       items:
>>>         - const: core
>>>         - const: bus
>>> +      - const: axi
>>> +      - const: block
>>> +      - const: timer
>>> +
>>> +  rockchip,txclk-tapnum:
>>> +    description: Specify the number of delay for tx sampling.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>
>> Constraints for this? 0 - 2^32 is okay?
>>
>>> +
>>>   
>>>   required:
>>>     - compatible
>>> @@ -49,6 +62,17 @@ unevaluatedProperties: false
>>>   
>>>   examples:
>>>     - |
>>> +    mmc@fe310000 {
> 
>>> +      compatible = "rockchip,dwcmshc-sdhci";
> 
>        compatible = "rockchip,rk3568-dwcmshc-sdhci"; ??
> 
>>> +      reg = <0xfe310000 0x10000>;
>>> +      interrupts = <0 25 0x4>;
>>> +      clocks = <&cru 17>, <&cru 18>, <&cru 19>, <&cru 20>, <&cru 21>;
>>> +      clock-names = "core", "bus", "axi", "block", "timer";
>>> +      bus-width = <8>;
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +    };
>>> +  - |
>>>       mmc@aa0000 {
>>>         compatible = "snps,dwcmshc-sdhci";
>>>         reg = <0xaa000 0x1000>;
>>> -- 
>>> 2.7.4
>>>
>>>
>>>
>>
> 
> 
> 
> 
> 


