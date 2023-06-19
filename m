Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FED4EB64D9
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Jun 2023 19:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjFSTyl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Jun 2023 15:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjFSTyk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Jun 2023 15:54:40 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C215106
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2023 12:54:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51a3e6a952aso4615400a12.3
        for <linux-mmc@vger.kernel.org>; Mon, 19 Jun 2023 12:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687204478; x=1689796478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyRSVfrJOL+bwgeDq4PIh5Rzl57vR7EHanbiiiTR8wg=;
        b=NdU4cZf3o/Slw0OTT0Gkj4kXxTKxGNmHJGYPORt2EYMWK5iXe7DO8O1LCMqXG/ES7B
         hCqJrja0F2Rb6FUdthfgH86ZBv9JQS5RTB9oVpmp3u7Xqi8xsTecpmP9kxXxJ83hhVQ+
         Yy0WiRDPjAobfzucFS/a/YNBAIDXOvEEBCfC5WKJs1Nixgo2ZhI8PFAhL/+ZbmmQTKkt
         DmCUn6vBedA3NJQzlSNnD53HP0VXfXEtob8G+HaXAtPN2U0357taEr8fTaM2HxQ9qYAc
         f1bASkWnbfoWeAhj5d67zNVlCiUu3JQ4uMx37g112b3UEK9cIpccSBm7k8+3GD5+C8EG
         PxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687204478; x=1689796478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyRSVfrJOL+bwgeDq4PIh5Rzl57vR7EHanbiiiTR8wg=;
        b=GUm4ZilDAUt+iCnqy0o9isXKknHuEng/TAckFuiLCAx9jdkHcF3PPd8H937rImd510
         aJKQquOt70p8PgE3XZg/SLZS9sf6DBgnAkScC+kABfhEfuBj9ynvkjmLNr4SgGdL1fiQ
         x70ngmWeMCtecS15/A/xwXe7Mm8tT9ECfMeZLUWwIR7HSybvqr79NDAfwIjS9hXmdIeu
         11TOKNIXPapRciAzaEKS4iJB4uHxRdseOHy4WvXNfBzHX8ZzslQSzcs8w6OeMIrYG/Ad
         efFj1h1hZdzUuNlxkShky4rtABsp4XLApd6M/r58H9oq3W/mpkyCd4HDAaZ3EKTVOq5F
         IQ5A==
X-Gm-Message-State: AC+VfDzZ1u1U3H/GGNa0njpe8LN7suPp7kh6eR8Wwn7Ucftiu9gSB5fP
        evshorZY+u64H4TtS6Hk7ewWzWfIxCphUAsAyTs=
X-Google-Smtp-Source: ACHHUZ4oQOwBKmQqjEJKI8Xyl7E8lAKnYccshQEse6MTexFIRWVjUn0WWitQsU7gg5VXUNmU/apcOwiFcKuZmG66m8Y=
X-Received: by 2002:a17:907:a42:b0:96f:afe9:25c7 with SMTP id
 be2-20020a1709070a4200b0096fafe925c7mr10751771ejc.10.1687204477606; Mon, 19
 Jun 2023 12:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
 <CAPDyKFqgYnBfm-NespEZF8AJ5Ou4Bya8jLfVEnfyZvfAZ05Q7Q@mail.gmail.com>
 <CAFBinCDjPJHEhN-Jx3DhhhHJ3yi8oEoW7u4-Ld6Rd1+W826ttA@mail.gmail.com>
 <CAPDyKFqKSWJkJwgCO89jgKQ6AB==P9BWkuX6XtKj=ASOH15y9g@mail.gmail.com>
 <CAFBinCDwgYw3v31hP4AtV3+Z1o+esDqMKugRwMMMLqSX0Acjzw@mail.gmail.com>
 <CAPDyKFr+hQo+N31r=3f58taf9sYW0UF0ApCJhwz9vRsyNizcvg@mail.gmail.com>
 <CAFBinCDSv_vdu5887vveotvaOGFrZvaSX4jM+7Q3QvDhTdazzw@mail.gmail.com> <CAPDyKFpS-UwiaRPMqSpX0mNPrS5p=yJzu3g0=pGyCkWHSYyqWg@mail.gmail.com>
In-Reply-To: <CAPDyKFpS-UwiaRPMqSpX0mNPrS5p=yJzu3g0=pGyCkWHSYyqWg@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 19 Jun 2023 21:54:26 +0200
Message-ID: <CAFBinCCnB=po9x6tsxCzRM99ZqgV9=5jBxS9LaoJqLPGZYSH6g@mail.gmail.com>
Subject: Re: Odroid-C1 regression with commit 4bc31edebde5 ("mmc: core: Set HS
 clock speed before sending HS CMD13")
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Luca Weiss <luca@z3ntu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Wed, Jun 14, 2023 at 5:49=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
[...]
> > Full register dump:
> > # cat /sys/kernel/debug/regmap/c1108e00.mmc/registers
> > 00: 00000900
> > 04: 0000004d
> > 08: e7ffe002
> > 0c: 02f0003f
> > 10: 0003f009
> > 14: 03b81c00
> > 18: 2c43bcf0
> > 1c: e0000150
> > 20: 00000000
> > 24: 00003067
> > 28: 00000000
> > 2c: 00000000
> > 30: 00000000
> > 34: 00fe0cff
> > 38: 0000100b
> >
> > In case you are curious, the driver is: drivers/mmc/host/meson-mx-sdhc-=
mmc.c
>
> Thanks for sharing this data!
>
> I assume the above registers indicate that we have sent the command
> and are now waiting for an IRQ for a response/error, but we never
> receive one.
>
> To really figure out what is going on, I think we need to do some
> additional low level debugging/testing.
>
> I was looking at the commit message from e4bf1b0970ef ("mmc: host:
> meson-mx-sdhc: new driver for the Amlogic Meson SDHC host"), which
> indicates that the clock management is quite limited for this HW. For
> example, the 51000000Hz isn't one of the supported frequencies. Could
> that be the reason for the problem? Perhaps if we play with changing
> the frequency to something that is considered supported - then can we
> make this work?
You seem to be more familiar with this Amlogic MMC controller than I am ;-)
Today I finally had some time for testing and when I started Ziyang
Huang provided a patch [0] (admittedly: I think it needs to be
improved, but finally we know that it's a MMC controller driver
limitation and not an MMC core bug)


Best regards,
Martin


[0] https://lore.kernel.org/linux-amlogic/TYZPR01MB5556B56D834E02F41C44D81D=
C95FA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com/
