Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26DAECAAD1
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Sep 2022 07:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiIAHVz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Sep 2022 03:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiIAHVd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Sep 2022 03:21:33 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9D14F642
        for <linux-mmc@vger.kernel.org>; Thu,  1 Sep 2022 00:20:20 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bq23so23145551lfb.7
        for <linux-mmc@vger.kernel.org>; Thu, 01 Sep 2022 00:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=iAjJ7YXrX4dY+khgJ0CvZFUwoSGJiVC2yG+JBLcRLOs=;
        b=fLWwUhHvPyto5H3nuIWvqJPMNvmWOB004/EKKa2V47PhZjWX58wky1TPW9KCu0SFig
         8d0o67kBt3PyANHrQ6WwuTiJtIMHIHbH7rwT9RJjsFcsUvCiDfo3mwdriq1zL4a6OS36
         VtWY9yGEEO5z5kdRf0j3O953oqkpWYjltrRHw4np1NPtTrOIVF4b954l3eZ1Qz8VUeIl
         vAN6ue2tgabtHJ5PX4nMvGJlRbeUMg5H6dOnuHgWq2g4aJZ1xDmndzzvb82dNGgGsUzx
         12zAEYUmOBl+HrL1VeMRv/QfRwFEpyOph8nx7WSD+8TtBgoz+NhfhcYDj4B1xWsjo+zA
         NBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=iAjJ7YXrX4dY+khgJ0CvZFUwoSGJiVC2yG+JBLcRLOs=;
        b=4Y7lzGCD95d+Xsj/4fUO806qlnLIyCAn9BUhN8k8fOgPqWlW8p04sivUdQK7tvgZGX
         pq1GBQl99DlBE8detw1x9JrHGWJRQ6jWeA+lJ6RjPdfWGn7+4r8yG4zk7x2vJVlqPeEJ
         zBz+7INg8OD6unPkJkXWtfBUmVQ9UqAsc07aHfjegE7hC9AbCXvRKAR7jdgXmzW4CWVw
         uMlUDbGlQhyV67/gdFiRkW9ZBmgPaeOCyWnPoSq3AVNNLiouVBQmoxwkiBJFDlseF7jM
         pPshaCjaWQEhg1oQSe2kFxUkyK5ngQtpzSU5KS2ZLFcXGfDy+2dCJCW5/9o2FXagHwHg
         D1QA==
X-Gm-Message-State: ACgBeo0dS1iCDpoSVsQ3pfZbiemm9csNB6uXjH5CCbfLjZ10qD1gNmbG
        I0IAFhRtfkvqRik+BXNOlxnPVw==
X-Google-Smtp-Source: AA6agR7p9hZ4KeN5ZMThv3ZJ9FdSHYAb/sKypVOmRnbR+PSR6S3byZbXwveJtyu3K7crCSdR8rrTdA==
X-Received: by 2002:a05:6512:230c:b0:494:8ddb:606 with SMTP id o12-20020a056512230c00b004948ddb0606mr1844510lfu.44.1662016814560;
        Thu, 01 Sep 2022 00:20:14 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id r26-20020a2e80da000000b0025e49aaae10sm1575867ljg.12.2022.09.01.00.20.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:20:14 -0700 (PDT)
Message-ID: <936c5623-07b9-c49d-e113-fc056a4eb9bc@linaro.org>
Date:   Thu, 1 Sep 2022 10:20:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Content-Language: en-US
To:     "Larson, Bradley" <Bradley.Larson@amd.com>,
        Rob Herring <robh@kernel.org>, Brad Larson <brad@pensando.io>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "brijeshkumar.singh@amd.com" <brijeshkumar.singh@amd.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "piotrs@cadence.com" <piotrs@cadence.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-7-brad@pensando.io>
 <20220822142544.GA3770388-robh@kernel.org>
 <554f33b4-d235-5516-e8ff-5bf80d63a9b9@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <554f33b4-d235-5516-e8ff-5bf80d63a9b9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 01/09/2022 02:01, Larson, Bradley wrote:
> 
>>> +  is implemented by a sub-device reset-controller which accesses
>>> +  a CS0 control register.
>>> +
>>> +maintainers:
>>> +  - Brad Larson <blarson@amd.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - amd,pensando-elbasr
>>> +
>>> +  spi-max-frequency:
>>> +    description: Maximum SPI frequency of the device in Hz.
>> No need for generic descriptions of common properties.
> 
> Changed to "spi-max-frequency: true" and moved to end of properties.

Then you should rather reference spi-peripheral-props just like other
SPI devices.

> 
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  '#address-cells':
>>> +    const: 1
>>> +
>>> +  '#size-cells':
>>> +    const: 0
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - spi-max-frequency
>>> +
>>> +patternProperties:
>>> +  '^reset-controller@[a-f0-9]+$':
>>> +    $ref: /schemas/reset/amd,pensando-elbasr-reset.yaml
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +
>>> +    spi {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        num-cs = <4>;
>>> +
>>> +        sysc: system-controller@0 {
>>> +            compatible = "amd,pensando-elbasr";
>>> +            reg = <0>;
>>> +            #address-cells = <1>;
>>> +            #size-cells = <0>;
>>> +            spi-max-frequency = <12000000>;
>>> +
>>> +            rstc: reset-controller@0 {
>>> +                compatible = "amd,pensando-elbasr-reset";
>>> +                reg = <0>;
>> What does 0 represent here? A register address within 'elbasr' device?
> 
> Removed, I recall a check threw a warning or error without reg.
> 
>> Why do you need a child node for this? Are there other sub-devices and
>> your binding is incomplete? Just put '#reset-cells' in the parent.
> 
> Without a reset-controller node and booting the function 
> __of_reset_control_get(...) fails to find a match in the list here

That's not actually the answer to the question. There was no concerns
whether you need or not reset controller. The question was why do you
need a child device instead of elbasr being the reset controller.

Your answer does not cover this at all, so again - why do you need a
child for this?

Best regards,
Krzysztof
