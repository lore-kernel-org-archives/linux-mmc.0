Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B319EB64DB
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jun 2023 19:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjFNTW7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjFNTW5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2023 15:22:57 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A625C2689
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 12:22:35 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bc43a73ab22so58771276.0
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686770555; x=1689362555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTgKJ0Xv9os7bie+kMAyra/nI6Vl0QY0hlCtc8nBPq8=;
        b=K7vEPf6d0ix+0wowHhaHisBWY3Jqwdp9PP6WOxGUmgDk1EudFVEHJsWl7Ba28deDKh
         CFhzzTs8bd2qMiaMIzTuS4fNDW0xoCuhitbO/HUhnE2rZUfbx8ZpiRB4R3qPt9I3mK76
         RKVM1ivyZ2whSAHOEnPVEUoLzCj3kOefZcS/tURikdMccszC37XXrbL/slm6ggW4sU7j
         i8mOT0NoGT7mu0YAdy24wyCamPzhYXqZjfQuyYVe3XArSvqoM3OGql2s2b0bU89tzOUq
         tsD20WSVQ613+J6F8VsXPI3wmf08qUdiN2GqGsoKzYU0zSnN6uS2Ws/2f+dw8qJCcBmE
         O9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770555; x=1689362555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTgKJ0Xv9os7bie+kMAyra/nI6Vl0QY0hlCtc8nBPq8=;
        b=HuAJQtcrrLqgTMxYj/Y3hnGbVl567oCW1y1QT8BuHM/nuzX2ed0vhRtdc2qFoIDTYF
         hXiN4R85SETWIh4Kmbfd0eWzv7nCIVhGOPf2P1Yalde+PRjir1kPNY7FwLsqx8KMhp3L
         AKwPuHyuhCxGhrQ/vvnMIEXuuKpqG60opSXhNue6yb9CLmciKuwO5xjtz3nClf65NJB2
         BR225shpA4uTTXC5oBTkT0KK2GKZO8Scc8pVhhXD788fphtZiSN5+0whOJxlVscPcK5L
         I6RdCbgiaVTwGAITQOrYOOueSRxY0t4vDhrH8hjDhDcBmH8x8pLZx3bcFPIqKnp9QqCW
         mCUQ==
X-Gm-Message-State: AC+VfDxmg+ZPJtFsSevfc4C9uG0wFx/d4P/qXth7dC1/5Lq7pNeosBR9
        ZUwuT+uMKJl1tNRWlduoLVeYthyD4XOKCBYnFgGlVw==
X-Google-Smtp-Source: ACHHUZ6tXpnORUqaDomrOU8lA/2e9S3QjHVo/NzRv+Gx8ZqDefS1gZN1tL/jTFpsxhGG3vM6fTc4HCZz9zhsbaA8pIM=
X-Received: by 2002:a25:2d10:0:b0:bab:8be5:697d with SMTP id
 t16-20020a252d10000000b00bab8be5697dmr2830570ybt.32.1686770554779; Wed, 14
 Jun 2023 12:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org>
 <20230405-pl180-busydetect-fix-v3-10-cd3d5925ae64@linaro.org>
 <CAPDyKFqxvNxFqLdpj15Gz+zDNT04YzxEAh-svKvRuaM52dCV3g@mail.gmail.com>
 <CACRpkdbg5UXnU=WcQa2HoGH54UK-C8+vU8t+7iLChvd__iJiMg@mail.gmail.com>
 <CAPDyKFoMNPHs3td-UBnqDdEK4i7aHybWfsba796BEXPQC-bzUQ@mail.gmail.com>
 <CACRpkdbYNn0S7AXn_sbPb+o8L_DcffKat=tR0mLtNiBhgy7UEg@mail.gmail.com> <CAPDyKFqZsQ+wHdh1FYZwBxiar=9SeobiucaTVhPyQzHgAq-CWQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqZsQ+wHdh1FYZwBxiar=9SeobiucaTVhPyQzHgAq-CWQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Jun 2023 21:22:23 +0200
Message-ID: <CACRpkdYKif6LhLWEoid3vhuDmuSdR6eW9B=ZdGLtNnAzUb9W2w@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] mmc: mmci: Add busydetect timeout
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

On Wed, Jun 14, 2023 at 2:22=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> On Wed, 14 Jun 2023 at 13:17, Linus Walleij <linus.walleij@linaro.org> wr=
ote:
> >
> > On Wed, Jun 14, 2023 at 12:05=E2=80=AFPM Ulf Hansson <ulf.hansson@linar=
o.org> wrote:
> >
> > > However, we use the spin_lock to protect some members in the struct
> > > mmci_host. In this case, the mmci_cmd_irq() is using "host->cmd" to
> > > understand whether there is an active command to manage. When the
> > > command has been completed, we set host->cmd to NULL.
> >
> > Hm right...
> >
> > I'm leaning toward some catch-all like:
> >
> > if (!host->cmd)
> >   state =3D MMCI_BUSY_DONE;
> >
> > as if there is no command going on then surely nothing is busy on the
> > host controller.
>
> Right, so at what point do you want to add this check?

I have put it before the calls to the busy_complete() callback, in the
IRQ, where we are already in atomic context. If we are not processing
a command, we should not do any busy detection for sure.

Yours,
Linus Walleij
