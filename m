Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB65C56202
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 10:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890A220872
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 10:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwNz1/ln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgKYKtq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Nov 2020 05:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgKYKtp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2020 05:49:45 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F501C0613D6
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2020 02:49:45 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id g3so580824uae.7
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2020 02:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=31ORbJvpr4ykU4u2xXAVnohJ/y8a5FqNZaGbZYVVFHo=;
        b=cwNz1/lnfHNnk2Fo93Sc5IhaKrZvyN+IsXV0V0jam8rUGqC6wnalsUp4uENdUG4KEp
         OgL3+5wXy3GZ99Ea2sfjhXp5j/I6qQ8IOGWWgoosN0YWfF0IK1cR9wZlhCQ4Wl0LqTZT
         7hYxA8aZKWPxbR6VTQ/wipC5ACTuL0nCRFEkPFFLn2+24hNU433PifLpC2Z8pHzB9YaN
         8JlEMBsmJ1aXYHggL7omDsCOaVDpxhp54RulLN26s/dzYRQmVv4vStGgY6IFkS4Y4iwL
         iH4OKYCxI8ZZfxK5Rk2Ju1PYy+/wrbMweydt7YzdvxDF6f+CW//wZiY2+eQ3tA1GF5kf
         j+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=31ORbJvpr4ykU4u2xXAVnohJ/y8a5FqNZaGbZYVVFHo=;
        b=OuGUUdrh0e/XPtYk/GpFHaowGVPcEE6/V1UmdmvKZvJjy7EFo7GWHCHhOeQnJySFgx
         ojDLpi+zm9e+h26f+YydN6cX7LFyXqR4Cg1KQABFhnFKOX7Hx43vTSZL5+7rH1E+frdx
         QZDjbQEuCqSZLTAWJ+gFboW/0QGxhDr2q51pxQOGhzxc0vI7jOFdVlXTugCU5pMjyaea
         fZFO4RLNxnJvfXVcDXNNaJ0HzXgCP4xZTSLZTkAsPxFslEdcF8QviMsNSR7fwCfd7XNi
         XM5LgWnzO1SkRTAY5BFGuAXGCcPa5SgkErFdjDBq9umUMEvBNbbZ+7clH7TVzFiwxYKp
         BIBA==
X-Gm-Message-State: AOAM5301bxb2t/tPX+LsH7jKk2FMatEYUoCK2RLanVtZkjKecNDcVDhU
        EzFkr1tZh+mVUa0x5vvvX+DJW5WL2JXmZwkeCGQNWQ==
X-Google-Smtp-Source: ABdhPJxvKc4ULy6q7CJ7mO41iSeOCkXef+sQYC+c14MlX208nmd4//r9zeeD0FYl9GhROlbWoFtq0cyCnzRDavk6H6U=
X-Received: by 2002:ab0:5859:: with SMTP id p25mr2162180uac.100.1606301384756;
 Wed, 25 Nov 2020 02:49:44 -0800 (PST)
MIME-Version: 1.0
References: <20201125100004.1288-1-benchuanggli@gmail.com> <CAPDyKFp_3Vpq6ZRm5Qm1Zningz9tDqQLS_E78a8ChYHVbofB9g@mail.gmail.com>
 <CACT4zj_rrV+MFXwsnXpLD=CNjApUKozMWJMnhS6z2q5d6-dY-g@mail.gmail.com>
In-Reply-To: <CACT4zj_rrV+MFXwsnXpLD=CNjApUKozMWJMnhS6z2q5d6-dY-g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 25 Nov 2020 11:49:08 +0100
Message-ID: <CAPDyKFq=r8Fwt1j7S1F5fCsMjGp6mxfWWPjppA0CVjx17MVRVQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Disable slow mode in HS400 mode for GL9763E
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 25 Nov 2020 at 11:43, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> Hi Ulf,
>
> On Wed, Nov 25, 2020 at 6:04 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 25 Nov 2020 at 10:59, Ben Chuang <benchuanggli@gmail.com> wrote:
> > >
> > > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > >
> > > The GL9763E uses 150Mhz (slow mode) by default in HS400 mode. In order
> > > to make HS400 mode run at 200Mhz, the slow mode needs to be turned off.
> > >
> > > Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
> >
> > Why a fixes tag? This patch looks like an improvement and not a fix, right?
> >
>
> Since the specification defines that the HS400 mode must run at 200Mhz,
> this patch fixes the HS400 mode to 200Mhz.

The spec states that in HS400 mode the clock can be *up to 200MHz* -
not that it must run at 200MHz. At least at those places I have looked
at in the spec.

[...]

Kind regards
Uffe
