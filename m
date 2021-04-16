Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C742C433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Apr 2021 09:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0A161166
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Apr 2021 09:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbhDPJeD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Apr 2021 05:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241022AbhDPJeC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Apr 2021 05:34:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4F6C061756
        for <linux-mmc@vger.kernel.org>; Fri, 16 Apr 2021 02:33:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w4so22290768wrt.5
        for <linux-mmc@vger.kernel.org>; Fri, 16 Apr 2021 02:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y6UyUK/PLZR7RRPxa5IwMOvQk8P6IAfMpv+pLHnWIWk=;
        b=QZQkZJdBI8z4aSv5GPjE/sdUZF5KNDwCq5LFScZU1aQwxesSrQTgs2rloNEdifvRkG
         kutHzoba1sPCUsWxZjyPd2edgncUU/2Qdt9sFwNZxbEF/1AErUeJce7TeCo0pSweY58F
         sRTu860WAz3M8uM6/XAdDMy37xtCeDXbzcYA4VB33RITm7AgkBtdz6HoJzEcpvxdPbLG
         6VszU67q5srWYwsySecPDR5vGbtoUxsQgBhu1aR08i9iuDhhJLiIrAbvsw6Jp+K38Pnf
         O0fxY7RTMTlhQ6p9NrrYcoaNPcY6+cIWLP6ln+KF4a9iWUuZqCUIWK/lyj7Occ3Y3Hwz
         bTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Y6UyUK/PLZR7RRPxa5IwMOvQk8P6IAfMpv+pLHnWIWk=;
        b=cNbAiHPJFyt+4atusYAB1/fP8th7iOsTyJ65ZrhwwQqcW1NZdbMglBTC+5CQon10HP
         pRjqRp44LltLhiwiUxgw4yFBZBfSwSJfMrGWi/GefKnDXFlzjBc1uC6vy6U+o85wZ7Qy
         Nnn1EoHqsbnt0p9Y3CCp1Uj4fTa97aKk5cba9pa0yOKG6mSZv4htDL80pNRnMeV1VNiL
         xFoXShMw8LklRYRnxgzePR7H1Q1Ms2FLHHOlYE1zGmu1/4pfZBXEwKIAWgdJiOD8qRW5
         1UQameIgj0lRMwCIXo0tatmW8lXPFYm113H7wDrRhhDo2X28yvQxGiuLFPl0LHsqZd8i
         Dp9w==
X-Gm-Message-State: AOAM5333D/u/nsORKspMgzRa9c7bKce/lKrbydCIiIhTjplnkK0KOL+5
        VJrgHFTa5rwiiyLohaGYx7xw6A==
X-Google-Smtp-Source: ABdhPJyi9TudN5b27GdAZGQawwbe7hN4TWTVODnrXz7f90bs+B7teKNt5eKgfJN+j0eEBk4vPKX/tg==
X-Received: by 2002:a05:6000:118c:: with SMTP id g12mr8068180wrx.241.1618565615984;
        Fri, 16 Apr 2021 02:33:35 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:6e70:fd4e:dfdb:68d7? ([2a01:e0a:90c:e290:6e70:fd4e:dfdb:68d7])
        by smtp.gmail.com with ESMTPSA id s14sm9473716wrm.51.2021.04.16.02.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Apr 2021 02:33:35 -0700 (PDT)
Subject: Re: [PATCH] mmc: meson-gx: remove useless warning about scatterlist
 size alignment in block mode
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Lebed <lebed.dmitry@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210414100010.3877669-1-narmstrong@baylibre.com>
 <CAPDyKFpNLu3R+7ODZaC7yWMYbSOujswgLTkN97FQNg5zhwSxgw@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <ff1d8605-4f45-c272-9bd6-e55ea8a9c68c@baylibre.com>
Date:   Fri, 16 Apr 2021 11:33:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpNLu3R+7ODZaC7yWMYbSOujswgLTkN97FQNg5zhwSxgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/04/2021 11:07, Ulf Hansson wrote:
> On Wed, 14 Apr 2021 at 12:00, Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Since commit e085b51c74cc ("mmc: meson-gx: check for scatterlist size alignment in block mode"),
>> support for SDIO SD_IO_RW_EXTENDED transferts are properly filtered but some driver
>> like brcmfmac still gives a block sg buffer size not aligned with SDIO block,
>> triggerring a warning even if the transfer works in degraded mode.
>>
>> This should be ultimately fixed in brcmfmac, but since it's only a performance issue
>> the warning should be removed.
>>
>> Fixes: e085b51c74cc ("mmc: meson-gx: check for scatterlist size alignment in block mode")
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index eb6c02bc4a02..6bc151045843 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -246,11 +246,8 @@ static void meson_mmc_get_transfer_mode(struct mmc_host *mmc,
>>                  * size, otherwise chain mode could not be used.
>>                  */
>>                 for_each_sg(data->sg, sg, data->sg_len, i) {
>> -                       if (sg->length % data->blksz) {
>> -                               WARN_ONCE(1, "unaligned sg len %u blksize %u\n",
>> -                                         sg->length, data->blksz);
> 
> Rather than removing this warning, perhaps an option could be to use
> dev_warn_once() instead?


Yep, I'll re-spin.

Neil

> 
>> +                       if (sg->length % data->blksz)
>>                                 return;
>> -                       }
>>                 }
>>         }
>>
> 
> Kind regards
> Uffe
> 

