Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85059ECAAD2
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Aug 2022 18:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiH2SX4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 29 Aug 2022 14:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiH2SXz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2022 14:23:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF147F098
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2022 11:23:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id se27so9674499ejb.8
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2022 11:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=lzr5Lsq+f9ZSX9ifjDA4NRi7ohUATgbbTVphu4Vb8uc=;
        b=WcoLwdRNxh7KerKwMk/KQrIMAxDhwWUjVlF4wMbYe03fZ3sVMAN/iKd+N/rr0LxXet
         8qwb2LMPIXfl9s9M7a+dp4yOPPpjqXOg9r03Nf2VUMTG66199nOyVw/nl0Iv3jriWF4Q
         1kj661VHudfDM1Cn1cCPoHXd1wmlU+R3pumO9xTVDmXcnKDe6k+MaoCJWeywJVR0Ggvy
         1TWzhpzcZbJZK/gs5GJEvNzPbBTHb7R9J+7pavyVD1AglZxS3sTK+HWUa4X6JUBKHpQ8
         LTfY48w2feoStsQT2eRJc6BSNiGn3zTmGybjcwdMTFSYwVKPCQgTkCsO/SRpnCAG5DND
         rKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=lzr5Lsq+f9ZSX9ifjDA4NRi7ohUATgbbTVphu4Vb8uc=;
        b=a28tmgWoYoRv0po6CFFPlRL4AxeDw+WFokhxafGyPw6nwZRgwJPrXHfYXfXo6Sq6ZQ
         CGVr/gRY0eWj3bt4BXQvHL6GmBPncFPvl1wBbHUZJ1ZfW6rg6bkD66PqDOdNyd36dQFg
         lPD4Nq9j5S8fZM7lieyhK7QxSDY7yZp4RrauA+Gspy6YcOzS79sZeq/W/lqfnkSUbfyj
         bQY8zEG8CGdAHiXSBrfp6RqbxOi3yne6JvxEYZFBMtyoLoVGwUYB/rrFHEZYH6z13KS7
         fiTDmye8JMpMfOzSApon0a6+qUXPsbqYKySyQdD0H6xHjhwyKQ/9Mrh2Y3GZ12bZB0b0
         wcxw==
X-Gm-Message-State: ACgBeo1j9ZSDLvUCtkT5QI4Djv1355F7reurrrpjTHnrIZFDUMyxnbUW
        SF86zI8zTvrVMVAsRKJOrUc=
X-Google-Smtp-Source: AA6agR5mhyciLiiZ8wkHuD4vne3nKeE9fhYRT5e0PAtgWAb8iB5OuaMxznYbF/3+9OrPwp3ZmyNUxA==
X-Received: by 2002:a17:906:845c:b0:73d:831e:b73d with SMTP id e28-20020a170906845c00b0073d831eb73dmr13927091ejy.687.1661797432990;
        Mon, 29 Aug 2022 11:23:52 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bd96:2400:287c:a714:9c3c:aa54? (dynamic-2a01-0c23-bd96-2400-287c-a714-9c3c-aa54.c23.pool.telefonica.de. [2a01:c23:bd96:2400:287c:a714:9c3c:aa54])
        by smtp.googlemail.com with ESMTPSA id l9-20020aa7c309000000b0043cc2c9f5adsm6006512edq.40.2022.08.29.11.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 11:23:52 -0700 (PDT)
Message-ID: <7b66d876-aabe-7f07-7e54-0be28a25ed3f@gmail.com>
Date:   Mon, 29 Aug 2022 20:23:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 0/2] mmc: meson-gx: add SDIO interrupt support
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <72459a46-fd20-60d8-a7e7-076d8f321816@gmail.com>
 <CAPDyKFokmJr7e8=gvsYbBbdxceG6kCa57vbYy1tUT_b+B=8P8Q@mail.gmail.com>
 <e970e07d-9bb8-707d-1dc6-09fae2abbfff@baylibre.com>
 <CAPDyKFqRm=RVn__3HJDk_0bBemudh_y7YEYPZe3W7iJCfP50fg@mail.gmail.com>
 <67f29dfe-a579-125e-cb84-f6b554932b42@baylibre.com>
 <CAPDyKFqqtHUtGshE=JYaLK09P28EeenYAsvnDkROvMHb7i2bDg@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAPDyKFqqtHUtGshE=JYaLK09P28EeenYAsvnDkROvMHb7i2bDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29.08.2022 16:21, Ulf Hansson wrote:
> On Mon, 29 Aug 2022 at 15:29, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> On 29/08/2022 14:07, Ulf Hansson wrote:
>>> On Mon, 29 Aug 2022 at 09:42, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>>
>>>> Hi Uffe, Heiner,
>>>>
>>>> On 26/08/2022 11:16, Ulf Hansson wrote:
>>>>> On Thu, 25 Aug 2022 at 21:52, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>>>
>>>>>> Add SDIO interrupt support. Successfully tested on a S905X4-based
>>>>>> system (V3 register layout) with a BRCM4334 SDIO wifi module
>>>>>> (brcmfmac driver).
>>>>>>
>>>>>> v2:
>>>>>> - use new SDIO interrupt API
>>>>>> v3:
>>>>>> - don't duplicate checking mmc->sdio_irq_pending
>>>>>>
>>>>>> Heiner Kallweit (2):
>>>>>>     mmc: meson: adjust and re-use constant IRQ_EN_MASK
>>>>>>     mmc: meson-gx: add SDIO interrupt support
>>>>>>
>>>>>>    drivers/mmc/host/meson-gx-mmc.c | 84 +++++++++++++++++++++++++--------
>>>>>>    1 file changed, 65 insertions(+), 19 deletions(-)
>>>>>>
>>>>>
>>>>> Applied for next, thanks!
>>>>
>>>> Thanks for applying, but I was off (like many of reviewers) and I would have like
>>>> this patchset to be tested on earlier SoCs aswell, or only enabled on S4 for now.
>>>
>>> To actually make use of the new code, an update to the corresponding
>>> DTS files are needed to set the cap-sdio-irq property.
>>
>> I know but it changed the IRQ handling, let's hope we don't see any regressions.
> 
> Right. Let's encourage people to test this!
> 
> I noticed that $subject patch sets the CLK_IRQ_SDIO_SLEEP bit, no
> matter whether the SDIO IRQs has been enabled. Don't know if that is
> intentional and/or could be a problem? Heiner?
> 
This bit enables SDIO interrupts in sleep mode too. I experienced no difference
in behavior if SDIO interrupts aren't enabled.

> [...]
> 
> Kind regards
> Uffe

