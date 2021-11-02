Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C70C433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Nov 2021 15:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE986603E5
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Nov 2021 15:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhKBP30 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbhKBP3Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Nov 2021 11:29:24 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB19C061205
        for <linux-mmc@vger.kernel.org>; Tue,  2 Nov 2021 08:26:49 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id i26so33627432ljg.7
        for <linux-mmc@vger.kernel.org>; Tue, 02 Nov 2021 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fxVnPZH6b6L2I7aYk+0v0By0qTM5ney7UTSCmiLQK+A=;
        b=x5JmB/0OUUm0n3pUNm0d3bDFVZ9zoYTwmC68+WhMKiYCDd8J6meh19KGHZHjteCmGj
         Gb+poFRw+Q5O4+zzJh7M1JgxVnp1aEyWS9A6EwcLLgY1LpLfVZUgGn2Yl2smq1KttslG
         jPUkrYMvywbQCMzI5XmPp3b7So9dWZKEff10PaYosjnRDQLTQFGGPrDw8wBORG8lCbKW
         055tT1pMfjVah6HOGuwIlD2rt3+wAoJcH5D10pnUSYQaFdjeh/fCItdq489Cn5qMhSnu
         pXYuysYzaAZvTPJAXCBoDBvy2nCrHmK0DLmb5ukSGYKQGQKHUnB+TYuHVt5IerDWDAHS
         SkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fxVnPZH6b6L2I7aYk+0v0By0qTM5ney7UTSCmiLQK+A=;
        b=cfGU86bxYiLdxOCE6SRo660PUom0c0mmAhxQhDjSu/yYX082Avhq4DAdnnEU9Chyvi
         0lcs2z8Kr/i/OBh+tX3ixXWDGIid0I/tH4EZZp626/+mHKtq6Gjrsybq3749OkO8jDxk
         yclWHKk0iYC15goP13qxOgGg7Bg7SM/H+wd/bkhcB+ZVs7S19o7xcimCi+DRaznFgVO1
         v4Ucwp39XYkSJ7uhaQ3Q97A07Ymu8C8ZMs18+tzvHxbpiQ/c6iLsrhEqCAWNFlq7V71G
         zKNid9xmtvpx4/QcwdHpr0KJXU3ElrbCnijxhNMJiJcT1XnWZmdRoOc/+N9g+Ma4lxj2
         8MrA==
X-Gm-Message-State: AOAM533f22c9Thr8Nt5IyrhOFMfuaktYjjuZMImudY+pvQLtwnLqukI6
        oImznO6uBGPw4hWqt+SI5Uh8Lg==
X-Google-Smtp-Source: ABdhPJywD1fXGsmUvzlGsbwzhNq/8e0eLaGhh844IKPxeN7lhccCNTjpZy9biEo0Bug7ay78GS+QVg==
X-Received: by 2002:a2e:7210:: with SMTP id n16mr29186843ljc.155.1635866807510;
        Tue, 02 Nov 2021 08:26:47 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id c1sm1844823ljr.111.2021.11.02.08.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 08:26:46 -0700 (PDT)
Subject: Re: [PATCH v1 01/15] dt-bindings: add pwrseq device tree bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
References: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
 <20211006035407.1147909-2-dmitry.baryshkov@linaro.org>
 <YXf6TbV2IpPbB/0Y@robh.at.kernel.org>
 <37b26090-945f-1e17-f6ab-52552a4b6d89@linaro.org>
 <CAL_JsqLAnJqZ95_bf6_fFmPJFMjuy43UfP2UxzEmFMNnG_t-Ug@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <31792ef1-20b0-b801-23b7-29f303b91def@linaro.org>
Date:   Tue, 2 Nov 2021 18:26:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLAnJqZ95_bf6_fFmPJFMjuy43UfP2UxzEmFMNnG_t-Ug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 28/10/2021 00:53, Rob Herring wrote:
> On Tue, Oct 26, 2021 at 9:42 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On 26/10/2021 15:53, Rob Herring wrote:
>>> On Wed, Oct 06, 2021 at 06:53:53AM +0300, Dmitry Baryshkov wrote:
>>>> Add device tree bindings for the new power sequencer subsystem.
>>>> Consumers would reference pwrseq nodes using "foo-pwrseq" properties.
>>>> Providers would use '#pwrseq-cells' property to declare the amount of
>>>> cells in the pwrseq specifier.
>>>
>>> Please use get_maintainers.pl.
>>>
>>> This is not a pattern I want to encourage, so NAK on a common binding.
>>
>>
>> Could you please spend a few more words, describing what is not
>> encouraged? The whole foo-subsys/#subsys-cells structure?
> 
> No, that's generally how common provider/consumer style bindings work.
> 
>> Or just specifying the common binding?
> 
> If we could do it again, I would not have mmc pwrseq binding. The
> properties belong in the device's node. So don't generalize the mmc
> pwrseq binding.
> 
> It's a kernel problem if the firmware says there's a device on a
> 'discoverable' bus and the kernel can't discover it. I know you have
> the added complication of a device with 2 interfaces, but please,
> let's solve one problem at a time.

The PCI bus handling is a separate topic for now (as you have seen from 
the clearly WIP patches targeting just testing of qca6390's wifi part).

For me there are three parts of the device:
- power regulator / device embedded power domain.
- WiFi
- Bluetooth

With the power regulator being a complex and a bit nasty beast. It has 
several regulators beneath, which have to be powered up in a proper way.
Next platforms might bring additional requirements common to both WiFi 
and BT parts (like having additional clocks, etc). It is externally 
controlled (after providing power to it you have to tell, which part of 
the chip is required by pulling up the WiFi and/or BT enable GPIOs.

Having to duplicate this information in BT and WiFi cases results in 
non-aligned bindings (with WiFi and BT parts using different set of 
properties and different property names) and non-algined drivers (so the 
result of the powerup would depend on the order of drivers probing).

So far I still suppose that having a single separate entity controlling 
the powerup of such chips is the right thing to do.

I'd prefer to use the power-domain bindings (as the idea seems to be 
aligned here), but as the power-domain is used for the in-chip power 
domains, we had to invent the pwrseq name.

-- 
With best wishes
Dmitry
