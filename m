Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A58C61DA4
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Feb 2023 06:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjBNGjk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Feb 2023 01:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjBNGjh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2023 01:39:37 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE795244
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 22:39:36 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cq19so13184642edb.5
        for <linux-mmc@vger.kernel.org>; Mon, 13 Feb 2023 22:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1nhKjEH7r7Yngny/ZqXBLs863BYkcnxD7fB2ffD3a7g=;
        b=KhWzA/nWCJvJ2hbMirUFPhS8xCzZHclfVulD8YuxpThoyqWehSBjvsNhvnOe3VdaDf
         YPtyvyV0wG+xt3KQtwMxlPBvoSbYADr8Dt4s3x8dVMOVMvKauMYdZm34koT24XSqym4c
         O9+dUP5UPdv8Xaz5j43Ht8O/P1mC6X8gGKNsz97bra1IxWjYqN2UHEzwmTsswMF3/v1A
         W68kxqUVGEBTtXr9EMmd7PhIuyK++Rt4/TmI9jOjZ6RGw+2iJdLPjDYnmADMYxdFuQLZ
         Q7JECb7Kc2EaCbk1JuTCAj4aNKd7GcXW/KO+ODfdlPE22j/a654+OUDJVee/JRnFNXzB
         1SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nhKjEH7r7Yngny/ZqXBLs863BYkcnxD7fB2ffD3a7g=;
        b=o/17GnT/FJ6cLU6FDsFr0YHNVVRHuCsI/PhZSfHTDYt00ImqtrODUCKZoZ+/lEcwBf
         uCiVO/TlVHhufVVzN7SWgDB3ynvG5r+jPh/5ajsLm0Jw4rsr3xVyFXcYolxmsw2ktHYJ
         xM/JnoDGAxYHjNYQ6HyjnYG3ET+3YLRD7kQ2b89fys2syxP2TKgzN9SdIb0RFJ1brbxt
         h1Jxcufq1aoZqJx8TXQFTYRBAmj0GYRUXtja/IQUYcRlzukV/hvjFwKG70919esgDREy
         tRHdeYGln0iMVT9wHJ9pF2opU1tN5jcVdw5CQiyAVjmVb+WTFv+ZHaPdDyvOdvm1lT24
         6PYw==
X-Gm-Message-State: AO0yUKVn+R3SYvoQjrta3sSHlPHmYfQA9jf4+mqiqFLXkh01kliQHDiD
        MbAFPleFpf20P2N1xYXCVFI=
X-Google-Smtp-Source: AK7set9PbG2cD/G9Z3G++ccd4S18aj36cUCelMQMgZtNzRwkqZcEIIf5LzkYL24nqTWJ9Q7yLQjwGQ==
X-Received: by 2002:a50:ce1c:0:b0:4ab:4c36:463c with SMTP id y28-20020a50ce1c000000b004ab4c36463cmr1180023edi.16.1676356774649;
        Mon, 13 Feb 2023 22:39:34 -0800 (PST)
Received: from ?IPV6:2a01:c22:7234:f800:3c3d:a22e:c2c4:b19f? (dynamic-2a01-0c22-7234-f800-3c3d-a22e-c2c4-b19f.c22.pool.telefonica.de. [2a01:c22:7234:f800:3c3d:a22e:c2c4:b19f])
        by smtp.googlemail.com with ESMTPSA id d1-20020aa7d681000000b00499703df898sm7360254edr.69.2023.02.13.22.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 22:39:34 -0800 (PST)
Message-ID: <ade6669b-9a4b-094c-a485-fdc8c7f5a8c3@gmail.com>
Date:   Tue, 14 Feb 2023 07:39:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/2] mmc: meson-gx: support platform interrupt as card
 detect interrupt
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
 <9e08411b-20cb-874f-8915-6f8dc32e9fcf@gmail.com>
 <CAPDyKFrsTMpguDp+0ZrKYkH5CYSk_OgKLxuZu4tFoGYaLpbJUQ@mail.gmail.com>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAPDyKFrsTMpguDp+0ZrKYkH5CYSk_OgKLxuZu4tFoGYaLpbJUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 13.02.2023 23:47, Ulf Hansson wrote:
> On Mon, 30 Jan 2023 at 00:10, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> Use a new mmc core feature and support specifying the card detect
>> gpio interrupt in device tree.
> 
> Don't we need an update to the DT doc too?
> 
Right, the binding still has to be changed to allow more than one interrupt.

> Kind regards
> Uffe
> 
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index be1a972c2..c87bc31d0 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -1236,6 +1236,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
>>                 goto free_host;
>>         }
>>
>> +       /* gpio card detect interrupt */
>> +       mmc->cd_irq = platform_get_irq_optional(pdev, 1);
>> +
>>         host->pinctrl = devm_pinctrl_get(&pdev->dev);
>>         if (IS_ERR(host->pinctrl)) {
>>                 ret = PTR_ERR(host->pinctrl);
>> --
>> 2.39.1
>>
>>

