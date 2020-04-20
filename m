Return-Path: <SRS0=uOye=6E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD5FC54FCB
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 12:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973A220736
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 12:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386107;
	bh=2jHGMZ+1hForNEsX6w16lx7Gn/ZpAd+NbEO3YIm/NAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jJKGbgHaZX1KCz6CH3Xa9RPYWrBy4ApU3/ggZtT0cDQMI1c6124UGu+rB/LICreEy
	 4ClXjCJa0ESWN9erXdGJ2EG7u8krqqZDmki1hkcHOzELmpzGTswmkn8wcf2Hi9IcVR
	 hPqkD7UO/MZI6n4vIAWtcWfoZ4U9Yrzq9+89dPOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgDTMfH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:35:07 -0400
Received: from condef-06.nifty.com ([202.248.20.71]:25678 "EHLO
        condef-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgDTMfG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Apr 2020 08:35:06 -0400
Received: from conssluserg-01.nifty.com ([10.126.8.80])by condef-06.nifty.com with ESMTP id 03KCSt7u019736;
        Mon, 20 Apr 2020 21:28:55 +0900
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 03KCSI2F017351;
        Mon, 20 Apr 2020 21:28:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 03KCSI2F017351
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587385699;
        bh=51UZo8wSG/CwNqhAi1vJ/PbEP1Hkm+7R4orLX2dX+H0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d+yVosrZN+nC8cCZ/G5WjLy+DJm0b9xV0tbsEkKLN3sjhsfJ/8Wc9BYl+PdkJQWfG
         H56NM4weJFUoKYtLW0PZM3FIB+mtOaiuCiIpL4sW1On8D+9K1wOW5YqnNN1JrhRitf
         3otEP6eYEuSPjaQLaIpiQ0ppexmZ8CJtWd6vs75rKqJfWIY7PRkIZsqWfdq7wNQ8HJ
         PH6Wlnqsmow94Y0rt0csgDGj3W7xlrqJsS4bB2K63+SnqyNswOGUSzIYhvVdmASxuq
         IbNu73bu3WtslYIZWZDdF8eu8VHZxWAVmSJYPWefGGogZ9hnYa7n8WgfwYeg+7HR6I
         rmwdyzGGSXCZw==
X-Nifty-SrcIP: [209.85.217.46]
Received: by mail-vs1-f46.google.com with SMTP id g184so5836709vsc.0;
        Mon, 20 Apr 2020 05:28:19 -0700 (PDT)
X-Gm-Message-State: AGi0PuYwzIIr/Q1s98CNRwjzqnBL1wOfr7aAUT7ztPaJooJuG7v68PkQ
        rXVvO5AvjWl2ItlqYPT5VYlHzQOy4BmakVZwgL8=
X-Google-Smtp-Source: APiQypIcWBVRoIIEpkTzQbZkvVmidU34sIfQFhwP7quBFSRvFsrUGx7VAubsD7+mQMHbB+Pgv3v3/yClr13p987POC0=
X-Received: by 2002:a67:3293:: with SMTP id y141mr11500153vsy.54.1587385697774;
 Mon, 20 Apr 2020 05:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200417145017.3932443d@canb.auug.org.au> <995a958c-15a1-cb05-e276-065c7f6e57fd@infradead.org>
 <CAPDyKFqE7zfaKSbpBoBbrSCEnx+70dOrWs+=QG_x2G-Fpt6=ng@mail.gmail.com> <ce11a0b5-22a6-dd18-f858-5d30f43e1128@intel.com>
In-Reply-To: <ce11a0b5-22a6-dd18-f858-5d30f43e1128@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 20 Apr 2020 21:27:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNARCT3YQEnVE0NMCphSuqvjLoG2EXdpdcAZuoEOD_mFyEw@mail.gmail.com>
Message-ID: <CAK7LNARCT3YQEnVE0NMCphSuqvjLoG2EXdpdcAZuoEOD_mFyEw@mail.gmail.com>
Subject: Re: linux-next: Tree for Apr 17 (mmc/host/sdhci-of-at91.c)
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Apr 20, 2020 at 7:28 PM Adrian Hunter <adrian.hunter@intel.com> wro=
te:
>
> On 20/04/20 12:12 pm, Ulf Hansson wrote:
> > + Masahiro Yamada, Adrian Hunter
> >
> > On Fri, 17 Apr 2020 at 16:48, Randy Dunlap <rdunlap@infradead.org> wrot=
e:
> >>
> >> On 4/16/20 9:50 PM, Stephen Rothwell wrote:
> >>> Hi all,
> >>>
> >>> Changes since 20200416:
> >>>
> >>
> >> on i386:
> >>
> >>   CC      drivers/mmc/host/sdhci-of-at91.o
> >> In file included from ../include/linux/build_bug.h:5:0,
> >>                  from ../include/linux/bitfield.h:10,
> >>                  from ../drivers/mmc/host/sdhci-of-at91.c:9:
> >> ../drivers/mmc/host/sdhci-of-at91.c: In function =E2=80=98sdhci_at91_s=
et_clks_presets=E2=80=99:
> >> ../include/linux/compiler.h:394:38: error: call to =E2=80=98__compilet=
ime_assert_63=E2=80=99 declared with attribute error: FIELD_PREP: value too=
 large for the field
> >>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER=
__)
> >>                                       ^
> >> ../include/linux/compiler.h:375:4: note: in definition of macro =E2=80=
=98__compiletime_assert=E2=80=99
> >>     prefix ## suffix();    \
> >>     ^~~~~~
> >> ../include/linux/compiler.h:394:2: note: in expansion of macro =E2=80=
=98_compiletime_assert=E2=80=99
> >>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER=
__)
> >>   ^~~~~~~~~~~~~~~~~~~
> >> ../include/linux/build_bug.h:39:37: note: in expansion of macro =E2=80=
=98compiletime_assert=E2=80=99
> >>  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >>                                      ^~~~~~~~~~~~~~~~~~
> >> ../include/linux/bitfield.h:49:3: note: in expansion of macro =E2=80=
=98BUILD_BUG_ON_MSG=E2=80=99
> >>    BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?  \
> >>    ^~~~~~~~~~~~~~~~
> >> ../include/linux/bitfield.h:94:3: note: in expansion of macro =E2=80=
=98__BF_FIELD_CHECK=E2=80=99
> >>    __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: "); \
> >>    ^~~~~~~~~~~~~~~~
> >> ../drivers/mmc/host/sdhci-of-at91.c:185:11: note: in expansion of macr=
o =E2=80=98FIELD_PREP=E2=80=99
> >>   caps1 |=3D FIELD_PREP(SDHCI_CLOCK_MUL_MASK, clk_mul);
>
> My guess is the compiler has decided clk_mul is constant (probably (unsig=
ned
> int)-1) because there is no CONFIG_COMMON_CLK i.e. clk_get_rate() is 0
>
> So maybe add to config MMC_SDHCI_OF_AT91
>
>         depends on COMMON_CLK
>
> >>            ^~~~~~~~~~



I checked include/linux/clk.h


clk_get_rate() is guarded by CONFIG_HAVE_CLK.

I think

    depends on HAVE_CLK


--=20
Best Regards
Masahiro Yamada
