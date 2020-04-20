Return-Path: <SRS0=uOye=6E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAA0C3A5A0
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 08:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098EE206B8
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 08:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jb1MGt9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgDTISu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgDTISu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Apr 2020 04:18:50 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE75C061A0C
        for <linux-mmc@vger.kernel.org>; Mon, 20 Apr 2020 01:18:48 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id v24so3287423uak.0
        for <linux-mmc@vger.kernel.org>; Mon, 20 Apr 2020 01:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=It2vA21CwHolWpfirZrNfml7BAn8xW9KliuigaVPmQc=;
        b=jb1MGt9S2UQTTMPIjIj59TqFDBsCYHvXydQP1BV/FKasi9ecAniUpbEZyM4n0wyUBI
         rEIVIB1SoIuUQ5/RtDynoWn+x9z6lPx8chOdzQDtQcF2OTurfPvimcChtZQhDoyth90s
         dHKt9NIZkh4+iVw/+Lk17lOt/fj4pGvaPNBwaXS2CdhLeuei0Rcran3pkuRSZkRD84yA
         G4yw7PpFjYRALt+krAtZvAHqMROyloyKUh6xdZtzQncj0wt8XZYtre6TCDpaM+K2ostp
         2Owmu8mpy9iVy1UsL0gNXmRa2aIfHWNYANkVzvRTnLfpuqWqXBCNdvwvO9kA9PtNohDH
         vPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=It2vA21CwHolWpfirZrNfml7BAn8xW9KliuigaVPmQc=;
        b=MXZu8kOPU/NBcfJbRkT/VbGASgLK9p9YgnIHMdKEaszn0kbRAzgyy3Ms/2dFB3QF4X
         2quxmOau+6H1qxmjkclTttf9nLlmvzUgQuUlagTJ8FvYBqJA8QV/fyJZLQzsV735X6NY
         2iLUHqq6b5h1AOycmHOpVuRqHapdqkDQWBeRoel2Bp/gpA07E6kFhXNP71ZzMIyj5LC0
         BPhyPqJ6X+e80uRs9ROoawxDjJkz9jEJ+Qg+AvOUdGmNk1uZPp7DLTFsUXm5/w5HBoOH
         HooHhcAUPEyyb6ILrxvoRfOKtWCjsN+97gl+yvXnI0y5kwNTEoRgKLijyEolQb45p+Lf
         1DPg==
X-Gm-Message-State: AGi0PuYUmjhdTI+w4V10w5Judr8aLDhSCi/37r0d2RoHVve+KUMOm5wL
        1sRAzS1ZAm/B+EUq7vfQD6uDWlvZhzozWiEFuJF/BwXtaRI=
X-Google-Smtp-Source: APiQypJtk77V1X8LIw0dAU5kX+wiqu7ySYUsJUq3LKsJR6m83qHiqqkP5jl/C3bqjnClwMvFKIlOPeqfCMfE1azjEhY=
X-Received: by 2002:ab0:6588:: with SMTP id v8mr6243394uam.100.1587370728146;
 Mon, 20 Apr 2020 01:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200416163649.336967-1-marex@denx.de> <CAPDyKFqztJDfTrc+1q9mdyf0f2s=gE91J3eM92rzmm+FJNBW9A@mail.gmail.com>
 <11a78052-6320-2986-42b0-3f5536b8c061@denx.de>
In-Reply-To: <11a78052-6320-2986-42b0-3f5536b8c061@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Apr 2020 10:18:12 +0200
Message-ID: <CAPDyKFpQXaQ+rOX7f+zLfG2Q6fX3FsDk8d+uBtxAcLNkKPhAxQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] mmc: Prepare all code for mmc_regulator_set_vqmmc()
 returning > 0
To:     Marek Vasut <marex@denx.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick Delaunay <patrick.delaunay@st.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 17 Apr 2020 at 17:33, Marek Vasut <marex@denx.de> wrote:
>
> On 4/17/20 11:30 AM, Ulf Hansson wrote:
> > On Thu, 16 Apr 2020 at 18:36, Marek Vasut <marex@denx.de> wrote:
> >>
> >> Patch all drivers which use mmc_regulator_set_vqmmc() and prepare them for
> >> the fact that mmc_regulator_set_vqmmc() can return a value > 0, which would
> >> happen if the signal voltage switch did NOT happen, because the voltage was
> >> already set correctly.
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> >> Cc: Linus Walleij <linus.walleij@linaro.org>
> >> Cc: Ludovic Barre <ludovic.barre@st.com>
> >> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> >> Cc: Patrice Chotard <patrice.chotard@st.com>
> >> Cc: Patrick Delaunay <patrick.delaunay@st.com>
> >> Cc: Russell King <linux@armlinux.org.uk>
> >> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> >> Cc: linux-stm32@st-md-mailman.stormreply.com
> >> To: linux-mmc@vger.kernel.org
> >
> > Applied for next, thanks!
> >
> > I took the liberty to re-work and simplify some of the code, please
> > have a look at my next branch to make sure I didn't screw something
> > up.
>
> Where is your next branch ?

It's listed in the MAINTAINERS file.

git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git

Kind regards
Uffe
