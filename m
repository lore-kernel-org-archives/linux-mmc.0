Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F7FC433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Sep 2022 09:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiI2JjO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Sep 2022 05:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbiI2JjF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2022 05:39:05 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE861319AE
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2022 02:39:02 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id i26so1374646lfp.11
        for <linux-mmc@vger.kernel.org>; Thu, 29 Sep 2022 02:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kCZ4Pz5Na1L5rg+BCeSLukrf0LAH8BPG3NztvAytJ0Y=;
        b=EnhQRapMdIIxrVNiesoKMYgH2QA2B7VgT3sVjo2pIipQYrifNQfYIExcwmgyONZVPR
         pNznMI41AZ3qRYIUKH7Zm4N3fIdFXAiOksFVt9aS4mx4U13ubueTrGNGLIVkxI4dczEq
         soqda72d0ClvgGb3wibLvoIl8xPIRWJigsQnyFbD//hmiFe8wiogJiOGxQoOJdWvqKuC
         mZHJVj4cOrABxKr1pTk7s8qNB/Bv2jGRpDOAirMx7eM6jiQFteC7c1Rxf+gKR2RzlF5N
         Btl9pbzhi9TMFU8ZwqRGw54O/uDK82HOrxUIB9O5IiXG9Rh1kjEbTB/bXbkeWRqvx3Y9
         Nj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kCZ4Pz5Na1L5rg+BCeSLukrf0LAH8BPG3NztvAytJ0Y=;
        b=LGq1VrWtbouW5q+WCjaybRuSZcIQLweDtoMVEVGPD7/RwcRn5eFzXxbuVD4DNBW3/I
         mZJDX1tinz9ng2JP5b8nt3yGkQevOHOFaiIOmnLssj6gZ+TM2riPqaW9F9KrQoVIIGNF
         MoYDezyX5bWwb+qMGopFVLSnhLBaYlVirGN+XG/gWuRXSjl8U0geoFH5DT0yjQP/A8YN
         Y7r1iyXdlztUVU3Uuy/dVffJX0FnHUqA+9vkZHqtxdZXpwCQPsXZnHkt9aaTzJxF7RKq
         fjQ0m/BOCUcZ4LWtGJ7G2OjnUTkRLDlUk8L2BshVbpqVdXv2ua/Fenwi4lzS15f1G0ZO
         1HCA==
X-Gm-Message-State: ACrzQf0vFpAE7wsYNI4lmniodFTVVcbMVIWRrTKyu7ZNSV1A1A5BC1ii
        7WwyqleQIRW11rwG1AInEREmrg==
X-Google-Smtp-Source: AMsMyM7T8oKUZtlfNO3LqEKKqsfZycyI7KzJAN9PiOq28dhUgTbRJ0jLBas2YrP9hD+SezXLSRPglg==
X-Received: by 2002:a19:5e4f:0:b0:497:aa47:86b8 with SMTP id z15-20020a195e4f000000b00497aa4786b8mr885795lfi.261.1664444340939;
        Thu, 29 Sep 2022 02:39:00 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g22-20020a056512119600b00498f3ebffb2sm736362lfr.25.2022.09.29.02.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 02:39:00 -0700 (PDT)
Message-ID: <0fff7922-7932-dda7-f476-32f4b0d09fa0@linaro.org>
Date:   Thu, 29 Sep 2022 11:38:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHv4 1/3] dt-bindings: mmc: synopsys-dw-mshc: document
 "altr,sysmgr-syscon"
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     jh80.chung@samsung.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220928165420.1212284-1-dinguyen@kernel.org>
 <CAPDyKFp5oPuOz9A=37pRTvq7JPtJRdduEgmU9g+eUm0K=dZjUg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPDyKFp5oPuOz9A=37pRTvq7JPtJRdduEgmU9g+eUm0K=dZjUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29/09/2022 11:24, Ulf Hansson wrote:
> On Wed, 28 Sept 2022 at 18:54, Dinh Nguyen <dinguyen@kernel.org> wrote:
>>
>> Document the optional "altr,sysmgr-syscon" binding that is used to
>> access the System Manager register that controls the SDMMC clock
>> phase.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>> v4: add else statement
>> v3: document that the "altr,sysmgr-syscon" binding is only applicable to
>>     "altr,socfpga-dw-mshc"
>> v2: document "altr,sysmgr-syscon" in the MMC section
>> ---
>>  .../bindings/mmc/synopsys-dw-mshc.yaml        | 31 +++++++++++++++++--
>>  1 file changed, 28 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
>> index ae6d6fca79e2..b73324273464 100644
>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.yaml
>> @@ -6,9 +6,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>>
>>  title: Synopsys Designware Mobile Storage Host Controller Binding
>>
>> -allOf:
>> -  - $ref: "synopsys-dw-mshc-common.yaml#"
>> -
>>  maintainers:
>>    - Ulf Hansson <ulf.hansson@linaro.org>
>>
>> @@ -38,6 +35,34 @@ properties:
>>        - const: biu
>>        - const: ciu
>>
>> +  altr,sysmgr-syscon:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    items:
>> +      - items:
>> +          - description: phandle to the sysmgr node
>> +          - description: register offset that controls the SDMMC clock phase
>> +    description:
>> +      Contains the phandle to System Manager block that contains
>> +      the SDMMC clock-phase control register. The first value is the pointer
>> +      to the sysmgr and the 2nd value is the register offset for the SDMMC
>> +      clock phase register.
>> +
>> +allOf:
>> +  - $ref: "synopsys-dw-mshc-common.yaml#"
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const:
>> +              - altr,socfpga-dw-mshc
>> +    then:
>> +      required:
>> +        - altr,sysmgr-syscon
>> +    else:
>> +      properties:
>> +        altr,sysmgr-syscon: false
> 
> So this change will not be backwards compatible with existing DTBs. I
> noticed that patch2 updates the DTS files for the arm64 platforms, but
> there seems to be some arm32 platforms too. Isn't this going to be a
> problem?
> 

The backwards compatibility is actually expressed by the driver. If the
driver keeps ABI, we can change bindings so that all DTS are being
updated to pass the checks.

On the other hand, the commit should express why it changes the bindings
in incompatible way - this is lacking here.

Best regards,
Krzysztof

