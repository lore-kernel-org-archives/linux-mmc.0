Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C252C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 12:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E6FC23877
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 12:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbhANMFm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 07:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbhANMFm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2021 07:05:42 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7B5C061575
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jan 2021 04:04:56 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id x4so2933363vsp.7
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jan 2021 04:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4x4x0Nj/wFI+6ARDdl2ZQ+A+ovOi+cuPXqwiIPE/44Y=;
        b=R4mJdpV5kJb1NFzjfvZQaR6tfJvyA1KrRUPNmt2lFi1jCHsBMRrdXU8rPgBu0hMEG7
         yHC3zbGL6UAOt3zP+MrKxxQa+5lLLM079aTkfGMXVmK7O7A65aSHmjJSehodbi08XXrg
         ZravXhe6OfF0a8brBmI/yajLml5Gdet5gJOIWbjAXFDbbPlJZKG+UUBvisjxhojteDdS
         9YJ3RWNw6OoFDd5lKS/VBmrpTTJa8xeqFgC8kel0XdOMwLyQSJGE3Q/mJ8JV8LlukjMR
         AUbatloFhZF2Lne6BgkbrEnjTMTupQtCHhDwYt7+KRwDdqsNIy6Fy9W+vP1MEGIP5rdw
         VuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4x4x0Nj/wFI+6ARDdl2ZQ+A+ovOi+cuPXqwiIPE/44Y=;
        b=La/smhRpUfG+swh2iZG7odaStUF4lH/+JU4MKzN4hlca4ybj12NA6N8isF8nn2Zy2m
         6RkacFmxkw1ta0FyCLWUirATA/ZBWs+tgCLE0X13r6ymfQWMKNaPKFozDD1gFkJbZb57
         ah+2o31nP8BUNxrJ17Yf5ZY88DrvN9YCjuAyzmyiiEBX6XUz15OiQPmQUMN2FkQjgRW6
         umyUoC58CJR3+QQtLu/0Rs68lWPlWPZxOORIKOdCeFOuhB/N8SeQ3kXtJe160o6DSVMf
         Q6H7OXSOsJt1WMTol/5lfYbb2xPfQfzkoGfrheAd4icvin5gqYZNNmQ9rduSXbMR1AVx
         IxsQ==
X-Gm-Message-State: AOAM533oEsIYOOx/pFWOPe2LXpWFpkhzcE9fXa1swLyZxH7Ls3G7SaXh
        5sKGk2LNjaNe3bUf6G0p+8d3Z3n+29mYOmk06tVeOQ==
X-Google-Smtp-Source: ABdhPJwN81B6Ybxy6tJeN4J0+qAqhWeQYoNE/uS0CwfiQYk0pXzqtEnkx86Kr69cCDzQ19v1Yuy0u8gdMHYkmsdX7dg=
X-Received: by 2002:a05:6102:2127:: with SMTP id f7mr6025568vsg.48.1610625895461;
 Thu, 14 Jan 2021 04:04:55 -0800 (PST)
MIME-Version: 1.0
References: <20210106092740.5808-1-reniuschengl@gmail.com> <CAPDyKFq1EVVfU4HU_=-7TmSRinkTCA41pKWtrMD4C+yCUPYECg@mail.gmail.com>
 <CAJU4x8uKHQy_hbMhsErzWb2U5USjMRhAZv=+14a9zDn068vHmw@mail.gmail.com>
In-Reply-To: <CAJU4x8uKHQy_hbMhsErzWb2U5USjMRhAZv=+14a9zDn068vHmw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Jan 2021 13:04:19 +0100
Message-ID: <CAPDyKFrgHgkxFjG5X6v6jx6LYAwx4m5pGROrVY2a42wTPeTKiQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Enlarge ASPM L1 entry delay of GL9763E
To:     =?UTF-8?B?6Zmz5bu65a6P?= <reniuschengl@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 14 Jan 2021 at 07:25, =E9=99=B3=E5=BB=BA=E5=AE=8F <reniuschengl@gma=
il.com> wrote:
>
> > Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=881=
3=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:53=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >
> > On Wed, 6 Jan 2021 at 10:27, Renius Chen <reniuschengl@gmail.com> wrote=
:
> > >
> > > The R/W performance of GL9763E is low with some platforms, which
> > > support ASPM mechanism, due to entering L1 state very frequently
> > > in R/W process. Enlarge its ASPM L1 entry delay to improve the
> > > R/W performance of GL9763E.
> >
> > What do you mean by frequently? In between a burst of request or
> > during a burst of request?
>
> GL9763E enters ASPM L1 state after a very short idle in default, even
> during a burst of request.

Okay, then it certainly makes sense to extend the idle period.

Would you mind extending the commit message with some of this
information, as I think it's useful.

>
> > I am thinking that this could have an effect on energy instead, but I
> > guess it's not always straightforward to decide what's most important.
> >
> > Anyway, what does it mean when you change to use 0x3FF? Are you
> > increasing the idle period? Then for how long?
>
> Yes, we considered that having high performance is more important than
> saving power during a burst of request.
> So we increased the idle period for 260us, by setting 0x3FF to the
> ASPM L1 entry delay bits of our vendor-specific register.
> Anyway, GL9763E can still enter ASPM L1 state by a longer idle.

Most mmc controllers that uses runtime PM autosuspend for the same
reasons, uses and idle period time of ~50us. 260us is in the same
ballpark, so I am fine with that, if that works for you.

However, can you please add a comment in the code (and preferably also
to the commit message) that 0x3FF means using a 260us idle period?

[...]

Kind regards
Uffe
