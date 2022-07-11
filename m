Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453A0C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 11 Jul 2022 07:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiGKHpg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 11 Jul 2022 03:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiGKHpf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Jul 2022 03:45:35 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCCC63B6
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 00:45:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y11so796394lfs.6
        for <linux-mmc@vger.kernel.org>; Mon, 11 Jul 2022 00:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wqIFBf3DN10dow3GoXse21GGYLCZcVsfvhzNfQvO+X4=;
        b=bhLbh/jndXXNXiXMqF9n8seGfMnoBKK43GGudT+034/0ObNAvJXElA+PkDogw3+zvz
         pyQjOWzfJ6nNk3z7KpVKqEVBeuQXMlUdEAkDg6rgTp8HbKllExHTod6aqZISDZZbg8Pj
         w0Wi/owibTrxU/BgAaZ9wf1Ur5T18OlAvmcmAlOJUPdvIwvNivbKjeK4yQdy3UBuIdLZ
         MKDR4DBhmYmyBL1nbxQAkYge1/TaXEDSe7ty71Ro6K6AwDeMIgejSTwkfxw1PLZgZRA9
         8O/ba7KaeAKM2zfeq4AUdqc7jGptwKD6OHzc+FyI3VNINdcb6vv2Q6FItsCvH2uabyJ3
         OryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wqIFBf3DN10dow3GoXse21GGYLCZcVsfvhzNfQvO+X4=;
        b=LT2Zwa07hT2tNSmEZugtUqL/iedaLMaU4DGT5gCbkQC0XuNXvwbGLkHWfJrKJUYLMf
         AGIu2Lkf2Bejgjo0P9OpCgBRZqCUliRbU7/R8PlS3hROe4hmPFztPEMkuqmPgqcppLow
         Fe1+SPTtGrpw1OQXCsIdVjd46W3B1fbeAfjNweun+MJw3Crqyl/EpFC16JSA1Bweu2Oo
         gwWjFuZvTn8APsKDoc4EWfBTFql3IjtFw/T9H9j+8u6a2uOm6/qnhID1xFhL28i09sVX
         4wvN2/LJ4tN43kthAZpj2rdZilP1C2e3JjcU472VgeC5cwJK0hoDt7Xe759ebh9AiCUX
         hxsg==
X-Gm-Message-State: AJIora+rV3x5GXxTsdHaLBnsdIqMwtbFXpUWibG2lsFVE+TjYvXPZTe1
        fNrF/pTzRCwkT4gj+cehXUaxlA==
X-Google-Smtp-Source: AGRyM1vPfEahu4HcbTv/71vdz7MtuUZ4XlDhRbns/Wsz9/D078JYEbthPyLCS1hxYMSuW+6bMIpmsg==
X-Received: by 2002:a05:6512:31c9:b0:489:e037:31b9 with SMTP id j9-20020a05651231c900b00489e03731b9mr1802467lfe.178.1657525531668;
        Mon, 11 Jul 2022 00:45:31 -0700 (PDT)
Received: from [10.0.0.8] (fwa5cab-55.bb.online.no. [88.92.171.55])
        by smtp.gmail.com with ESMTPSA id r17-20020ac25f91000000b004867a427026sm1401483lfe.40.2022.07.11.00.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 00:45:31 -0700 (PDT)
Message-ID: <9fb4beb2-96c3-1bf6-9ee3-5b87b641c234@linaro.org>
Date:   Mon, 11 Jul 2022 09:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] dt-bindings: mmc: sdhci-msm: constrain reg-names at
 least for one variant
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org>
 <20220707075151.67335-3-krzysztof.kozlowski@linaro.org>
 <CAD=FV=WFdtx_v3iPaNYDkhBw+fkSRriG0-w1R5vXRCugZPW6Vg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=WFdtx_v3iPaNYDkhBw+fkSRriG0-w1R5vXRCugZPW6Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 07/07/2022 16:31, Doug Anderson wrote:
> Hi,
> 
> On Thu, Jul 7, 2022 at 1:04 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> The entries in arrays must have fixed order, so the bindings and Linux
>> driver expecting various combinations of 'reg' addresses was never
>> actually conforming to guidelines.
>>
>> Specifically Linux driver always expects 'core' reg entry as second
>> item, but some DTSes are having there 'cqhci'.
> 
> This is a bit misleading and makes it sound like we've got a bug. In
> truth the Linux driver looks at the compatible string. If it sees any
> compatible listed as "v5" (or a slight variant of v5 to handle a
> workaround for sc7180 / sdm845) then it _doesn't_ expect 'core' reg as
> the second entry. See the variable `mci_removed`. The old bindings
> ".txt" file also had this to say:
> 
>                 For SDCC version 5.0.0, MCI registers are removed from SDCC
>                 interface and some registers are moved to HC. New compatible
>                 string is added to support this change - "qcom,sdhci-msm-v5".

You're right, thanks, I missed that part.

> 
> So I guess that means this is the documentation for all of the
> combinations you have listed:
> 
> * hc only - v5 controller w/out CQE / ICE
> 
> * hc + core - v4 controller w/out CQE / ICE
> 
> * hc + cqhci - v5 controller w/ CQE and w/out ICE
> 
> * hc + cqhci + ice - v5 controller w/ CQE / ICE
> 
> * hc + core + cqhci + ice - v4 controller w/ CQE / ICE
> 
> Said another way, before v5 the "core" range existed. After v5 it
> apparently doesn't so there's no way we could have specified it.
> 
> You'll notice that one of the options above implies that a v4
> controller (with "core" specified) can have CQE and ICE. Is this
> actually true, or was it a misunderstanding in the .txt to .yaml
> conversion?
> 
> If it's true that a v4 controller can have CQE and ICE then your patch
> is wrong in asserting that v4 controllers have only "hc" and "core".
> 
> If a v4 controller _can't_ have CQE and ICE then your patch is right
> but incomplete. It should also be removing the option:
>           - const: hc
>           - const: core
>           - const: cqhci
>           - const: ice
> 
> I am not intimately familiar with Qualcomm MMC controller history.
> That being said, the old .txt file said:
> 
>         - CQE register map (Optional, CQE support is present on SDHC
> instance meant
>                             for eMMC and version v4.2 and above)
> 
> To me this implies that a v4 controller could _at least_ have "cqhci".
> I dunno about "ice". I seem to recall that this was the argument for
> why the driver had to use reg-names to begin with and why the driver
> looks for "cqhci" by name.


I checked manual and SDCC v4 already supports CQE. ICE appears at v4.1
(MSM8996, MSM8953 and some more which do not have dedicated
compatibles), so the compatibles seems inaccurate. ICE capability can be
runtime detected, but we still need to provide ICE address space. Anyway
I don't want to dig too much into SDCC versions, so I'll allow
hc+core+cqhci+ice.

Thanks for the feedback, much appreciated!


Best regards,
Krzysztof
