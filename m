Return-Path: <SRS0=OcmH=2C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5012AC43603
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Dec 2019 14:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BDD2464B
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Dec 2019 14:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdbTZBwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfLLOX6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:23:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33470 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbfLLOX6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Dec 2019 09:23:58 -0500
Received: by mail-lj1-f193.google.com with SMTP id 21so2520903ljr.0;
        Thu, 12 Dec 2019 06:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MyViXaXViSVG5MBJuSOs6DiQwJnGAWqF15GC1uXA5A0=;
        b=QdbTZBwtHOy+M6WHKQrwDg7E6qPmaSVXXEaT/TI9cHjZVym9jpjw35m1agJ4bcuiHw
         PVKcuGPcGrtpDbYfJl7lDpSSjux5XXZ00J64dgkcHhmPn6544nT+Rvnqr2MfaOVXic8h
         /hlUB8g9HWIfFAuZYAJ4qU2PfTemOHH99VrTT0pCCzryT3KLXlvPIZ8FIfsqXdeWNACA
         TTRw246TxgzNqy3FyV5DEAuHB3Mx+0LJk9PKTzjghv9sBkklD6xMRtt9kXm49J26wuhk
         ktz9Rz6K/MRz5MSPS/KkCwGHyQgErHFMnGGMAyNkuwdkjebHtJm90kAKs3fyGwfS5tvb
         L1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MyViXaXViSVG5MBJuSOs6DiQwJnGAWqF15GC1uXA5A0=;
        b=B0sh0fudWe2A7cD+o9mT+4F+rVOHTqPtbyM9wtlUMCO+jwupE1JA3/4dWfeGJkAKVd
         x72F5+BPgYGUz35wOb0lnBlrhPrpib7vbXKgP0YGvMCvn2YtwPd/vGu2YTU9FanP3IuX
         tUPRDFU4+b9XNt0vXySkF3/0Yw5tV+xxBcYsoYH3TQN2SbzSRR390utOi9vkEbJ02/sg
         vpxbza/PUi2ad4gSSnK1NYm6GMWem2u3KrMXT+1/o7A6rCcOZ9BtkzB5F4GxYXaQy37k
         zqpFyU1gOgZEokGqpSlHHfWZT1wTJxFVpJQnvOPXF2ynxTfNOIL1GOpY/ZfoGUoCkiMF
         677Q==
X-Gm-Message-State: APjAAAU/aPDRSv1G7RY+9OE8DFBJwvQe8jqg4SckTNtUHHrc59vY+rUv
        uQV5z/rYfmX6SiVjLj/lZKuC66tZ
X-Google-Smtp-Source: APXvYqxPdke9a4fNDxxTT1/ezaD5xKhLk744tLFmfTCPZ+DMObNr2MqCaIJCdDxk+viYke6SHqA2IA==
X-Received: by 2002:a05:651c:112c:: with SMTP id e12mr6106503ljo.169.1576160634822;
        Thu, 12 Dec 2019 06:23:54 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id v9sm3399542lfe.18.2019.12.12.06.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 06:23:54 -0800 (PST)
Subject: Re: [PATCH v1] sdhci: tegra: Add workaround for Broadcom WiFi
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191210014011.21987-1-digetx@gmail.com>
 <CAPDyKFpMe09PNQqinvvidF+wfASx2nuvgf7=Hx5+cGni8pdcRA@mail.gmail.com>
 <28045442-6a1c-1e0b-0dfe-c36fa9de149a@gmail.com>
 <CAPDyKFpWO_McZEoefX1T=SE=RYm_GU3S+LgYZrgJY_SJgv7egA@mail.gmail.com>
 <44f99e56-468e-c3f9-3785-73c2cf8ba118@gmail.com>
Message-ID: <d4933cb1-d2c1-8055-e0f4-f6fcbe9973bc@gmail.com>
Date:   Thu, 12 Dec 2019 17:23:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <44f99e56-468e-c3f9-3785-73c2cf8ba118@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

11.12.2019 19:29, Dmitry Osipenko пишет:
> 11.12.2019 19:10, Ulf Hansson пишет:
>> On Wed, 11 Dec 2019 at 16:46, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>
>>> Hello Ulf,
>>>
>>> 11.12.2019 11:11, Ulf Hansson пишет:
>>>> On Tue, 10 Dec 2019 at 02:40, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>>
>>>>> All Tegra20 boards that have embedded Broadcom WiFi SDIO chip are affected
>>>>> by a problem where WiFi chip reports CCCR v1.10, while it should v1.20.
>>>>> In a result high-speed mode isn't enabled for the WiFi card and this
>>>>> results in a malfunctioning SDIO communication.
>>>>
>>>> Does that also mean SDIO_SPEED_SHS bit is set when reading SDIO_CCCR_SPEED?
>>>
>>> Yes, the SDIO_SPEED_SHS bit is set.
>>>
>>>>>  brcmfmac: brcmf_sdio_readframes: read 304 bytes from channel 1 failed: -84
>>>>>  brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame, send NAK
>>>>>
>>>>> Downstream kernels are overriding card's CCCR info in SDHCI driver to fix
>>>>> the problem, let's do the same in upstream.
>>>>>
>>>>> The change is inspired by omap_hsmmc_init_card() of OMAP's HSMMC driver,
>>>>> which overrides card's info for the TI wl1251 WiFi.
>>>>
>>>> This is a temporary solution and should be replaced by doing the DT
>>>> parsing during
>>>>
>>>> So, yes, let's see if we can use a card quirk instead. That's the first option.
>>>>
>>>> A second option is simply to parse the DT subnode for a new DT
>>>> property during mmc_sdio_init_card(). Along the lines of what we do
>>>> for the broken-hpi DT binding for eMMC.
>>>
>>> Let's try the first option. My understanding is that the problem affects
>>> only the specific model of the WiFi chip and it's not a board-specific
>>> problem. I'll add Broadcom driver people to CC for the next version of
>>> the patch, maybe they'll have something to say.
>>
>> Okay, sounds reasonable. By looking at your latest attempt for a fix,
>> I have two minor nitpicks, otherwise it looks good.
>>
>> The nitpicks:
>> I suggest to rename MMC_QUIRK_HIGH_SPEED_CARD to MMC_QUIRK_HIGH_SPEED
>> and mmc_card_need_high_speed_toggle() to mmc_card_quirk_hs().
> 
> I'll take it into account, thanks.

Looks like I managed to figure out what's really going on:

  1. The BCM4329 doc clearly states that High Speed is supported, see
page 49 (Section 11: WLAN Interfaces, SDIO v1.2)

https://www.cypress.com/file/298626/download

  2. I googled for performance results of the BCM4329 SDIO WiFi and came
to a conclusion that ~40 Mbit/s is a realistic maximum of the WiFi-data
throughput for NVIDIA Tegra20 boards due to antenna configuration
limitations and whatever.

  3. The Tegra's SDHCI clock is pre-configured to 48MHz at the time of
kernel's boot-up.

  4. IIUC, the maximum clock rate for the legacy SD signaling mode is
~25MHz and that is more than enough for a 4-lane SDIO data-bus that
allows up to 100 Mbit/s for the WiFi which is capped to 40 Mbit/s anyways.

  5. Apparently MMC core doesn't limit the clock rate for the Normal
Speed cards.


So, I added "max-frequency = <25000000>;" to the SDHCI node of the
board's device-tree and ta-da! WiFi works absolutely fine without the
quirk! Thus the SDIO card quirk isn't really needed and I'm dropping it
for now.

Ulf, do you know if it's a bug or a feature of the MMC core that it
doesn't limit clock rate for the Normal Speed cards?
