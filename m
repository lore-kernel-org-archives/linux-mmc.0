Return-Path: <SRS0=S1FC=Z6=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6695DC2D0C0
	for <linux-mmc@archiver.kernel.org>; Sun,  8 Dec 2019 23:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A660206E0
	for <linux-mmc@archiver.kernel.org>; Sun,  8 Dec 2019 23:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jaP0lKZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLHX4p (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 8 Dec 2019 18:56:45 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37072 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfLHX4p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Dec 2019 18:56:45 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so9242928lfc.4
        for <linux-mmc@vger.kernel.org>; Sun, 08 Dec 2019 15:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G98iQ4Xz1596icAZ7mOyKIsOKgGjMdou0zMqC7TfbVs=;
        b=jaP0lKZzSBuq07uSKcJFRDfXUKQo0AVQBIHNFxx6la3qlyWukiqyuu2b6k7WWBtXiv
         qLv7E+qDTwIVVCnnG6ulWj81HpEdvl7f293zntRt7i5Ot0JCQVBmVT1L+6Q33vFuaVBq
         yHdGD6CSTwhkz5aCKq7TnyjRx9DqfNsgs++asIuoRnh64zevQ0vN+s7EMipU+pV1KnGT
         XdU9fQHfPDYviHFTnT7Z5lxfyOFRgoa6ZqUVeT39nXcwX6cZbc+roGLBIYzexWndx1mI
         dHMyfjt7nJD6xm8zGieTR0RFmq9RaKBFGVmtasmpup6ApzmcKv/a2ZDrEFW14AlUWc76
         0Crg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G98iQ4Xz1596icAZ7mOyKIsOKgGjMdou0zMqC7TfbVs=;
        b=DWf2YEGNgwbqLEBWhmb9nKnNDgfGXd0y8MVIrhgF5N7uDxd6MGLBs+AUF7FD/tG1gk
         v0kmlVYobvFzXyfI7KAisOyMoQVXI6niNZKrGPdwBQ1i7ch8PvUwujLwL6DdpC5c62bf
         ldhnC3sEpyMPIe2RnvR7czGiu8tRptcKXccIWGpfzQzpRB8bmDsIqAlydBjiBspVkRqF
         69lIpfvmQQ76IrcYTXGHf2ZbWzZJ0AJE6IgVqJMe9MdfXOVU1aspZOolM87pOi6FhsG2
         h/tbY6ccS5NdyoAe6LB2gwTQSCy8XzPs4w0NR+MuQ7mfK5VZSY+MHnLB7qg21qnE53Oc
         pDLA==
X-Gm-Message-State: APjAAAWV+r8UuzLNFREGnz6nixO0YMQj436cMHUQiTRcBM6Ma38g0v0Q
        a2SJjfueAj229mK2ktBurGugWFQZeR9z0KK+LEUneg==
X-Google-Smtp-Source: APXvYqzVoNkq9pkmph0v2+xPiSjUlmLk/6GbSB0ueTQeLYHC7/MGvlWBMQmYVy24nsYfZn2LZ0YjErbZUliuhlouYrE=
X-Received: by 2002:a19:c648:: with SMTP id w69mr9095069lff.44.1575849403347;
 Sun, 08 Dec 2019 15:56:43 -0800 (PST)
MIME-Version: 1.0
References: <20191206170821.29711-1-ulf.hansson@linaro.org> <20191206170821.29711-9-ulf.hansson@linaro.org>
In-Reply-To: <20191206170821.29711-9-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Dec 2019 00:56:31 +0100
Message-ID: <CACRpkdZAUH9+f6zS1sxVSLDdUnynEhbB7XqBETzcM2S122kwtA@mail.gmail.com>
Subject: Re: [PATCH 8/9] mmc: jz4740: Convert to pinctrl_select_default_state()
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Dec 6, 2019 at 6:08 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> Let's move away from using pinctrl_pm_select_default_state() as it's
> scheduled for removal and use pinctrl_select_default_state() instead.
>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
