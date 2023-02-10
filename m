Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431B6C05027
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Feb 2023 11:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjBJLmC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Feb 2023 06:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjBJLmA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Feb 2023 06:42:00 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8641C14234
        for <linux-mmc@vger.kernel.org>; Fri, 10 Feb 2023 03:41:56 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o18so4804596wrj.3
        for <linux-mmc@vger.kernel.org>; Fri, 10 Feb 2023 03:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+1Hokza/rU47NXkUNadYe1UXBqBUr2w3Zg790aE96A0=;
        b=ltdGgJD9bbf6fuoivKqor5pMjRN+/pLdfKU6sgMhGrmDai/QeZoFwsrA72u+zKBO7G
         yfwhepNDPNouSZfew/vRQqiJk9Z/g8o9gC4IgN07oUMVt/JDIA5SawQM195TJSs2YxKR
         R5nYedqCGOJPLrfdn89Lq8ahA2Eh0pYD+c8evEkFRXnszQWdHTqLc+QaS0LYKzxKRnhA
         GluyHZ5UjtlHyR7nbIW48eQ8cCSv2Vx7vr5iIm8Bl++B2raMkV5+T5rx4mNpm3y4Hjbd
         Xr3K3ZymlWJrND3M4WwYW1k3ZrFomQzoqEq5QsDZDBR6KtE8mb+HaEpuOwgDU9YcJKOI
         x8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1Hokza/rU47NXkUNadYe1UXBqBUr2w3Zg790aE96A0=;
        b=t7fk+4RfTqcyYSvBzdr9GtYJoWmdu8sS23NiJZ9mZkdVvExyvpVl5oDZanpvVjeW0L
         OrnFI/no/LNjs2Axn5sGBBrz3ZaKUoIGgCVOGqLKzjA6I71ZaIzSwLytkEnwpf9AA7fP
         fYL4XuZGScRit2IonuWp0koDN1hL1bFmhQjttPdwiMzEuXc/ulTEZAjSNkJ9CkaR11Xu
         7mXpTjCGVwOeIWQGk4FPGbh64USPfuk10yJ+VeprjLxk+0CpaqST7JsCsx5/yNjILfPD
         7KhpWjzXUmp/D09X5TJNgJEt24ZRjEAGZVr9zWTm+d7e4cE5dT2OvLIqVBH/h22JmmAh
         NOEw==
X-Gm-Message-State: AO0yUKWIZUVyuob4vrl3ArlSZ8nGAQ23Ueem4WjnGfmQh7Rl2ARcNr2c
        pSssYEt8zcust1GEQxS2y1ETeg==
X-Google-Smtp-Source: AK7set+ywEK8ZNR0oaDC5Zo5ahb+nJPy87HEcyapQ8T1F6CTrcWTftpJgtSLQHM8hr3ISPDNr2bKTg==
X-Received: by 2002:adf:f287:0:b0:2c5:3d1c:efda with SMTP id k7-20020adff287000000b002c53d1cefdamr4503616wro.31.1676029315093;
        Fri, 10 Feb 2023 03:41:55 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d5941000000b002c54241b4fesm2376840wri.80.2023.02.10.03.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 03:41:54 -0800 (PST)
Message-ID: <07d2aad9-ce87-01d2-fb21-0301606231d3@linaro.org>
Date:   Fri, 10 Feb 2023 12:41:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: mmc: Add resets property to cadence SDHCI
 binding
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230209014211.17816-1-hayashi.kunihiko@socionext.com>
 <ec412378-ae31-e199-b5a1-f37a4731f31a@linaro.org>
 <8d80a837-b2bd-26af-e633-5b6081caaaef@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8d80a837-b2bd-26af-e633-5b6081caaaef@socionext.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 09/02/2023 12:34, Kunihiko Hayashi wrote:
> Hi Krzysztof,
> 
> On 2023/02/09 18:14, Krzysztof Kozlowski wrote:
>> On 09/02/2023 02:42, Kunihiko Hayashi wrote:
>>> Cadence SDHCI controller allows reset control support on UniPhier SoC.
>>> Add resets property to cadence SDHCI binding.
>>>
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>> ---
>>>   Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>>> b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>>> index d3dce4d6c168..adacd0535c14 100644
>>> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>>> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
>>> @@ -29,6 +29,9 @@ properties:
>>>     clocks:
>>>       maxItems: 1
>>>
>>> +  resets:
>>> +    maxItems: 1
>>
>> This looks specific to UniPhier, doesn't it?
> 
> I think this IP has some hardware reset lines, however,


Hm, fine with me. It's actually expected.

> it depends on the implementation whether the lines can be
> soft controlled or controlled by power-on-reset.
> 
> In case of UniPhier SoC, these lines are connected to the syscon
> reset controller, but deasserted with initial state.
> 
> Currently, the binding has one compatible.
> If drawing this dependency, Is the device dependent compatible necessary?
> Or I can remove reset property from DT.

No, its okay.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

