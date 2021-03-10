Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBCFC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 06:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA9E064F79
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 06:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhCJGyf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Mar 2021 01:54:35 -0500
Received: from regular1.263xmail.com ([211.150.70.206]:50360 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhCJGyD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Mar 2021 01:54:03 -0500
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Mar 2021 01:54:02 EST
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id AE8001B0A;
        Wed, 10 Mar 2021 14:44:27 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P13096T140547786254080S1615358667251887_;
        Wed, 10 Mar 2021 14:44:27 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <922dcb4a27086f313d7c2f0d168d7104>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-rockchip@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <fab85a6a-5db3-a5c1-f6e1-16f55641ecb5@rock-chips.com>
Date:   Wed, 10 Mar 2021 14:44:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Cc:     shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v3_2/3=5d_dt-bindings=3a_mmc=3a_sdhci-of-d?=
 =?UTF-8?B?d2NtaHNjOiBBZGQgcm9ja2NoaXAgc3VwcG9ydOOAkOivt+azqOaEj++8jOmCrg==?=
 =?UTF-8?B?5Lu255Sxcm9iaGVycmluZzJAZ21haWwuY29t5Luj5Y+R44CR?=
To:     Rob Herring <robh@kernel.org>
References: <1615254990-192784-1-git-send-email-shawn.lin@rock-chips.com>
 <1615254990-192784-2-git-send-email-shawn.lin@rock-chips.com>
 <20210310030122.GA1664258@robh.at.kernel.org>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20210310030122.GA1664258@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Rob

On 2021/3/10 11:01, Rob Herring wrote:
> On Tue, Mar 09, 2021 at 09:56:29AM +0800, Shawn Lin wrote:
>> This patch adds rockchip support in sdhci-of-dwcmhsc.yaml
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

.....

>> +
>> +  rockchip,txclk-tapnum:
>> +    description: Specify the number of delay for tx sampling.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Constraints for this? 0 - 2^32 is okay?

Oh, actually this is a 4-bit value, and the reg map looks like:

7:5 RO reserved
--------------------
4:0 RW tapnum

So I think it should constraints for u8?


> 
>> +
>>   
>>   required:
>>     - compatible
>> @@ -49,6 +62,17 @@ unevaluatedProperties: false
>>   
>>   examples:
>>     - |
>> +    mmc@fe310000 {
>> +      compatible = "rockchip,dwcmshc-sdhci";
>> +      reg = <0xfe310000 0x10000>;
>> +      interrupts = <0 25 0x4>;
>> +      clocks = <&cru 17>, <&cru 18>, <&cru 19>, <&cru 20>, <&cru 21>;
>> +      clock-names = "core", "bus", "axi", "block", "timer";
>> +      bus-width = <8>;
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +    };
>> +  - |
>>       mmc@aa0000 {
>>         compatible = "snps,dwcmshc-sdhci";
>>         reg = <0xaa000 0x1000>;
>> -- 
>> 2.7.4
>>
>>
>>
> 
> 
> 


