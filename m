Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38C4C433ED
	for <linux-mmc@archiver.kernel.org>; Tue,  4 May 2021 16:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADEBA611AD
	for <linux-mmc@archiver.kernel.org>; Tue,  4 May 2021 16:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhEDQUQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 May 2021 12:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbhEDQUP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 May 2021 12:20:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E13C061574;
        Tue,  4 May 2021 09:19:20 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i24so11108460edy.8;
        Tue, 04 May 2021 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=60fjmSbWautEiAXXZ/arvBTCpd67qkAETXpwdXksLGM=;
        b=qFthUpilO16l5BBY7830dFNGPY803Hw8e+Eye/onLP8kMF/PyMLQVAglHZ/BRoZpUy
         8Zy9hEVal3Hu63EPztEAlNQhEkOdTpz3qtqsgegeTfzwfyJgphG/hgv9h1X/dVsvZgaD
         aCiIAJuYjbGOs1xv0FXP9BeBQTHfyCsI4Mz9Re+mtGsmPNcZK4B65VysSNebcz1n4P6F
         MtbWl29/mpRg0uW7w7mFE3RxIYduBBt7pRm77TGEYzRhCoSoULZkV0k/64huszWwPxn8
         MGpuMX4hrUPy4YdXFpLj5LViNUsROaAnWr1g6fbHIZUbTtQVAvnkTqr7CPJWXMkAutRW
         MMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=60fjmSbWautEiAXXZ/arvBTCpd67qkAETXpwdXksLGM=;
        b=eLbQJYahVj9890nNrHhfEU/2ZYrKS6D5fEkkXKlgHHnSBZJNW4IqirD3uKYeKn+Yfe
         C7c4z+CLKzEbziGygeIeVdbE034VXX92vzYGkYy9Y0gkhe19bFN/X5NnQYlYEl62BWU9
         hy68P7LLMbr8nYgxM0aCU/XU/eXShTqvEWszYyz2L3aIHZ5K9cSd0Qe4knmeZ909NL2q
         nFHSfw9gJsPXcrmXHLAjDyolRHfxNZPww5r+eU0kCAEtf2NB7nGgYEU4EUR0VwuWRj0u
         4h/kwS+rB4zsBZlZTD5mLInS54NAO65VzelQLnr+kn6BXv8MxutB5Nz4kZY58JoTqo+x
         cYQQ==
X-Gm-Message-State: AOAM532n+vTw1O5Vr563/HugM1ge0SGQxCdRuBnBgskfesZkfaZXoCXQ
        kq2pbZsGn11UYfdlIFSpEkaMSCyNR1VXnA==
X-Google-Smtp-Source: ABdhPJxhAo3H1iYkoqJEJEahFcx35MkC2p0i2yMzVazAbR2jkzD9gR8K9ooHj8koXp2JKDOUamMMPQ==
X-Received: by 2002:aa7:d594:: with SMTP id r20mr26285506edq.242.1620145159294;
        Tue, 04 May 2021 09:19:19 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h15sm1618678ejs.72.2021.05.04.09.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 09:19:18 -0700 (PDT)
Subject: Re: [RFC PATCH v1] dt-bindings: mmc: snps,dwcmshc-sdhci: fix
 rockchip,txclk-tapnum
To:     Rob Herring <robh+dt@kernel.org>
Cc:     heiko@sntech.de, shawn.lin@rock-chips.com, ulf.hansson@linaro.org,
        Jisheng.Zhang@synaptics.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210430072138.6537-1-jbx6244@gmail.com>
 <CAL_JsqKnD1t7oRDY5sTi3TjJ0vbFK0tQcVj1qCw_jiOfOQh=mA@mail.gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <4b67c50e-558a-ab76-b8df-531691129837@gmail.com>
Date:   Tue, 4 May 2021 18:19:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKnD1t7oRDY5sTi3TjJ0vbFK0tQcVj1qCw_jiOfOQh=mA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 5/4/21 12:40 AM, Rob Herring wrote:
> On Fri, Apr 30, 2021 at 2:21 AM Johan Jonker <jbx6244@gmail.com> wrote:
>>
>> A test with the command below gives this error:
>> mmc@fe310000: rockchip,txclk-tapnum: missing size tag in [[8]]
>>
>> With this added to a dts file:
>> rockchip,txclk-tapnum = <0x8>;
>>
>> A look at the driver shows that:
>> DLL_TXCLK_TAPNUM_DEFAULT        0x8
>>
>> Adding the default value to the dts files is not needed.
>> Every clock is divided into 32 taps equally and
>> the max value is 31.
>>
>> Fix rockchip,txclk-tapnum property in snps,dwcmshc-sdhci.yaml by
>> adding a minimum, maximum and default.
>>
>> In the driver the function of_property_read_u8() is used,
>> but with dtbs_check the notifications only disappear in YAML
>> by changing uint8 to uint32.
> 

> Did you check what value the driver sees when you put 8 in the dts. I
> expect it will be 0 because you are reading the 1st byte in big
> endian.
> 

Hi,

Thanks for info.
A test with a dummy module shows that of_property_read_u8() read a 0
instead of 8.
There are approx 23 of_property_read_u8() functions in use in the
mainline kernel. Do they need a recheck?

Johan

=== other Rockchip recheck examples

drivers/mmc/host/sdhci-of-dwcmshc.c

	if (of_property_read_u8(mmc_dev(host->mmc)->of_node,
"rockchip,txclk-tapnum",
				&priv->txclk_tapnum))

drivers/pci/controller/pcie-rockchip-ep.c

	err = of_property_read_u8(dev->of_node, "max-functions",
				  &ep->epc->max_functions);

=== dts test
	dummy {
		compatible = "dummy";
		rockchip,dummy0x8 =        <0x8>;
		rockchip,dummy0x11223344 = <0x11223344>;
	};

=== driver probe
	of_property_read_u8(np,  "rockchip,dummy0x8", &tmp8);
	printk("u8 : 0x%08x\n", tmp8);
	of_property_read_u32(np, "rockchip,dummy0x8", &tmp32);
	printk("u32: 0x%08x\n", tmp32);

	of_property_read_u8(np,  "rockchip,dummy0x11223344", &tmp8);
	printk("u8 : 0x%08x\n", tmp8);
	of_property_read_u32(np, "rockchip,dummy0x11223344", &tmp32);
	printk("u32: 0x%08x\n", tmp32);

=== dmesg
[   18.089694] u8 : 0x00000000
[   18.090123] u32: 0x00000008
[   18.090494] u8 : 0x00000011
[   18.090865] u32: 0x11223344


>> The driver has no limit check for rockchip,txclk-tapnum.
>>
>> make ARCH=arm64 dtbs_check
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>> index e6c9a2f77..f43d8d829 100644
>> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>> @@ -48,7 +48,10 @@ properties:
>>
>>    rockchip,txclk-tapnum:
>>      description: Specify the number of delay for tx sampling.
>> -    $ref: /schemas/types.yaml#/definitions/uint8
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    minimum: 0
>> +    maximum: 31
>> +    default: 8
>>
>>
>>  required:
>> --
>> 2.11.0
>>
