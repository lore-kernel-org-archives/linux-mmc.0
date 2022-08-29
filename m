Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B8FECAAD5
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Aug 2022 13:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiH2Nal (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 29 Aug 2022 09:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiH2NaQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2022 09:30:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7718D2B277
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2022 06:29:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bq11so10192179wrb.12
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2022 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=0rzM7C+X4i/7+BgYPEAODopBKOgCUDXP2Yabdqjl+eg=;
        b=j+G31/aZ6ifEmtGsEbtR20sGXfhwMKDtYQLAWAdKkrUdgeF2sCNTMxYtoDuTRRSF79
         Q+j3CHhHyWyy3CSrxSAO0ElnySwHymijyMimdnVvNojKGUT6twlktQYFueAQ1Es3Yafq
         RB1QC4pcbYxz+QXEIln2qeTOoyXhuMUTG+TbWHlnJWBEELTzg5ZrrYReMUXCc4bBydtb
         4L2nhcwVlMc39A5QiRdEwF2I3wYP283KZutvasz+hfOf02tUyDIC/2+ndt1Yof3JztU2
         e356qtHbIYSgfgn9ExG1rEp9cVgtC698jO6g0SKAwrARZD0crR28Fwg3hjrQCWfizV7l
         KLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=0rzM7C+X4i/7+BgYPEAODopBKOgCUDXP2Yabdqjl+eg=;
        b=zyI5Xiv53NhoUjG/I1AEtnG/mNiRwn9M1/O+To9ddaUAfr7m9FbmHRfYHS2u/3assO
         /+3YRSD9rj+84DrGI7zp45xQzJUPNDn5q2PhiBz+1vHNiOtc0kYbo5VDSak5Fs9L9m3Q
         6aEKZsUPd7GHtJNcUtSwpesidan+AfBD1XyIppLslNvzcsnb+L2n418JsTjwWip/7AhB
         GlD8D97Rz4AoP4y4kwfgWEJrQ1eCB3x+z09pTdveJ1lM6FV9ZGs2Clm8IbN9N6KZnM+h
         wLnd9hOOWBBokuQjYsxTqD1Fr4xxGWiWiN7Icjdt0HNMqoshpnxqY5ctzlvM6pUQga54
         FmQA==
X-Gm-Message-State: ACgBeo2rMHfwXLeokzLvHEFFhXOiI1DgEB5OwKgVsGbBeQi32mUTHX9e
        0gZAEKzBs1tIyY4tZKjnT5enFg==
X-Google-Smtp-Source: AA6agR5lGVIfTvRtLKqvSwvLM/w54qDXbW6ptavzy0/El/cYWWyFKOkiRmSLjKpDkoaAWwl6Scaigg==
X-Received: by 2002:adf:dece:0:b0:226:dc0a:8b1a with SMTP id i14-20020adfdece000000b00226dc0a8b1amr2261100wrn.401.1661779793279;
        Mon, 29 Aug 2022 06:29:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6124:6b74:2847:d37b? ([2a01:e0a:982:cbb0:6124:6b74:2847:d37b])
        by smtp.gmail.com with ESMTPSA id h16-20020adff4d0000000b00226dbf4f607sm2815907wrp.10.2022.08.29.06.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 06:29:52 -0700 (PDT)
Message-ID: <67f29dfe-a579-125e-cb84-f6b554932b42@baylibre.com>
Date:   Mon, 29 Aug 2022 15:29:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/2] mmc: meson-gx: add SDIO interrupt support
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
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
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <CAPDyKFqRm=RVn__3HJDk_0bBemudh_y7YEYPZe3W7iJCfP50fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 29/08/2022 14:07, Ulf Hansson wrote:
> On Mon, 29 Aug 2022 at 09:42, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Hi Uffe, Heiner,
>>
>> On 26/08/2022 11:16, Ulf Hansson wrote:
>>> On Thu, 25 Aug 2022 at 21:52, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>> Add SDIO interrupt support. Successfully tested on a S905X4-based
>>>> system (V3 register layout) with a BRCM4334 SDIO wifi module
>>>> (brcmfmac driver).
>>>>
>>>> v2:
>>>> - use new SDIO interrupt API
>>>> v3:
>>>> - don't duplicate checking mmc->sdio_irq_pending
>>>>
>>>> Heiner Kallweit (2):
>>>>     mmc: meson: adjust and re-use constant IRQ_EN_MASK
>>>>     mmc: meson-gx: add SDIO interrupt support
>>>>
>>>>    drivers/mmc/host/meson-gx-mmc.c | 84 +++++++++++++++++++++++++--------
>>>>    1 file changed, 65 insertions(+), 19 deletions(-)
>>>>
>>>
>>> Applied for next, thanks!
>>
>> Thanks for applying, but I was off (like many of reviewers) and I would have like
>> this patchset to be tested on earlier SoCs aswell, or only enabled on S4 for now.
> 
> To actually make use of the new code, an update to the corresponding
> DTS files are needed to set the cap-sdio-irq property.

I know but it changed the IRQ handling, let's hope we don't see any regressions.

> 
> If that isn't sufficient, I prefer if we make a patch on top of the
> $subject series.

OK, let's wait and see

> 
> Kind regards
> Uffe

Thanks,
Neil
