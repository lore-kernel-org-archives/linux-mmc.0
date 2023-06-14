Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A88EEB64DB
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jun 2023 12:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244287AbjFNMWU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Jun 2023 08:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244505AbjFNMWT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2023 08:22:19 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D8C1FE3
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 05:22:17 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-bcd0226607bso855117276.1
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2023 05:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686745336; x=1689337336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHdjEjrtCdpZyiizDN/ie3cwcnch5LfPuYdQaiOTIAg=;
        b=LVRQnZcEgWtK2LpBkWBxcXb4bX2U29PkGGS8cZBMZoQZl22CXGMiJ+SJ0HAyDNR7Cy
         v4Koqh4BFBPybWr4fFnnlWAWlYKcu6De6V3HPN8zVc9Soll60+bh8CM0C+GR1gAQKUJv
         JAfkwT6qycr64w9HO5PCcBdV5MmkAQi7C+AjaodJJ67oz5FTSyXRMV1VmQ4943wTV5FZ
         dAnr/C7jMRLVIyZIjeHRLTM2+xoX64YV9kV24OJDJOMCFXiE3F67cOjHHkFbt+BycFz2
         eLQrP+MYS+kfpwXUVMd7rCI74E57dhsH4hGGHsFSfsYmZtqv8YtOBA9omzloEAg1Y7el
         jmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686745336; x=1689337336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CHdjEjrtCdpZyiizDN/ie3cwcnch5LfPuYdQaiOTIAg=;
        b=OTXzstIGYLju35YKuumxL+WSDwTnxaDZTYkIhWI08wC+BG+hWyBMrBzjfioYosUJVv
         XgS0U+5ssILJP+nA9r7hWfMCm4JK2tRJqb8KG00QvO5udbYLWOrLUspP3V+mhnNM9QZj
         hShBHPF5JEm74kVFS10XJleuh4LsjJFO/I2MmUjVRfS7kmh59zWTt8grrcXglWa4pbdQ
         +9v80zDUW/YJqMjjtL0SMbOQN21M5fVNccN+h8zPxG9FpvB/8sq9tmuXbQIw1Yfp6Dlv
         Vw7Gb1tktMbUuUKEcGorvkQkr20NwHCqB6jnJXE9xvwCufwFfVdgEWF9hS1Yf12nMxXY
         C+8g==
X-Gm-Message-State: AC+VfDw9/A+uu/wU1FYPS/cbTJx1VvYkAV0dunNs0Gg3uHozSI60bISf
        Bd05yodPLgnU3Xenm1RRTKJC+GzvJhv1dNEFOoHrPQ==
X-Google-Smtp-Source: ACHHUZ7agZuy3/Y1zHNX0/AKRTma1MumQbVPRJCI/cQ4hMsuAx0VjmuLvI3ZIVmGS0lRTBMrgi87SYklphIen6Pzfsk=
X-Received: by 2002:a25:2d10:0:b0:bab:8be5:697d with SMTP id
 t16-20020a252d10000000b00bab8be5697dmr1535020ybt.32.1686745336679; Wed, 14
 Jun 2023 05:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org>
 <20230405-pl180-busydetect-fix-v3-10-cd3d5925ae64@linaro.org>
 <CAPDyKFqxvNxFqLdpj15Gz+zDNT04YzxEAh-svKvRuaM52dCV3g@mail.gmail.com>
 <CACRpkdbg5UXnU=WcQa2HoGH54UK-C8+vU8t+7iLChvd__iJiMg@mail.gmail.com>
 <CAPDyKFoMNPHs3td-UBnqDdEK4i7aHybWfsba796BEXPQC-bzUQ@mail.gmail.com> <CACRpkdbYNn0S7AXn_sbPb+o8L_DcffKat=tR0mLtNiBhgy7UEg@mail.gmail.com>
In-Reply-To: <CACRpkdbYNn0S7AXn_sbPb+o8L_DcffKat=tR0mLtNiBhgy7UEg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Jun 2023 14:21:40 +0200
Message-ID: <CAPDyKFqZsQ+wHdh1FYZwBxiar=9SeobiucaTVhPyQzHgAq-CWQ@mail.gmail.com>
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

On Wed, 14 Jun 2023 at 13:17, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Wed, Jun 14, 2023 at 12:05=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.=
org> wrote:
>
> > However, we use the spin_lock to protect some members in the struct
> > mmci_host. In this case, the mmci_cmd_irq() is using "host->cmd" to
> > understand whether there is an active command to manage. When the
> > command has been completed, we set host->cmd to NULL.
>
> Hm right...
>
> I'm leaning toward some catch-all like:
>
> if (!host->cmd)
>   state =3D MMCI_BUSY_DONE;
>
> as if there is no command going on then surely nothing is busy on the
> host controller.

Right, so at what point do you want to add this check?

Kind regards
Uffe
