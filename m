Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ACAEB64D7
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 20:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjFMUdK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFMUdC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 16:33:02 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7421FC8
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:32:55 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-bd729434fa0so383869276.1
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 13:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686688375; x=1689280375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvJUa63SYtpqln5w0oMr9sRT2OZaa51HeQdSCgfliM0=;
        b=ahUth5LJeQaubKUs26hW0k3imv9oTxzJURnn2OsEM8iaQhJzPzGNwBYsNzpjTXXavT
         P+0P8W/1a8sABIoBxuK0jSyuHrxmjNABaJ+VwgtLJTJpluK8p5iq1MSaPUIIgTi2Tkg2
         HOUkRiXc5tcU6fze3UCaO9E9iaVmk7LyGePmJLppFzJqlOPWu9sW6IvhiYbDRCLt92Ay
         Xy7dcwigL99F+6BC+mFBY0yeUXcaUbXZ91CfPlbBTM1SxK7m8FVyqgaGvqylcHkUjJeO
         Llp+nInmtJeKBTju/jdf2nEQwgNQFgYgjqluFcjKqa0kN2h/34OSH892Y00H+tz07sXH
         RB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688375; x=1689280375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvJUa63SYtpqln5w0oMr9sRT2OZaa51HeQdSCgfliM0=;
        b=OpZUwJdQrCGFzZft+0eKsWiL0mAiC/1+TXgm8MGhJVmc/EPSxLcFqX9/d/5mau6fSx
         GVUry0+/HjabDyhWkETNEzkst5P0y9mwU4ZJRBwRmXZPfiEgca6H9WXTwD5SpH1SaqIe
         FFO+rr9bP8x1peBRvMUyhxLOhxTB8GQPJBWWbXqWQODmIAN6IihOlmGrCF1AGdAmkcyk
         sE9PvXvJ+7T+H2CwM+QUFqLVQ2edPeW8CLLGglWPU5vx7sVvrgBmfv6wLywriY5pU78x
         m4B++0u8H7OSwa4GeotkRspf7NEksxOn5Z7dzASAiOsvdVc9gQQbTJOmHG8QBUQdnf1X
         dnZw==
X-Gm-Message-State: AC+VfDzhqU2EYs50EmSQ2SmFHqJ1aGTUd95hWVDylpWvY8FxUPI8hObp
        glIzKmqCeb2IfiCw0wNCd8fITbTDxlJDwjYG+6BPHw==
X-Google-Smtp-Source: ACHHUZ4Q0zl75kxgo29sxb7h3KaImD0S7jPsix+2MlhAl2bVKHBTEAWt8S40lqMUM8ZoqbDP+nyyA+qYJtQErDEhFc4=
X-Received: by 2002:a25:b096:0:b0:bac:69be:9494 with SMTP id
 f22-20020a25b096000000b00bac69be9494mr266028ybj.36.1686688375119; Tue, 13 Jun
 2023 13:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org>
 <20230405-pl180-busydetect-fix-v3-10-cd3d5925ae64@linaro.org> <CAPDyKFqxvNxFqLdpj15Gz+zDNT04YzxEAh-svKvRuaM52dCV3g@mail.gmail.com>
In-Reply-To: <CAPDyKFqxvNxFqLdpj15Gz+zDNT04YzxEAh-svKvRuaM52dCV3g@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Jun 2023 22:32:43 +0200
Message-ID: <CACRpkdbg5UXnU=WcQa2HoGH54UK-C8+vU8t+7iLChvd__iJiMg@mail.gmail.com>
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

On Tue, Jun 13, 2023 at 2:08=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:

> Typically, the cmd->busy_timeout contains the current value of the
> timeout that should be used for the commands that have the flags
> MMC_RSP_BUSY set for it.
>
> The stm variant already uses cmd->busy_timeout, but also assigns a
> default timeout, just to make sure if the core has failed to set
> cmd->busy_timeout (it shouldn't but who knows).

I generalized the STM32 solution with the core-specified timeout
and default and used that.

If we know the core will always provide correct timeouts we should
probably delete hacks like this though (but that would be a separate
patch).

> > +static void busy_timeout_work(struct work_struct *work)
> > +{
> > +       struct mmci_host *host =3D
> > +               container_of(work, struct mmci_host, busy_timeout_work.=
work);
> > +       u32 status;
> > +
> > +       dev_dbg(mmc_dev(host->mmc), "timeout waiting for busy IRQ\n");
> > +       status =3D readl(host->base + MMCISTATUS);
> > +       mmci_cmd_irq(host, host->cmd, status);
>
> There's no locking here. I assume that's because we call
> cancel_delayed_work_sync() from an atomic context and we don't want
> that to hang.
>
> However, can't the call to mmci_cmd_irq() race with a proper irq being
> managed in parallel?

It will not be a problem AFAIC: the MMCI is using level IRQs, meaning it
will handle all flags that are set for command or data IRQs before exiting
the IRQ handler, the order of the IRQ handling if several fire at the same
time is actually dependent on the order the IRQ flags are checked in the
code.

When the interrupt handler exits, all IRQs should be handled and the
respective IRQ lines and thus the IRQ from the MMCI should be
de-asserted.

In this case, our problem is that an interrupt is not fired at all, but if
the actual IRQ (that should have been fired) or a totally different IRQ
(such as an error) is fired at the same time doesn't matter: the pending
IRQs will be handled, and if the timer then fires an additional IRQ
the IRQ handler will check if there are any IRQs to handle and then
conclude there isn't and then just return.

At least the way I read it.

I made a v4, sending it out so you can check!

Yours,
Linus Walleij
