Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F8BC43381
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2049164E62
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhCCBlv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377993AbhCBIqU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Mar 2021 03:46:20 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC369C061356
        for <linux-mmc@vger.kernel.org>; Tue,  2 Mar 2021 00:45:39 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id o186so10225326vso.1
        for <linux-mmc@vger.kernel.org>; Tue, 02 Mar 2021 00:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BDwFPh89sek8c4gYigyPtmobsd1aoVN5drZwpxRsgFE=;
        b=KVzLefRbNuNm+PTem7wZkaTTCSR5XP88Ln/heJszN9Rsu2bb9ItIHI46eCuvV7BuUy
         26WBpoFMhOzub+R/Gi+FcLChTwb0gCRqYUz4LyJ3IAhWg8uhIOszb5t9lJKA1DWx8PpI
         hLUVBQiz7rBxi2aMAB9T1It2WOsD51RK8OCgu0r10sa81BLCn1IYxHSK1B3/GVX21t4Q
         NzbpbACfpC8yOUXaa0UmH3xJ92YAkDErCPBMzINM2C8sY/6H2ZZr/9UH5VgfPwQ2bb9G
         +Pj6dnOrghAGpk4oTNAlVQ+jQIKK/c1gHLGBPYQFpsVnJn6/WdzLltWs35DWtBoGZtew
         XE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BDwFPh89sek8c4gYigyPtmobsd1aoVN5drZwpxRsgFE=;
        b=YWN2VleiCKYNG4oATros0v0mSLX6cyumkGR0lss40GKoHshGYGtCyUtkDEHrjl2Swk
         +YCf1sAPA6dQR423qTNQuvKD4hIgkP7H3uEpmLkvCPwrbVD6vJrIDOLP0OgKK5U20WlK
         lqMa8SVOLLPqscNCJuQvRksR3UAFTduwQnW+zozLNfzZS9RF9sEe2NEYPWAY5FbVCX9u
         j3Nu3bkDV4sNGW62MGvSON2a/80gfdA4PNBYHXaQ9YOykouzQaM+h9pL4RFw8L4I+ecr
         HgLiGOXXcZXKO1bWVqeieVJXKiIEqVZpR1AuH8Y0BURfLXKsFrFlCsFHtc12BQE07u1s
         3gvA==
X-Gm-Message-State: AOAM533JHY6zbQigMBhxJrlT9nouqLsA01x2nEOHMX8c5ajntz2o9per
        zAcKXC63RTbDcbRvVrPKtP5B+CD+3Vgu0lkzQHo24w==
X-Google-Smtp-Source: ABdhPJwltS124Jky7ewef1zQsANHCdXtXFdUUmqwI7r+Tsdk17xjqOLrIAcxy2V84YK0YyM4pBoYJdfxFDB5SkNHQFs=
X-Received: by 2002:a67:8c6:: with SMTP id 189mr1388424vsi.55.1614674738964;
 Tue, 02 Mar 2021 00:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20210216224252.22187-1-marten.lindahl@axis.com>
 <CAPDyKFoASx=U8b1Oqtuo6ikiM=gXfL2x1Gsz=rfAn9zxP0y_iA@mail.gmail.com> <20210301215923.6jfg6mg5ntorttan@axis.com>
In-Reply-To: <20210301215923.6jfg6mg5ntorttan@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 09:45:02 +0100
Message-ID: <CAPDyKFoaKfuwweaEMf1Pz+ECAPU3P9-gmCJcpq+MADH5gH1c=Q@mail.gmail.com>
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

On Mon, 1 Mar 2021 at 22:59, Marten Lindahl <martenli@axis.com> wrote:
>
> Hi Ulf!
>
> Thank you for your comments!
>
> On Mon, Mar 01, 2021 at 09:50:56AM +0100, Ulf Hansson wrote:
> > + Adrian
> >
> > On Tue, 16 Feb 2021 at 23:43, M=C3=A5rten Lindahl <marten.lindahl@axis.=
com> wrote:
> > >
> > > Sometimes SD cards that has been run for a long time enters a state
> > > where it cannot by itself be recovered, but needs a power cycle to be
> > > operational again. Card status analysis has indicated that the card c=
an
> > > end up in a state where all external commands are ignored by the card
> > > since it is halted by data timeouts.
> > >
> > > If the card has been heavily used for a long time it can be weared ou=
t,
> > > and should typically be replaced. But on some tests, it shows that th=
e
> > > card can still be functional after a power cycle, but as it requires =
an
> > > operator to do it, the card can remain in a non-operational state for=
 a
> > > long time until the problem has been observed by the operator.
> > >
> > > This patch adds function to power cycle the card in case it does not
> > > respond to a command, and then resend the command if the power cycle
> > > was successful. This procedure will be tested 1 time before giving up=
,
> > > and resuming host operation as normal.
> >
> > I assume the context above is all about the ioctl interface?
> >
>
> Yes, that's correct. The problem we have seen is triggered by ioctls.
>
> > So, when the card enters this non functional state, have you tried
> > just reading a block through the regular I/O interface. Does it
> > trigger a power cycle of the card - and then makes it functional
> > again?
> >
>
> Yes, we have tried that, and it does trigger a power cycle, making the ca=
rd
> operational again. But as it requires an operator to trigger it, I though=
t
> it might be something that could be automated here. At least once.

Not sure what you mean by operator here? In the end it's a userspace
program running and I assume it can deal with error paths. :-)

In any case, I understand your point.

>
> > >
> > > Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
> > > ---
> > > Please note: This might not be the way we want to handle these cases,
> > > but at least it lets us start the discussion. In which cases should t=
he
> > > mmc framework deal with error messages like ETIMEDOUT, and in which
> > > cases should it be handled by userspace?
> > > The mmc framework tries to recover a failed block request
> > > (mmc_blk_mq_rw_recovery) which may end up in a HW reset of the card.
> > > Would it be an idea to act in a similar way when an ioctl times out?
> >
> > Maybe, it's a good idea to allow the similar reset for ioctls as we do
> > for regular I/O requests. My concern with this though, is that we
> > might allow user space to trigger a HW resets a bit too easily - and
> > that could damage the card.
> >
> > Did you consider this?
> >
>
> Yes, that is a valid point, and that is why the power cycle is only tried
> once. But the conditon for this reset is a -ETIMEDOUT, and this is the pa=
rt of
> this patch where I am myself not sure of if it is enough to check for. Wo=
uld
> this be an error that you could expect to happen with ioctl requests in o=
ther
> situations also, but not necessarily cause by a stalled card?

Exactly.

Many different commands can get pushed down to the card through the
mmc ioctl interface. It's difficult to know what error path we should
pick, other than reporting and propagating the error codes.

[...]

Kind regards
Uffe
