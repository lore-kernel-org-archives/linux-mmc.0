Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BEAEB64D8
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jun 2023 19:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjFNT3N (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbjFNT3L (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2023 15:29:11 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D6A1FCA
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 12:29:09 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b160f3f384so4493923a34.3
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686770949; x=1689362949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xQSBZnjVZwiGIBU0/Lf+Ki0HJUMiX71/NTUOVFIy1Y=;
        b=ppg6XoTrfWZDyErylcYF2DQzEl9q8X3WUNu3aHZamHu83/gpvfLmXHID3jmDMsuO/y
         tyHgW8eEjDxfspO0qrXImzWTEi1yibUyC604m6Z0mp7LmC5fTqk701cMNkdOmNbqbZ9U
         q5sFxJMY0kt26rAaXNV9uQ9baJhubGAEkbCAHzh4fWWhfmXCYrqUq7nXFvQZmSL0GKuv
         eiYLhH6XWBVuNLewxgQ9LDOuDukp8D+9Jbxo81+5v5nNwyerr9fkYWlzDNhpfPpZ9xT+
         UKnKw+KZpeA3E9y/vzXdRimv/nyAB+WpPJuaAfRH59mYntJr/0POSAAOzVmSa08mN+nL
         oHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686770949; x=1689362949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xQSBZnjVZwiGIBU0/Lf+Ki0HJUMiX71/NTUOVFIy1Y=;
        b=LKSkTwjCoMERgAV18/+Eo0uX3QQkfqqF1I5APxrNuCaP/wcxAhHRsbF1FUz+a6LD0R
         ezTi4rKOrTUOJ2hcicc3TG28r6Wbho+lqmufJbgj79247g0Vf/KZ5kMelsTLglhr22Fm
         TZU/3bnSZJzc23pdNekbmmnPqxsRYZk0dNq9iwDFLEl0qIi/HHS1JSx9GDV+hQDaeQMn
         LY3LVwjc6RfNt1XKF7BG0MhWEs8lao3j3xGorsrIF06FJwd8v0b2i9+WKqD5dPARycET
         9+9VK8k7RQPr2a+Cd00CCGiPq9v33zYBInNMyp8almE/+vKh5PxTw8bxpcEDyIaR2GrT
         vmog==
X-Gm-Message-State: AC+VfDwBHoX/fGo0HgEV52YQFPgxAgzh0qZIHNWlnNXiTgLxKR8FlvSc
        vwz73OO0B6lEu0op/MaIDQp+02mPG5p2fBHinYxIDw==
X-Google-Smtp-Source: ACHHUZ4BVse2Zid0AMkc46SM88xlc+RII83ocsbKNBNxR6RxK3hLxCLK/jVPbbsy2bJiyQhbwMfnqcY7uWiAEpvHq2I=
X-Received: by 2002:a05:6359:229:b0:12e:e48a:7e4f with SMTP id
 ej41-20020a056359022900b0012ee48a7e4fmr3366250rwb.9.1686770949138; Wed, 14
 Jun 2023 12:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org>
 <20230405-pl180-busydetect-fix-v3-10-cd3d5925ae64@linaro.org>
 <CAPDyKFqxvNxFqLdpj15Gz+zDNT04YzxEAh-svKvRuaM52dCV3g@mail.gmail.com>
 <CACRpkdbg5UXnU=WcQa2HoGH54UK-C8+vU8t+7iLChvd__iJiMg@mail.gmail.com>
 <CAPDyKFoMNPHs3td-UBnqDdEK4i7aHybWfsba796BEXPQC-bzUQ@mail.gmail.com>
 <CACRpkdbYNn0S7AXn_sbPb+o8L_DcffKat=tR0mLtNiBhgy7UEg@mail.gmail.com>
 <CAPDyKFqZsQ+wHdh1FYZwBxiar=9SeobiucaTVhPyQzHgAq-CWQ@mail.gmail.com> <CACRpkdYKif6LhLWEoid3vhuDmuSdR6eW9B=ZdGLtNnAzUb9W2w@mail.gmail.com>
In-Reply-To: <CACRpkdYKif6LhLWEoid3vhuDmuSdR6eW9B=ZdGLtNnAzUb9W2w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Jun 2023 21:28:58 +0200
Message-ID: <CACRpkdb_2bndukbO8zfNtWjMKvKX72DLRoJ+7RWYAz+UM3HN4g@mail.gmail.com>
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

On Wed, Jun 14, 2023 at 9:22=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
> On Wed, Jun 14, 2023 at 2:22=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> > On Wed, 14 Jun 2023 at 13:17, Linus Walleij <linus.walleij@linaro.org> =
wrote:
> > >
> > > On Wed, Jun 14, 2023 at 12:05=E2=80=AFPM Ulf Hansson <ulf.hansson@lin=
aro.org> wrote:
> > >
> > > > However, we use the spin_lock to protect some members in the struct
> > > > mmci_host. In this case, the mmci_cmd_irq() is using "host->cmd" to
> > > > understand whether there is an active command to manage. When the
> > > > command has been completed, we set host->cmd to NULL.
> > >
> > > Hm right...
> > >
> > > I'm leaning toward some catch-all like:
> > >
> > > if (!host->cmd)
> > >   state =3D MMCI_BUSY_DONE;
> > >
> > > as if there is no command going on then surely nothing is busy on the
> > > host controller.
> >
> > Right, so at what point do you want to add this check?
>
> I have put it before the calls to the busy_complete() callback, in the
> IRQ, where we are already in atomic context. If we are not processing
> a command, we should not do any busy detection for sure.

No that's wrong. The mmci_cmd_irq() is actually passed the command as
parameter, so I just augment the busy_complete() prototype to pass this
along down, check out the patch (I talk to much).

Yours,
Linus Walleij
