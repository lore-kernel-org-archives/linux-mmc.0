Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5020C433DB
	for <linux-mmc@archiver.kernel.org>; Sun, 24 Jan 2021 22:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A113B22581
	for <linux-mmc@archiver.kernel.org>; Sun, 24 Jan 2021 22:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbhAXWwj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 24 Jan 2021 17:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbhAXWwi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Jan 2021 17:52:38 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD53C061573
        for <linux-mmc@vger.kernel.org>; Sun, 24 Jan 2021 14:51:57 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a25so11954927ljn.0
        for <linux-mmc@vger.kernel.org>; Sun, 24 Jan 2021 14:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4HuGZS3FXmpI/CZ9WRJi1GTxY4eR6JlbnQlmIWJDvhs=;
        b=NUPplP+vwWcGNZku67kF6v0Zc3+oX52TgC4UVnC9NbzphbJ7yOo3lZgx0NHXvAzi4/
         xnRCAIHE0ruAJ8HvkZDbaiyl/5VEQFlcXHUyUOg5W0tXmw8xRR/9ZGxYRibTCKQd2Em3
         JGzKjFrj8IqxAGlyzt9x8qfsWUU1NwCPVqpRz2nhXoRxd+1G7sHECm9fdWqcPoKOiUDE
         xoPn9xr3ZkalTIBSogHq2aR3gkTcYeyYoFzZivXKeIY/XR4ENYkwdlJ7WamTamtbwtXi
         hTYSsVxmsDFQD9NO4GyfrEW+6KtsLs3TFca+J5YdXQ+PCtX8ME9+98DFYwf/wy+DY0Rd
         Gc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HuGZS3FXmpI/CZ9WRJi1GTxY4eR6JlbnQlmIWJDvhs=;
        b=R37BBGAzrei2wrGj+AI/5ts1DtbrbGXOATnjtPOa/933RqIEAK7MPWTpBD/RsPdFWI
         0Anatw84xFK7p+x+GBXKF5YYI1IdM3KXjfwSxDRsp/hAdWkwJQ1XjPF5sISI/zx1OqQJ
         FdmGF44lGyiq277c7eyW/HfnpIWaE/9zqHVjjK7d5uoVFtxunuLmOhprzvPmj7TaKrsx
         NZRYalGipFfs1yDfonkwiDFritEaOehWepPzJX9UjvQtv9cemWxdwFd13ZrgevULbMur
         jNyfAbZfnaZkxAQO7hfB5Khd36JkqxC0RK+WVYSZWfDjDh2Z6zO16ZGqOVObR/jpHMxx
         4W8w==
X-Gm-Message-State: AOAM5323WARdrgSZu7N/VIKliP7xXd3wfNNqU0s5lK2YN3wPIw3DUpZy
        89qNuAtCC84HEkTGlodOasz0ZwSkHJNlB4vCNLCSdw==
X-Google-Smtp-Source: ABdhPJxQyfKzJabalN+bedwoS7NGWpYLLpd54boyq2sKBZ7lVn6U5490067UEc04d3r+vv3OMoYA394NyqYfuciT6KQ=
X-Received: by 2002:a2e:9ec3:: with SMTP id h3mr120887ljk.200.1611528716487;
 Sun, 24 Jan 2021 14:51:56 -0800 (PST)
MIME-Version: 1.0
References: <20210124170258.32862-1-marex@denx.de>
In-Reply-To: <20210124170258.32862-1-marex@denx.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 24 Jan 2021 23:51:45 +0100
Message-ID: <CACRpkdaLN_Q9rmMnuVhB8wuZJzMMzqdc+O54WOKfc4a2bgnUwQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] mmc: mmci: Add bindings to operate CMD, CK, CKIN
 pins as GPIO
To:     Marek Vasut <marex@denx.de>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Jan 24, 2021 at 6:03 PM Marek Vasut <marex@denx.de> wrote:

> Add DT bindings to describe GPIO line associated with CMD, CK, CKIN pins.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: devicetree@vger.kernel.org
> ---
> V2: Rebase on next-20210122

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I would probably add an example as well, but that can be
done separately and isn't super-important.

Yours,
Linus Walleij
