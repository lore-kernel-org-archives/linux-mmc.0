Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E0BC46467
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Nov 2022 16:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbiK2QBa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Nov 2022 11:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbiK2QBA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2022 11:01:00 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E51697CF
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 07:59:24 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id u27so11709963lfc.9
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2022 07:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bDvxVOu+PnvvHRulbZFibX61kwkQP19u6RVUNmmpkgY=;
        b=bw/kC+x+9HZsxIhQWPogLf1q10xRBgTta5JXdbQzEI3yOW1lB1zVd+DO+mU9OChNsp
         OwiHrMEjR3cjneLpBilCu5WReSjHfNk1WtkziQM+nASpT277TBPjRo08F0XoVf7DyVJV
         EQ3+bYudZ/j90oQrP9gpstBeWCQtuha7r6Lr1vQOPG1Yc20bkJeRINKzwAKyiKzpK7ws
         roEH+azxI+KRjYeHxbMaT39a8q9We7+RTbU81GNNnUV0EqFedsVhQ26bvdjMMRwNv1pr
         N9Wv0gtWbmS8uSJWUkOn2gXRo9JdZq2tNKFyVWiTSEGV4+GkE6AZuqoLcRlZYPkfDvVI
         ZW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bDvxVOu+PnvvHRulbZFibX61kwkQP19u6RVUNmmpkgY=;
        b=0k89bTxyviivYlk3w3QUR/rx0HAUePe2gaCPN/5hmAM3gEaiNk5wGIMHC6YCkg3tZQ
         U5eC2B60vxSunGZg3Fgi+s2tTkoyaEYXh/qsE2aqgd4SWHA0Wu1uI3Hh1ZqwQAgrNcqL
         fudzClD7e3mmLCJFjZb50NS1/ABbiorZiTuN03lnZJSAQl/ffRRaf6Go0m+NsRgcsBTQ
         t/e1BsOhiPJDR4Ixqb7XXA6L8IQ++IKs0eJAc+3ARisjzSqbkBUyoOOzWiPqRuMCamXB
         zNtLXMGwXYVTs5tlIMUn8jnd4d5GevEDXovfdCZwQObNQA5DgGxkfbG5S3ymVTAYpHhm
         7fFA==
X-Gm-Message-State: ANoB5pmPxBz4pStEKlGfNeu0lvXrSEn7AMSdnZ8cSnBsL29w7r5VOO/N
        PPVV61L9myRO0UVdLfT2AZSgCw==
X-Google-Smtp-Source: AA0mqf6s6h21gBLJgUb7HsJExGWf4j/ozGnG1ZJJ/G04lnH7uEnRrIfZndNl3qwLh6+Y0H8lkADvEA==
X-Received: by 2002:a05:6512:1505:b0:4af:b5d0:695e with SMTP id bq5-20020a056512150500b004afb5d0695emr20039824lfb.6.1669737562297;
        Tue, 29 Nov 2022 07:59:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z15-20020a056512370f00b004a9b9ccfbe6sm2282883lfr.51.2022.11.29.07.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 07:59:21 -0800 (PST)
Message-ID: <b5a6b8fc-6435-a92f-4b34-8bf95772db65@linaro.org>
Date:   Tue, 29 Nov 2022 16:59:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] dt-bindings: mmc: Make comment on wakeup-source less
 confusing
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, kernel@dh-electronics.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <20221122111124.6828-1-cniedermaier@dh-electronics.com>
 <20221122111124.6828-3-cniedermaier@dh-electronics.com>
 <55c29f92-4c6b-266f-2004-ae633a658963@linaro.org>
 <CAPDyKFparoXMJ-sRxgqi8zDGn5AoNDLfsAF9YkdoaKpTU3EchQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPDyKFparoXMJ-sRxgqi8zDGn5AoNDLfsAF9YkdoaKpTU3EchQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29/11/2022 16:30, Ulf Hansson wrote:
> On Tue, 29 Nov 2022 at 13:36, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 22/11/2022 12:11, Christoph Niedermaier wrote:
>>> The current comment on wakeup-source is a bit confusing, because it isn't
>>> clear at first sight which property is actually deprecated.
>>> Change the comment to one that is less confusing.
>>
>> It's still confusing - you mention some non-existing property. I don't
>> think it's worth to touch it. If you insist, drop entire comment...
> 
> Hmm, it doesn't look that easy to me. The "enable-sdio-wakeup" is
> indeed a deprecated wakeup property [1], but it seems like it's not
> really described somewhere. I wouldn't mind removing it (as it seems
> to add some confusions), but in that case it needs to be entirely
> removed from the DT docs, right?

Yes, from the bindings and from DTSes. It's already gone from
mmc-controller.yaml bindings, so basically we already did the most of
such removal.

> 
> Another option, would be to add a proper description of the property
> and mark it with "deprecated: true".


Best regards,
Krzysztof

