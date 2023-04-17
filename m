Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E542EC77B76
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Apr 2023 15:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjDQPrt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Apr 2023 11:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjDQPrs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Apr 2023 11:47:48 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FB61BD
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 08:47:47 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54f21cdfadbso371360657b3.7
        for <linux-mmc@vger.kernel.org>; Mon, 17 Apr 2023 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681746466; x=1684338466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQlIri97TmZMXUVRTtsm2+SywZpxFoXWBikPobx0N+0=;
        b=ihY84tfAWitQmk4iYcuvCGxmy/54iD05VS9oIH9KrWeafpu605HY0OU8cnANkZ8Erk
         jpHU15o1JV1lWjKoxybXKVzmmRF3uhkGFnb/PaOGtFOl3GozpOGU/NHblqAGvEpalRwe
         reIoNNwh5OhKe85xkfaykWJe35uFaN5/q7hx9lgrqbPQMStHBLrRlSIgNQKr+m+4gEWW
         BKKcyX8tlXaHzxMKBngP6IreSK8Jb1lrdXWjpzveI/2eaZeRJMkcL0IgZb3psb3bj+rW
         Ebq47k8EL7Gg3ZnZXhWTXjeBeY+m300Uc5P4o8bUu0kFCLL/TFJjZDivN67jcVtwGFd2
         iWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681746466; x=1684338466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQlIri97TmZMXUVRTtsm2+SywZpxFoXWBikPobx0N+0=;
        b=N7uk/ySmt2RtDy8UXXX+ugh8nL7dnKj1MuHGghQJz1NG46pjIJ6dlXerqsBNuyAuJC
         O3pVFEIFfOUE0m3kFxSSqVoqQTKQcdA6Lxb1lsM0+hSYovdPoO+VH+DXM87nD1y7vxOg
         f6+OT+uXtbLg9B2dhI6bqUq/+UxGfXl+6E79ef3z1nyAudQUzmhf5VX2PtMBvRUok9J/
         uaI7WQFlVpply8A4h+1lUxEodSUyPyaboror1ERRYxqldb++MHvbHuTF6CLGAX9sdJUs
         5ULZW4jhfcMekIt5hUwSss6m3kusolNfykv7EBmjmK8neAvpzhq3+sRl+aAkqno/82Qs
         iZWw==
X-Gm-Message-State: AAQBX9dN4RxqWtF1EmhzKExr0i7BCNMKax2ksCX8Oc2lrSYSWc0db+3L
        Of0od3bdVSRtXPn58MJdYLEG96NAUNm8FJWWkKWLFabaWREvW+yK
X-Google-Smtp-Source: AKy350aTVotgdcfBmt/5SDUUs9b0di/T+TJuBST3fq8A+cUEB2XtX6flIyURAsDgZUz1CEda+DIkA6EYmuXh49Es3mk=
X-Received: by 2002:a81:af0c:0:b0:54f:bb71:c7b3 with SMTP id
 n12-20020a81af0c000000b0054fbb71c7b3mr9543515ywh.9.1681746466321; Mon, 17 Apr
 2023 08:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v2-0-eeb10323b546@linaro.org>
 <20230405-pl180-busydetect-fix-v2-10-eeb10323b546@linaro.org> <CAPDyKFptLGySEz3ygoacQ00rk69DKP=1wrt1Hq-weSMASwkF7w@mail.gmail.com>
In-Reply-To: <CAPDyKFptLGySEz3ygoacQ00rk69DKP=1wrt1Hq-weSMASwkF7w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Apr 2023 17:47:35 +0200
Message-ID: <CACRpkdazpoEfFZhjUNQ5=jc-EndxteVCLDQaTHT02Gob036uTQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] mmc: mmci: mmci_card_busy() from state machine
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Apr 17, 2023 at 4:49=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> On Sun, 9 Apr 2023 at 00:00, Linus Walleij <linus.walleij@linaro.org> wro=
te:
> >
> > If we have a .busy_complete() callback, then check if
> > the state machine triggered from the busy detect interrupts
> > is busy: then we are certainly busy.
> >
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v1->v2:
> > - Do this in a safer way that falls back to reading busy
> >   status from the hardware if the state machine is NOT
> >   busy.
> > ---
> >  drivers/mmc/host/mmci.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> > index 9a7f441ec9d6..180a7b719347 100644
> > --- a/drivers/mmc/host/mmci.c
> > +++ b/drivers/mmc/host/mmci.c
> > @@ -339,6 +339,12 @@ static int mmci_card_busy(struct mmc_host *mmc)
> >         unsigned long flags;
> >         int busy =3D 0;
> >
> > +       /* If we are waiting for IRQs we are certainly busy */
> > +       if (host->ops->busy_complete &&
> > +           host->busy_state !=3D MMCI_BUSY_IDLE &&
> > +           host->busy_state !=3D MMCI_BUSY_DONE)
> > +               return 1;
>
> This looks fishy to me.
>
> If this is needed, that means that the mmc core is calling the
> ->card_busy() ops in the middle of a request that has not been
> completed yet. This shouldn't happen - unless I am misunderstanding
> some part of the internal new state machine.

You're probably right about that, I have no idea when the core can
and cannot call ->card_busy, I just assumed it could be called at
any time (even while waiting for busy interrupts). If you say it won't
get called then this patch isn't needed.

Yours,
Linus Walleij
