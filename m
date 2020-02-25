Return-Path: <SRS0=gc8k=4N=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CFAC35E04
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Feb 2020 15:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17552082F
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Feb 2020 15:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyQ7bqVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbgBYPEL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:04:11 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36537 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730486AbgBYPEL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Feb 2020 10:04:11 -0500
Received: by mail-ua1-f65.google.com with SMTP id y3so4608291uae.3
        for <linux-mmc@vger.kernel.org>; Tue, 25 Feb 2020 07:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6bvPtd/198cywXTOvjPU3FjOjwVQjlkyqXViQFJxqc4=;
        b=QyQ7bqVkPtFxGSpRtJkoyUUpcZUWjPSm67wWaqXgNdhAN9SC1zKQBaYjXRJlPDuVV7
         mE6Y8QWd7OTy3FWHGqMnQB4PFJdlq00tF4nmmdbBhzr/UClptbQvq5PqiNJfyon2K6Gg
         Dnf2HAw1NAMUj+N5oFrdemY8zfdzVYZqJOBqic+gSal+FrLLACyZAoBMmDe1X1+5ua4x
         YljZ9xLGmdzM9hV2JyCzuDv+xJznShRiFe7pOsOVyrjCnNlUEjwolUHSkL4vEH+Z19ly
         pYjHxcVUP1RoStnsuJNPITwesICP8UZBTxteLU7K37jscplB0dZftuL/iMJgfox86tG9
         BYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bvPtd/198cywXTOvjPU3FjOjwVQjlkyqXViQFJxqc4=;
        b=JWal14rv1X1mxNV3gq/WFlR18mXLBH9OCrXhAO3h1DjnC1GNjYl6M3UJ/hKjnzEYrI
         bgTuDcVHk+CRS0BPHMcZtleheV0iys0sD5K0jVEwB0bVunMaAqYvlVz03JefuO+hpcCI
         YpVDGHMWXzzTkUFbLgabq+uIRx3C8oYrhNXwEBU7/vDaA/JTZZe5jUZc82FaZGT3spGH
         21w4PQag6zoDysUd37uvHicjpVTcFsbkMv7b/+4bjo2nxE/szpfz0Fdv1rK7EySPdnFU
         WI7SmAEFYeoLvriD6l0diB8tIofOt5/ZyaUUC46qALI7BqQn3LQ4FfXfjCQJQ5VIhH1i
         1SAg==
X-Gm-Message-State: APjAAAXNt1SVTWGUM+UXkE3LpFmpCGZo90tY6AvC6yu+ab1pXHFxUgqi
        nKTV1hTQhPmLLckMrEYxu7bc0qlg1Gsu/JacFOWYYA==
X-Google-Smtp-Source: APXvYqyUOxUhJ4b3/W1tXRB7d/Gqe+OHJl6TU22IV7BVTgvjS/zlWOMb37Twi9w+VXGISofCT3VP85nIdljSVB2gqN0=
X-Received: by 2002:ab0:740e:: with SMTP id r14mr28921662uap.104.1582643048621;
 Tue, 25 Feb 2020 07:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20191029170250.GA43972@google.com> <20200222165617.GA207731@google.com>
In-Reply-To: <20200222165617.GA207731@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Feb 2020 16:03:32 +0100
Message-ID: <CAPDyKFq_exHufHyibFCjS78PTZ7duS9ZSt3vi18CNM6+jMmwnw@mail.gmail.com>
Subject: Re: PCI device function not being enumerated [Was: PCMCIA not working
 on Panasonic Toughbook CF-29]
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Michael ." <keltoiboy@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Trevor Jacobs <trevor_jacobs@aol.com>,
        Kris Cleveland <tridentperfusion@yahoo.com>,
        Jeff <bluerocksaddles@willitsonline.com>,
        Morgan Klym <moklym@gmail.com>,
        Philip Langdale <philipl@overt.org>,
        Pierre Ossman <pierre@ossman.eu>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 22 Feb 2020 at 17:56, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Oct 29, 2019 at 12:02:50PM -0500, Bjorn Helgaas wrote:
> > [+cc Ulf, Philip, Pierre, Maxim, linux-mmc; see [1] for beginning of
> > thread, [2] for problem report and the patch Michael tested]
> >
> > On Tue, Oct 29, 2019 at 07:58:27PM +1100, Michael . wrote:
> > > Bjorn and Dominik.
> > > I am happy to let you know the patch did the trick, it compiled well
> > > on 5.4-rc4 and my friends in the CC list have tested the modified
> > > kernel and confirmed that both slots are now working as they should.
> > > As a group of dedicated Toughbook users and Linux users please accept
> > > our thanks your efforts and assistance is greatly appreciated.
> > >
> > > Now that we know this patch works what kernel do you think it will be
> > > released in? Will it make 5.4 or will it be put into 5.5 development
> > > for further testing?
> >
> > That patch was not intended to be a fix; it was just to test my guess
> > that the quirk might be related.
> >
> > Removing the quirk solved the problem *you're* seeing, but the quirk
> > was added in the first place to solve some other problem, and if we
> > simply remove the quirk, we may reintroduce the original problem.
> >
> > So we have to look at the history and figure out some way to solve
> > both problems.  I cc'd some people who might have insight.  Here are
> > some commits that look relevant:
> >
> >   5ae70296c85f ("mmc: Disabler for Ricoh MMC controller")
> >   03cd8f7ebe0c ("ricoh_mmc: port from driver to pci quirk")
> >
> >
> > [1] https://lore.kernel.org/r/CAFjuqNi+knSb9WVQOahCVFyxsiqoGgwoM7Z1aqDBebNzp_-jYw@mail.gmail.com/
> > [2] https://lore.kernel.org/r/20191021160952.GA229204@google.com/
>
> I guess this problem is still unfixed?  I hate the fact that we broke
> something that used to work.
>
> Maybe we need some sort of DMI check in ricoh_mmc_fixup_rl5c476() so
> we skip it for Toughbooks?  Or maybe we limit the quirk to the
> machines where it was originally needed?

Both options seems reasonable to me. Do you have time to put together a patch?

Kind regards
Uffe
