Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4DAC05027
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Feb 2023 23:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjBLXcR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Feb 2023 18:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBLXcQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Feb 2023 18:32:16 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF189F750
        for <linux-mmc@vger.kernel.org>; Sun, 12 Feb 2023 15:32:15 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s11so3007989edd.10
        for <linux-mmc@vger.kernel.org>; Sun, 12 Feb 2023 15:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DVenlwMH7zPhCytzFEgHgQa0+XAKJpBrd43+0QBLARA=;
        b=Dwxmne8u7AwHO2RTEZtixq0CKD+kAKWqE9guxMYWCJM0MLRCpv3xiOUApFQfxvkDGV
         X+CD8dJG1nUbUfUbFnBDKIiTVkmrj3PLF6trv4GIXmCoWKrpeA0fjV/jBPs7xDrnhSAD
         5klMKuUi8AqlHHMLVuR4rNagtXDhTlIPOHrKC6ZqEY5owUFHd5px5RvQgSkXC6UkTHj+
         foDJls2Ll97v2e8RwapWekpBmiYvnfzR3gcFGnvQzcf8hVjLI6v2RO8TamlMbe1X+Kpu
         c7Uiw3/vJijz/WYQDokxIDpkWlEQ0hbp6MgCHv92vN7HXlYbibbrngoLNdFfwM/1UxwH
         yt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVenlwMH7zPhCytzFEgHgQa0+XAKJpBrd43+0QBLARA=;
        b=gnFHSDO7OU6irKsc+hkQFAy/XZtOR5GVjTY3Z19tV+ktfH/g/8dyyaQwfxb3GD4Gzp
         9L7QHJ2kt3BQcJAhqZK1SHKjHxHQ0leGYs5GCdnFBpq60wBv+Jrd0Ioy40ATmXaBxy4H
         0kSKbJH+sZradFx4kz/75gn5TJDo1z+cAd3QE8PcVDh7s6tbOSNhljveFxUZvdtX1N/K
         W9TaNctRGAGOJYE2V2MO29MeUEto/9zP1KDYHpNudbYQjWX6FgxjjFmzsBYsiVJAPdCK
         agICTyWx+XRLAOt44KRyVVUhHuLWX0hvcTQxSwQhwOo5EegUi8nZWGu5sOZJoqcaEEPx
         hHzQ==
X-Gm-Message-State: AO0yUKVGVsOP7gmelqjzakmsw9BVG3WKs+AIuwjH/QITVO1kAesqaIhA
        lJ1pywJeh+OirgbQaMRTZok=
X-Google-Smtp-Source: AK7set/hraYgPFTvvdtr1Iza71ciF7HXQj2fByv09IC0lsg94o8OaOD4iQUkhu14r5RiC3iYIg0GVQ==
X-Received: by 2002:a50:ce06:0:b0:4ac:bda5:5f71 with SMTP id y6-20020a50ce06000000b004acbda55f71mr5713568edi.11.1676244734225;
        Sun, 12 Feb 2023 15:32:14 -0800 (PST)
Received: from ?IPV6:2a01:c23:bdd2:4300:1932:303f:b63a:5a0e? (dynamic-2a01-0c23-bdd2-4300-1932-303f-b63a-5a0e.c23.pool.telefonica.de. [2a01:c23:bdd2:4300:1932:303f:b63a:5a0e])
        by smtp.googlemail.com with ESMTPSA id dk19-20020a0564021d9300b0049e09105705sm5717018edb.62.2023.02.12.15.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Feb 2023 15:32:13 -0800 (PST)
Message-ID: <200a29cb-5b7b-47dd-6bfd-a5855ec7be58@gmail.com>
Date:   Mon, 13 Feb 2023 00:32:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] mmc: meson-gx: fix SDIO mode if cap_sdio_irq isn't set
Content-Language: en-US
To:     Geraldo Nascimento <geraldogabriel@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <9e296859-0363-ecc4-2d99-fd0239efceff@gmail.com>
 <Y+lqTSqKm4a/qTDN@geday>
From:   Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <Y+lqTSqKm4a/qTDN@geday>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12.02.2023 23:38, Geraldo Nascimento wrote:
> On Sun, Feb 12, 2023 at 10:54:25PM +0100, Heiner Kallweit wrote:
>> Some SDIO WiFi modules stopped working after SDIO interrupt mode
>> was added if cap_sdio_irq isn't set in device tree. This patch was
>> confirmed to fix the issue.
> 
> Hi Heiner,
> 
> with this patch, with cap-sdio-irq set or unset in the DT, it doesn't
> matter, I get the following warning on dmesg:
> 
> meson-gx-mmc d0070000.mmc: unaligned sg offset 3148, disabling descriptor DMA for transfer
> 
> The offset number varies between reboots.
> 
> Is that to be expected?

It's a known issue that ath10k may pass buffers to meson-gx-mmc that don't meet
the meson alignment requirement. See here:
https://lore.kernel.org/linux-arm-kernel/CAFBinCCN88nfSnmPoFq4H_ROWFMbq=Kcpr1W6CpNs58XeHtV2w@mail.gmail.com/T/
This means there's nothing wrong with the SDIO IRQ fix.

