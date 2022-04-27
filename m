Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67282C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Apr 2022 21:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237468AbiD0VrF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbiD0VrB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2022 17:47:01 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9736F6462;
        Wed, 27 Apr 2022 14:43:49 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id j17so2630892pfi.9;
        Wed, 27 Apr 2022 14:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=du/c2vhq3VYi9SfdNIrPwaHRFuDCP1aHXk3ODWglX9k=;
        b=YQsKFg1Y7ZeHToCxOw0GkIM/UDfcd904RmCWkma042dDiM28qwwOTf7HHy4/M87XhK
         xzGSrPWcuSMjC0RxpCBt3IZuCeowxcsrlzSlfzERsx3RZc8wEWQghLftczcTVqzjrob0
         9lJeng5YAMpP5Z66v8sTG7AOIR0U93xiFwX//gBkSOAPff/6BYcTQKM750qP5GO+tfOE
         tHOYHETfmGkuhM7xlZflLLhoncoCiGo62SIbykh81XvrzKqYeTlaHHYAP0EVDpHLrsBH
         OXxaeTwqGKUCIeMx8Wo7MTM1kMj6Bd07+yFCpl3Ojkzf+3CoL5TeGW9iNAgzR6/pHIgI
         efCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=du/c2vhq3VYi9SfdNIrPwaHRFuDCP1aHXk3ODWglX9k=;
        b=ui0HGwgoHmFsVHm9B1X7tDFwwF7QS1023g+6aGM04cRvRPIZ20/0MsM1hQhz8uWz+l
         R99EbXsZ17mY38QJWtNFhYWQJCovKDyoyzPgNGHng1jGvu2P59KcKrnbTZApekMr3sxR
         Wo0LBzgl6Va6ZjuH/1MUwUV/00T3YsmBsg2u/fdA+uMter2TvPcsZmCLvBROnZ1DpUqx
         alhWgqStV3iwD+OXtGECqJwimjTcE/InsVBDT028HravGLwBsiuawiwOK91/D1JiC2Xi
         OH4NHxsyNjxsDupeAitYyPoVpCs7gPGHTc8Luxdl1kaX6uFjDs2BYE4uoMcGQPDflncx
         iIHA==
X-Gm-Message-State: AOAM532x/aEIqzQdoSTxBKm4pfIy64qgycBRiTnqFhwxjRWdJroo2fyL
        WMm5xgjaJzMZIJSJmBIn8N4=
X-Google-Smtp-Source: ABdhPJzDqf4wmmACwNJoB16cZAuIolvX5v6xhuvwrSnwo5GaUZ57N3EQLaB9pKF/9o1j5SOgfNFlbg==
X-Received: by 2002:a63:f058:0:b0:3c1:42e9:eb40 with SMTP id s24-20020a63f058000000b003c142e9eb40mr4936551pgj.236.1651095829006;
        Wed, 27 Apr 2022 14:43:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y9-20020a17090a1f4900b001cd498dc153sm8015432pjy.3.2022.04.27.14.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 14:43:48 -0700 (PDT)
Message-ID: <96eef806-72df-71bc-8abb-70c26e947b3d@gmail.com>
Date:   Wed, 27 Apr 2022 14:43:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/4] mmc: sdhci-brcmstb: Enable Clock Gating to save
 power
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220427180853.35970-1-kdasu.kdev@gmail.com>
 <20220427180853.35970-3-kdasu.kdev@gmail.com>
 <CAPDyKFrW7DHzc32BYE5ZiPdOdMWqGo1ch4CZZHaM1jVNjpvpWw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAPDyKFrW7DHzc32BYE5ZiPdOdMWqGo1ch4CZZHaM1jVNjpvpWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/27/22 14:39, Ulf Hansson wrote:
> On Wed, 27 Apr 2022 at 20:09, Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>>
>> From: Al Cooper <alcooperx@gmail.com>
>>
>> Enabling this feature will allow the controller to stop the bus
>> clock when the bus is idle. The feature is not part of the standard
>> and is unique to newer Arasan cores and is enabled with a bit in a
>> vendor specific register. This feature will only be enabled for
>> non-removable devices because they don't switch the voltage and
>> clock gating breaks SD Card volatge switching.
> 
> Rather than using a HW specific thing for this, it may be better to
> use runtime PM. There are plenty of examples to get inspired from, so
> it should be rather easy to implement, I think. More importantly, it
> should work for both (e)MMC and SD cards, unless there are some
> specific things to manage for this controller.
> 
> When it comes to SDIO, some driver simply bumps the runtime PM usage
> count (pm_runtime_get_noresume()) to prevent the device from being
> runtime suspended. There are ways to work around this, let me know if
> you need some guidance around how to fix that too.
> 
> That said, I am not entirely opposed to $subject patch, but I wanted
> to point out that there are better alternatives.

This is a good suggestion, I would not consider runtime PM and enabling 
the clock gating as being alternatives to one another, but rather 
complementary.
-- 
Florian
