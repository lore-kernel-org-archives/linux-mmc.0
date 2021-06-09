Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EC3C48BCD
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Jun 2021 23:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4A2613EA
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Jun 2021 23:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhFJABI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Jun 2021 20:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJABH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Jun 2021 20:01:07 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73CEC061574;
        Wed,  9 Jun 2021 16:59:04 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id l1so21097284pgm.1;
        Wed, 09 Jun 2021 16:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sZzSiPNuS6HzP3W3kJeux2YhF8hkdCu7Hs+HpWnk32I=;
        b=g+mnOJ9CPb2aZZkhrxZSjQEA3l0xsT28NQFB8tWfdHx+kD1J02obbOj4obmpXt1Ru0
         dssAnA5M4elwWQW7f0NTx2UP273vVpzNCCRZj80dHfdkUumjBuKwmAhFyPMk9M1y++N3
         e/cDpxK7XCgTerPLo3tVhrsZR0biCzSYfQZjz/Tg9GurHsOdhkUhpkXG4dv09Q478gJk
         FxAcCXTP3Y0ZNqnxYoaAHmChIciPilU753kDk0dvklM8xp0FydoO/Z2SvUGulTK3ZMZz
         BtcHPLj5FlienrXMZmOJJtoANDOjxuu1FN5VGKv1myOQNTfl8VA/5A224xY02mbXc2N+
         Fx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sZzSiPNuS6HzP3W3kJeux2YhF8hkdCu7Hs+HpWnk32I=;
        b=Qvt0PN20Ws6st6SCVuAupYwXrZBLJ/vOa/NaSdrRbkNRjdoTW7iscMwloXaNasVm19
         GmpEmgcjyNAvPIOaGsKezhR9T3HvsjX3ZlDMBfmccO9wDhNosW/Yx2OFrtZoRKGW5JsS
         EYVjg8lg2f52euWDux/Dm3on70J+uslrev25prlplWI3Z/Dqu5iCFLRw8eKGRnZwzwi7
         RJpnfsoybZPUIyM20ebFQ4V7KwmtYY9dq67uKaRGBdA0MiLxcw8VyU84ugCbaXjUb9oV
         pV5LFNNhWbQ1v7jBt2RUrZcpJfb/cVzxDUDIwzt4pVHxhc/tIZkyvn0G0xY4yQzFACmq
         ED+Q==
X-Gm-Message-State: AOAM532oZlM2kiJn1wpyxpjCqK/Z/5I2h4JXZUvPivkA4Xmj2gi8Y7RP
        US7yG/zL+bveM35EYsaJ7/0=
X-Google-Smtp-Source: ABdhPJwgXo7n2Yno/auZncv+or4D/adXE63ZaZroShaZjM5hYoDhPmOuGVGxmf0W81DyS+VuzrBqAQ==
X-Received: by 2002:a65:6118:: with SMTP id z24mr2130369pgu.325.1623283144265;
        Wed, 09 Jun 2021 16:59:04 -0700 (PDT)
Received: from [192.168.1.67] (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with ESMTPSA id r11sm742619pgl.34.2021.06.09.16.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 16:59:03 -0700 (PDT)
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Add support for the legacy sdhci
 controller on the BCM7211
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Scott Branden <sbranden@broadcom.com>
References: <20210602192758.38735-1-alcooperx@gmail.com>
 <20210602192758.38735-2-alcooperx@gmail.com>
 <CAPDyKFrynST66yA_T3iroiJsfmNuBOEiiBnb=vNoyP6QpvZ7aQ@mail.gmail.com>
 <fe956941-bb39-413e-f051-d9f353f64eda@gmail.com>
 <CAPDyKFpEtvjS1mWC68gRBWD64dq2M1LO84UWE5uDLTzbGz1g8Q@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6acd480a-8928-89bb-0f40-d278294973a1@gmail.com>
Date:   Wed, 9 Jun 2021 16:59:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpEtvjS1mWC68gRBWD64dq2M1LO84UWE5uDLTzbGz1g8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 6/9/2021 2:22 AM, Ulf Hansson wrote:
> On Wed, 9 Jun 2021 at 05:07, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>>
>>
>> On 6/8/2021 5:40 AM, Ulf Hansson wrote:
>>> On Wed, 2 Jun 2021 at 21:28, Al Cooper <alcooperx@gmail.com> wrote:
>>>>
>>>> Add support for the legacy Arasan sdhci controller on the BCM7211 and
>>>> related SoC's. This includes adding a .shutdown callback to increase
>>>> the power savings during S5.
>>>
>>> Please split this into two separate changes.
>>>
>>> May I also ask about the ->shutdown() callback and in relation to S5.
>>> What makes the ->shutdown callback only being invoked for S5?
>>
>> It is not only called for S5 (entered via poweroff on a prompt) but also
>> during kexec or reboot. The poweroff path is via:
>>
>> kernel_power_off() -> kernel_shutdown_prepare() -> device_shutdown() ->
>> .shutdown()
>>
>> For kexec or reboot we do not really care about power savings since we
>> are about to load a new image anyway, however for S5/poweroff we do care
>> about quiescing the eMMC controller in a way that its clocks and the
>> eMMC device can be put into low power mode since we will stay in that
>> mode for seconds/hours/days until someone presses a button on their
>> remote (or other wake-up sources).
> 
> Hmm, I am not sure I understand correctly. At shutdown we don't care
> about wake-up sources from the kernel point of view, instead we treat
> everything as if it will be powered off.

The same .shutdown() path is used whether you kexec, reboot or poweroff,
but for poweroff we do care about allowing specific wake-up sources
configured as such to wake-up the system at a later time, like GPIOs,
RTC, etc.

> 
> We put devices into low power state at system suspend and potentially
> also during some of the hibernation phases.
> 
> Graceful shutdown of the eMMC is also managed by the mmc core.

AFAICT that calls mmc_blk_shutdown() but that is pretty much it, the
SDHCI platform_driver still needs to do something in order to conserve
power including disabling host->clk, otherwise we would not have done
that for sdhci-brcmstb.c.
-- 
Florian
