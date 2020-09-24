Return-Path: <SRS0=/Wn+=DB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FA6C2D0E2
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 12:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32E6C21D24
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 12:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yu4vRTmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgIXMuX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Sep 2020 08:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgIXMuR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Sep 2020 08:50:17 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2ABC0613CE
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 05:50:17 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id p24so2030319vsf.8
        for <linux-mmc@vger.kernel.org>; Thu, 24 Sep 2020 05:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Y5Ppu2JDn7zFg6xlFdfb3UOtdIGvgOWwdbFNFP5tnu4=;
        b=Yu4vRTmG1jPlvfBDq79ZztbfRzbktyevZvLxIv0IM9L73mP3E4NsCKzbmzBWTek5st
         llYkBsH1PM3JmDesX9U9ClzIQMCxSe9buzQUJ8SURPVXa4oXjnFUw93ptWB1GazF3YhD
         zuvSdgBi+4pjuGTDumHwUg48PwgKuobB27ASMnulPfjLWO/dCZD7WcuXbLkGq8E3pZ0A
         ylmJIpkAljVF2FJmzMlgUlTniJE+lY7hsZ8JtQWsKaksNkOuM6lhlmzx+EEeNjn54AT0
         FSNm8tJPeZPOBhcpixv9caVIJ8V7jsuBp1aCpcnrUBycRTVjE6tYMNU532zKdYNTtlbu
         mXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Y5Ppu2JDn7zFg6xlFdfb3UOtdIGvgOWwdbFNFP5tnu4=;
        b=ZWMac6KBkXIEQ062kbpubvUwtSiTkSzFD0ZwhzjjLRabAG2UAAQ26ST602g6G7oT+J
         hdCDHQQKvVk8BKnEG5iMb+OsjtNPQpT+u7NI5qKynp0DwzAVUKUxdyIGYZ6QEwUEEZTl
         XPeShF2N1fAQYDYwo5FhEF+V/+yKb2BivqLzD9ia5/HjrKclIJF8q6zEWBDqAHLaGbC+
         1kWPzV7c0HH1pbss4cLy5gOeHgIK07Akx53zeOF4Hlccb3h68F87f4opgIWb7TJ++7/7
         vDkm/Fsti1joCAPIb4BzfPhL6yLYylvzhZlL5tTr4LG9FTllBGhCM3/06ld4owbqMoeV
         GQ+w==
X-Gm-Message-State: AOAM531nZlDV4YE2oReqvtozFEyUO8XHKGWUvkd084CFuY5AkpU4PqrQ
        Ze55GmA0NPQ/h00r0sxiK8ycHqLlNHbwyDsW3uwjQWTRVEpFHg==
X-Google-Smtp-Source: ABdhPJy5nlulxWuM+Jo+bmpJ8LIGX/KrKnkL/IfjnXTnHwt9FSCQfeiQ0rEV2vyyC4xSOL1iFQBJ5klwacfan+B8gmg=
X-Received: by 2002:a67:d011:: with SMTP id r17mr3791446vsi.48.1600951816895;
 Thu, 24 Sep 2020 05:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200916090121.2350-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFoUw=xkPbCORSJ2io7Gs34dbbXQaGXdTsuzUqd+WEdR=A@mail.gmail.com> <20200918214759.GA65185@kunai>
In-Reply-To: <20200918214759.GA65185@kunai>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Sep 2020 14:49:38 +0200
Message-ID: <CAPDyKFqaA3rdFMYSfmuDB39mtY-bcwUUBfE_OHrOvbibWL6KgQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: document mmc_hw_reset
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 18 Sep 2020 at 23:48, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Wed, Sep 16, 2020 at 11:47:10AM +0200, Ulf Hansson wrote:
> > On Wed, 16 Sep 2020 at 11:01, Wolfram Sang
> > <wsa+renesas@sang-engineering.com> wrote:
> > >
> > > Add documentation for mmc_hw_reset to make sure the intended use case is
> > > clear.
> > >
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > ---
> > >
> > > While working on this, I get the feeling this function should be renamed
> > > to 'mmc_card_reset' or something similar. 'hw' is still confusing
> > > because it could easily be the host controller, too. I volunteer to
> > > prepare a patch if we can agree on a better name.
> >
> > You have a point. Although we also have mmc_sw_reset().
>
> Ah, I didn't know that. Though, mmc_card_{hw|sw}_reset() sounds still
> way better to me.

I fully agree.

>
> > Another thing that I would like to change is to make both of these
> > functions take a struct mmc_card* as in-parameter, rather than the
> > current struct mmc_host*.
> >
> > Not sure that it would completely solve the confusion, but at least it
> > would be a little more clear.
>
> Maybe if we do both, it will be really clear? :)

Makes perfect sense to me.

>
> > > +/**
> > > + * mmc_hw_reset - reset the card
> > > + * @host: MMC host to which the card is attached
> > > + *
> > > + * Reset the remote card. This function is only for upper layers, like the
> >
> > Perhaps make it clear that it's a full (or hw) reset, not just a reset
> > (as it could also be a soft reset). Moreover, I think you can skip
> > "remote".
>
> OK, will send V2 in a minute.
>

I have applied that one. Let's deal with potential additional
improvements on top.

Kind regards
Uffe
