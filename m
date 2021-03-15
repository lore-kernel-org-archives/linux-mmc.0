Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A69C433E9
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 09:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1269D64EDD
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 09:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhCOJ7F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Mar 2021 05:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhCOJ6u (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Mar 2021 05:58:50 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A916C061574
        for <linux-mmc@vger.kernel.org>; Mon, 15 Mar 2021 02:58:49 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id a12so16002569vsd.3
        for <linux-mmc@vger.kernel.org>; Mon, 15 Mar 2021 02:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jxbWASu5oWJzNTcEYWC8hv+A2NytfrTKC8d5cxLm8m4=;
        b=QO+Dsj7DNztito3plfPpudEkW6UzYy/kwjSy/EX1bSXEeAdO/n8ENbftctcLSbZ9AN
         1kgJGGRmS34bwBJ1KwCrYGXiVAi2B3cycK89PyEdtXIKd3iRFlUnYVigr2Q9GJTsHbPs
         Kco6SQp3afkjqy7/cvcQC1U1Uhu4Dh0v7iy41Oy7rxVoRhOSfgniazjeFbofQg/YMlpJ
         VB7p6Qj3gklfF2sf8e5MpP9WYwoPWoqf5UfZu158hQziwRs9JsyAecaZRQTtZZSvlguI
         P/Qra+J54RbhumZHnnfeT1W1Dhw04mEnJghbr6VI7Y9OIeKLziBK2q5HaUYbc226vCFq
         cS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jxbWASu5oWJzNTcEYWC8hv+A2NytfrTKC8d5cxLm8m4=;
        b=Qkn2Mn8BVthN+ZeQwB1UpoR4xT39lGEekcOHm/S/sPZib89UUIGtjXtSfH999FPHt2
         DOPJBJdvibZYJ7TgLGMkYZFqrdcB/bRlyD9cAhilT5Z1jSmmrfkSaA3BXZFtC2roNvRh
         DIIs+sQLrws6/SEt2G9CpFCM8FhvcoAn+8nsNDJpT9nLuCj+5A/4ksDokTjPXX4Rdnrs
         eknDi15fAZXcNCHtGBj642jTmACa+Ie7Ze31Fi5fNsbFPYWmlt6yvKrrZYqYIyN7yfBX
         4+mhZPlVetenW1fKXrpGgK1PkTj7ANB9RojFkw/ykS03hyLr001RYZ5JfFIFbetxOZx4
         P22A==
X-Gm-Message-State: AOAM532u3x6qm+EhKe1DdM8emyUjweN6QPOXRsdRW0KhsfHvvQDkEYI4
        H1awAHiLH6i/oLRD1UGbi3p+Imn8VnFQoWwdDAkBlh5NN3pgQ/Fc
X-Google-Smtp-Source: ABdhPJwtB/z3n3jeh8srMpGid+o1Na0JidEiSqnpdf8GFP15mWlT0Y1Aw9O1VY+dSpPMcVJqbQp5nBt84u676RgcYPs=
X-Received: by 2002:a67:8c89:: with SMTP id o131mr1866968vsd.42.1615802328387;
 Mon, 15 Mar 2021 02:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210310152931epcas2p1be7719eeaca8d14bf7a8244ff389bd39@epcas2p1.samsung.com>
 <20210310152900.149380-1-ulf.hansson@linaro.org> <000001d7195e$8122ca00$83685e00$@samsung.com>
In-Reply-To: <000001d7195e$8122ca00$83685e00$@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Mar 2021 10:58:11 +0100
Message-ID: <CAPDyKFqAXejhr4yytY7KwLycSTnyC0Y4AD3DErxbYMuXUJhVbg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix hanging on I/O during system suspend for
 removable cards
To:     Kiwoong Kim <kwmad.kim@samsung.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 15 Mar 2021 at 06:46, Kiwoong Kim <kwmad.kim@samsung.com> wrote:
>
> > The mmc core uses a PM notifier to temporarily during system suspend, turn
> > off the card detection mechanism for removal/insertion of (e)MMC/SD/SDIO
> > cards. Additionally, the notifier may be used to remove an SDIO card
> > entirely, if a corresponding SDIO functional driver don't have the system
> > suspend/resume callbacks assigned. This behaviour has been around for a
> > very long time.
> >
> > However, a recent bug report tells us there are problems with this
> > approach. More precisely, when receiving the PM_SUSPEND_PREPARE
> > notification, we may end up hanging on I/O to be completed, thus also
> > preventing the system from getting suspended.
> >
> > In the end what happens, is that the cancel_delayed_work_sync() in
> > mmc_pm_notify() ends up waiting for mmc_rescan() to complete - and since
> > mmc_rescan() wants to claim the host, it needs to wait for the I/O to be
> > completed first.
> >
> > Typically, this problem is triggered in Android, if there is ongoing I/O
> > while the user decides to suspend, resume and then suspend the system
> > again. This due to that after the resume, an mmc_rescan() work gets punted
> > to the workqueue, which job is to verify that the card remains inserted
> > after the system has resumed.
> >
> > To fix this problem, userspace needs to become frozen to suspend the I/O,
> > prior to turning off the card detection mechanism. Therefore, let's drop
> > the PM notifiers for mmc subsystem altogether and rely on the card
> > detection to be turned off/on as a part of the system_freezable_wq, that
> > we are already using.
> >
> Dear Ulf
>
> Do you think there is no possibility that claiming a host by mmc_rescan is
> postponed by early IO requests?
> E.g. the case where the work is executed later unexpectedly for something.

That shouldn't matter.

The important part is that I/O from userspace gets suspended before
the system_freezable_wq gets frozen, which is what mmc_rescan() runs
from.

>
> And it seems that cancelling the work before system suspend is removed in
> the patch.
> That means you might think there is no case with the pended the work, I
> think.
> Am I right?

When system_freezable_wq is frozen, running works will be synced for
completion. Scheduled works don't get to run until the
system_freezable_wq is unfrozen.

In other words, the behaviour remains the same, except that we are
suspending card detection in mmc_rescan() to a slightly later state.

>
> If I mis-understand something, please let me know.
>
> Thanks.
> Kiwoong Kim
>

Did you try out the patch at your side, to see if it resolves your problems?

Kind regards
Uffe
