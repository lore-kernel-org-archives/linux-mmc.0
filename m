Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F49C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Apr 2022 22:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355810AbiDZWrj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Apr 2022 18:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355823AbiDZWrb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2022 18:47:31 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C162A187469
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 15:44:21 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bq30so142019lfb.3
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 15:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXOC4nDMiIs3BeNgSghO3FPGiSBBxD4qpt6pgqjnGUI=;
        b=jvpS8bvU9PLdLoEDuJacmDvv9VyAl3CUbIROrGU2Neuq8zRwG8M5IRUZ8GpaWUYRF3
         qhcjUPsT4JgE/tDIampjBsPkgiT/Kt0kkrxjQlHrn2YvPGqHQ9oo+FhaH3uZbT5PtRfD
         PchXV7r3Ezh9tHTkfb4wpODQwTX8Xvcmgp54iiCJJ4eVOkdGEKlJHFj9V6A2YI+8Cc+6
         CIQkwwxw3eRE88dImmGGj4d4uB1xoAk7GC7NLdRzk8v9kun7rLZUaoHVRMI8DT3pIs3d
         ruO5t1/ZTNLWbQZ9XY8VRIGpwIguOuPPqFVuhgyxo+hgzTdc1eVV3TcGTt3UNAUZSHJF
         Gpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXOC4nDMiIs3BeNgSghO3FPGiSBBxD4qpt6pgqjnGUI=;
        b=p0hRebnyJk3Pr3Lcyj1GI+3zUcYHIkjZ+SJQ/b9KC0S5sATosQQ9KF+/vY5Hn+93cH
         HPB7Ps64MBBX4ttkBhkB3nvpL9LpdD5D8j9v7R1fGAkBtgyI/jPvuWC3YqfDiAkfYCps
         y4Nebl/maodT1LWHC08eVJlL/dzkLC+LBKa9PRX1ELcZ7aEDOGZg5qnXWTeuvbsrC0X+
         T0l90fL/yafElJtVkRLoMdE7Bw+3uJf3bHp9ah1rxVy2iNqBq2dcjxZATZM9CUNf+JDY
         2Z85yvmMNrVYhSs3yyyl045TZJ28h1u3AFOGDjMpoScbSzwZ8/hNoz+TN+UwzIOYsElP
         oX3Q==
X-Gm-Message-State: AOAM530AZ+OYFywWYBiDQ8MyTFIxAC2/BXUEdyVy9fJolB1IMyIdCrMO
        TOYl2aHxyY7fuGP+3xJh8yOmgGZqLG+oj/1xezGEXw==
X-Google-Smtp-Source: ABdhPJxeSl4Wwg6V6lU3GZfaobtTNr9O89vfLZomCPWfsjbhq4M5MMUvz7K0JQVLxm60gHak7PYn2eXZ+lRcOrqapQk=
X-Received: by 2002:a05:6512:301:b0:471:ecd0:ea24 with SMTP id
 t1-20020a056512030100b00471ecd0ea24mr15273491lfp.71.1651013060082; Tue, 26
 Apr 2022 15:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220424090422.97070-1-wanjiabing@vivo.com> <CAPDyKFreW44ou8O4R53XUf7iZTGBBMM+1jmrOeh9cyEOTU-r1Q@mail.gmail.com>
 <YmgKa4xQ+pOd2xfh@myhostname>
In-Reply-To: <YmgKa4xQ+pOd2xfh@myhostname>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Apr 2022 00:43:42 +0200
Message-ID: <CAPDyKFp38EKC88wGZyYm3agvY9zC2M6-qAgMqmOHne0kkDAhCg@mail.gmail.com>
Subject: Re: [PATCH] mmc: atmel-mci: simplify if-if to if-else
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 Apr 2022 at 17:06, Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> On Tue, Apr 26, 2022 at 03:53:09PM +0200, Ulf Hansson wrote:
> > On Sun, 24 Apr 2022 at 11:04, Wan Jiabing <wanjiabing@vivo.com> wrote:
> > >
> > > Use if and else instead of if(A) and if (!A).
> > >
> > > Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> > > ---
> > >  drivers/mmc/host/atmel-mci.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> > > index 807177c953f3..98893ccad4bd 100644
> > > --- a/drivers/mmc/host/atmel-mci.c
> > > +++ b/drivers/mmc/host/atmel-mci.c
> > > @@ -1125,8 +1125,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct mmc_data *data)
> > >         chan = host->dma.chan;
> > >         if (chan)
> > >                 host->data_chan = chan;
> > > -
> > > -       if (!chan)
> > > +       else
> > >                 return -ENODEV;
> >
> > To make a slightly better improvement of the code, I suggest we add an
> > early bail out point in the atmci_prepare_data_dma() function. Like
> > below:
> >
> > if (!host->dma.chan)
> >      return -ENODEV;
> >
> > [...]
> >
> > Kind regards
> > Uffe
>
> OK
>
> How about this new patch?

Please post a new version in plain text, not as an attachment.

Kind regards
Uffe
