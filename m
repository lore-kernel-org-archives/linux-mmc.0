Return-Path: <SRS0=ypud=CJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15619C433E2
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 18:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB62420936
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 18:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThTytV7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgHaSxj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgHaSxi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Aug 2020 14:53:38 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77395C061573;
        Mon, 31 Aug 2020 11:53:38 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h19so7883047ljg.13;
        Mon, 31 Aug 2020 11:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=L+p5pMS5zt9rDPom08XJnrF8bxGqtpHNHupyZeHaC5s=;
        b=ThTytV7Ig5B7hm5YhpUR7zmDLEA87iCYPbWjyx8p+PsfxGlbwgztuZy58UpfJO6Nxx
         VhfPLNKvBjbBXXKzwM7D+1XMN/uomJ6lUKBWaFe2i4jpaRTu5Yi1yexGBMD4Aaxlq9Rg
         q2bqNn89VqwZQNWafA2F341nTltxnX71p1yGQGO5lfemofdwH53xFcQytgqAu5CAQjA9
         FUEGNXsRv5PiYfIW4JjW/Mu7fHCcI1AUIRKJXO2yWzCSQIUSxC/sQTPhszuq/4VJ3nv3
         arh6NPgS34g3IKi0wmDM9XYYQTc0CClpl0sW3LkQsGW8iFzbcEKqZWhy1i+NpAInYUSi
         RQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L+p5pMS5zt9rDPom08XJnrF8bxGqtpHNHupyZeHaC5s=;
        b=XPVOc+iKWXDIByWdOYllchJ/ANCeLNE0rPq26eaM0LrCc7i4mDwW/MFaFpqcqtt41M
         nXFez4unNBYxwvDLQMKWD4m5d0ShwxWkDBcPq2fSDgI2o/5h7WF+tlpHWMzkJUJfkKGR
         9xzlh7HVpu/BUVE/StxDH9gsOLexyknrA/g0K4GxOjzq3AvzNAC1MSbe5osTleQe/+U5
         ZuFAE2suy12EG/ycx32yKQarVgUkU4KsAUjaFnLdEi5TR8HWU8NfeP3oiVByqQAd7Dkg
         viJ0G/OtoofHtr8OjiFXJIvmxX5kACQKOS2OxbZD0gYNwSjB2JCr9gOXUkVUbcP7Kt9U
         G0EA==
X-Gm-Message-State: AOAM5314JipIG3BKrfFeL5XZWGnLd6VpymLr/ET3wHxWsEuYV3SHU/fH
        cwIY0abUqk4FlWOZIhD67t78x+YSDLU=
X-Google-Smtp-Source: ABdhPJxEzrfGn7i3KNEykO5kPP4BLGlg14bAOleoamj8Ou3Tqnrnw+7oiuPQ4tHno4EbnaB0QEFEXA==
X-Received: by 2002:a2e:91d2:: with SMTP id u18mr1244754ljg.436.1598900016513;
        Mon, 31 Aug 2020 11:53:36 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id m26sm1538132ljc.82.2020.08.31.11.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 11:53:35 -0700 (PDT)
Subject: Re: Broadcom WiFi SDIO performance regression after commit "mmc:
 sdhci: Remove finish_tasklet"
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list@cypress.com,
        brcm80211-dev-list.pdl@broadcom.com,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5cf1af89-6026-09ad-7f20-82e19ad49fa1@gmail.com>
 <9332715c-6ee5-fce3-8b93-305823d5a551@intel.com>
 <eec0c7d2-87f3-1213-dec1-bb34c5bde35a@gmail.com>
 <379c7435-a940-c427-305d-c4fa5f1970d6@intel.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <17a4729b-b307-92cb-8669-bf043e65bc49@gmail.com>
Date:   Mon, 31 Aug 2020 21:53:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <379c7435-a940-c427-305d-c4fa5f1970d6@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

31.08.2020 18:08, Adrian Hunter пишет:
> On 27/08/20 12:36 pm, Dmitry Osipenko wrote:
>> 27.08.2020 09:45, Adrian Hunter пишет:
>>> On 27/08/20 9:07 am, Dmitry Osipenko wrote:
>>>> Hello!
>>>>
>>>> I was debugging WiFi performance problems on Acer A500 tablet device
>>>> that has BCM4329 WiFi chip which is connected to NVIDIA Terga20 SoC via
>>>> SDIO and found that the following commit causes a solid 5-10 Mbit/s of
>>>> WiFi throughput regression after 5.2 kernel:
>>>
>>> What is that in percentage terms?
>>
>> That is about 20%.
>>
>>>> commit c07a48c2651965e84d35cf193dfc0e5f7892d612
>>>> Author: Adrian Hunter <adrian.hunter@intel.com>
>>>> Date:   Fri Apr 5 15:40:20 2019 +0300
>>>>
>>>>     mmc: sdhci: Remove finish_tasklet
>>>>
>>>>     Remove finish_tasklet. Requests that require DMA-unmapping or
>>>> sdhci_reset
>>>>     are completed either in the IRQ thread or a workqueue if the
>>>> completion is
>>>>     not initiated by the IRQ.
>>>>
>>>> Reverting the offending commit on top of recent linux-next resolves the
>>>> problem.
>>>>
>>>> Ulf / Adrian, do you have any ideas what could be done in regards to
>>>> restoring the SDIO performance? Should we just revert the offending commit?
>>>>
>>>
>>> Unfortunately I think we are past the point of returning to the tasklet.
>>>
>>> sdhci can complete requests in the irq handler but only if ->pre_req() and
>>> ->post_req() are used, which is not supported by SDIO at present.  pre_req
>>> and post_req were introduced to reduce latency for the block driver, so it
>>> seems reasonable perhaps to look at using them in SDIO as well.
>>>
>>
>> I'll try to take a look at pre/post_req(), but I'm not very familiar
>> with the MMC code, so it may take quite some time. Will be great if you
>> could help with making a patch that I could test!
>>
> 
> You could start by seeing if using pre/post_req helps at all, as below.
> If that doesn't help, then it might need more analysis.

Hello, Adrian! I tested yours patch and 100% fixes the problem! Thank
you very much! Please make a proper patch and feel free to add my t-b!

Tested-by: Dmitry Osipenko <digetx@gmail.com>
