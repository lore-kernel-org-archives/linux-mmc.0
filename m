Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED840C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 07:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFA264FFF
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 07:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCJHBC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Mar 2021 02:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhCJHAs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Mar 2021 02:00:48 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1DBC06174A;
        Tue,  9 Mar 2021 23:00:47 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id e19so36248360ejt.3;
        Tue, 09 Mar 2021 23:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HpV61g+oYLSYBtGEzPQewJ9jJKBtqUZ3vW8+ZlcK3bc=;
        b=LDWfLaRuwyZp4ECU1y7VCbePgB5Q0iLvwj39bY/02EFzCMUDA4nu/BjUhUB0pC2DNH
         iP8MFEJEsy1ho8AWsc1bp6afZbOlYCMnkqj9uWN7jXSwMItiz3/1dzJjAc9NlUOXjkdT
         5AK6iNmA8b8mQcBVXdTdyjFK7ysbPekP4/C1y9dBPaaORFTMrn6cdWn9QK/ReEOGyx+K
         D8GzxCxMRn8VR3EqoVsuQmiqEQs5ApvQjyjduJoOMMz/utUaEmAcitpPzOGVFrVzq0ED
         xKHurBwn2oMzDB/egVY0TGxBOjZCMZo5V31EvjOVS6HyIhlVfnIBXDeLyKr1hM6CfQ3i
         9ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HpV61g+oYLSYBtGEzPQewJ9jJKBtqUZ3vW8+ZlcK3bc=;
        b=cMSNcM7t210X46hJzFka5V6nKAHAAsqI188Aw+znm90X1iUCRbSftweHq7pt07l7xX
         kgWZJmHWFkRqa8JdrWi8O3qqmQHwvJ39wGzmc9n0ycoaen/t3cXc77AgkJBhTesrY8rS
         oM67jiCWceoqkhYNLewiB3T6J1zu5JLQATxuuvAK8jskcMzVflLmuq5ih57oFWvWOQsa
         O2E5hCNZiTkm0le10MkcehvsUXu1gK6zb7FHOFmdWPFxBToyjqYZy0WHXMNj2SCT4Scc
         BV7AMDHYc/c+SbGs16/9ZC2PF8sIfVtLqFhAF8GZx756QgTB+AmqSFHKCs17NLG7vsx7
         8lAg==
X-Gm-Message-State: AOAM532NSw4xrDm+73Vfk5rYchyFr2CjmuNjUVnNZEtYIfHbbo6zsiev
        LEly/pBg59hu9LN1rNYZWuqi5MEGUIwIjQ==
X-Google-Smtp-Source: ABdhPJxgXlxFN3aPH8RD25JOLFYzmkQANhpzj7tPt7r9hmWyNhp5WBYhOc4/TPu6lhL3aOyHTjzFlw==
X-Received: by 2002:a17:906:a944:: with SMTP id hh4mr2005336ejb.479.1615359646569;
        Tue, 09 Mar 2021 23:00:46 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r5sm10157691eds.49.2021.03.09.23.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 23:00:46 -0800 (PST)
Subject: Re: Re: [PATCH v3 2/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Add
 rockchip support
To:     Rob Herring <robh@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
References: <1615254990-192784-1-git-send-email-shawn.lin@rock-chips.com>
 <1615254990-192784-2-git-send-email-shawn.lin@rock-chips.com>
 <20210310030122.GA1664258@robh.at.kernel.org>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <9f8b3be6-d87e-d944-d5db-67f3bcf0fad0@gmail.com>
Date:   Wed, 10 Mar 2021 08:00:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210310030122.GA1664258@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 3/10/21 4:01 AM, Rob Herring wrote:
> On Tue, Mar 09, 2021 at 09:56:29AM +0800, Shawn Lin wrote:
>> This patch adds rockchip support in sdhci-of-dwcmhsc.yaml
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v3: None
>>
>>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml           | 24 ++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>> index f99fb9f..43989f2 100644
>> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
>> @@ -16,6 +16,7 @@ allOf:
>>  properties:
>>    compatible:
>>      enum:

>> +      - rockchip,dwcmshc-sdhci

Compatible strings are supposed to be SoC orientated.
What SoC was this change for? rk3568 ?
Could Shawn confirm that?

         - rockchip,rk3568-dwcmshc-sdhci ??

Could Rob advise here?

>>        - snps,dwcmshc-sdhci
>>  
>>    reg:
>> @@ -31,12 +32,24 @@ properties:
>>      items:
>>        - description: core clock
>>        - description: bus clock for optional
>> +      - description: axi clock for rockchip specified
>> +      - description: block clock for rockchip specified
>> +      - description: timer clock for rockchip specified
>> +
>>  
>>    clock-names:
>>      minItems: 1
>>      items:
>>        - const: core
>>        - const: bus
>> +      - const: axi
>> +      - const: block
>> +      - const: timer
>> +
>> +  rockchip,txclk-tapnum:
>> +    description: Specify the number of delay for tx sampling.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Constraints for this? 0 - 2^32 is okay?
> 
>> +
>>  
>>  required:
>>    - compatible
>> @@ -49,6 +62,17 @@ unevaluatedProperties: false
>>  
>>  examples:
>>    - |
>> +    mmc@fe310000 {

>> +      compatible = "rockchip,dwcmshc-sdhci";

      compatible = "rockchip,rk3568-dwcmshc-sdhci"; ??

>> +      reg = <0xfe310000 0x10000>;
>> +      interrupts = <0 25 0x4>;
>> +      clocks = <&cru 17>, <&cru 18>, <&cru 19>, <&cru 20>, <&cru 21>;
>> +      clock-names = "core", "bus", "axi", "block", "timer";
>> +      bus-width = <8>;
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +    };
>> +  - |
>>      mmc@aa0000 {
>>        compatible = "snps,dwcmshc-sdhci";
>>        reg = <0xaa000 0x1000>;
>> -- 
>> 2.7.4
>>
>>
>>
> 


