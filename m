Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657CEC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jul 2022 22:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiGOWdf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Jul 2022 18:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiGOWdd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jul 2022 18:33:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A20167C80
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jul 2022 15:33:31 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id v12so7991467edc.10
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jul 2022 15:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=76JC0t9LbhiWqJ9c7y773RaCGcRxX9GUE05Rg0MDK+4=;
        b=cxaJhA8kubAdEIOHAjA59STazGw/8l7Dig24ByRHAaBT0QSAU20+qVeIba5HSZc6aI
         bHoQ+oiIzqn4om474i0bxnj9Q6wDJqidq5C4NEKQbR2NGEHm8s+DoN8Yl4QbJQw1eoYb
         dcvkxRiG3vdQLrAuaB6pMvFS+CXSaV7Vf21i6/B1ihvL1LkqyuJmaf6d9zx39JypZkAU
         VLj0ax2rZ+DIvbKbwf5u8lQOylKE5dC+e/CVu0htHs0ZR18BEwP3maEnHqw0AMA9k8+Z
         ktbjbRdQq1X8f04jhkQiEaJTN7wMvgWTo2YMOcXwMHwQgE3G4/oCZBQBKFm8i1qQwR3t
         t36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=76JC0t9LbhiWqJ9c7y773RaCGcRxX9GUE05Rg0MDK+4=;
        b=XecIs+qzY15wpReMFhXFs1+RWLV7AxUHx0LDo2T+0DGc+lXMZNDx1afBzOHkhiNQ+9
         A9i42mSirQu5aw5SDyh0l9FYcF7IzF8dz7v8oYN5dE/5iBW7rsF8sXJGTc8YeUGTpY9P
         VN4ksiB0pZBoYVUZD9KV7NLjakoPX7MJ7+7Y/alktPBwtrJdQpGa21jV+0jdr/Mi8CVG
         bIbDocXx63e1rsBWhkCty3hmVCJj1THqP4+TTv2HDgufcCovk/mBDsjkWQtSVdBjAIQK
         CYaHHy2cWYlinxBhpn5IXNE01/qIQXH1TH3801dzbKxYwDqH/75sQmnOdoK0EzT4RDJl
         1xrQ==
X-Gm-Message-State: AJIora/02Ja29pohoHTElmvmIRHU9ChGcVc8zedKq1bB16ZLRqbkAZIX
        UkFtRMk75Vnr+avWoSHXXV9KLg==
X-Google-Smtp-Source: AGRyM1t/u2jjmV7/R6F6DGJ3m++32lPifqZ4JkCBXP1dlNz4t2qr0k+nLIeoKlklRBaGwWGalcw2Yg==
X-Received: by 2002:aa7:c657:0:b0:43a:4a68:bcc5 with SMTP id z23-20020aa7c657000000b0043a4a68bcc5mr22746058edr.337.1657924410165;
        Fri, 15 Jul 2022 15:33:30 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id p25-20020a056402155900b0043aa17dc199sm3564771edx.90.2022.07.15.15.33.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jul 2022 15:33:29 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v4] arm64: dts: rockchip: Fix SD card init on
 rk3399-nanopi4
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <daf3b61c-d886-98eb-0443-de233d742041@arm.com>
Date:   Sat, 16 Jul 2022 00:33:28 +0200
Cc:     wens@kernel.org, =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CDF716FC-F6CF-44A9-84D9-B48C46E6AC2C@kohlschutter.com>
References: <C639AD88-77A1-4485-BAEA-2FF8FC15A844@kohlschutter.com>
 <12878108.O9o76ZdvQC@diego> <103b714c-b07c-f016-1062-84bd94786b22@arm.com>
 <9AF1E75F-5947-49B0-887D-82C426527B99@kohlschutter.com>
 <590f7a08-a6ca-be54-4254-363343642a52@arm.com>
 <A6B896E5-CD25-4441-B6A5-0BE1FA284B2C@kohlschutter.com>
 <A9634366-A012-43D2-B253-8BB9BF6005C7@kohlschutter.com>
 <CAGb2v65Ehbu1wrib2CzF1fDZuD3fHZQDhKfVusyUF9KnxTvi+Q@mail.gmail.com>
 <5ca9bd94-54d9-04f8-0098-a56ffb6f5fe1@arm.com>
 <502b3fbe-3077-407e-6010-a8cb3ffce7d6@arm.com>
 <449292CA-CE60-4B90-90F7-295FBFEAB3F8@kohlschutter.com>
 <73F9AED0-D2A8-4294-B6E1-1B92D2A36529@kohlschutter.com>
 <115AD6A4-021B-4879-BFB5-BC7689A0203E@kohlschutter.com>
 <17a4c6f6-d79c-a7b2-860f-e5944b778f9f@arm.com>
 <9405b97a-6758-ad4e-ccff-eed072096539@arm.com>
 <BF7CC548-88C9-4889-8A41-8E99C31EF81C@kohlschutter.com>
 <daf3b61c-d886-98eb-0443-de233d742041@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
X-Mailer: Apple Mail (2.3696.100.31)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Am 15.07.2022 um 21:38 schrieb Robin Murphy <robin.murphy@arm.com>:
>=20
> On 2022-07-15 20:04, Christian Kohlsch=C3=BCtter wrote:
>> Am 15.07.2022 um 20:57 schrieb Robin Murphy <robin.murphy@arm.com>:
>>>=20
>>> On 2022-07-15 19:11, Robin Murphy wrote:
>>>> On 2022-07-15 18:16, Christian Kohlsch=C3=BCtter wrote:
>>>>> OK, this took me a while to figure out.
>>>>>=20
>>>>> When no undervoltage limit is configured, I can reliably trigger =
the initialization bug upon boot.
>>>>> When the limit is set to 3.0V, it rarely occurs, but just after I =
send the v3 patch, I was able to reproduce...
>>>> Well this has to be in the running for "weirdest placebo ever"... =
:/
>>>> All it actually seems to achieve is printing an error[1] (this is =
after all a tiny 5-pin fixed-voltage LDO regulator, not an intelligent =
PMIC), and if that makes an appreciable difference then there has to be =
some kind of weird timing condition at play. Maybe regulator_register() =
ends up turning it off and on again rapidly enough that the card sees a =
voltage brownout and glitches, and adding more delay by printing to the =
console somewhere in the middle gives it enough time to act as a proper =
power cycle with no ill effect?
>>>=20
>>> ...and apparently the answer is yes, it seems to be doing exactly =
that (see attached). But seemingly my SD cards don't mind, or maybe my =
T4 board happens to have more capacitance than Christian's R4S so my =
voltage dip isn't as bad, or both.
>>>=20
>>> So it seems like the solution here might indeed simply be to remove =
the regulator-always-on which doesn't seem to have any reason to be here =
anyway. Without that, the enable stays low until the MMC driver probes =
and claims it, which is then massively longer than the time it takes for =
VCC3V0_SD to ramp down completely.
>>>=20
>>> Robin.
>> Removing "regulator-always-on" has the effect that the system freezes =
upon reboot.
>=20
> Ah, right (can we fast-forward to a world where everyone has a =
reliable bootloader in SPI flash or similar?). Is that more glitching, =
or a firmware bug not resetting the GPIOs to their default state on warm =
reset, I wonder.
>=20
>> There may well be another bug slumbering in the codebase that is =
circumvented by 1. adding a delay in the code and 2. not turning the =
regulator off upon shutdown.
>=20
> Yes, it seems suboptimal that the regulator core allows this glitch =
where an always-on regulator which is already on gets turned off at all, =
but I guess that's its own problem. In the meantime, off-on-delay-us =
sounds like the most likely property to bandage this locally. I'm seeing =
a fall time in the order of milliseconds (attached), so we'd probably =
want a fair chunk of that to be safe.
>=20
> Robin.<SDS00003.png>

I think we have a way where there's no need to pick a delay value that =
may ultimately not work in all cases.
Following up with "[PATCH] regulator: core: Resolve supply name earlier =
to prevent double-init" [1]

Thank you so much for helping me getting that far! It would be great if =
you'd keep following the thread.

Best,
Christian

[1] https://www.spinics.net/lists/kernel/msg4440365.html

