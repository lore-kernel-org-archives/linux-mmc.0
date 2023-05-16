Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C834C77B7A
	for <linux-mmc@archiver.kernel.org>; Tue, 16 May 2023 20:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjEPUp2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 May 2023 16:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEPUp1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 May 2023 16:45:27 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A885102
        for <linux-mmc@vger.kernel.org>; Tue, 16 May 2023 13:45:26 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-510bcd2d6b8so650416a12.0
        for <linux-mmc@vger.kernel.org>; Tue, 16 May 2023 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684269925; x=1686861925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLuNzxgt4u7wYy4U8lUYhqOALXydn6b7WXFOJngr8yI=;
        b=Fw0fmDSHT4fboK1etWSMbJ4UTjJufy/4YmlEKwzF4KXiTLKoDDD1sUV8moO8Cidf+J
         3hgQ6YLL2zzGT8wgogtBkOXovi2ZmQCxd2NunOH5l33fmCzerzZpu6rWjLn04ZXhlJzr
         zEGmF+uLUM2mPW2irMxxLrqNaXXXlVnB6qjcEAU9X6fIyM+BvJ7ZSyI6/xbxn15puhSa
         GHX/433UnJrrSkmUT+2byGV35OmFZkQtkkqRDwfaYddgikeRVNU/T8TKBCfDw1ONEGJu
         D/ElAGFUIEFIti1z1tg8VrwE2jdTvSPiTqc/VP0u4Y+8615jytYhYjeNfohFKDdk5+ST
         aGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684269925; x=1686861925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLuNzxgt4u7wYy4U8lUYhqOALXydn6b7WXFOJngr8yI=;
        b=Hx5LtPq2F98zdLW4/2W4CWfy12D8p8RmjlHoVgDIc9Sy8KzkteUap6thSUt0r8lGtB
         jlR8eP2PKF+Zy4aEooSr3rBBTtmIxPeSWC7KGRExH45Kig4SggmeujVVtoaPWzIRudCn
         Byy74zh0ZeQ12U89iEkbW1f+lGXghPe2CfhTkVeFkF3zQSdsMNXc62Whjo82ddhFAoJk
         Kw7ZNZXaHZzdqB+djq6zC1AYiRq7lY79w+d25oFhfiaDhm7QshOc2kCZC1quc9Vs4ER3
         wfogLKf1srdyP9HC1hR7jyBCUyjtGg+ryajKB0KRM/PfPRh1A61xM1CXwhuMtu7vTGgH
         QHvQ==
X-Gm-Message-State: AC+VfDz5a1Df5k384/YkIyaawhcTH5wgVBlbKzWpYhJqObHjW4Maucm0
        45mXPyZ4v40cnJz+ySMmeo4jVgcS9pPWOL5lxN8=
X-Google-Smtp-Source: ACHHUZ5A/qcEmUqmdhQJ4a20RyacFe7ibnyzP+AGiKCcqftnAp0QRaurLuLtBclnLo2zrB5DXnCGcGNeDjHFbciY2pk=
X-Received: by 2002:a17:907:d21:b0:94a:57d1:5539 with SMTP id
 gn33-20020a1709070d2100b0094a57d15539mr75336ejc.5.1684269924790; Tue, 16 May
 2023 13:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
 <CAPDyKFqgYnBfm-NespEZF8AJ5Ou4Bya8jLfVEnfyZvfAZ05Q7Q@mail.gmail.com>
 <CAFBinCDjPJHEhN-Jx3DhhhHJ3yi8oEoW7u4-Ld6Rd1+W826ttA@mail.gmail.com>
 <CAPDyKFqKSWJkJwgCO89jgKQ6AB==P9BWkuX6XtKj=ASOH15y9g@mail.gmail.com>
 <CAFBinCDwgYw3v31hP4AtV3+Z1o+esDqMKugRwMMMLqSX0Acjzw@mail.gmail.com> <CAPDyKFr+hQo+N31r=3f58taf9sYW0UF0ApCJhwz9vRsyNizcvg@mail.gmail.com>
In-Reply-To: <CAPDyKFr+hQo+N31r=3f58taf9sYW0UF0ApCJhwz9vRsyNizcvg@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 16 May 2023 22:45:13 +0200
Message-ID: <CAFBinCDSv_vdu5887vveotvaOGFrZvaSX4jM+7Q3QvDhTdazzw@mail.gmail.com>
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

On Mon, May 15, 2023 at 11:44=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
[...]
> > > 3) If 2) seems to work above, we need to figure out why
> > > mmc_switch_status() is hanging. If there is a problem with the eMMC
> > > card responding in-correctly, the host driver should return with an
> > > error code, right?
> > You're right: it's indeed hanging in mmc_switch_status()
> > I don't get any interrupts (timeout, CRC error, ...) for it.
> > Do you have any suggestions what to check next?
>
> So the mmc_switch_status() is sending a CMD13. Even if the card
> doesn't reply, I would expect that the meson mmc controller would
> raise some kind of error condition, probably via a timeout-irq.
>
> Did you verify that the driver is actually waiting for an IRQ to
> happen, which also means waiting for a CMD13 response?
register 0x24 is ICTL (interrupt control) and 0x28 is ISTAT (interrupt stat=
us)
ISTAT is all zeros and ICTL is 0x3067 which translates so:
- BIT(0): RESP_OK
- BIT(1): RESP_TIMEOUT
- BIT(2): RESP_ERR_CRC
- BIT(5): DATA_TIMEOUT
- BIT(6): DATA_ERR_CRC
- BIT(12): RXFIFO_FULL
- BIT(13): TXFIFO_EMPTY

I guess in this case BIT(1) RESP_TIMEOUT is the relevant one.

register 0x04 is SEND and reads 0x4d which translates to:
- CMD13
- MMC_RSP_PRESENT (HAS_RESP, BIT(6))
- no other flags (STOP, R1B, ...) are set

Full register dump:
# cat /sys/kernel/debug/regmap/c1108e00.mmc/registers
00: 00000900
04: 0000004d
08: e7ffe002
0c: 02f0003f
10: 0003f009
14: 03b81c00
18: 2c43bcf0
1c: e0000150
20: 00000000
24: 00003067
28: 00000000
2c: 00000000
30: 00000000
34: 00fe0cff
38: 0000100b

In case you are curious, the driver is: drivers/mmc/host/meson-mx-sdhc-mmc.=
c


Best regards,
Martin
