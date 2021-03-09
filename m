Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9310C433E6
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 17:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4D565235
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 17:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhCIRWl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Mar 2021 12:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhCIRWP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Mar 2021 12:22:15 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AA7C06174A
        for <linux-mmc@vger.kernel.org>; Tue,  9 Mar 2021 09:22:15 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id z65so7177096vsz.12
        for <linux-mmc@vger.kernel.org>; Tue, 09 Mar 2021 09:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icH34N0BzxWptc4AsCi8eFQPKCsD1ffvQta96njCeko=;
        b=UBK8W01OY9HLcrmjdo6e0EnHeBBn6a3F3srBAC4doo8KW+L4eAnDhY/YDntxKqThJb
         YkAMA33qZJ/+fnPKgXTatjx5szbLeMDvd07jP5ZnUf7kls7/PU54/XKaEHuwx4fk3fN/
         MnY8eaLFIZAKLyIypdWi2zGXCnFFqoRV3H18zHce7zkRcQdrPQGET56+GCkjFx2vusau
         6ZlDFMrqxP2zvera8MTGe9rx++RnkEm/UoyZlV0SPWeefCSKZ7ZWf7/BjZgPAUtck71H
         VoWLmUEbIriIbyAT9z7JuJ4GmFC4UWMH3Tg21I1uC1jkO9/9zs8hf09XcNVn17CHRui/
         1eVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icH34N0BzxWptc4AsCi8eFQPKCsD1ffvQta96njCeko=;
        b=hIbnNDXLSuaYMVbUZ7UIJw4J1Mkf5LOpBCLqn2FB0u4LfCyKpHlHF3pWEZ2FYDb6Ee
         1NcREKGTwsqSyz62dQzaKEaHOQDzRbXYrgfXSOV+P9vRRstw6P1Z9szIQ4QcOxrFblWs
         /APouGvym4XO1fEUeMVDHw1FeNtQv8F37tgWK8GY5lyoKfhVcDtYnb0x0xvPrSOa6MqB
         VFTA13xp5DRDIM2WUgB6Adv1VCuVmYTuX08BTqkUd5HYFuQTJsdiCztq485VHp/XSfCC
         WrlDI977/UnRLxlSmrdy5Kddba+9O5Ng8Auc6YEZwLxvTAKRxQOXpw0akVKMny/2Iz+g
         Roww==
X-Gm-Message-State: AOAM533B9E8PpZLhpjqleyL5XMQXcIHR53V7qE/1L5DtYzYcddp9h3dW
        pGQur3lduD0V1vEOeQrE1GGqHtCLYenCHddQ/O4bsgCndabv2w==
X-Google-Smtp-Source: ABdhPJwD5PFvImpnAFp8yCzDarn54M24T8+O5uhL/zwYZ+UgFzbpJoy6Copf2kbjJv9dPDXjs8mqhtzuS4H0gdnvx8A=
X-Received: by 2002:a05:6102:7b0:: with SMTP id x16mr15479343vsg.34.1615310534496;
 Tue, 09 Mar 2021 09:22:14 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210309041059epcas2p49567b092c8d82bb80aa76ad26f8d212b@epcas2p4.samsung.com>
 <02da01d7149a$35dec530$a19c4f90$@samsung.com> <CAPDyKFpeCWp6JUS4w9h1K7ZLjvE0JuREuWgrsuQSzD7dOJBHGw@mail.gmail.com>
In-Reply-To: <CAPDyKFpeCWp6JUS4w9h1K7ZLjvE0JuREuWgrsuQSzD7dOJBHGw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 9 Mar 2021 18:21:37 +0100
Message-ID: <CAPDyKFoEGp1CHo1OuTTeGqKkPG1Nke0k_rLBLSwmLH_BCcDDtA@mail.gmail.com>
Subject: Re: About a possibility of long latency to claim host
To:     Kiwoong Kim <kwmad.kim@samsung.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 9 Mar 2021 at 14:07, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 9 Mar 2021 at 05:11, Kiwoong Kim <kwmad.kim@samsung.com> wrote:
> >
> > Dear All
> >
> > I want to discuss about this topic with you guys.
> >
> > There is an application to put many IO requests to a SD card right after completion of system resume.
> > Current MMC stack invokes mmc_rescan asynchronously for PM_POST_SUSPEND.
> > As reported to me, there could be a race between an IO thread and the kworker for mmc_rescan,
> > especially when the application mentioned before is installed and the function of mmc_rescan is run later than expected
> > For a series of IO requests, mmc_rescan, particularily at __mmc_claim_host called in mmc_sd_detect, didn't acquire a host for longer than expected.
>
> That's not a problem, in general.
>
> As long as the card is inserted and functional, the I/O operations
> should be completed successfully. It doesn't matter if mmc_rescan() is
> waiting to claim the host, as it's not important that it gets to run
> as long as the card remains inserted/functional.
>
> >
> > Below is the call stacks shown after the symptom happened and the system tried to enter into suspend again.
> > In this case, mmc pm notifier is called with PM_SUSPEND_PREPARE, so it waits for completion or cancelling the work for mmc_rescan.
> > For the latency, mobile users can see black screen for a long time sometimes, even with pushing a power button to wake up the system.
>
> I think I understand what you are saying, but please correct me if I am wrong.
>
> The I/O requests keep flowing into the blk queue even after
> PM_SUSPEND_PREPARE has been fired, thus preventing the earlier
> scheduled mmc_rescan() from claiming the host?
>
> This sounds quite reasonable that it could happen, at least
> theoretically. Although, I am a bit surprised that nobody has reported
> about this problem, until now. The design in the mmc core, has
> remained unchanged in regards to this behaviour, for a very very long
> time.
>
> Let me try to reproduce the problem, I will get back to you soon. In
> the meantime, I would also appreciate it if you could share, more
> exactly, how to trigger this problem at your side.

I have managed to reproduce the problem!  Wow, I wonder how this could
have slipped through without anybody reporting about this, until now.
So, thanks for bringing this to my attention!

My rough guess is that SD cards, used in these kinds of configurations
(Android), are actually set to non removable. This would prevent
mmc_rescan() from claiming the host.

In any case, this needs to be fixed properly. I will continue to work
on a solution and get back to you with a patch.

[...]

Kind regards
Uffe
