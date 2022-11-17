Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45903C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Nov 2022 12:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbiKQMeh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Nov 2022 07:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240097AbiKQMd4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2022 07:33:56 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BCF11C29
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2022 04:33:34 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u11so2501544ljk.6
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2022 04:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8TReWwUSXElyK+mKSFqY3hsdNui99iOxPQBAxPdloM=;
        b=iN5zkrul3GVTJbtunuN2P+DGyoNisIIirJIXG46DwBGW2UJUM3oQNolAtgChfRA9OA
         crSXiF+AhDjuKPcQY4M9yIAHECG624D4W1zk/dclVc/MPHG6s4/iZpgfEvTORe40iiwz
         NHvdL5AhNGL9TRu37hB3ly8d/jYzSNkrNGqW5DTKKLs01pnucQCHL186Lc2UrimOZjsp
         M2CKnx3UilRcN1ro+vBL3UcFT4biumPNqPSD2e5GXYT91QwY//MpWc5bzvt5LtOKSEnO
         TtWzZCdj189WFYIwv1F5vt9vXmeKfnEDLYoXu4Icsiixv8VMKO/m3E6c29EFiYtjERAP
         kQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8TReWwUSXElyK+mKSFqY3hsdNui99iOxPQBAxPdloM=;
        b=Fs0kl9CB16Gw7Goe0E+2/dLYefc1NYfaZUBxPEmjbG70K81KBYXNZK28DAo/U2blQl
         EvMCahxTgy+K1E1uxd+9iaBBNabg0A0cFtZBduHZZJgUo6WzEaDc8HT3M4Rsu7rt5O15
         S54q4RP3IdAAOKShtjHCX26CbJJBpZjVM6S4LihUEG0DJ7BNMm3c1LZzaNdynXYeDYfH
         d0Bvde4RxaxnIAlvq4l2L2q1znNxetZPGPH43A0hQdH8Iv20VxUIZtTXcgLUlZ2Ya4iZ
         J6Of36TKYT3rTEIW4kG99/FAMRhgqZvcFfhc1o5yBKZlYp3OthXk+9jYFhkgME9UpbYM
         JTzg==
X-Gm-Message-State: ANoB5pm1DU20pfbqH/Qm0Ui8mF0CaDfntsfACRiSjbBq6zGw1UOrGZwY
        QIOB+xJzOl4UTi8l9tUeg3pRFw==
X-Google-Smtp-Source: AA0mqf6oN0gZyT7BOI2ieb7TbLqHVSqMfrMq1tn0e4/SzfNYQAMrlGAGjmyLj4/zoCg9egXcn1gJKg==
X-Received: by 2002:a2e:3512:0:b0:277:c68:874b with SMTP id z18-20020a2e3512000000b002770c68874bmr835701ljz.261.1668688413222;
        Thu, 17 Nov 2022 04:33:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q23-20020ac246f7000000b004a27d2ea029sm128432lfo.172.2022.11.17.04.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 04:33:31 -0800 (PST)
Message-ID: <56e640fe-d3b7-31f1-2171-5040a7e043d2@linaro.org>
Date:   Thu, 17 Nov 2022 13:33:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v8 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Content-Language: en-US
To:     "Larson, Bradley" <Bradley.Larson@amd.com>,
        Rob Herring <robh@kernel.org>, Brad Larson <brad@pensando.io>
Cc:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
References: <e9d8c14d-38b3-0401-7bfc-b2bd7ab36c52@linaro.org>
 <20221116193940.67445-1-blarson@amd.com>
 <20221116223045.GA1130586-robh@kernel.org>
 <BL0PR12MB2401ECC21B2EA83A5D806E369B069@BL0PR12MB2401.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <BL0PR12MB2401ECC21B2EA83A5D806E369B069@BL0PR12MB2401.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 17/11/2022 01:41, Larson, Bradley wrote:
> [AMD Official Use Only - General]
> 
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, November 16, 2022 2:30 PM
> 
>>> v8:
>>>  - Apply review request changes and picked the two unique examples
>>>    for the 4 chip-selects as one has the reset control support and
>>>    the other an interrupt.  Missed the --in-reply-to in git
>>>    send-email for v7, included in this update.
>>
>> No, you haven't. By default in git, you don't have to do anything. See
>> --thread and --no-chain-reply-to options. If you are messing with
>> --in-reply-to, you are doing it wrong.
>>
>> Please resend the whole series properly threaded.
> 
> Will resend the series
> 
>>> diff --git a/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
>>> new file mode 100644
>>> index 000000000000..622c93402a86
>>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
>>> @@ -0,0 +1,60 @@
> ...
>>> +
>>> +title: AMD Pensando Elba SoC Resource Controller
>>> +
>>> +description: |
>>> +  AMD Pensando Elba SoC Resource Controller functions are
>>> +  accessed with four chip-selects.  Reset control is on CS0.
>>
>> One device with 4 chip-selects? Then I'd expect 'reg = <0 1 2 3>;'
>>
>> Hard to say more because I don't have the whole thread nor remember what
>> exactly we discussed before. That was 100s of bindings ago...
> 
> I agree and the example for v7 had all 4 chip-selects shown.  This is not a pick and
> choose device on what functions to use for a usable system.  Krzysztof requested
> only showing two chip-selects in the example.

The problem is that you describe here SPI controller (and its chip
selects) but binding is for the SPI device. The example is not the
problem...

> ...
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +
>>> +    spi {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        num-cs = <4>;

Drop this property as well, unless it is necessary to explain
"amd,pensando-elbasr" device.

>>> +
>>> +        system-controller@0 {
>>> +            compatible = "amd,pensando-elbasr";
>>> +            reg = <0>;
>>> +            spi-max-frequency = <12000000>;
>>> +            #reset-cells = <1>;
>>> +        };

Best regards,
Krzysztof

