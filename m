Return-Path: <SRS0=nQxR=4B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB46C2BA83
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 11:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDA720848
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 11:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q4CPnMXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgBMLJa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:09:30 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46158 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgBMLJ3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2020 06:09:29 -0500
Received: by mail-vs1-f67.google.com with SMTP id t12so3291718vso.13
        for <linux-mmc@vger.kernel.org>; Thu, 13 Feb 2020 03:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0VL/eeO+2uXvxLBxsa+UTgHYdszEFwqJl1oJL1GlXkI=;
        b=Q4CPnMXgnFDpAh308OcLx/03Sn1uN2WUh8nEgQvbh5yDgssE7MxJ5zJ751KmfbL1YC
         Djb9f4OEPGkNaLMmKIUVifWJf6r7WxF0RpKFXOjp0kKkw5J8VKkhKiiSbtVXVak7OSmX
         Fi6bJpoDv3bp0CyI1la7CYYPGfYJZxusOhNhWuc+/5TJ5AopTGbxVvRHEifHEnbM+nNb
         KPpEJcbtUqG4/4EpNhjDqserA1NQoyNEzuhlbKhCM2o9N95nYPfgcZ+rpBuI+6J0rWoJ
         3u/mpYH3n/rTYhK5mpjdkqoecGxGrcpZz4DBqk+Cp4C77KUtdu+ctc0J6N7DF0ZGXwPy
         iP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0VL/eeO+2uXvxLBxsa+UTgHYdszEFwqJl1oJL1GlXkI=;
        b=EjW/IjdX1B/qP9HcgSMhEeoYXvac5QTIPlnaRWhWf5ghSIkJ9aISTulXepiFn3FRCS
         dh81HwmokE5IgNE4HW/rRHHIVKuMdoUvLGOQjMlxULihukHxI3qCMsPoTSPNRwaKd/+r
         /u1TIwDD/umm5DzEwTqxG3BP5TrvA/20YWPRjBC3WFtvuVwZYgyZrB8E4Y+dNaiu1eWp
         K+5javiNqneS0kE3PoaizCtqEmy3rRsRm21kc3v6ny/q+YtDXQa5m5H/dPdnRHW6xBtt
         5wRxVbL2cWY/fjwPEDw/wWaAsL97WwxHUQNLGR70Cze8dbnqLOd6kfTjXhqyni7CE4y5
         Ibug==
X-Gm-Message-State: APjAAAXdNlJuoTlJ5QIJcATkRByI2bKjuT/FydUNGKNDYEopTRBC2FcD
        MeX+cDn8YMDmkBQFwp83tE/kyqDtNYl4W5oRHsQjJA==
X-Google-Smtp-Source: APXvYqxGtYxJ52X5LMERzTzkS7VMP0e6UDmg5Ln2rSOliPdJ8C+BJRx0BByhBHdFwwLvM8BOsN5sNIEartm8H3kd3O0=
X-Received: by 2002:a67:f591:: with SMTP id i17mr3847550vso.34.1581592168893;
 Thu, 13 Feb 2020 03:09:28 -0800 (PST)
MIME-Version: 1.0
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
 <CADBw62o+9aasHDJtOLAXkhvV3DSVXHePwqy707DMQNo2O-+YmQ@mail.gmail.com> <CADBw62rXMEq2mE43aJn=rq8CKX=1sM6hMBKuiqUbwmsDGJM5pw@mail.gmail.com>
In-Reply-To: <CADBw62rXMEq2mE43aJn=rq8CKX=1sM6hMBKuiqUbwmsDGJM5pw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Feb 2020 12:08:52 +0100
Message-ID: <CAPDyKFqxY8=jXTQH-Z3tkDpmLdL2iA7OnGgHoiqzgbugpEHmjw@mail.gmail.com>
Subject: Re: [PATCH 00/12] mmc: core: Improve code for polling and HW busy detect
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 13 Feb 2020 at 07:24, Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> On Tue, Feb 11, 2020 at 9:17 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > Hi Ulf,
> >
> > On Tue, Feb 4, 2020 at 4:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > There exists several separate variants of polling loops, used to detect when
> > > the card stop signals busy for various operations, in the mmc core. All of them
> > > have different issues that needs to be fixed.
> > >
> > > The intent with this series, is to address some of these problems, via first
> > > improving the mmc_poll_for_busy() function, then consolidate code by moving
> > > more users to it.
> > >
> > > While I was working on this, I stumbled over some code here and there, that
> > > deserved some cleanup, hence I also folded in a couple of patches for this.
> > >
> > > So far, I have only managed to extensively test the updated mmc_poll_for_busy()
> > > function for CMD6 commands. Some tests for erase/trim/discard and for
> > > HPI+sanitize are needed.
> > >
> > > Note that, there are still separate polling loops in the mmc block layer, but
> > > moving that to mmc_poll_for_busy() involves some additional work. I am looking
> > > into that as a next step.
> > >
> > > Please help review and test!
> >
> > That will be help if you can supply one git branch to fetch these
> > patches :), and I will help to do some testing on my platform.
>
> I've tested on my platform, incuding reading, writing, mounting and
> running all cases in mmc_test.c, and I did not find any problem. So
> please feel free to add my test tag. Thanks.
>
> Tested-by: Baolin Wang <baolin.wang7@gmail.com>

Thanks a lot for testing!

Kind regards
Uffe

>
> > > Ulf Hansson (12):
> > >   mmc: core: Throttle polling rate for CMD6
> > >   mmc: core: Drop unused define
> > >   mmc: core: Extend mmc_switch_status() to rid of __mmc_switch_status()
> > >   mmc: core: Drop redundant in-parameter to __mmc_switch()
> > >   mmc: core: Split up mmc_poll_for_busy()
> > >   mmc: core: Enable re-use of mmc_blk_in_tran_state()
> > >   mmc: core: Update CMD13 busy check for CMD6 commands
> > >   mmc: core: Convert to mmc_poll_for_busy() for erase/trim/discard
> > >   mmc: core: Drop redundant out-parameter to mmc_send_hpi_cmd()
> > >   mmc: core: Convert to mmc_poll_for_busy() for HPI commands
> > >   mmc: core: Fixup support for HW busy detection for HPI commands
> > >   mmc: core: Re-work the error path for the eMMC sanitize command
> > >
> > >  drivers/mmc/core/block.c   |  55 +++++--------
> > >  drivers/mmc/core/core.c    |  53 +------------
> > >  drivers/mmc/core/mmc.c     |  38 ++++-----
> > >  drivers/mmc/core/mmc_ops.c | 159 ++++++++++++++++++++++---------------
> > >  drivers/mmc/core/mmc_ops.h |  13 ++-
> > >  include/linux/mmc/core.h   |   3 -
> > >  include/linux/mmc/mmc.h    |  10 +++
> > >  7 files changed, 157 insertions(+), 174 deletions(-)
> > >
> > > --
> > > 2.17.1
> > >
