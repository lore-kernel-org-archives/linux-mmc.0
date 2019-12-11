Return-Path: <SRS0=rVnL=2B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8746C43603
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Dec 2019 00:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE80A2073D
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Dec 2019 00:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DzWEDMV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfLKAkH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 19:40:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40081 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfLKAkH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 19:40:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id s22so21957824ljs.7
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2019 16:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+6mwPhn94U0FJCp8N/iLCGyoYPPPkFesQi/ZLGlNabg=;
        b=DzWEDMV6zFCN5CPxuB98wPU/lUNXV9fCtKG8vCaJDjqrBnuzhjUaeFZ1+la3wXQNbZ
         8/1piJtHwCYSk/iJH2vOcrQprWHzccO/cVI8fc6j9HT3nMHYJPMp50W2ZbayjxlZafpm
         OEJRafmYkmHflbQUtOlcyMahRvYz91/Hf3goXN6Zz+WIFvhQesbfOgF9knBF8WlES3+4
         fSxUmiSMjXRfs+mEUZbI+ocT2kGtWBHBQ/Q7pfc/glkE9HXO7uVV1HvthjvSH71AzryA
         0t0LBbJSLwDUNu6noDycU/vAunTwuYiBsh7EDK/8nri5y9zn1jgRN8DduJjuRD3zSQA6
         fmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+6mwPhn94U0FJCp8N/iLCGyoYPPPkFesQi/ZLGlNabg=;
        b=QNeqQSUDZu3jffbKsqZPbtK2yMZG3VH85fTP2ICdcOtH65roJI97wewLdoLryNYwuX
         PrSJ5kde81nJkM6xg8Uk3QplirCEzWjGubPhKiNklKtB5onubxRl7Gz0mPW8wTrbEwTi
         DC7+NpaSw0sIvA0ljltGiLb0vd4WTG9Oh66qRCYI9bHzSNCVf4faLC1c70XXmfo5Drwa
         8d6BNYo4xdS3OApcLGywuTBBMNu6Y5c/pEogi6bS6VPSL7idMPVVi4jxZxQc2/W2a3+1
         Z5POkUPonlyESc9NxtTRPBUc7AhdqbXlvwPyn6ZxLaBug53GQL7aSbZWSog7vYueJs2G
         GpMg==
X-Gm-Message-State: APjAAAXUhXvakXBZK1VdPo0pcip5WsJiE1n1k5USlv3UmWlqsdavX2YB
        9sZKD4JtIuX4vf5vTGodEJ9uVs4xzH9a936bc7phiw==
X-Google-Smtp-Source: APXvYqz+5hSx8AyIO68PLEgCzJXxNiyGKQgrsukDLUqC8J76DV8xgyxi+ERIJqysr1OXhO0gL6QnXeuXk3A1jZ6O+EM=
X-Received: by 2002:a2e:b4f6:: with SMTP id s22mr93491ljm.218.1576024805657;
 Tue, 10 Dec 2019 16:40:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575925023.git.mirq-linux@rere.qmqm.pl> <56d2568cd45a13c738e2804d04348566a8ee8d03.1575925023.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <56d2568cd45a13c738e2804d04348566a8ee8d03.1575925023.git.mirq-linux@rere.qmqm.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Dec 2019 01:39:54 +0100
Message-ID: <CACRpkdZ0mk2dWBnWh+mRmBy2t-ALONtvv23Hr-2o8LD8CPYtgg@mail.gmail.com>
Subject: Re: [PATCH 1/4] gpio: add gpiod_toggle_active_low()
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Dec 9, 2019 at 10:09 PM Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.=
qmqm.pl> wrote:

> Add possibility to toggle active-low flag of a gpio descriptor. This is
> useful for compatibility code, where defaults are inverted vs DT gpio
> flags or the active-low flag is taken from elsewhere.
>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Proliferating APIs isn't good but I think this is the lesser evil
given the mess there is in the MMC subsystem for this stuff.

Maybe I can make a second attempt to move all polarity
toggling back to gpiolib-of.c and remove the API after this
has landed, hehe ;)

Yours,
Linus Walleij
