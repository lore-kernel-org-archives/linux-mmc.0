Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8BFC433E6
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 14:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7959F64EEC
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 14:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhCDOIT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 09:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbhCDOIM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Mar 2021 09:08:12 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9832C061574
        for <linux-mmc@vger.kernel.org>; Thu,  4 Mar 2021 06:07:31 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id t15so9283875ual.6
        for <linux-mmc@vger.kernel.org>; Thu, 04 Mar 2021 06:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9dTkEDAWuipSwEUEz6FUWxAZBayw5+HD87LY50xpX7E=;
        b=n7WG4bsvdGds89CSDqh7alsOK4tO2O6WdIVFrvKschtHWXCulKHfmabgoQTUqHZwdj
         CbLSQUEi5VqtNp9TeB00YVeml+W2pQer42tO8VPu4xHfmz0ZZoSKX1ksA0utLlR8o2xt
         ejSJkDkp0SabO6ZPNo8hRWBlPvWk2w0RqtYEtO0IBRcsLbLnV8u/YnT7w2kot12eM2aS
         2L3Y+8/3YVznVYanQRK69AZK6/r0QDFJNjz2+iNOZnFbJhky/wZh8nf/CI9LNmbEXR7C
         xFvE6ID7acgHDeX5L4L4VkLvaBhptgRXbEIhBewl0dliCtXn3psFmux/alD0rcdssRKt
         9sJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9dTkEDAWuipSwEUEz6FUWxAZBayw5+HD87LY50xpX7E=;
        b=H0/9AkVdhhOpqfQwkY3wzuNHUOQUl5uYk60LrRIe6zL17F7UNDIDv+0jXBa+xmGoNY
         dwClDvLFEJxxEog8a1zKCGfz+Hqb8DR8qTkFCgV2CjvG5Undt6qO2FeD+94IJhI5bc2T
         +i0Kxq/HbRfkCXtDeorsdBRs9/Pc3SG+tpE+kpBt+lChqRVezQOhDq4mLqC4KPJ6ZM9a
         9s0eif7AxHoKclykiMnccUyqkUYLAWjszP01J44Il0Iw1i1cSf4mY2/0v5SqzBbusC/d
         w0O4CBUBfR2kuxRCJwA2JjNJ1ZReqnVM1hleZ+lzHafhE/7EAKdjnBAtu6Gp2w6ZXKP+
         eDzg==
X-Gm-Message-State: AOAM532CDj4UCETo3yo4+wHk0N5RWjaVO5AjmQGKt5V2jVADHtk5G9EJ
        /yWNfHslHO+vgvYOISGuHl8I0jB+7FTqDjmuGonOzg==
X-Google-Smtp-Source: ABdhPJwK19dXZ6vaYcFXhCp6tF7d+VYkikOlrtYmzgvLCNoBqDo76kYh1DilPZxUZWHeFyejjvMv8zkkPpS4I6C5HIM=
X-Received: by 2002:ab0:1581:: with SMTP id i1mr2245315uae.15.1614866851042;
 Thu, 04 Mar 2021 06:07:31 -0800 (PST)
MIME-Version: 1.0
References: <20210216224252.22187-1-marten.lindahl@axis.com>
 <CAPDyKFoASx=U8b1Oqtuo6ikiM=gXfL2x1Gsz=rfAn9zxP0y_iA@mail.gmail.com>
 <20210301215923.6jfg6mg5ntorttan@axis.com> <CAPDyKFoaKfuwweaEMf1Pz+ECAPU3P9-gmCJcpq+MADH5gH1c=Q@mail.gmail.com>
 <20210304134836.xlw7wbbvkc5bqzmm@axis.com>
In-Reply-To: <20210304134836.xlw7wbbvkc5bqzmm@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Mar 2021 15:06:54 +0100
Message-ID: <CAPDyKFous2oDwcUgPkZV8bZzpd+yA8m9LwC3+yk0uxqWcrJx1w@mail.gmail.com>
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

On Thu, 4 Mar 2021 at 14:48, Marten Lindahl <martenli@axis.com> wrote:
>
> Hi Ulf! My apologies for the delay.
>
> On Tue, Mar 02, 2021 at 09:45:02AM +0100, Ulf Hansson wrote:
> > On Mon, 1 Mar 2021 at 22:59, Marten Lindahl <martenli@axis.com> wrote:
> > >
> > > Hi Ulf!
> > >
> > > Thank you for your comments!
> > >
> > > On Mon, Mar 01, 2021 at 09:50:56AM +0100, Ulf Hansson wrote:
> > > > + Adrian
> > > >
> > > > On Tue, 16 Feb 2021 at 23:43, M=C3=A5rten Lindahl <marten.lindahl@a=
xis.com> wrote:
> > > > >
> > > > > Sometimes SD cards that has been run for a long time enters a sta=
te
> > > > > where it cannot by itself be recovered, but needs a power cycle t=
o be
> > > > > operational again. Card status analysis has indicated that the ca=
rd can
> > > > > end up in a state where all external commands are ignored by the =
card
> > > > > since it is halted by data timeouts.
> > > > >
> > > > > If the card has been heavily used for a long time it can be weare=
d out,
> > > > > and should typically be replaced. But on some tests, it shows tha=
t the
> > > > > card can still be functional after a power cycle, but as it requi=
res an
> > > > > operator to do it, the card can remain in a non-operational state=
 for a
> > > > > long time until the problem has been observed by the operator.
> > > > >
> > > > > This patch adds function to power cycle the card in case it does =
not
> > > > > respond to a command, and then resend the command if the power cy=
cle
> > > > > was successful. This procedure will be tested 1 time before givin=
g up,
> > > > > and resuming host operation as normal.
> > > >
> > > > I assume the context above is all about the ioctl interface?
> > > >
> > >
> > > Yes, that's correct. The problem we have seen is triggered by ioctls.
> > >
> > > > So, when the card enters this non functional state, have you tried
> > > > just reading a block through the regular I/O interface. Does it
> > > > trigger a power cycle of the card - and then makes it functional
> > > > again?
> > > >
> > >
> > > Yes, we have tried that, and it does trigger a power cycle, making th=
e card
> > > operational again. But as it requires an operator to trigger it, I th=
ought
> > > it might be something that could be automated here. At least once.
> >
> > Not sure what you mean by operator here? In the end it's a userspace
> > program running and I assume it can deal with error paths. :-)
> >
> > In any case, I understand your point.
> >
>
> Yes, we have a userspace program. So if the userspace program will try to
> restore the card in a situation such as the one we are trying to solve
> here, how shall it perform it? Is it expected that a ioctl CMD0 request
> should be enough, or is there any other support for a userspace program t=
o
> reset the card?

Correct, there is no way for userspace to reset cards through an ioctl.

>
> If it falls on a ioctl command to reset the card, how do we handle the ca=
se
> where the ioctl times out anyway? Or is the only way for a userspace prog=
ram
> to restore the card, to make a block transfer that fails?

Yes, that is what I was thinking. According to the use case you have
described, this should be possible for you to implement as a part of
your userspace program, no?

[...]

Kind regards
Uffe
