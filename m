Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE6CEB64D8
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jun 2023 21:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjFUVNO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jun 2023 17:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjFUVNN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jun 2023 17:13:13 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5281713
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jun 2023 14:13:12 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b2f0a140b7so5873639a34.3
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jun 2023 14:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687381991; x=1689973991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bj31qV4w7FTwbNCG+FmKSWTcgCNp/w3XrGa8kwvnp3s=;
        b=WbqhAPyjDPYCaO3m8RmY2Zup7Rf5lIalkwpClqt3TyV8PD4QNK/SgcoZqo6G8mdasQ
         1a+1imZ4SsuqMYrpVnPmydQAw4KiaNiEuP8HE87PsFFfUHUrPEyTSv/zAHqmwdk1yzaB
         6SR8HqveP2OjFboXt06zCpAsfe2VtuOLpOSeP4YfMzbE+9Q1ayCLngCU6LorK5OTHlDb
         YbHipeg+QDkvd18P4xp7YaI7bT7khqfrQATv5imG0+mN7qElUKk4uxKr0ZvTdxA6XEtw
         4uhZiK/VgMWwzKuGVXPnrKfVZYG3DbiyEfedcQr4HDiAIqa0CSYNGNJoTURyMjMFB3ub
         5Dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687381991; x=1689973991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bj31qV4w7FTwbNCG+FmKSWTcgCNp/w3XrGa8kwvnp3s=;
        b=flB0+zBetn1/0uo8Ea4MeDatQBSb69MpLr3Uh8mseLvzAMO3Iw7DB9S0hIK5EK5E1/
         qDhNIPzQlqn+GSS5P/rqunDBvw/E8k1Oo71xzYhBZtpCrz3h1owgUWg6SU2TFpk2zgmy
         MdB+FW0TN1APuTODTY8wDgMUdNP1ZRBXLM6kCaeRgaf8tPKqXLgOS/q8EXUwCLvgCBAC
         5ugpvjP0NdwUBOpYr87AtvbsJajHKv/iUprY8s3O7UBLCdRQPOqqxkfaDlJXa2zfPFDJ
         kdxKFd6yMJ/6PEs08ED7MM3npn3RSGkmCEKkCzp60aW7z2l3gSE5JMKNKHDxj6vyuEp3
         cfTQ==
X-Gm-Message-State: AC+VfDxJ/7X47iKV+XvBNZdwR1/443Yv/JyNjMGfiZifpC7g5ZPwg/M5
        2LNlp7ZP2XXixR/HgI9gpS9jiScHU5FjuLlf1DYHeVHggzKsP0IS
X-Google-Smtp-Source: ACHHUZ4N/aUw7MGVaBsUNWWJdgJaZwsFELSGs8Very4NSpYnlQAw6rRm1cbnixIrGRWKxCZEKxQ6/bOvVLUckSwTC5A=
X-Received: by 2002:a05:6358:c102:b0:132:8351:84b8 with SMTP id
 fh2-20020a056358c10200b00132835184b8mr1295862rwb.14.1687381991460; Wed, 21
 Jun 2023 14:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230620091113.33393-1-ulf.hansson@linaro.org>
 <CACRpkdZfhPxFZhjiU9k5fjM9v9VOuZwu16eyn_qHL4Jm+CyhBg@mail.gmail.com>
 <CAPDyKFqXu9R=+281Ovt=ZR6VHYAv96LEvP+DgaZo2aHJB8_dgw@mail.gmail.com> <CAPDyKFrwBWrdMmwqJeTothwmLFiPmZy0+CreZu5cUMKpxiuXjQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrwBWrdMmwqJeTothwmLFiPmZy0+CreZu5cUMKpxiuXjQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 21 Jun 2023 23:12:59 +0200
Message-ID: <CACRpkdYMjwnBv9kGxMcUpx0-Ogpc6E2jcqBaZbwj195c5mtUxQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Add support for SW busy-end timeouts
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marex@denx.de>,
        Yann Gautier <yann.gautier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jun 21, 2023 at 2:33=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:

> > More importantly, the busy timeout work never gets to run, which
> > indicates that we are no longer hanging and waiting for an IRQ to be
> > raised. Is that correct?
>
> Ehh, I should have looked more closely at the log. Indeed there is one
> case where the timeout work kicks in.

Yeah...

It wasn't until I added the timeout that I could get the whole
thing to work, both are needed: handling lost IRQs and then
an occasional timeout.

> Maybe we should log the information about the current ->busy_state at
> that point too, so understand under what condition we are hanging? I
> think we should also log the actual used timeout in this case.

Sure thing, please merge this patch as-is (solves a problem!) and I try
to make a debug improvement patch on top with what I have (like
printing the command) and add in the busy state as well.

Yours,
Linus Walleij
