Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63182EB64D7
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jun 2023 12:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjFUMdM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jun 2023 08:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjFUMdL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jun 2023 08:33:11 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CB810D0
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jun 2023 05:33:09 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-78f208ebf29so1667481241.3
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jun 2023 05:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687350789; x=1689942789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NK0NN/+ZValsIKtRUFDnLqqWJ0ytqCxhWx151bq5PNU=;
        b=WZ3dc8cmORqtGl93BumHA1Bz3HIj4rT/gEQUtuJKDQ/Ws0yaN562rcRMU0gkV2E6lq
         88SPPscYU0spST9vUg2SoJTUnmzt1dF+3JMMDfWAbwe2ZM2vSUHQFyqrYGn0bwlvsBqx
         o4Hby1830o2m3uNvnN5Bw28UGLI2CwQZDiOSkDamdC4DZNc+le+tu5RkK4PFir5voXYN
         2D6w+0cYZjdp0jYx8HasiyXTJPfF3U1c3PFgYcJYMQZVZxnVNB5nc0uEZfS3Ql1LSiBE
         LLr0e5w1HtelWa5XoqaQoQHZ8a7bseSVaW2qQlGbYTY96X/TMG2R5qlyLM3auohl/CzS
         Nhsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687350789; x=1689942789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NK0NN/+ZValsIKtRUFDnLqqWJ0ytqCxhWx151bq5PNU=;
        b=YVuIOb3g8K/1ZqYUVDlWtkdNyJQ1DnEIexT+ZumZpk/zeZcLyoUjd+Wb7ht7KTBSBH
         GCpyURfUTelOGR1o7aTcatIk35MGVJI1Lw9dhR6JZAwx0EbVzjAmwYznOyrnorPmWLxi
         S5N4ARarD+ltEKTbLtbhnxAS8zqrQWDY6ZpqDUTOJf2jaLLNZ6IOw1V0fVbh//0wLGUp
         0kY1N+o56lNublTfgWvT/To5Vlpvo7sO8LWBqFvCx4wG5bzYGSj1LlkwlOMxwv+HesYq
         sdHYAW05MzkOUzVPab94s2Na5iy0E9tRGHFKJFBZu1jDU5p0YzfEl7N0GnDTYX2ksZJ9
         /Zow==
X-Gm-Message-State: AC+VfDwWZsGJP3cZMPF2B7fv5nHxaq0ur0WrVPv428Pi5bjsuBg0rIev
        a9L/r9Dk5+Oh19xM+ezM3SaVqvO70LLpsTUBF2i875Bj58K2sYkx
X-Google-Smtp-Source: ACHHUZ4i08Hs9UVTqns+eDXRP7jO3EcUw5/pzw7CtVgJF6BTqURPGz1BWUsniaZqqEghS73ggoE/mzl3ROa2Fg/Ctds=
X-Received: by 2002:a67:f1ca:0:b0:440:a545:61f2 with SMTP id
 v10-20020a67f1ca000000b00440a54561f2mr4473783vsm.4.1687350789019; Wed, 21 Jun
 2023 05:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230620091113.33393-1-ulf.hansson@linaro.org>
 <CACRpkdZfhPxFZhjiU9k5fjM9v9VOuZwu16eyn_qHL4Jm+CyhBg@mail.gmail.com> <CAPDyKFqXu9R=+281Ovt=ZR6VHYAv96LEvP+DgaZo2aHJB8_dgw@mail.gmail.com>
In-Reply-To: <CAPDyKFqXu9R=+281Ovt=ZR6VHYAv96LEvP+DgaZo2aHJB8_dgw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Jun 2023 14:32:33 +0200
Message-ID: <CAPDyKFrwBWrdMmwqJeTothwmLFiPmZy0+CreZu5cUMKpxiuXjQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Add support for SW busy-end timeouts
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>,
        Yann Gautier <yann.gautier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 21 Jun 2023 at 14:28, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 20 Jun 2023 at 21:27, Linus Walleij <linus.walleij@linaro.org> wr=
ote:
> >
> > On Tue, Jun 20, 2023 at 11:11=E2=80=AFAM Ulf Hansson <ulf.hansson@linar=
o.org> wrote:
> >
> > > The ux500 variant doesn't have a HW based timeout to use for busy-end=
 IRQs.
> > > To avoid hanging and waiting for the card to stop signaling busy, let=
's
> > > schedule a delayed work, according to the corresponding cmd->busy_tim=
eout
> > > for the command. If work gets to run, let's kick the IRQ handler to
> > > completed the currently running request/command.
> > >
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Some experiments: I added a patch to print the offending command and
> > dev_err() all the timing bugs. The resulting log:
>
> Interesting!
>
> >
> > /home/linus # dmesg |grep '80005000\|mmcblk2'
> > [    2.684814] mmci-pl18x 80005000.mmc: mmc2: PL180 manf 80 rev4 at
> > 0x80005000 irq 81,0 (pio)
> > [    2.695831] mmci-pl18x 80005000.mmc: DMA channels RX dma0chan4, TX d=
ma0chan5
> > [    3.410400] mmci-pl18x 80005000.mmc: no busy signalling in time (OP =
06)
> > [    3.434936] mmci-pl18x 80005000.mmc: no busy signalling in time (OP =
06)
> > [    3.451721] mmci-pl18x 80005000.mmc: lost busy status when waiting
> > for busy start IRQ (op 06)
> > [    3.489379] mmcblk2: mmc2:0001 M4G1YC 3.69 GiB
> > [    3.569000]  mmcblk2: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13
> > p14 p15 p16 p17 p18 p19 p20 p21 p22 p23 p24 p25
> > [    3.583526] mmcblk2boot0: mmc2:0001 M4G1YC 2.00 MiB
> > [    3.594726] mmcblk2boot1: mmc2:0001 M4G1YC 2.00 MiB
> > [    3.602233] mmcblk2rpmb: mmc2:0001 M4G1YC 128 KiB, chardev (246:0)
> > [    4.103057] mmci-pl18x 80005000.mmc: lost busy status when waiting
> > for busy start IRQ (op 06)
> > [    8.074188] mmci-pl18x 80005000.mmc: lost busy status when waiting
> > for busy start IRQ (op 06)
> > [    8.084350] mmci-pl18x 80005000.mmc: no busy signalling in time (OP =
06)
> > [    8.451446] mmci-pl18x 80005000.mmc: lost busy status when waiting
> > for busy start IRQ (op 06)
> > [    8.757934] mmci-pl18x 80005000.mmc: no busy signalling in time (OP =
06)
> > [   10.211883] mmci-pl18x 80005000.mmc: no busy signalling in time (OP =
06)
> > [   10.587646] mmci-pl18x 80005000.mmc: lost busy status when waiting
> > for busy start IRQ (op 06)
> > [   10.913604] mmci-pl18x 80005000.mmc: no busy signalling in time (OP =
06)
> > [   10.924072] mmci-pl18x 80005000.mmc: no busy signalling in time (OP =
06)
> > [   10.931671] mmci-pl18x 80005000.mmc: no busy signalling in time (OP =
06)
> > [   12.023345] mmci-pl18x 80005000.mmc: lost busy status when waiting
> > for busy start IRQ (op 06)
> > [   12.357757] mmci-pl18x 80005000.mmc: lost busy status when waiting
> > for busy start IRQ (op 06)
> > [   14.087677] mmci-pl18x 80005000.mmc: no busy signalling in time (OP =
06)
> > [   14.096191] mmci-pl18x 80005000.mmc: no busy signalling in time (OP =
06)
> > [   15.124114] mmci-pl18x 80005000.mmc: no busy signalling in time (OP =
06)
> > [   15.153411] mmci-pl18x 80005000.mmc: lost busy status when waiting
> > for busy start IRQ (op 06)
> > [   15.525024] mmci-pl18x 80005000.mmc: lost busy status when waiting
> > for busy start IRQ (op 06)
> > [   15.850036] mmci-pl18x 80005000.mmc: timeout waiting for busy IRQ (o=
p 06)
> > [   18.250122] mmci-pl18x 80005000.mmc: lost busy status when waiting
> > for busy start IRQ (op 06)
> > [   18.988983] mmci-pl18x 80005000.mmc: no busy signalling in time (OP =
06)
> > [   19.302612] mmci-pl18x 80005000.mmc: no busy signalling in time (OP =
06)
> > [   19.320953] mmci-pl18x 80005000.mmc: no busy signalling in time (OP =
06)
> > [   19.333251] mmci-pl18x 80005000.mmc: lost busy status when waiting
> > for busy start IRQ (op 06)
> > [   21.851715] mmci-pl18x 80005000.mmc: lost busy status when waiting
> > for busy start IRQ (op 06)
> >
> > Always command 0x06, MMC_SWITCH. But this is also the *only*
> > command that resturns MMC_RSP_BUSY so it doesn't say very
> > much about the card in general.
>
> We have other commands that have R1B responses.
>
> For example, open-ended I/O writes that are completed with CMD12 or
> the erase/discard command. Not sure which ones that are easiest for
> you to test with, we can chat more about this offlist.
>
> >
> > We have speculated that the card is maybe operating out of spec, such a=
s
> > holding DAT0 high for too short time (not across enough MCLK cycles)
> > or similar when indicating busy for short timespans.
>
> By looking at the above log, it seems like the card does signal busy,
> at least occasionally.
>
> 1) The print "no busy signalling in time", isn't so worrying to me. It
> probably means that the card doesn't need to signal busy, as it's
> internal operation is completed. To be absolutely sure, we could
> extend the polling loop to more retries, just to test.
>
> 2) The print "lost busy status when waiting for busy start IRQ" is a
> bit harder to understand. However, my guess is that the mmci
> controller does raise an IRQ, to signal a *changed* busy signal state,
> which is the most important thing. When we end up reading the busy
> status bit to manage the IRQ, we find that the card has stopped
> signalling busy. That seems perfectly fine to me. So, maybe we don't
> get the start IRQ (as that state wasn't discovered) but only the end
> IRQ, so to say.
>
> More importantly, the busy timeout work never gets to run, which
> indicates that we are no longer hanging and waiting for an IRQ to be
> raised. Is that correct?

Ehh, I should have looked more closely at the log. Indeed there is one
case where the timeout work kicks in.

Maybe we should log the information about the current ->busy_state at
that point too, so understand under what condition we are hanging? I
think we should also log the actual used timeout in this case.

[...]

Kind regards
Uffe
