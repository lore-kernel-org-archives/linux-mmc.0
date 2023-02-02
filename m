Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAEDC61DA4
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Feb 2023 22:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjBBWOO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Feb 2023 17:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjBBWON (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Feb 2023 17:14:13 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911CA23DB4
        for <linux-mmc@vger.kernel.org>; Thu,  2 Feb 2023 14:14:12 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id i2so872149ybt.2
        for <linux-mmc@vger.kernel.org>; Thu, 02 Feb 2023 14:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md74lIzR0o7460ORkMXn7KayL0aVbPKupRPBeuDbbTI=;
        b=HRlsCWSs2dlebCLDmMtYuLDdArqtkMee6iQwte/VlkN1bbSWSHpDHWT/4je9mWPJp7
         XgWSFXL3rw72a77sKpV5fXDQZyitEG5D7aUJKvATOj8z6s5XuDQ6k8YpAK86Q9+qcKe5
         Cjfa7U0G5JCOuCU29CFkM6xInxzM9rWSDf9NivVjuXnS26g3GnzTfzlvJrStborIXI+7
         phOG4nm/iHnXPn2lp5Vd40MAenaY08OtlvQtal4K/dIRzdMZvG6sEpdbIdSpRh3kXMvp
         VfBKmyVJaEyu+t3DYYd5h9FD927ZiMrD4zKOeOOc+ANuYw68CRwq40W23G8F3FIdE52B
         qSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Md74lIzR0o7460ORkMXn7KayL0aVbPKupRPBeuDbbTI=;
        b=kkRS2vxeMKXO4fr488lk2v7ASaXkMVrh4d/ZhNaL9jX8pigVqxB4A47F4fwRiqaSAW
         IdNjhD6A8o+3h+w37PYYYIq97CWHcToGTAvE4Jw1oY7Dnuukl42O78LXbYcu2fw74j9u
         bTomcutPAQ3CtnD2hbNKhtfHcK5TeWPMNcl8P244mzQi5Yr14SZr3pAZEv4/tAoy5wHd
         g57rfj39B+yHzGCbT3BaUrpUuct5xyfy8B4uYtWuN7cz0oBg1L2DlUxyW9U4u56NMA75
         aDhfzrnlKDYPKsTVlmiI9hwKZfn2u1aFi0s8+Wf4y390o4sSaGdx3iEPWZhS+CGnTPGL
         DLhw==
X-Gm-Message-State: AO0yUKUGebNBO1WRJNREvQTZzsfAeLODNMvcI/gMCZYHX/Hot83ozHFr
        qdQTVQEv8wRKuAzI39ZhHNoKW+nCoKgotErwkCxU9g==
X-Google-Smtp-Source: AK7set8Ww53okW+GPRByKcLI9t2DJ87/pgwZwaQZjPnrIW92KM4QAuzw/T3WwMXedMTepXLt1YwySXkRQL98LHIhZws=
X-Received: by 2002:a25:aa0b:0:b0:80b:c9d0:c676 with SMTP id
 s11-20020a25aa0b000000b0080bc9d0c676mr1107062ybi.341.1675376051809; Thu, 02
 Feb 2023 14:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20230131084742.1038135-1-linus.walleij@linaro.org>
 <CAPDyKFrLetcCcFueJzZeWa-SVbsJcspwZ+nXWUDCGRXawxNhdg@mail.gmail.com> <98014ebd-7e57-0fc3-9ab0-49f4b727150d@kernel.dk>
In-Reply-To: <98014ebd-7e57-0fc3-9ab0-49f4b727150d@kernel.dk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Feb 2023 23:14:00 +0100
Message-ID: <CACRpkdacMR8wLX0O5qNAbeGxpJTo99F7XXCiZ+tUCuOO8=GcaQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Imply IOSCHED_BFQ
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Feb 2, 2023 at 7:04 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 2/2/23 8:22=E2=80=AFAM, Ulf Hansson wrote:
> > On Tue, 31 Jan 2023 at 09:47, Linus Walleij <linus.walleij@linaro.org> =
wrote:
> >>
> >> If we enable the MMC/SD block layer, use Kconfig to imply the BFQ
> >> I/O scheduler.
> >>
> >> As all MMC/SD devices are single-queue, this is the scheduler that
> >> users want so let's be helpful and make sure it gets
> >> default-selected into a manual kernel configuration. It will still
> >> need to be enabled at runtime (usually with udev scripts).
> >>
> >> Cc: linux-block@vger.kernel.org
> >> Cc: Paolo Valente <paolo.valente@linaro.org>
> >> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > I have taken the various arguments (for and against), but I think
> > $subject patch makes sense to me. In the end, this is about moving
> > towards a more sensible default kernel configuration and the "imply"
> > approach works fine for me.
> >
> > More importantly, $subject patch doesn't really hurt anything, as it's
> > still perfectly fine to build MMC without I/O schedulers and BFQ, for
> > those configurations that need this.
> >
> > That said, applied for next, thanks!
>
> It doesn't make sense, for all the reasons that Christoph applied.
> But you guys seemed to already have your mind made up and ignoring
> valid feedback, so...

The history leading us here as I see it:

In 2017 or if it was 2016 I think Paolo and Ulf started to look into
BFQ for improving the user experience with MMC on embedded
devices such as phones, tablets etc. I.e all systems using it.

As BFQ was not accepted for the old block layer it was adopted
for the MQ rewrite, as I understood a bit as "the new CFQ" for
slow single-queued devices.

Then, the MMC subsystem was consequently
rewritten to use MQ to be able to take advantage of BFQ.
It's why we pushed the conversion to MQ. To the point of creating
social conflicts I might add. Not everyone loved converting MMC
to MQ.

Those changes are direct causes and effects, one to one.

And now today all that work has made it possible for the MMC
subsystem to perform as we wanted it to.

Most MMC systems are interactive human operator-facing
devices where interactivity matters. Any other MMC storage
is secondary, uncommon and unimportant. It is called
MultiMedia Card for a reason.

So for MMC BFQ is a sensible default as an interactivity
boosting scheduler. The kernel should provide sensible
defaults.

I do not see why it is not a sensible default for systems with
MMC.

Yours,
Linus Walleij
