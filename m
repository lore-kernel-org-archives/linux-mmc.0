Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F945EB64DB
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jun 2023 10:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243553AbjFNKF6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Jun 2023 06:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243620AbjFNKFl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2023 06:05:41 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789F41BF9
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 03:05:27 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bc4f89f0f2fso470890276.3
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 03:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686737126; x=1689329126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ae9OtuHFGy8oX3kZN3aX8TWXzvhsHlOVNH6KwSyYBM=;
        b=Us3KLmpNbztLlFCIjBK6FlhIA/8GqQHlxb2CJAzLSQRLPgKDI+kNEqXTXp8Xuj5653
         QZJv3UO+4NuEwpZGrkib9IyooWgmoU/mlyZna2WXaGCcmjg8wEZbzKw4X5XpPICcZuMf
         Suya2xCPWOHXf2HhsicifeUAwPeSJ4oFAQosGda/vbIzPeoXH6edMBZMWN6Qc6119Bn3
         6KDgmUIVNRvg4DQWDLJgLNVkFQjS5Db9O05GcSlvRw6xoMjAcHCgq3BjI3NcVCd1JJud
         FshL4YgjrfGQrAJhGXVfsEl+8OYoOp6zaipUwmTqFjIaUwi64ma1tN/eURV296E0K8ew
         LqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686737126; x=1689329126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Ae9OtuHFGy8oX3kZN3aX8TWXzvhsHlOVNH6KwSyYBM=;
        b=h675XXPM2P/tvIeVat2DyMOLE6yd/0SdfQuqW6TFBFAzWA8WEfoBzhf4DUoFczA18J
         3YFWw7I9XU/S5Sea5vY45/sHUlLo5vCv0Fg/SyzLHyGKt71/T+Hs5IOD9bLPzT1gIS/0
         sqZS6RHAb/ROYDRL4AWRr9RIA4IhVwwM+mAsCylq4YNO+wrh0iCb4a+pPxx8HPkwyY2c
         zTV5ehqT3b1RCb9fPAy9oynoBKp6LvuwD96QHlqQJ2M+6dz25tgZz22qwpzcLok94jRT
         6VjqTli/6flaZE7UVcGLTK43BSDO9ACO16YLW/19Wr8xkHMIBokOD5H4uTytuJh1W+Cg
         6Pgg==
X-Gm-Message-State: AC+VfDxjoTZIN/ZEfdF5jbNo3ShIOTaOKvlD7MefWMRiU4T3PKKsWqDQ
        EHMocGJFZ1N3TPa/SfzAU988qaF2Ag1v94AeHfaczQ==
X-Google-Smtp-Source: ACHHUZ5ad4U15u9oHllT+swudTjsUEgS/M1+l81Mj6ke6PqhJHG8wnH1wdeT3A7kGOBvquZXrkoAPtmpbErc66rd6hQ=
X-Received: by 2002:a25:acd3:0:b0:bcd:3379:11b2 with SMTP id
 x19-20020a25acd3000000b00bcd337911b2mr1443925ybd.52.1686737126656; Wed, 14
 Jun 2023 03:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org>
 <20230405-pl180-busydetect-fix-v3-10-cd3d5925ae64@linaro.org>
 <CAPDyKFqxvNxFqLdpj15Gz+zDNT04YzxEAh-svKvRuaM52dCV3g@mail.gmail.com> <CACRpkdbg5UXnU=WcQa2HoGH54UK-C8+vU8t+7iLChvd__iJiMg@mail.gmail.com>
In-Reply-To: <CACRpkdbg5UXnU=WcQa2HoGH54UK-C8+vU8t+7iLChvd__iJiMg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Jun 2023 12:04:50 +0200
Message-ID: <CAPDyKFoMNPHs3td-UBnqDdEK4i7aHybWfsba796BEXPQC-bzUQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] mmc: mmci: Add busydetect timeout
To:     Linus Walleij <linus.walleij@linaro.org>
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

On Tue, 13 Jun 2023 at 22:32, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Tue, Jun 13, 2023 at 2:08=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
>
> > Typically, the cmd->busy_timeout contains the current value of the
> > timeout that should be used for the commands that have the flags
> > MMC_RSP_BUSY set for it.
> >
> > The stm variant already uses cmd->busy_timeout, but also assigns a
> > default timeout, just to make sure if the core has failed to set
> > cmd->busy_timeout (it shouldn't but who knows).
>
> I generalized the STM32 solution with the core-specified timeout
> and default and used that.
>
> If we know the core will always provide correct timeouts we should
> probably delete hacks like this though (but that would be a separate
> patch).
>
> > > +static void busy_timeout_work(struct work_struct *work)
> > > +{
> > > +       struct mmci_host *host =3D
> > > +               container_of(work, struct mmci_host, busy_timeout_wor=
k.work);
> > > +       u32 status;
> > > +
> > > +       dev_dbg(mmc_dev(host->mmc), "timeout waiting for busy IRQ\n")=
;
> > > +       status =3D readl(host->base + MMCISTATUS);
> > > +       mmci_cmd_irq(host, host->cmd, status);
> >
> > There's no locking here. I assume that's because we call
> > cancel_delayed_work_sync() from an atomic context and we don't want
> > that to hang.
> >
> > However, can't the call to mmci_cmd_irq() race with a proper irq being
> > managed in parallel?
>
> It will not be a problem AFAIC: the MMCI is using level IRQs, meaning it
> will handle all flags that are set for command or data IRQs before exitin=
g
> the IRQ handler, the order of the IRQ handling if several fire at the sam=
e
> time is actually dependent on the order the IRQ flags are checked in the
> code.
>
> When the interrupt handler exits, all IRQs should be handled and the
> respective IRQ lines and thus the IRQ from the MMCI should be
> de-asserted.

Right, I think I follow.

>
> In this case, our problem is that an interrupt is not fired at all, but i=
f
> the actual IRQ (that should have been fired) or a totally different IRQ
> (such as an error) is fired at the same time doesn't matter: the pending
> IRQs will be handled, and if the timer then fires an additional IRQ
> the IRQ handler will check if there are any IRQs to handle and then
> conclude there isn't and then just return.

To clarify, I am not worried about the IRQ handling as such.

However, we use the spin_lock to protect some members in the struct
mmci_host. In this case, the mmci_cmd_irq() is using "host->cmd" to
understand whether there is an active command to manage. When the
command has been completed, we set host->cmd to NULL.

[...]

Kind regards
Uffe
