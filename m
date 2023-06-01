Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F283C7EE23
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jun 2023 09:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjFAJvt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Jun 2023 05:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjFAJvs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jun 2023 05:51:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FB0138
        for <linux-mmc@vger.kernel.org>; Thu,  1 Jun 2023 02:51:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96fe2a1db26so78092566b.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Jun 2023 02:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613101; x=1688205101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QG9pHzzcyK6b24WKR++ZmeXnFl9pwi+O6EouelciZaI=;
        b=RuoajPozdhZntVDqrt1dOELtD3PuASBkJJqgjFSWckckoj+ZbYkFQIhqlYXROuBSUk
         A06fkccrZV8021BwHMGRKkG+emj4yClL6ZC9C+VqeR5GK98zbG25W/x8OOp87iUGaIzk
         oIVthKVSbS9N4/LWTwj07LgxgxegakQiX5HCBt5apCJIYQALr8A/h4gZwLIOmjYCxXcK
         qLuVmeobXokE0O7vgvRw4C/+SAws7AZZVQu6z73D0JQhS5eM7CtaSKwlNUGP6Lxggdnr
         I/zXxhopWMJz+FUXYXYChQIzOubYewmtlhf8mzHWX9seLh8XQSASkKeciZSNKkYDso5d
         pRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613101; x=1688205101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QG9pHzzcyK6b24WKR++ZmeXnFl9pwi+O6EouelciZaI=;
        b=HOi7ZFES7sX529bwP4/NmsVSXtNBR3ieGjlK+uCyhGHfL4+RFdEXHyt1DzHHbPl6MA
         4WjBGxaDTnth6MLfYXDu4pNa+yRJWCq7aAjqINK9S1dfCrhmAfBXvBtIFAyRuUiGKlpb
         GsEPmUkXP5xENH4KoG9RENjoWVGC+uE4pRxzY861+vr6wjy0qK/v3jj03/EOo5Hzv8do
         WP79AgPeroPNpeMbtReEmgLl79aCkmJmOjLaHFwgAPaFlLFbG/xNHX4+8e4cT7+uko+h
         nVVgX4MlzfWEeO4Uk6lcYOgJHeg4dwMfjtk9CFUlgg9sHLIGAzeBy+vZ6Kxdjkwe2rKS
         DO2w==
X-Gm-Message-State: AC+VfDyiqJ9x9ibnLpOUOEhqz7GstjmmYHccCzu6q4bRGXqhcf/vgVFR
        XlSypTSo0ud+en+UD6wLkD0O1w==
X-Google-Smtp-Source: ACHHUZ7D9TmemflT+NV4U6bJeJ6lfj1rIcifZvhAelKJmzqQ5l0NUReLgGxytAOtXg4CuZgjcTXW2Q==
X-Received: by 2002:a17:907:7f8c:b0:96f:a0ee:113c with SMTP id qk12-20020a1709077f8c00b0096fa0ee113cmr9010761ejc.19.1685613101389;
        Thu, 01 Jun 2023 02:51:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id a6-20020a170906244600b00965b416585bsm10248223ejb.118.2023.06.01.02.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 02:51:40 -0700 (PDT)
Message-ID: <664940c3-9ec1-b4bd-9db5-fa3529e3d1ff@linaro.org>
Date:   Thu, 1 Jun 2023 11:51:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V7 4/8] pinctrl: qcom: Add IPQ5018 pinctrl driver
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        andy.shevchenko@gmail.com
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robimarko@gmail.com
References: <20230519125409.497439-1-quic_srichara@quicinc.com>
 <20230519125409.497439-5-quic_srichara@quicinc.com>
 <CAHp75VfVx+oGYKcija3h9-eWc6jggMx8p5SAQTEHTBEbjTaJKw@mail.gmail.com>
 <1823419a-6bb4-03f7-d5ae-e32204c5e598@quicinc.com>
 <ZHTK7uEzO7kcx_cV@surfacebook>
 <aefd0df1-8dfb-1b69-589b-974dea312845@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <aefd0df1-8dfb-1b69-589b-974dea312845@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 01/06/2023 11:50, Sricharan Ramabadhran wrote:
> 
> 
> On 5/29/2023 9:25 PM, andy.shevchenko@gmail.com wrote:
>> Mon, May 29, 2023 at 03:58:09PM +0530, Sricharan Ramabadhran kirjoitti:
>>> On 5/20/2023 12:17 AM, Andy Shevchenko wrote:
>>>> On Fri, May 19, 2023 at 3:55 PM Sricharan Ramabadhran
>>>> <quic_srichara@quicinc.com> wrote:
>>
>> ...
>>
>>>>     depends on OF || COMPILE_TEST
>>>
>>>   Yeah sure. COMPILE_TEST could be standalone. Will fix it and repost.
>>
>> Standalone COMPILE_TEST will give you definitely NOT what you want.
>> And actually it's strange to have it standalone.
>>
> 
>   Ho ok, i meant like this, "depends on ARM64 || COMPILE_TEST"

Don't do it differently than all other drivers. Open the Kconfig and
look at existing entries.

Best regards,
Krzysztof

