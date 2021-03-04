Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F09BC433E9
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 18:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C1664F5C
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 18:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhCDSE2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 13:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbhCDSD4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Mar 2021 13:03:56 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC9AC061761
        for <linux-mmc@vger.kernel.org>; Thu,  4 Mar 2021 10:03:16 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id y35so9567317uad.5
        for <linux-mmc@vger.kernel.org>; Thu, 04 Mar 2021 10:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ot0pBmNC9C2X+nBkx9lvZxGNQE3VnPlcBNxjMI2kl+A=;
        b=fG6Yc8BxmivwsyBhxPN1l4Usla51wPxUb9C+NJKw79QMnmmdMxSKukhr9vHrPDsG9S
         0g23BMN5bI2LBgTYDB4apV4a5icGjwB5ZqPDM+aHN3H5bE+G1mzAxLxqK8pItyJ3Tngy
         gTOWsJJVQlOhdqP328V3kJdm+R0lSBOBvQ5cIwXhEttI1D/l/hkg3O0tFsIvvp+hsKwu
         Bh2izbfPWkw7g5fVQ2ITw2dpwZSZXzwZ0SK2z4xftMe9Drhiyg4unRjrbfqT4SLTrsx1
         X1U7O0O/7sUUuBqLaNWWFMmi/Fwsk8FvjcZ1G10xwccF/Um6gWFn4+Bpy+oWk6n/o0oX
         jKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ot0pBmNC9C2X+nBkx9lvZxGNQE3VnPlcBNxjMI2kl+A=;
        b=Rg/Z7hJWIw33ZjnhasHqYQ++T7HTaJn4zXeZ8d2X9cpc4QVQHEzPL3Mi6li8KbtOMs
         iKsUcn97JKPfxin81KpReOVwzisePr2nXNLdJeC5B0KS0eKjf3IAMQTkGJpficvpkUFr
         TrJrv2j+nqHzEXba3U0DcEGPPWG65wrdyGEm6Ed7R6TBXh+2VruFElkBOV9IsocxNOis
         tC5dWBJGKoNqKXxlFxpdqbwfRYdyuu/05NqKGlwCmwyxIzqdYeUnJsCKMYtIF9voiSDp
         QlvOcCvAiOeWDa5I0oHscNPofxt8uwuBVfQ3CgZ5n2bBpfFMq3yQJr6AUFSPKK/3+hA9
         5PVw==
X-Gm-Message-State: AOAM532bIoQvG3/gnewwRd/Tc0a7aL91dM9dqjNl6wGC2b1MBCSqjiD2
        Qdsvbl+STfwNjQlUoo+AoIOIau2D/efLugxo/dMQQA==
X-Google-Smtp-Source: ABdhPJzytwgL73ZPP1K08fGAHeN5ehDIPgAIh1Ry5wIZKXT9Gb2rtJUPv8Stfn3sJQFKv9Ay2SrZvQYLvDwrweiH8mY=
X-Received: by 2002:ab0:6045:: with SMTP id o5mr3525813ual.100.1614880995595;
 Thu, 04 Mar 2021 10:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20210216224252.22187-1-marten.lindahl@axis.com>
 <CAPDyKFoASx=U8b1Oqtuo6ikiM=gXfL2x1Gsz=rfAn9zxP0y_iA@mail.gmail.com>
 <20210301215923.6jfg6mg5ntorttan@axis.com> <CAPDyKFoaKfuwweaEMf1Pz+ECAPU3P9-gmCJcpq+MADH5gH1c=Q@mail.gmail.com>
 <20210304134836.xlw7wbbvkc5bqzmm@axis.com> <CAPDyKFous2oDwcUgPkZV8bZzpd+yA8m9LwC3+yk0uxqWcrJx1w@mail.gmail.com>
 <20210304145946.tnbbd4qq6nvc2mcb@axis.com>
In-Reply-To: <20210304145946.tnbbd4qq6nvc2mcb@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Mar 2021 19:02:38 +0100
Message-ID: <CAPDyKFqF3MSfatooLQyXsz3Yu_zNSpzKaGWUP0nJsQjJZ+0FGQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: Try power cycling card if command request times out
To:     Marten Lindahl <martenli@axis.com>
Cc:     =?UTF-8?Q?M=C3=A5rten_Lindahl?= <Marten.Lindahl@axis.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel <kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 4 Mar 2021 at 15:59, Marten Lindahl <martenli@axis.com> wrote:
>
> On Thu, Mar 04, 2021 at 03:06:54PM +0100, Ulf Hansson wrote:
> > On Thu, 4 Mar 2021 at 14:48, Marten Lindahl <martenli@axis.com> wrote:
> > >
> > > Hi Ulf! My apologies for the delay.
> > >
> > > On Tue, Mar 02, 2021 at 09:45:02AM +0100, Ulf Hansson wrote:
> > > > On Mon, 1 Mar 2021 at 22:59, Marten Lindahl <martenli@axis.com> wro=
te:
> > > > >
> > > > > Hi Ulf!
> > > > >
> > > > > Thank you for your comments!
> > > > >
> > > > > On Mon, Mar 01, 2021 at 09:50:56AM +0100, Ulf Hansson wrote:
> > > > > > + Adrian
> > > > > >
> > > > > > On Tue, 16 Feb 2021 at 23:43, M=C3=A5rten Lindahl <marten.linda=
hl@axis.com> wrote:
> > > > > > >
> > > > > > > Sometimes SD cards that has been run for a long time enters a=
 state
> > > > > > > where it cannot by itself be recovered, but needs a power cyc=
le to be
> > > > > > > operational again. Card status analysis has indicated that th=
e card can
> > > > > > > end up in a state where all external commands are ignored by =
the card
> > > > > > > since it is halted by data timeouts.
> > > > > > >
> > > > > > > If the card has been heavily used for a long time it can be w=
eared out,
> > > > > > > and should typically be replaced. But on some tests, it shows=
 that the
> > > > > > > card can still be functional after a power cycle, but as it r=
equires an
> > > > > > > operator to do it, the card can remain in a non-operational s=
tate for a
> > > > > > > long time until the problem has been observed by the operator=
.
> > > > > > >
> > > > > > > This patch adds function to power cycle the card in case it d=
oes not
> > > > > > > respond to a command, and then resend the command if the powe=
r cycle
> > > > > > > was successful. This procedure will be tested 1 time before g=
iving up,
> > > > > > > and resuming host operation as normal.
> > > > > >
> > > > > > I assume the context above is all about the ioctl interface?
> > > > > >
> > > > >
> > > > > Yes, that's correct. The problem we have seen is triggered by ioc=
tls.
> > > > >
> > > > > > So, when the card enters this non functional state, have you tr=
ied
> > > > > > just reading a block through the regular I/O interface. Does it
> > > > > > trigger a power cycle of the card - and then makes it functiona=
l
> > > > > > again?
> > > > > >
> > > > >
> > > > > Yes, we have tried that, and it does trigger a power cycle, makin=
g the card
> > > > > operational again. But as it requires an operator to trigger it, =
I thought
> > > > > it might be something that could be automated here. At least once=
.
> > > >
> > > > Not sure what you mean by operator here? In the end it's a userspac=
e
> > > > program running and I assume it can deal with error paths. :-)
> > > >
> > > > In any case, I understand your point.
> > > >
> > >
> > > Yes, we have a userspace program. So if the userspace program will tr=
y to
> > > restore the card in a situation such as the one we are trying to solv=
e
> > > here, how shall it perform it? Is it expected that a ioctl CMD0 reque=
st
> > > should be enough, or is there any other support for a userspace progr=
am to
> > > reset the card?
> >
> > Correct, there is no way for userspace to reset cards through an ioctl.
> >
> > >
> > > If it falls on a ioctl command to reset the card, how do we handle th=
e case
> > > where the ioctl times out anyway? Or is the only way for a userspace =
program
> > > to restore the card, to make a block transfer that fails?
> >
> > Yes, that is what I was thinking. According to the use case you have
> > described, this should be possible for you to implement as a part of
> > your userspace program, no?
>
> Ok, I will discuss that with the people maintaining the userspace program=
 :)
>
> But would it be of interest to review a patch introducing a more clean ca=
rd
> reset request, without block transfers?

Well, if you can solve it with block transfers that's the preferred
option, in my opinion.

As I stated earlier, my main issue with the HW reset through the ioctl
interface, is that we don't know what combination of
request/command/response we should be doing a reset for.

Kind regards
Uffe
