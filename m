Return-Path: <SRS0=WBH1=6A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A054C2BB55
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 12:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4BB20767
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Apr 2020 12:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LSxq7bWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634831AbgDPMHk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635002AbgDPMHh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2020 08:07:37 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60524C061A0C
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2020 05:07:37 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y15so2229248vsm.5
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2020 05:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqK9vQ7uGVRX9EHsY2IXKQ2OQL2LPfO4oHpQbQH0pZ8=;
        b=LSxq7bWjMbSX3AuwKUh3cNpQt/nN7PvEFYiQB9rgjEvR0+dRmCdIMIqoXYMhiblyaw
         C91Dd7UOwgN9yPg5X/DFkqiTma1eDPP/rzOsCuPeMkzxgZiGADw9WtgpjP3VStN6KoY9
         5yVRw/pcZ0V+nkcCVoJSLlDurwhMIRLW0fZxjK39nl69/FeO+zlWHm7JwOy3V1c1EyTt
         0RxSo0ZXoA2X6qaG2cwa/s7hzBY9q7YhzY3gItlnxgDGMOd4Q+ak7m1zg+nQRtZOs8HM
         K0BFFf1FAj9ZfenK+l2umXsqnuL8oqJWgb8HDX//7MOuvt4zQ21bC0uqbKs3Yz6TKu3I
         tVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqK9vQ7uGVRX9EHsY2IXKQ2OQL2LPfO4oHpQbQH0pZ8=;
        b=q744Sr4X4nrDJrpZLi7Ermlrgp9VdoxEwbJ+4Ts250jjaz88dJpt+u+9kiWKEkRSKN
         HrNvO3TECp/3c1MyQOcIDgecpi43IUjM9e20wahTlERv166dIhuL1gYowHMvU5VLTbbB
         UfU7pZcIkPwidYL+/P1jOIXDje9C0hs5nTIw/vlNf/0qZAqAxs0wGRbcwJCWa0rmOUf8
         8Z2Xc8iM7bU4NEy2OQYicDUeLeMJVKBwTLL26qHmsYZfXw2Q/v6dITRo4xJABAc7dyry
         GQ+tAni9DMwx5pEGUQjJvrGMAw4tpDWUdF29HbOrEixvstr5zFiG7fESLyQu05dJetFZ
         mQoA==
X-Gm-Message-State: AGi0Pub+Zutm+MrKNi636AiG/zO/M9easujFDI8c6lCL35N1ERgSrV1Y
        oHDXWxt9lGquhVOoWyURDtI0fOZpJB7pjfD3aJnSEg==
X-Google-Smtp-Source: APiQypIf2U2EaVxpSy4+oahhN3R6apIV7Qx6ZHTYZ7H9F80/bkUHDrRU90Fz1tgagdqlSZBnxZruBkF4YXlou7tk7Sk=
X-Received: by 2002:a67:ead1:: with SMTP id s17mr1293841vso.200.1587038856541;
 Thu, 16 Apr 2020 05:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200401195722.208157-1-marex@denx.de> <CAPDyKFoDB=d5B-2u_Y0e-XVzPQE46JBUTPwY_b_xzESm3NnjwQ@mail.gmail.com>
 <58d6bc7a-b772-e8cc-6120-b0adeb128070@denx.de>
In-Reply-To: <58d6bc7a-b772-e8cc-6120-b0adeb128070@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Apr 2020 14:07:00 +0200
Message-ID: <CAPDyKFrAgLMUqU4oSRX64VoDQMMFZuM3KtUq6SL770XDSc+QbQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: Prepare all code for mmc_set_signal_voltage()
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

On Thu, 16 Apr 2020 at 12:29, Marek Vasut <marex@denx.de> wrote:
>
> On 4/15/20 10:40 AM, Ulf Hansson wrote:
> > On Wed, 1 Apr 2020 at 21:57, Marek Vasut <marex@denx.de> wrote:
> >>
> >> Patch all drivers and core code which uses mmc_set_signal_voltage()
> >> and prepare it for the fact that mmc_set_signal_voltage() can return
> >> a value > 0, which would happen if the signal voltage switch did NOT
> >> happen, because the voltage was already set correctly.
> >
> > I am not sure why you want to change mmc_set_signal_voltage(), can you
> > elaborate on that?
> >
> > I thought we discussed changing mmc_regulator_set_vqmmc(), what am I missing?
>
> Because mmc_set_signal_voltage() optionally calls
> host->ops_>start_signal_voltage_switch() , which can now return value >
> 0 , so the rest of the core needs to be patched to cater for that.

The issue that you wanted to solve (at least by looking at the
original patch) was to understand whether the vqmmc regulator changes
voltage level and then take different actions based on that in the
mmci host driver.

You don't need to change anything related to mmc_set_signal_voltage()
to accomplish that, do you? Moreover, I am worried that it may affect
the host driver's expectations from when
->start_signal_voltage_switch() may be called.

[...]

Kind regards
Uffe
