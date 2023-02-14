Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71B3C61DA4
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Feb 2023 07:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBNHph (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Feb 2023 02:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBNHph (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2023 02:45:37 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7449CAD39
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 23:45:34 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id a10so16051828edu.9
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 23:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+bPNOknem0ZLzUy8OCs2/BuycFXjZsobDgAQeOxtxnc=;
        b=SSF5oYVYkR4KK4QiuKf/KRQMSvcu55fSgO417tePfFaq/CT94TmZeM4eT7LghHWSem
         oXTuV6+/nJgjFog7PTHeUvju6Wsdqqe17XwyxemuZJeEYSHRPzEviDQCqz1iXHhTTy6m
         zdhQUoqN3uX9qMjUfspfn4de0oi6Bi+cS/xIrPhXivE1pZg/qb9cKEOxzRV/FzSYAJE5
         3FwY6vOCJ8c0uUi+XVcmvR1gdgk+9hOW2CUO3mek4geW62DO/S9gDXNES1QDWa+Y2Rnw
         cWWpvmHtMxbPoj183SscRiGTwBR9DAwCh3yrC6oGG0UjMtA8vfcowi2/iK4kh4Ltv5LN
         YIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bPNOknem0ZLzUy8OCs2/BuycFXjZsobDgAQeOxtxnc=;
        b=tYewC1fdCzMJ1YTL+kNu6yj/T8v3QY9Gvs6/tErnb1hVmsoUBmqDminMw5xxBdH0Tu
         awkbtimIxNUnyo5JFaHqQjXnYCPdh7/2XXE1cLZ/7f31HQ1EJEm3Aqs+y2POauX5WCjL
         AXjQJAEfOj+zEaTd08Pl0TECojPv1+2oxSQjUr5R66Rf2hep3MUTcaLs/cRHRmlCc+tR
         3UWwsbLEuCI9pzqUa3S1l1+ukk0k5BoGfljoXvMeektVOpNwlB/w1IaLBDxeIbiWa4+v
         unMDko/cc0RGgezzfcwkXrgwije1aJa06s1xavHbrB/NL7wcdLc12O0N4Cpm6zsVMMKm
         AuSg==
X-Gm-Message-State: AO0yUKW8UTbpnPJbB60ZYDwtBP31shZIgUIydo/ON+2lp1VO50eZUupp
        7ry5Tlkk83bL3KVeW+Lv21w=
X-Google-Smtp-Source: AK7set9SplxCGgMgXHVIj9c1B4G2H++Vlslx/7yEj7lPfV5BaDl0aqp+0PWTEkXCCnL8lEPSneqdQg==
X-Received: by 2002:a50:ab4f:0:b0:4aa:dedd:41e0 with SMTP id t15-20020a50ab4f000000b004aadedd41e0mr872266edc.8.1676360732918;
        Mon, 13 Feb 2023 23:45:32 -0800 (PST)
Received: from ?IPV6:2a01:c22:7234:f800:3c3d:a22e:c2c4:b19f? (dynamic-2a01-0c22-7234-f800-3c3d-a22e-c2c4-b19f.c22.pool.telefonica.de. [2a01:c22:7234:f800:3c3d:a22e:c2c4:b19f])
        by smtp.googlemail.com with ESMTPSA id w9-20020a50d789000000b004aacee2728dsm7615579edi.19.2023.02.13.23.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:45:32 -0800 (PST)
Message-ID: <fc9bc263-5dbb-7db3-cd23-f0351138fc47@gmail.com>
Date:   Tue, 14 Feb 2023 08:45:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 1/2] mmc: core: support platform interrupt as card detect
 interrupt
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <dfb90ca4-1f62-e3ed-2ce4-a7b5f661e36d@gmail.com>
 <a0f895b3-f895-f256-1274-a61571264617@gmail.com>
 <CAPDyKFoeeof8G=AY4Z_CE4di4xUu8L9JT3UDYtPW6UVyTg1L=g@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAPDyKFoeeof8G=AY4Z_CE4di4xUu8L9JT3UDYtPW6UVyTg1L=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13.02.2023 23:46, Ulf Hansson wrote:
> On Mon, 30 Jan 2023 at 00:10, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On certain platforms like Amlogic Meson gpiod_to_irq() isn't supported
>> due to the design of gpio / interrupt controller. Therefore provide an
>> option to specify the cd interrupt e.g. by device tree. The host
>> controller can store the interrupt in cd_irq for use by
>> mmc_gpiod_request_cd_irq().
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/mmc/core/slot-gpio.c | 2 +-
>>  include/linux/mmc/host.h     | 1 +
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
>> index dd2a4b6ab..69c22a997 100644
>> --- a/drivers/mmc/core/slot-gpio.c
>> +++ b/drivers/mmc/core/slot-gpio.c
>> @@ -99,7 +99,7 @@ void mmc_gpiod_request_cd_irq(struct mmc_host *host)
>>          * IRQ number is already used by another unit and cannot be shared.
>>          */
>>         if (!(host->caps & MMC_CAP_NEEDS_POLL))
>> -               irq = gpiod_to_irq(ctx->cd_gpio);
>> +               irq = host->cd_irq > 0 ? host->cd_irq : gpiod_to_irq(ctx->cd_gpio);
>>
>>         if (irq >= 0) {
>>                 if (!ctx->cd_gpio_isr)
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 8fdd3cf97..e998e919e 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -470,6 +470,7 @@ struct mmc_host {
>>
>>         struct delayed_work     detect;
>>         int                     detect_change;  /* card detect flag */
>> +       int                     cd_irq;         /* for use by mmc_gpiod_request_cd_irq */
> 
> Rather than putting this in the struct mmc_host, I would prefer to
> keep it more internal to the mmc core/slot code.
> 
> That said, what do you think of moving this into the struct mmc_gpio
> instead? Of course, that also means that we need to add new slot gpio
> helper that users can call to set the corresponding value for the
> cd_irq.
> 
> Would that be okay to you?
> 
Yes, that's the better approach.

>>         struct mmc_slot         slot;
>>
>>         const struct mmc_bus_ops *bus_ops;      /* current bus driver */
> 
> Kind regards
> Uffe

