Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A680C63793
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 10:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BAB46109F
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 10:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhGVJ4L (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Jul 2021 05:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbhGVJ4K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Jul 2021 05:56:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDCFC061575;
        Thu, 22 Jul 2021 03:36:44 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id y3so3970946plp.4;
        Thu, 22 Jul 2021 03:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J+CJm7w5RtYQkCsp0Qp6X/Re0wsgac5NK3ZDCttrjqo=;
        b=YRilbTuyLbp7M19OwW9DR5Z5cQ4qixCtje3vuhQ5WTPRlhc+wyJGrc3SsJvhgiSC+m
         VzF5y0+eCAE3Tm1/7c9kD0UQqHo4zwtSfAxEHsNZo5qHkR6Thw+tYzMDQZpQRpPJ6m+e
         L11H/zuwi4xGu9SBxWQZGq6UDmW3bnEGI0T4g9GOhJCXzMlMUk7UYCgqeoo57qCs6sJz
         PIupVDWDJmVoluxEN+5VMVcUfxSo5xvPC0awdbN+tMaVlfjTYuGEsiBhrSFCcOZuA88k
         YXQygClGCl+HT08VdG9sCYGY9evmdcQiz10woDQVKludvmQUXWq2gs+9P7+7kcaOoU7s
         Yi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J+CJm7w5RtYQkCsp0Qp6X/Re0wsgac5NK3ZDCttrjqo=;
        b=E3HUiQ8tdQvtd8v52vNfX+dcvvis29ac9BH4DxUN3TqZEq1d06Arp6G8iXI/5XfEpO
         Iao7BQO48YQJjzf+MZzroZ6haETsbeLlv9dIaSLW7j5GK3poh9weqhZjUjNojAgDsmAL
         yFLpZIsEtaHIXlZzxz2EcB0OKUABgmt9A0sgcyNhiwe502NoaRmwSrd2OXxgZX9lsGVq
         HSKOPucfGAOg6oYPqDkFLqnoKwEHWlawmpuHFw6g7gMin7expjE7yrjM3vv1o7C5yYZy
         h7oj8R+qXpkFdeyo5EZFYb/iad9e0vzF8c7O6ONdZr7ZYd/C4i6qtA1ag+sbTXJ7LB3V
         iE8A==
X-Gm-Message-State: AOAM530txF8RYgzaRJNYyJNxte0qWZd2nO7qYnU886FA8vppYk3osn1k
        IhQ7zzySi5Udasizg736KJVZW6ML9ut7EYVXdiY=
X-Google-Smtp-Source: ABdhPJxdlZNIa/0ALQiPRqOaAjE8Ng7pPoMRxsNR2cvET40h66FY3fV+POJ9kyMpUSKp6FtD33kK1dYY2/8vw9rX9ys=
X-Received: by 2002:a17:90b:1194:: with SMTP id gk20mr8357672pjb.181.1626950204461;
 Thu, 22 Jul 2021 03:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <mvmtukn6bmu.fsf@suse.de> <YPgwHcbK7XoXL/mD@smile.fi.intel.com>
 <mvmpmvb68cg.fsf@suse.de> <YPg3VS/Ure6VRsuJ@smile.fi.intel.com>
 <mvmlf5z66l9.fsf@suse.de> <CAHp75VeFKn=--PuF6deOp6H-j7z8PXgkXA5PeSftiK5LWX30Qw@mail.gmail.com>
 <mvmh7gn649v.fsf@suse.de> <YPhT1APE8QweDCoP@smile.fi.intel.com>
 <mvmczra64yj.fsf@suse.de> <CAHp75VfY-_xtRJyfez_4voDuOUcfJAfFjtnAipCt2_UA4wqbQg@mail.gmail.com>
In-Reply-To: <CAHp75VfY-_xtRJyfez_4voDuOUcfJAfFjtnAipCt2_UA4wqbQg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 22 Jul 2021 13:36:04 +0300
Message-ID: <CAHp75VdUYVrHdhjZSi6stCF5kz2KadbiefWLsYgVy4Wm3QfJHQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_spi: add spi:mmc-spi-slot alias
To:     Andreas Schwab <schwab@suse.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jul 22, 2021 at 1:28 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Jul 22, 2021 at 1:03 PM Andreas Schwab <schwab@suse.de> wrote:
> > On Jul 21 2021, Andy Shevchenko wrote:
> >
> > > Or problem is somewhere else?
> >
> > I don't know.  Why does the spi subsystem put "spi:mmc-spi-slot" into
> > the modalias file, instead of "of:N(null)T(null)Cmmc-spi-slot" or
> > similar?  The same problem exists with the other spi port on the board,
> > which has a jedec,spi-nor instance attached, also not auto loading.
>
> You see, there are two unrelated drivers that share the same issue
> (the common denominator is that they are SPI devices). I believe the
> issue is somewhere in the SPI core rather than here.
>
> Compare the code of
> https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L649
> vs.
> https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L56
>
> and
>
> https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L139
> vs.
> https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L361


> The culprit is this one:
> https://lore.kernel.org/lkml/20190618052644.32446-1-bjorn.andersson@linaro.org/
>
> and in my humble opinion must be reverted.

Oops, I have been too fast. It's not related to SPI in general, sorry
guys. But the idea you have got from above, I believe.



-- 
With Best Regards,
Andy Shevchenko
