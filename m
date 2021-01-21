Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E87C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 21:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D00A722BEF
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Jan 2021 21:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbhAUVGt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Jan 2021 16:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbhAUVFt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jan 2021 16:05:49 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CAEC061756
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jan 2021 13:05:09 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o10so4500027lfl.13
        for <linux-mmc@vger.kernel.org>; Thu, 21 Jan 2021 13:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZugsqJA8Q1yl6+4pzBVXRUwd28mrT2JYS1TJy5ykuI=;
        b=YZQNwK9UXQfz9pmNXG+BE9nTpQ1H3yg4Pm0NyVdfyCJei4NEyQk3cPtrjgVYXMsUVo
         sZmVCS33nXSZejVP6BWBFLZXnNgos5V6rjdEdEzEkx6XbE6+o7WAf+f9naTYJoA9sIqZ
         jM3zvaGq1f/rOnmDRHR0AExrBbzYlB18dk1u2tFKI+2MN1z5PsxKySH6pMKxWPrb0dsL
         wbtdnXQB0hj0KJYIJ3YljQs5SsvotZfi09SpNVapVNC/jiZaWXtVepOOM8+dQGOPT8DD
         v3kE6Efrsaail7nvexEiC/amqISp1CrHMjyCzwINhNxPNrBfixtDh8sl5KCkoPZI5N9C
         3IHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZugsqJA8Q1yl6+4pzBVXRUwd28mrT2JYS1TJy5ykuI=;
        b=gjlhU7ugPiHlFuyrsl0s61fEofz2Vn9uOdB2YPoSfledaFJvhJvSnjEPNbsjnE6jRV
         gtNQIfIqNmQlGOvDle6cVbJ869ZikJDxK1/sI3BZOda1SDssaKuUUGZdhUtiJascjH7a
         FZW1qJeudkhgD9IcULaGCcHaUaQo2m6P1p58/g14fQ6QSn0XQjenSk3jazb6RrvhkbTF
         LOEczAGrtggv0adVrJg5510dP9ihV5vgiRxVShbHXhVN4Ut7vHAZIH1zRlqvdLhw5J/6
         GSMtkDBzEWE3JqHsyAct/AWnXsakLa1GZWXAeWBne/6BR/mA0J5rmHqI6M5j9GXYPc+i
         /9vw==
X-Gm-Message-State: AOAM531wWUtMfgqxR/TzIwCWXl483sAktn/uBUo3xkRKB2T0lVr1+3J7
        JF0P9CTvkaolN+NlofY00e0bFX39rOtkBHvwgX7E5Q==
X-Google-Smtp-Source: ABdhPJympICjXFgiTKputbVjOoWvR0HAhO3o4V0dJu/d9HzUmXivyzv2TH8oXsJx6QgTxw4WQsKRjZ9LH75RgC5N3yg=
X-Received: by 2002:ac2:5597:: with SMTP id v23mr487223lfg.649.1611263107527;
 Thu, 21 Jan 2021 13:05:07 -0800 (PST)
MIME-Version: 1.0
References: <20210116180424.57331-1-marex@denx.de> <20210116180424.57331-2-marex@denx.de>
In-Reply-To: <20210116180424.57331-2-marex@denx.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 21 Jan 2021 22:04:56 +0100
Message-ID: <CACRpkdapEtphavg5zWgu=2trYg8LYMd31roHzfebsiyWFBn=uw@mail.gmail.com>
Subject: Re: [PATCH 2/4] mmc: mmci: Add support for probing bus voltage level translator
To:     Marek Vasut <marex@denx.de>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, Jan 16, 2021 at 7:04 PM Marek Vasut <marex@denx.de> wrote:

> Add support for testing whether bus voltage level translator is present
> and operational. This is useful on systems where the bus voltage level
> translator is optional, as the translator can be auto-detected by the
> driver and the feedback clock functionality can be disabled if it is
> not present.
>
> This requires additional pinmux state, "init", where the CMD, CK, CKIN
> lines are not configured, so they can be claimed as GPIOs early on in
> probe(). The translator test sets CMD high to avoid interfering with a
> card, and then verifies whether signal set on CK is detected on CKIN.
> If the signal is detected, translator is present, otherwise the CKIN
> feedback clock are disabled.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-stm32@st-md-mailman.stormreply.com

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
