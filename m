Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C554EB64D8
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jun 2023 15:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjFNPto (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Jun 2023 11:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbjFNPtn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2023 11:49:43 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D9D184
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 08:49:42 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5700b15c12fso7553217b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686757781; x=1689349781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxVrMc42GlGm037tYDtQh1qqmMvrc7pVLH4c7Xq6Nww=;
        b=a1lns4S840FDGsylZBmR1hjPQ5CMUMRtMRMM2Ts3BQRr1P9Lt/vv3y08UrU2yposa9
         sns0eNVtWBSwIjLcsr6ErbS+qh1jxFirCvJVtdvC2lZ66qMaRT3gt8lYFXWH2jlH3PVf
         qG3QJp3ug0/kpNzcmX3sCHgxp2TFHYb9fW2Xwbm2Yqq/BcEvQ20AyLmLFipSBgKM+el/
         34LVQ03NgWBLcUaVEArEvVF/V0RFsL8ryvUZfRlr0AnSZzqiWleFeS924jiCHoVT7Ipt
         51/0X0J3BS8DwBk8hXzwYzlX+J7hqDyeJBzpxFlsuLfR5emzur8SSinrbkx18HAK/a7q
         7vJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686757781; x=1689349781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TxVrMc42GlGm037tYDtQh1qqmMvrc7pVLH4c7Xq6Nww=;
        b=JFzeUuNi5MVkRv9lHgtpEglGjIyZ4h4I/G/huaf2a0hjgh5mOfiuYrRrLQYsrlybP6
         atuxysCQuX9D/yjuC81JY1aIsJ8dRAtHC5fF3TGNiaxa2FUkMaw40vLvpPhzBJ7qddg6
         9gLbEGT58nMpBdVz9uNRG3VD/r9iylRrNcWRQ/VihUQe3b1EKIqC3SuvYaYYMHOgTGbg
         bHsHhSooGvANFigXkBeTpeCp3c9HX3Uh87b5jQvMKV5LueusWBeSro03GWEAxez0DxSZ
         MT06CZUy5z1gTjuJuD8m3niYgFSktfDNoneDqUqInxXPW7wR/s/DAsheFt63qwTadmQA
         L6Uw==
X-Gm-Message-State: AC+VfDwksZy09b6W/QtQqdGfM2OBgAHBSkdHQ+VTURQJliBJBnb4UZ3W
        UY7fhIzBVvsfng8o5zx92PQqc83nH4e52S+6YRujCw==
X-Google-Smtp-Source: ACHHUZ7e/n0Lm0wrB1nuWYk3tKRGNJfvpDpevXdTTfkMRXQ7qEe06IhcWrw2SqZnLVGpqolrepQCHzgztLAGVPweNF4=
X-Received: by 2002:a0d:f102:0:b0:570:acd:493f with SMTP id
 a2-20020a0df102000000b005700acd493fmr1899602ywf.19.1686757781433; Wed, 14 Jun
 2023 08:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
 <CAPDyKFqgYnBfm-NespEZF8AJ5Ou4Bya8jLfVEnfyZvfAZ05Q7Q@mail.gmail.com>
 <CAFBinCDjPJHEhN-Jx3DhhhHJ3yi8oEoW7u4-Ld6Rd1+W826ttA@mail.gmail.com>
 <CAPDyKFqKSWJkJwgCO89jgKQ6AB==P9BWkuX6XtKj=ASOH15y9g@mail.gmail.com>
 <CAFBinCDwgYw3v31hP4AtV3+Z1o+esDqMKugRwMMMLqSX0Acjzw@mail.gmail.com>
 <CAPDyKFr+hQo+N31r=3f58taf9sYW0UF0ApCJhwz9vRsyNizcvg@mail.gmail.com> <CAFBinCDSv_vdu5887vveotvaOGFrZvaSX4jM+7Q3QvDhTdazzw@mail.gmail.com>
In-Reply-To: <CAFBinCDSv_vdu5887vveotvaOGFrZvaSX4jM+7Q3QvDhTdazzw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Jun 2023 17:49:05 +0200
Message-ID: <CAPDyKFpS-UwiaRPMqSpX0mNPrS5p=yJzu3g0=pGyCkWHSYyqWg@mail.gmail.com>
Subject: Re: Odroid-C1 regression with commit 4bc31edebde5 ("mmc: core: Set HS
 clock speed before sending HS CMD13")
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Luca Weiss <luca@z3ntu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 16 May 2023 at 22:45, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> On Mon, May 15, 2023 at 11:44=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
> [...]
> > > > 3) If 2) seems to work above, we need to figure out why
> > > > mmc_switch_status() is hanging. If there is a problem with the eMMC
> > > > card responding in-correctly, the host driver should return with an
> > > > error code, right?
> > > You're right: it's indeed hanging in mmc_switch_status()
> > > I don't get any interrupts (timeout, CRC error, ...) for it.
> > > Do you have any suggestions what to check next?
> >
> > So the mmc_switch_status() is sending a CMD13. Even if the card
> > doesn't reply, I would expect that the meson mmc controller would
> > raise some kind of error condition, probably via a timeout-irq.
> >
> > Did you verify that the driver is actually waiting for an IRQ to
> > happen, which also means waiting for a CMD13 response?
> register 0x24 is ICTL (interrupt control) and 0x28 is ISTAT (interrupt st=
atus)
> ISTAT is all zeros and ICTL is 0x3067 which translates so:
> - BIT(0): RESP_OK
> - BIT(1): RESP_TIMEOUT
> - BIT(2): RESP_ERR_CRC
> - BIT(5): DATA_TIMEOUT
> - BIT(6): DATA_ERR_CRC
> - BIT(12): RXFIFO_FULL
> - BIT(13): TXFIFO_EMPTY
>
> I guess in this case BIT(1) RESP_TIMEOUT is the relevant one.
>
> register 0x04 is SEND and reads 0x4d which translates to:
> - CMD13
> - MMC_RSP_PRESENT (HAS_RESP, BIT(6))
> - no other flags (STOP, R1B, ...) are set
>
> Full register dump:
> # cat /sys/kernel/debug/regmap/c1108e00.mmc/registers
> 00: 00000900
> 04: 0000004d
> 08: e7ffe002
> 0c: 02f0003f
> 10: 0003f009
> 14: 03b81c00
> 18: 2c43bcf0
> 1c: e0000150
> 20: 00000000
> 24: 00003067
> 28: 00000000
> 2c: 00000000
> 30: 00000000
> 34: 00fe0cff
> 38: 0000100b
>
> In case you are curious, the driver is: drivers/mmc/host/meson-mx-sdhc-mm=
c.c

Thanks for sharing this data!

I assume the above registers indicate that we have sent the command
and are now waiting for an IRQ for a response/error, but we never
receive one.

To really figure out what is going on, I think we need to do some
additional low level debugging/testing.

I was looking at the commit message from e4bf1b0970ef ("mmc: host:
meson-mx-sdhc: new driver for the Amlogic Meson SDHC host"), which
indicates that the clock management is quite limited for this HW. For
example, the 51000000Hz isn't one of the supported frequencies. Could
that be the reason for the problem? Perhaps if we play with changing
the frequency to something that is considered supported - then can we
make this work?

Kind regards
Uffe
