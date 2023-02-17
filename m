Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6615C636D6
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Feb 2023 23:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBQXq4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Feb 2023 18:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBQXqz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2023 18:46:55 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2697664B3D
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 15:46:54 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id fh15-20020a17090b034f00b0023127b2d602so3003980pjb.2
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 15:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676677613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckp4pLuUHkuempvnYbrn9XuKX3oztgaEXvwAfzzvbKY=;
        b=rWGWSdMT5ixaW0iNl8IhrhsuifkVG2oQPpuqB2Eetrood7DpY5O3hTe8+qsucNsr11
         UCr2m1Sm7iSV33/sNfViZVRh1QGM0SlGmlVSekcypOu6X2iwzSK0RiUkTAyCxHutakzb
         ZNFHMeAzuxMeRESMv9EdMvXIpiJXuIGsMayaq2iAVID//4R0tOdLAuq2IrOqg9gGKVqm
         BbbYZZdAtHuaOsGVxkdFuk5s6nY5jWvbns5uG/pcVznnZmBCoAdMiUf9cDPwfYlAzRhk
         QTGnsMphT8kymOGYBnNjK2l1BJ/0o7Xw8dR/pzvTnvHYrUG2zYDaWbuCzglaw5NaFn72
         pxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676677613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckp4pLuUHkuempvnYbrn9XuKX3oztgaEXvwAfzzvbKY=;
        b=WZma7TIrvgE1pEdChtQ5W16dfVKSYgCP8OmOMGiWGyichaYJgSBuEClUfLdkzSSpbQ
         3ald6FHy1In6j4Ky56pZyUIprF7+s8U3AGyoOO38OYFHMcbMI9hoat4y2XDh3FKCrIdo
         Ld0rUSeMA80tHP1kvkigIce9liXvMZRp7axQesDRvR368Ge5On+dNKvqdUmKNYTzgFT+
         b1wMe+xFHyzveKKZe3QNG9yOKdbOlIizZr6BPCJx4//pAYtaa2M2yH2kFa6kKT3Vprii
         o9uSiH6WvLdJ7ZlfARUQ/bBRw6QYCqsP57o0qR5sgQFn8EreeIT29oMmai+/xJ9nxjVC
         402w==
X-Gm-Message-State: AO0yUKWHUK2pM9osbrUbnMdqFWx5A6ZlZoogy3zDIcyhkxGHQbmjIHx4
        KOQWnsUPKgNkzRhu3OQyD4OZTC+rLtMMx35k6vdNog==
X-Google-Smtp-Source: AK7set/WKbRLdtHn4gVAoqZXddY2wGOMgp4LCc77gafDWBJfKQOBHBqd8D3oSx1xsHRCoFAuoVn5+jh3RFhp9BlMoys=
X-Received: by 2002:a17:903:328e:b0:19b:c39:3ba5 with SMTP id
 jh14-20020a170903328e00b0019b0c393ba5mr862857plb.29.1676677613373; Fri, 17
 Feb 2023 15:46:53 -0800 (PST)
MIME-Version: 1.0
References: <932DEB17-70FB-4416-80B3-C48A7C31848F@kohlschutter.com>
 <20220825212842.7176-1-christian@kohlschutter.com> <CAGETcx__Ez8i9O2O30-Q1R00xOqBjkKMCwt37_AGAQjNvZqpdg@mail.gmail.com>
 <B6E001E2-9BCD-420A-B0F6-1495DE46955E@kohlschutter.com>
In-Reply-To: <B6E001E2-9BCD-420A-B0F6-1495DE46955E@kohlschutter.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 17 Feb 2023 15:46:17 -0800
Message-ID: <CAGETcx_OKA+MkExc98337kZYKsoJtV0ZdfYJE7Tk00CFvCt2bA@mail.gmail.com>
Subject: Re: [PATCH v5] regulator: core: Resolve supply name earlier to
 prevent double-init
To:     =?UTF-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, m.reichl@fivetechno.de,
        robin.murphy@arm.com, vincent.legoll@gmail.com, wens@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Feb 17, 2023 at 3:33 PM Christian Kohlsch=C3=BCtter
<christian@kohlschutter.com> wrote:
>
> On 18. Feb 2023, at 00:22, Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Thu, Aug 25, 2022 at 2:28 PM Christian Kohlsch=C3=BCtter
> > <christian@kohlschutter.com> wrote:
> >>
> >> Previously, an unresolved regulator supply reference upon calling
> >> regulator_register on an always-on or boot-on regulator caused
> >> set_machine_constraints to be called twice.
> >>
> >> This in turn may initialize the regulator twice, leading to voltage
> >> glitches that are timing-dependent. A simple, unrelated configuration
> >> change may be enough to hide this problem, only to be surfaced by
> >> chance.
> >
> > In your case, can you elaborate which part of the constraints/init
> > twice caused the issue?
> >
> > I'm trying to simplify some of the supply resolving code and I'm
> > trying to not break your use case.
> >
> > -Saravana
>
> Here's a write-up of my use case, and how we got to the solution:
> https://kohlschuetter.github.io/blog/posts/2022/10/28/linux-nanopi-r4s/

I did read the write up before I sent my request. I'm asking for
specifics on which functions in the set_machine_constraints() was
causing the issue. And it's also a bit unclear to me if the issue was
with having stuff called twice on the alway-on regulator or the
supply.

-Saravana
