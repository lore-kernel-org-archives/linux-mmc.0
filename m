Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC71C4332F
	for <linux-mmc@archiver.kernel.org>; Sun,  1 May 2022 21:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355242AbiEAVjI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 1 May 2022 17:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355119AbiEAVjG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 1 May 2022 17:39:06 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247313D4A1
        for <linux-mmc@vger.kernel.org>; Sun,  1 May 2022 14:35:38 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2ec42eae76bso131397197b3.10
        for <linux-mmc@vger.kernel.org>; Sun, 01 May 2022 14:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T254pOQ0OrSDi8zN/59MRP0JPU9NfQ5B5Rmbgtdrkko=;
        b=wlpA+CfyvX91ALnfVCMPP166Rc0Mpatt42DsMvCkWJmeZUVRfB6mnUYecnMGRNYbhI
         ld8YsssomjW9oCtQmr15blAmBLS+t4KouSWHxbIZVjnsq1DnJlp8Fx6XNCVuGUF0GS/N
         6klXRU6dGXOQupaFrwlX9Yah5rEs29v06x/UCbuJ/f0GQoJQPiBvrEccSjVf/VH42K7p
         RwLGlqfP5o3h1uwBR8xQuBvPKaAX5Sq4RHEUwFvP/y5fx9owfyl5p9sMhmOT/ahPJUD6
         7q+tV1u5MOsspWP4YhNR748kjKGgc9lX4NNszXKAVeEM0jxtUxFRG3LYR6gGsd4NYws0
         Yv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T254pOQ0OrSDi8zN/59MRP0JPU9NfQ5B5Rmbgtdrkko=;
        b=1zk+E6Xxfo870o4N/UCJGT2auWEo663bS/BTrElj3JSfXj0IezSwNZNLZRF+vvWc01
         HM5HojTZMaROYYHqym3luQf/IMB9qzmcWpLHP7AgGjwYSv8dY3W4tzJTR77Yt4lAaJvR
         HNt3Nm2MGtzdwzryBfjNbBTe7sxBOJBpGNw97nl3KSqe1w2RQz4dl+dip42mMQWSJNI+
         9kAfD3qGFfh1Lt81hQ39wq0WNDfRL6fswXzM6yjYAoFb9e413RoV9yok2MQ9+cBbtxdI
         myrAW8x3A8BKe9zuHP6NdI/q1hO7+g2tvQn0Xpx1aSElTVNZeOOGDsA0P03aaAlcmAwK
         2hoQ==
X-Gm-Message-State: AOAM533HnywoqX5DWKDa70GWrnTC4sGXKzL+9f8foeYuOBw/DrQgfN7H
        z8/XiOuO6wjraMeMmFyJ6OKS/N24NbYYEpqU9+i/ww==
X-Google-Smtp-Source: ABdhPJyiNIf7FX2G9hbcHdCnWtNprAICIXfmTZ2O7M9XljL3Duwj1WbWX/AgvgI1z1Nmh9oOd4l1d7OyIUiw7QC5qEY=
X-Received: by 2002:a0d:ddc6:0:b0:2f8:a506:a5c0 with SMTP id
 g189-20020a0dddc6000000b002f8a506a5c0mr9543818ywe.140.1651440937377; Sun, 01
 May 2022 14:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220419163810.2118169-18-arnd@kernel.org>
In-Reply-To: <20220419163810.2118169-18-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 1 May 2022 23:35:26 +0200
Message-ID: <CACRpkda10Cv9W07FjO4Ww58V_cgP05Thz-7cv6aF=QC8iW2vDA@mail.gmail.com>
Subject: Re: [PATCH 17/48] ARM: pxa: corgi: use gpio descriptors for audio
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Apr 19, 2022 at 6:41 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The audio driver should not use a hardwired gpio number
> from the header. Change it to use a lookup table.
>
> Acked-by: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
