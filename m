Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F07BC636D3
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Jan 2023 19:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbjA3TES (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Jan 2023 14:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjA3TER (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2023 14:04:17 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493399EEE
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2023 11:04:15 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id fi26so11963971edb.7
        for <linux-mmc@vger.kernel.org>; Mon, 30 Jan 2023 11:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u1SdFn8vbHHOlpifiyP00EMYgDWF+uk4/FOG5AZyHX4=;
        b=Jxt+vF/1MVyYRopjBrEyHy5y5iwMNP0QBIi1CSN81hDB0quugAmHiWz+frKVH6EOtb
         UFhZ1XZ78/UGLVI0h/nMbcGJxzGajwfsatTEx4Q5omu0WNu0B3lZOfoNRn9GE9rL6EJa
         IlYuqBgST73iRxcJuY+OcpZwxMAa9oLVTd5vEdoXJwV5dfx+D16xLanoFJpr+IG28B7l
         bbTrQDPDvVz05kuua1eVYTGS4iqDuxQRxWXNGSEjIXeoFZSecBF1zOpyiQWpRbbQq7w7
         WkZ6yR6x3Nq0VSqWCwOFq5dW9iL6LwZkVMJSOeQXxyj4cMuILQ5G3f7AZ0uz7vxqRTRE
         xNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1SdFn8vbHHOlpifiyP00EMYgDWF+uk4/FOG5AZyHX4=;
        b=dnVVlDwKgvzY70t7l8UX3iml+KSNWixxY9KVMq4VkwMhUj/4Y7AqD8UJqjtLqjoaSr
         1T9ZUiFyQ/uub5WROwS0xTOaqLL93oPa70dIYNd13wbxeVhiqOf9G6lITJSw6kNQ3BBG
         5XpHQQ4/CGOzpgScP3zJAcwb8Al2wdwI+KAFS9s7uP2cmzDUuFu4R5JL8OFglmbUDIa+
         kzDPAIuSJloD4NOrhujWrdFJWU++JGqobqDiDeIVB1dpylvJR4V1avgVBCiKOuyfKzJf
         hcFCT/gfM18HOygOKIQAkn0fP806S/eDrVXih1DXjbC9S12EQi7/ao1LuvKbFjq47P21
         UekQ==
X-Gm-Message-State: AO0yUKVpR91RInjm/zLDhlveqEbcdUwEF83a4cmpgLu3j/qaF1Z/4LWL
        vUvC4t5417oY4aratNHb3Bs=
X-Google-Smtp-Source: AK7set+Db0EDdD7Zkic+Nmr1q4zIaFKr34uDd8R07IIRCK7amBMeiGGWIhiSh3YmSl6je5VpayrRLA==
X-Received: by 2002:a50:950b:0:b0:4a2:43ae:a9ef with SMTP id u11-20020a50950b000000b004a243aea9efmr5851453eda.35.1675105453676;
        Mon, 30 Jan 2023 11:04:13 -0800 (PST)
Received: from ?IPV6:2a01:c23:c074:7400:d941:3cb5:fa86:8ec8? (dynamic-2a01-0c23-c074-7400-d941-3cb5-fa86-8ec8.c23.pool.telefonica.de. [2a01:c23:c074:7400:d941:3cb5:fa86:8ec8])
        by smtp.googlemail.com with ESMTPSA id x5-20020aa7cd85000000b00497d8613532sm7313164edv.5.2023.01.30.11.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 11:04:13 -0800 (PST)
Message-ID: <34cd9312-67da-b069-4e61-5763a7460c38@gmail.com>
Date:   Mon, 30 Jan 2023 20:04:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] mmc: meson-gx: support platform interrupt as card
 detect interrupt
To:     neil.armstrong@linaro.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <dfb90ca4-1f62-e3ed-2ce4-a7b5f661e36d@gmail.com>
 <9e08411b-20cb-874f-8915-6f8dc32e9fcf@gmail.com>
 <7789e36f-f13a-9837-5432-c16754922fa3@linaro.org>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <7789e36f-f13a-9837-5432-c16754922fa3@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 30.01.2023 12:06, Neil Armstrong wrote:
> On 30/01/2023 00:10, Heiner Kallweit wrote:
>> Use a new mmc core feature and support specifying the card detect
>> gpio interrupt in device tree.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>   drivers/mmc/host/meson-gx-mmc.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index be1a972c2..c87bc31d0 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -1236,6 +1236,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
>>           goto free_host;
>>       }
>>   +    /* gpio card detect interrupt */
>> +    mmc->cd_irq = platform_get_irq_optional(pdev, 1);
> 
> Ok it's fine but beware GXBB/GXL/AXG doesn't support Rising + Falling GPIO IRQ,
> so this should only be used on G12A/B/SM1 and later.
> 
Thanks for the hint. I'm aware of the constraint for older versions.
There the mmc core would silently fall back to polling.
At the time when the gpio irqchip code was developed Jerome and me had
intense discussions on whether there's an acceptable workaround to
support edge-both on these chip versions.

I tested on SC2, there the proposed way to support the gpio cd irq
works fine.

> Neil
> 
>> +
>>       host->pinctrl = devm_pinctrl_get(&pdev->dev);
>>       if (IS_ERR(host->pinctrl)) {
>>           ret = PTR_ERR(host->pinctrl);
> 

