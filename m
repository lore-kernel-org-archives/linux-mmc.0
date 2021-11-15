Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823BEC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 14:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C17463219
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Nov 2021 14:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhKOO6A (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Nov 2021 09:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhKOO6A (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Nov 2021 09:58:00 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45599C061570
        for <linux-mmc@vger.kernel.org>; Mon, 15 Nov 2021 06:55:04 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id t11so36133987ljh.6
        for <linux-mmc@vger.kernel.org>; Mon, 15 Nov 2021 06:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L4dQb9bI/nF/LdtSNvytuCGCdqOvBdUbMDkCHhqnw1U=;
        b=FgoUMGuQP2TVwQPlX5+4cW8knkZrMIjpu1BwvthctuoigZq8ek8gx6QaPJPHZ2A4uZ
         YaStWGgRdqZPxLAO+EaPzGg4kK3iP1GK2tdlQjN1UiOz06K2M22pBQ4sYa2sb2tvlWG3
         5WmAQegVRc2oz9T4Q9CC4kKMgRxAcfoahfgE3YUV4uXvoogQWjR4okD99GC/VReQd/YF
         4eTnGxlH6G/qj+JXNxIXU+w+XYH0Hp1lGZsr0aFODqQvN19DeXjPhDn8wXHtrNQwhuh8
         2Z7Jiry9aduNqwXY4dWlKkGhbYcmkFSk/czAQRTg8OYSGA4ESOhjN3WuXJ7MqUYC98/o
         j8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L4dQb9bI/nF/LdtSNvytuCGCdqOvBdUbMDkCHhqnw1U=;
        b=lfB5xupsGqyliMB8JhDK7gl0gQCKck0d5GY/WsEkB9U4C6ib2FkZNC9AoCPhe/LgSc
         w+iry2FUibeD+Gn/YVHGRwtkyLQHTAoHENsFtRDfWXch2wWHY3N6XkcjsM1gTcS8wCVv
         I+Jr1Wgk23Y2dHQ7W1F69jIm5vGzTD4a73skVulBYJnMA4YQEu17O0e9gWo0bPE//pbK
         LD/grDAioVj8jOjl6XulQOjEM/E7YAWe/BWDUV4C/eX9NQot7/wbaYURMMwpbRcKxBFd
         mM9wNh+IeHOAmByAutceG+97nPSRYKqLvUon1HBYv9j/q3IjH1OhnOT46ffUi55hh9q6
         tK1Q==
X-Gm-Message-State: AOAM531knwe8ZI0a0R9AvC5iSRFAj6PVtJ3COzMJkM8yxipjfHLquU7N
        IcSAyhwJo7JoE6PLW/OFs3lZcJXuLlRKoqSIw2PZIQ==
X-Google-Smtp-Source: ABdhPJwL0yY24aTYONuKRYpZACxpDl8FPJZXxorHZizuYP5UvUeQ2YTon2cOy7GRLQXTmEH0c2QfB0dYeSM606JaSi4=
X-Received: by 2002:a2e:a5c8:: with SMTP id n8mr40399279ljp.367.1636988102606;
 Mon, 15 Nov 2021 06:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20211103182716.28419-1-marten.lindahl@axis.com>
 <20211111154020.GA21634@axis.com> <20211112124602.GA23161@axis.com>
In-Reply-To: <20211112124602.GA23161@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Nov 2021 15:54:26 +0100
Message-ID: <CAPDyKFrz9x-H5v0yAWVjgDi-=5DwmYZNTTLku6SLziVDNgZNzw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Avoid hung state if GEN_CMD transfer fails
To:     Marten Lindahl <martenli@axis.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel <kernel@axis.com>, Doug Anderson <dianders@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 12 Nov 2021 at 13:46, Marten Lindahl <martenli@axis.com> wrote:
>
> On Thu, Nov 11, 2021 at 04:40:20PM +0100, Vincent Whitchurch wrote:
> > On Wed, Nov 03, 2021 at 07:27:16PM +0100, M=C3=A5rten Lindahl wrote:
> > > If we get a data error during a block transfer command, a stop comman=
d
> > > (CMD12) is normally initiated. But this does not work for the general
> > > command (CMD56), but instead the action is ignored and an uninitializ=
ed
> > > command struct is used for the stop action, with unexpected result.
> > >
> > > Fix this by adding a check for GEN_CMD when preparing stop transmissi=
on.
> > >
> > > Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
> > > ---
> > >  drivers/mmc/host/dw_mmc.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > > index 6578cc64ae9e..988c32e93e03 100644
> > > --- a/drivers/mmc/host/dw_mmc.c
> > > +++ b/drivers/mmc/host/dw_mmc.c
> > > @@ -335,7 +335,8 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *=
host, struct mmc_command *cmd)
> > >         cmdr =3D=3D MMC_WRITE_BLOCK ||
> > >         cmdr =3D=3D MMC_WRITE_MULTIPLE_BLOCK ||
> > >         cmdr =3D=3D MMC_SEND_TUNING_BLOCK ||
> > > -       cmdr =3D=3D MMC_SEND_TUNING_BLOCK_HS200) {
> > > +       cmdr =3D=3D MMC_SEND_TUNING_BLOCK_HS200 ||
> > > +       cmdr =3D=3D MMC_GEN_CMD) {
> > >             stop->opcode =3D MMC_STOP_TRANSMISSION;
> > >             stop->arg =3D 0;
> > >             stop->flags =3D MMC_RSP_R1B | MMC_CMD_AC;
>
> Hi!
> >
> > While this fix looks correct for CMD56, the "Data transfer mode"
> > sections of the eMMC and SD specifications list several more data
> > commands, all of which can be aborted by CMD12, but which aren't handle=
d
> > in the if above.
> >
> > If I'm not mistaken, those will also result in an uninitialized stop
> > command being sent in the case of an error, since the driver calls
> > send_stop_abort() on any data error.
> >
> > Is there a reason why those other commands should not be in the list
> > above, or should we fix this list so that CMD12 is initialized for all
> > data commands except SD_IO_RW_EXTENDED?
>
> I agree that there are more commands that according to the specification
> should be included in the list. The most obvious ones that I identify are=
:
> CMD26, CMD27, CMD30, CMD46, and CMD47.
>
> But the reason why I added just CMD56 is that I have an easy way to test
> this specific command, and which was how I saw the need for this fix.
>
> My suggestion is to separate adding the other commands to one (or more)
> separate patch(es), to when there are good test cases for those.

I agree with both of you, it would be nice to make a change that takes
care of all the relevant commands at once, rather than having to come
back to this later again.

On the other hand, as it's not always straightforward to test the
other commands, I am fine with this as well.

So, applied for next, thanks!

Kind regards
Uffe
