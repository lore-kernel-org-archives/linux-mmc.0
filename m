Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA23EB64D8
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Jun 2023 09:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjFTJ6R (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Jun 2023 05:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjFTJ5t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2023 05:57:49 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D87423C
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 02:54:40 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bd77424c886so4784965276.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2023 02:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687254869; x=1689846869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeKQxqV7wBO20CvYxv2br28Pl0//wusiddMDwssEpU4=;
        b=HDT+vm1yWhzlGFf3yabwM5+KGsjqQ4JCHsnZ30oorP73rvRr0HUaHjt++ZSQlI1If6
         20haBYxqpfdexux/3GPcUw8kz5Cn6MZHsVAJzm9hGWyjvFTKLZdPHne5bVcmTz8mXE8O
         DhmroUV+XEAZMzMgMeaeYtgHfwKgaxzYHhqwLVGeBYusZtZJ69rMw/wK2YwM6juPaXxv
         NQfujQ/z+aIxdIQuaI1/AH5Qu0B9lnKFAqjDGYT61CG3u9cWCoFXyqn6bxnD6OG9AsAj
         cdM214HBHXDRgYoyg62Ggqs2bYorw+qJEE/RTAskU/QDZYMDoIwEoYpnpK2BIAIUyQni
         vFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687254869; x=1689846869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeKQxqV7wBO20CvYxv2br28Pl0//wusiddMDwssEpU4=;
        b=knCNhl1HU6D6JnCzAD+SWOtykCBao0eOo6l9LKk9eAP2rR9vpZcNAVpZl2A5cmRCUf
         4ds72zvVwdEoyhi62IFVeO0RevJUZt1VdHasVBCuveIA+pRpwG0vYFzywNdFluJAResi
         mwp5aLzp3ypO/knqAJEKtClFQXpB8y7B85wawd9+rWzSRT9BWUyFxiWyVbAyofY+HXgJ
         vIfI1i75LQ0dNQ7BoYpQaGroIpdRYploOPraUc5rQ0wblCvOhQ9SutgdxM8Ob3BlRDPX
         fXIidu8ukxqV48EfPZy6l+5mJ5nCuLM4Bh/CkOG0Z04z+0Xvx7hq14f9OcX/EkuaHwZ9
         7ndw==
X-Gm-Message-State: AC+VfDx/eyWC3Y1AUPAla2uvIjOavn3TaUU9lCeeBkod/CXFe6zNmGoe
        Van8jy2rMwcXPRB8hlFvIzznUY+lGJR9Uykcb20CLQ==
X-Google-Smtp-Source: ACHHUZ4H+LGKUzcGaaCj0Gc7mOWw+qA4DkD5qhFOEsz8bQbOYlz7AQcAjt4bzqj4/VID/w07RPUazZ8NiOebA60ECMk=
X-Received: by 2002:a25:b188:0:b0:be4:684e:1971 with SMTP id
 h8-20020a25b188000000b00be4684e1971mr10265097ybj.63.1687254869759; Tue, 20
 Jun 2023 02:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAFBinCD0RT0p-jk86W0JuMT3ufohRh1RqWCcM35DKZJpuc10HQ@mail.gmail.com>
 <CAPDyKFqgYnBfm-NespEZF8AJ5Ou4Bya8jLfVEnfyZvfAZ05Q7Q@mail.gmail.com>
 <CAFBinCDjPJHEhN-Jx3DhhhHJ3yi8oEoW7u4-Ld6Rd1+W826ttA@mail.gmail.com>
 <CAPDyKFqKSWJkJwgCO89jgKQ6AB==P9BWkuX6XtKj=ASOH15y9g@mail.gmail.com>
 <CAFBinCDwgYw3v31hP4AtV3+Z1o+esDqMKugRwMMMLqSX0Acjzw@mail.gmail.com>
 <CAPDyKFr+hQo+N31r=3f58taf9sYW0UF0ApCJhwz9vRsyNizcvg@mail.gmail.com>
 <CAFBinCDSv_vdu5887vveotvaOGFrZvaSX4jM+7Q3QvDhTdazzw@mail.gmail.com>
 <CAPDyKFpS-UwiaRPMqSpX0mNPrS5p=yJzu3g0=pGyCkWHSYyqWg@mail.gmail.com> <CAFBinCCnB=po9x6tsxCzRM99ZqgV9=5jBxS9LaoJqLPGZYSH6g@mail.gmail.com>
In-Reply-To: <CAFBinCCnB=po9x6tsxCzRM99ZqgV9=5jBxS9LaoJqLPGZYSH6g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 20 Jun 2023 11:53:54 +0200
Message-ID: <CAPDyKFpAGUudAJKAmzMbcM=LrALU6ELpwaD-ijy18o7yrPgOqA@mail.gmail.com>
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

On Mon, 19 Jun 2023 at 21:54, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Ulf,
>
> On Wed, Jun 14, 2023 at 5:49=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> [...]
> > > Full register dump:
> > > # cat /sys/kernel/debug/regmap/c1108e00.mmc/registers
> > > 00: 00000900
> > > 04: 0000004d
> > > 08: e7ffe002
> > > 0c: 02f0003f
> > > 10: 0003f009
> > > 14: 03b81c00
> > > 18: 2c43bcf0
> > > 1c: e0000150
> > > 20: 00000000
> > > 24: 00003067
> > > 28: 00000000
> > > 2c: 00000000
> > > 30: 00000000
> > > 34: 00fe0cff
> > > 38: 0000100b
> > >
> > > In case you are curious, the driver is: drivers/mmc/host/meson-mx-sdh=
c-mmc.c
> >
> > Thanks for sharing this data!
> >
> > I assume the above registers indicate that we have sent the command
> > and are now waiting for an IRQ for a response/error, but we never
> > receive one.
> >
> > To really figure out what is going on, I think we need to do some
> > additional low level debugging/testing.
> >
> > I was looking at the commit message from e4bf1b0970ef ("mmc: host:
> > meson-mx-sdhc: new driver for the Amlogic Meson SDHC host"), which
> > indicates that the clock management is quite limited for this HW. For
> > example, the 51000000Hz isn't one of the supported frequencies. Could
> > that be the reason for the problem? Perhaps if we play with changing
> > the frequency to something that is considered supported - then can we
> > make this work?
> You seem to be more familiar with this Amlogic MMC controller than I am ;=
-)

Sometimes a well written commit message actually helps. :-)

> Today I finally had some time for testing and when I started Ziyang
> Huang provided a patch [0] (admittedly: I think it needs to be
> improved, but finally we know that it's a MMC controller driver
> limitation and not an MMC core bug)

Great news!

I will continue to monitor the thread and defer to apply anything
until you have given it your blessing, of course.

Kind regards
Uffe
