Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0D8C46467
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Nov 2022 12:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiK2Mdu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Nov 2022 07:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiK2Mdr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2022 07:33:47 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AF65987A
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 04:33:45 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s8so22250932lfc.8
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 04:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eWiURuJRvAmuYPzpqI5IuB0ekBiTCCwJkSVslWsTGxk=;
        b=UiRPU+UB4O8IwKcHb80Kp4fIqFBx4i0T/QAwF0fryNwIqRMo6wjAbpF3FTq1Uc6oEd
         l2XCJUWyUHNdWjjgqg0E7bQpm1qkfSB2XbDxksmg2fhl8y5BkZRSIGJsK97PxsARF5Lz
         2d/FrFy+1ezdgESwcoVKyCa/XJlkXSSBsC2GfL7hBAsTQQ00g3Du5QOXtkOOnvJ8z1P0
         3ePddbTBACGeX1aKhwew2QOk9s4wwn0/qYhJhV+n29QDVMKMABGocjd4y2CUNxSIxnlA
         2sDwogQwGt1Tv+vrcJtQrRD7TGv4DXbpkAbv0J4kXJ80ka20e8+uBgzFLwGq8yXOvmwX
         JqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWiURuJRvAmuYPzpqI5IuB0ekBiTCCwJkSVslWsTGxk=;
        b=P0P4bsYowssXOaxlSF3hdckpYyKbuDE51SVNvcT6+I5hXH2E1fK0+8HRMZBCtokEJR
         hZ83y8Jx39R/FIPqsEipO/DZqey/iBaL3tNHf75kg3AUWejuue1YwKhjIqO/cLz9+gf2
         Z+zJUP64XBxda5SutqU9Z6bsjOBGpoKNae/4NHOkBV+weMdSXNhXcGjN67k1dT1P+YcX
         r+fh0jNGsw5tCUV+BV3LQf71DyV2KY+SLQh4Waf3uENmsfBDOdtAswQw+Erbmnu7mAC4
         Uu67HJxhyK62sEdNo90AAY45BqlaUz0+1cA1zLeEruiKBIsDvyXHbjy3FNnbnaKSpDkV
         qhIw==
X-Gm-Message-State: ANoB5pkobsNuKJCGEL462tc6VQZfaH20Ej+SjPFCYyCI+fwNIsccJa0n
        MSlDe28YxE8DzVXuwgNupLA9/g==
X-Google-Smtp-Source: AA0mqf4oipRDlOIiFITebYunhRAq9eBxigTkhcl/VBISsSItweziG7YPuy5kUrZ5/YAYa3KHhgLc4g==
X-Received: by 2002:a05:6512:3248:b0:4aa:148d:5168 with SMTP id c8-20020a056512324800b004aa148d5168mr18029487lfr.561.1669725224037;
        Tue, 29 Nov 2022 04:33:44 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z14-20020a056512370e00b004acb2adfa1fsm2185015lfr.307.2022.11.29.04.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 04:33:43 -0800 (PST)
Message-ID: <bb035398-ba56-0ce0-3b14-b8dc5863b7f3@linaro.org>
Date:   Tue, 29 Nov 2022 13:33:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: mmc: Make comment on wakeup-source less
 confusing
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        kernel@dh-electronics.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <20221122111124.6828-3-cniedermaier@dh-electronics.com>
 <CAPDyKFqc2kc4O55BAVikZFeZpAeRYo3AAfnHyxKPcsUujeGauA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPDyKFqc2kc4O55BAVikZFeZpAeRYo3AAfnHyxKPcsUujeGauA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29/11/2022 13:06, Ulf Hansson wrote:
> On Tue, 22 Nov 2022 at 12:43, Christoph Niedermaier
> <cniedermaier@dh-electronics.com> wrote:
>>
>> The current comment on wakeup-source is a bit confusing, because it isn't
>> clear at first sight which property is actually deprecated.
>> Change the comment to one that is less confusing.
>>
>> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
>> ---
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: kernel@dh-electronics.com
>> Cc: linux-mmc@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> To: linux-kernel@vger.kernel.org
>> ---
>>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
>> index 802e3ca8be4d..a921442c6c1d 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
>> @@ -293,7 +293,7 @@ properties:
>>      description:
>>        SDIO only. Preserves card power during a suspend/resume cycle.
>>
>> -  # Deprecated: enable-sdio-wakeup
>> +  # Use wakeup-source instead of the deprecated enable-sdio-wakeup
>>    wakeup-source:
>>      $ref: /schemas/types.yaml#/definitions/flag
>>      description:
> 
> Rob, Krzysztof - do we have a preferred pattern for how to express
> deprecated bindings - or is the above okay to you?

Yes, we have:
  deprecated: true

I don't get why this is in response to LED patch? I entirely ignored
this thread because of it.


Best regards,
Krzysztof

