Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4C4ECAAD2
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Aug 2022 07:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiH2Hmf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 29 Aug 2022 03:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2Hmf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2022 03:42:35 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E3A4DF16
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2022 00:42:33 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id d12-20020a05600c34cc00b003a83d20812fso2356643wmq.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2022 00:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=Ord4hpx3Xd+i/UwyGaCf/vKkWqcTfQ/IC1j07fGcrjc=;
        b=pLmBdFIRDpgWHv7Lo3wLPl012iBHd7T+73AUNhvejNTCf4dcym6kgdYcnYPCSPWayy
         d+XipCcPP4cn8cAnJcI9Efs8GJmPVGnXTb9Iamu3ln7rQqxCeM8uLtr8lEcZ5A/Q2t6q
         p3J+CjGwZ1IGzAVEEmJDoPP05iDOqD9LEleyiimOBY5LSpDSZ3G9nD6q5L85vvqK/t6a
         Ubj/dshtG+r9KbPfrD+IX4bdkhAtE5UjL76+7mazkV9YeAxNiY4quhZQrX24h+fZeRC7
         O5yRxW9gy0CGdh/2gbBIlF734fjyCUs8XE+62DugwAdp/VCjIJVRyiwqu/abRwuEIBgy
         FfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Ord4hpx3Xd+i/UwyGaCf/vKkWqcTfQ/IC1j07fGcrjc=;
        b=P/kIjABA1P9QJCYMw20d8s62vkEpE7vOrWcTBPde0JYlDiYPMao/NB1yKS6aptZciS
         8qzqjD5ZIh3uph6e9iMtA9eld338bvKLSS+ArNoZdXc3K+3xAmWXfDlc4ZqY0ImajQGT
         sbReZQwWqGkPoQsgFNttgj68/jHGB2/tKvTPvXTmL7WGLhmKdyRlnaQL1hZEeNIPgBgG
         VXnRw4/PvA2TLCllVdENjCTG+xvz/gZ4oFZM9NkquSIXG3O+SMyazXFF3C79bVQ+fgh3
         V1Kh+/ck8RoV8MKMMYlbMfMQenxJA/l5eAjOYCmODmhFVOJsKnKu3H854/j3RvFtR1N2
         UqsA==
X-Gm-Message-State: ACgBeo1d00VHWl8+JMGxq4sbxhGhDKkXmZm8k1iLmy9MdR1k0uBmC0vx
        6lItYK42oFkrT+TQU3smsCNMLw==
X-Google-Smtp-Source: AA6agR6vOedkOEDaDT8D7fDwrbld9zNfqqhvSnpkpkYnYN1bjv7xc3q3VttNTvVWvYdBibwNeVjBcg==
X-Received: by 2002:a7b:c045:0:b0:3a5:ff4e:5528 with SMTP id u5-20020a7bc045000000b003a5ff4e5528mr6257372wmc.150.1661758951904;
        Mon, 29 Aug 2022 00:42:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6124:6b74:2847:d37b? ([2a01:e0a:982:cbb0:6124:6b74:2847:d37b])
        by smtp.gmail.com with ESMTPSA id l26-20020a05600c1d1a00b003a62052053csm9768603wms.18.2022.08.29.00.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 00:42:31 -0700 (PDT)
Message-ID: <e970e07d-9bb8-707d-1dc6-09fae2abbfff@baylibre.com>
Date:   Mon, 29 Aug 2022 09:42:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/2] mmc: meson-gx: add SDIO interrupt support
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
References: <72459a46-fd20-60d8-a7e7-076d8f321816@gmail.com>
 <CAPDyKFokmJr7e8=gvsYbBbdxceG6kCa57vbYy1tUT_b+B=8P8Q@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <CAPDyKFokmJr7e8=gvsYbBbdxceG6kCa57vbYy1tUT_b+B=8P8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Uffe, Heiner,

On 26/08/2022 11:16, Ulf Hansson wrote:
> On Thu, 25 Aug 2022 at 21:52, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> Add SDIO interrupt support. Successfully tested on a S905X4-based
>> system (V3 register layout) with a BRCM4334 SDIO wifi module
>> (brcmfmac driver).
>>
>> v2:
>> - use new SDIO interrupt API
>> v3:
>> - don't duplicate checking mmc->sdio_irq_pending
>>
>> Heiner Kallweit (2):
>>    mmc: meson: adjust and re-use constant IRQ_EN_MASK
>>    mmc: meson-gx: add SDIO interrupt support
>>
>>   drivers/mmc/host/meson-gx-mmc.c | 84 +++++++++++++++++++++++++--------
>>   1 file changed, 65 insertions(+), 19 deletions(-)
>>
> 
> Applied for next, thanks!

Thanks for applying, but I was off (like many of reviewers) and I would have like
this patchset to be tested on earlier SoCs aswell, or only enabled on S4 for now.

Neil

> 
> Kind regards
> Uffe

