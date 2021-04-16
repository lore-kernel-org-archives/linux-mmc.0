Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61169C433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Apr 2021 09:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 376356117A
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Apr 2021 09:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbhDPJwd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Apr 2021 05:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242188AbhDPJwb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Apr 2021 05:52:31 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A5FC06175F
        for <linux-mmc@vger.kernel.org>; Fri, 16 Apr 2021 02:52:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r7so14070517wrm.1
        for <linux-mmc@vger.kernel.org>; Fri, 16 Apr 2021 02:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/JSJp+Tkpj2oHC+t+aQ3pMzn5E4MQekWdcaHODVVDPs=;
        b=Zd2CpPg+2KjAqulL9Rnwmz6bHroGJTQVRiJWLNk6QjtL+9aK70oyA+gP4hUZ+xNgCX
         pblmTtjslgvg8A8RxjsWDlJEFQMqHBya+h5w7Rm7lasOTgQ9+vpvbBBQMs3jcUk3PjkT
         iLnDhBZbsW7QPC1t+byTsyp9j+4phtKgSYLmbZdM8wSxjwCbl1lz2MArmvahFC70AXZW
         7Su7vcoeaspUdvfq681Z9k8KOmn/m1Cnv6y/9qacbQQCd/mTmGwxhY3Tf3TFePhfx6Qp
         jsDLIv5iTGqcB1UdAuEykG5TfmkdzTUy0XxwkqpSjNuEK1JU9Y+WPf3GdnHJnw2gHU5a
         acyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/JSJp+Tkpj2oHC+t+aQ3pMzn5E4MQekWdcaHODVVDPs=;
        b=EirDQo9Yqtv8qfExTKefw2aPkdiO5QL1C4soXeAays9FNlewsw2f34tPyZ9zAC1+cn
         g9VvmHvVOZe4mM6kiHXfllDf01MPXffARDPYpEXLmajrA/tWxcLrz2VrHC+ZVNNsU6fO
         7DM5MnLAYLOe03aEpFb2c3d1IHfHkMeOEX3Q9u7KEDdZtUXcFAppSOdmVF9xDmC31xR8
         oxQLuQAOOnubdhvMLap70PK6cfDsnVdxGp4G+G8wfyuDEMQuteQsT9dLpNBefDCY1iJX
         ZWZkIHTtln/mysLalIgMYVoMcleF0NQeTgo/aHiZC+zrvbp1O/SuTK7VU4kOSGZWLhLt
         f++w==
X-Gm-Message-State: AOAM5325yA2wX7hh/viO2njRGgiWcV92bJPJHuW4lenR2N5WGQnEppYM
        BfpEi/Vgi4wWFx0qDlAul9IPyg==
X-Google-Smtp-Source: ABdhPJwLeVjxevDvuRkaNwCHgSj2pf06ftSAwKCQNXwuAPm7bmGh/kmcoaI44wdJF08QBoLbr7t2yQ==
X-Received: by 2002:adf:fbcc:: with SMTP id d12mr8031032wrs.151.1618566725566;
        Fri, 16 Apr 2021 02:52:05 -0700 (PDT)
Received: from MacBook-Pro.local ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h17sm9483596wru.67.2021.04.16.02.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 02:52:05 -0700 (PDT)
Subject: Re: [PATCH V2] arm64: dts: qcom: sc7280: Add nodes for eMMC and SD
 card
To:     Doug Anderson <dianders@google.com>,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Cc:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        sartgarg@codeaurora.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>, cang@codeaurora.org,
        pragalla@codeaurora.org, nitirawa@codeaurora.org,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>, okukatla@codeaurora.org
References: <1616264220-25825-1-git-send-email-sbhanu@codeaurora.org>
 <CAD=FV=WLZCSd6D5VFyD+1KBp5n1qyszER2EVaEMwYjQfPSSDnA@mail.gmail.com>
 <b77f207b-2d90-3c8b-857f-625bd3867ed1@codeaurora.org>
 <6fdf704c4716f5873d413229ca8adc57@codeaurora.org>
 <CAD=FV=Wa4fT5wZgd0==8kLy_tzTLgdZ-HwdfOEAM9pMeMjjFyg@mail.gmail.com>
 <8126e130e5c0ea1e7ea867414f0510c0@codeaurora.org>
 <CAD=FV=XavWbf_b7-=JT6V5_RNA8CjdK4oRu7H719AaPDJ5tsqQ@mail.gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <bdda73d8-0ba4-92e7-b4ae-ed05cc9a9f55@linaro.org>
Date:   Fri, 16 Apr 2021 12:52:02 +0300
MIME-Version: 1.0
In-Reply-To: <CAD=FV=XavWbf_b7-=JT6V5_RNA8CjdK4oRu7H719AaPDJ5tsqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 14.04.21 23:25, Doug Anderson wrote:
> Hi,
> 
> On Tue, Apr 13, 2021 at 3:59 AM <sbhanu@codeaurora.org> wrote:
>>
>>>>>>> +                                       required-opps =
>>>>>>> <&rpmhpd_opp_low_svs>;
>>>>>>> +                                       opp-peak-kBps = <1200000
>>>>>>> 76000>;
>>>>>>> +                                       opp-avg-kBps = <1200000
>>>>>>> 50000>;
>>>>>> Why are the kBps numbers so vastly different than the ones on sc7180
>>>>>> for the same OPP point. That implies:
>>>>>>
>>>>>> a) sc7180 is wrong.
>>>>>>
>>>>>> b) This patch is wrong.
>>>>>>
>>>>>> c) The numbers are essentially random and don't really matter.
>>>>>>
>>>>>> Can you identify which of a), b), or c) is correct, or propose an
>>>>>> alternate explanation of the difference?
>>>>>>
>>>>
>>>> We calculated bus votes values for both sc7180 and sc7280 with ICB
>>>> tool,
>>>> above mentioned values we got for sc7280.
>>>
>>> I don't know what an ICB tool is. Please clarify.
>>>
>>> Also: just because a tool spits out numbers that doesn't mean it's
>>> correct. Presumably the tool could be wrong or incorrectly configured.
>>> We need to understand why these numbers are different.
>>>
>> we checked with ICB tool team on this they conformed as Rennell & Kodiak
>> are different chipsets,
>> we might see delta in ib/ab values due to delta in scaling factors.

If the scaling factor is different, maybe this should be reflected
in the BCM data, where we have the following:
     @vote_scale: scaling factor for vote_x and vote_y

This is 1000 by default, but maybe we should set it to some
different value for some of the BCMs?

I'm adding Odelu, who is more familiar with this platform.

> 
> ...but these numbers are in kbps, aren't they? As I understand it
> these aren't supposed to be random numbers spit out by a tool but are
> supposed to be understandable by how much bandwidth an IP block (like
> MMC) needs from the busses it's connected to. Since the MMC IP block
> on sc7180 and sc7280 is roughly the same there shouldn't be a big
> difference in numbers.
> 
> Something smells wrong.
> 
> Adding a few people who understand interconnects better than I do, though.
> 

Thanks!
Georgi
