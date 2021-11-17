Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99B4C433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 09:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DBE7619E5
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 09:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbhKQJj6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbhKQJj5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Nov 2021 04:39:57 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4068EC061570
        for <linux-mmc@vger.kernel.org>; Wed, 17 Nov 2021 01:36:59 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 13so4774795ljj.11
        for <linux-mmc@vger.kernel.org>; Wed, 17 Nov 2021 01:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OzDGWpE8Xkh6MkfGrduT5RxR6FF+JkpXqd6pdp832EI=;
        b=qZ1X4IeqaalMpioV74hHQpqMiyqd4d2toccPhHW+I4Yu9tn5VMhUfRo55awifbY5h9
         PP5wQ2z6heTzgrmM6bb2sumAQ/FFvubvbBt2XeNa5wxBLMO9UY2Q8clDp7LQOEyRIDCw
         qR5UAjl32dB1ddrWmGqbOxaVSyW4+9lRW1aJrJxefkYSITz5d64KBWOPoa7AbHkoizLG
         SPl+JMP1fPWjulRg6G1OU4Bxk6GxEGMa9HDIb8nveiJilKVOH8oWuf0y0zGritUz5RtL
         JOjvee6Jv6fn6CUxU1GVGEZShLcEWTb4keYE4m3Y0NhUUwugxXwcvpacHRGrEkoB/wpT
         zEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OzDGWpE8Xkh6MkfGrduT5RxR6FF+JkpXqd6pdp832EI=;
        b=T7A+BACEmP57lGHGZGyI639N8ezNqGBSi3SBmIH7HXgk/RW/abq/2DEDgbgKAsjvkG
         kI7TmY9dYvkNp5zDyyqCclK74+XmTkUFdCXNwWHoGKnPVG7GdJ36X66Zb+dl8qVAX/da
         ic61YfobwbQEzT9quZGlDi9/14YGE+SXxtKIw6iM3TcYV388K4e/Q8ktxUQzo3tEAmJl
         wVmxswIfthx26b6H3Dk60w1RO4PPqy4w280I3QUVGYyxm4wo6Q9uHnVt+4FO5HtGD/G+
         KLQegpiwS+1Go2ByuqttgvuaaAcYXJaYGkMYK5+YiXrmiVVHXUkdHppEViKb7+Mlv3Io
         9goQ==
X-Gm-Message-State: AOAM533+dr3kmlQ9cosP+RliojKEBg4kwcu5yLGoPBsJ6xLdCoZ/7D2v
        9SOU4pQeo5Bzd6y7TEBUv0qdXunzsJxHAmYlOCnTXQ==
X-Google-Smtp-Source: ABdhPJyu8uzQotpkSKmSCF418T4vjD98z7xjQQXYuvyv3DlPStOFCtploEjHMofLR/wxuFacd4QfwYs5OYj/KE7LDsc=
X-Received: by 2002:a2e:a22a:: with SMTP id i10mr6466687ljm.16.1637141817265;
 Wed, 17 Nov 2021 01:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20211110110500.4105-1-marten.lindahl@axis.com>
 <CAPDyKFpKbKEePYyb1fQ_cxjtJS6JuF1qFKh2KKfXpM23nvkH+g@mail.gmail.com> <20211116165949.GA32249@axis.com>
In-Reply-To: <20211116165949.GA32249@axis.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 17 Nov 2021 10:36:21 +0100
Message-ID: <CAPDyKFrDfUEg0rHS2VVYbMLUaL-oOFFPU9V+A=W1m5S6sYTGBQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: dw_mmc: Allow lower TMOUT value than maximum
To:     Marten Lindahl <martenli@axis.com>
Cc:     =?UTF-8?Q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Doug Anderson <dianders@google.com>, kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 16 Nov 2021 at 17:59, Marten Lindahl <martenli@axis.com> wrote:
>
> On Mon, Nov 15, 2021 at 03:54:19PM +0100, Ulf Hansson wrote:
> > On Wed, 10 Nov 2021 at 12:05, M=C3=A5rten Lindahl <marten.lindahl@axis.=
com> wrote:
> > >
> > > The TMOUT register is always set with a full value for every transfer=
,
> > > which (with a 200MHz clock) will give a full DRTO of ~84 milliseconds=
.
> > > Since the software dto_timer acts as a backup in cases when this time=
out
> > > is not long enough, it is normally not a problem. But setting a full
> > > value makes it impossible to test shorter timeouts, when for example
> > > testing data read times on different SD cards.
> > >
> > > Add a function to set any value smaller than the maximum of 0xFFFFFF.
> > >
> > > Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
> >
> > Applied for next, thanks!
> >
> > Kind regards
> > Uffe
> >
>
> Hi Ulf!
>
> During tests on some units I found that there is a potential overflow
> of the 32bit divider in this patch (if clk_div > 4).
>
> Is it possible to stop this patch, until I created a new version of it?
> I guess it's better to update this patch, in favour of sending a new
> correction patch for it?

I have dropped the patch from my next branch. Please send a v4.

[...]

Kind regards
Uffe
