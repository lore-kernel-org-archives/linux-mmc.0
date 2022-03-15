Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DFFC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Mar 2022 12:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245531AbiCOMYd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Mar 2022 08:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241910AbiCOMYc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2022 08:24:32 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C93639F
        for <linux-mmc@vger.kernel.org>; Tue, 15 Mar 2022 05:23:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w27so32690546lfa.5
        for <linux-mmc@vger.kernel.org>; Tue, 15 Mar 2022 05:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sb104aj3tjLKyTTZ17U/Klg2aBSSJ2T/5c6D895wNBw=;
        b=EKPJ4DTBgq1DS2BRevHWl8q2iA30+g+EpaPb32GmUpkfz6F9SIgFvoxLwtDVSmVnc9
         o4QCgNSFdCUehk+XZ06HqikO+9nVCx2GZ0p5otm+Zz/Jn1JCrgp9c4Oj8pASpU4tszeq
         U6bgOy/C/rTInOq21QMcQzfEkFSDw0PCOMXqmV1oNJEl2DNtoC9oVyIKO+mjsQBBcEbV
         mroOVOpOGvmGmenjIO233FBscoMB8PD9OTym9PsGjI3oGy7JrzoaEK6U3+bCt59XbHiv
         +QWeP8yTegN+YXO+E0WXIVXCXySLaiURu2jpPLeTmAAOXrHveXhYA1nYE9wDqcDypBRO
         rhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sb104aj3tjLKyTTZ17U/Klg2aBSSJ2T/5c6D895wNBw=;
        b=r58nmZyvN+7/0JUD8kR2IHjFr86xDlfftOcTmjAIVO3egM2Rswhlz+Iz4aq8B1PA7s
         gEg8LnR+LvFXahdLq1jCI/+r6eJO7VLCn5dUfWcZwYTR1XFmRSuxsBgjTDQ6it7EiRhA
         KwpNbTZof6SqK2oJ6kewuFZQ4NNfN945pQf1y+IiicSa9pYTVVkBY/E3TobyC2EUYgR1
         M0MP5PzT2Zr4AQ4S1XZYrbpwZ2ngBhKVTRH/6+32L2YEgN5k8tAiu6PqBJtOnCYBTotH
         SCvdY0ejThr3vXHTQ49iMQJ6LQLiRpHodfWfh3t6t9Nak7XSedIp1z7P/WlrcTpERytD
         EObw==
X-Gm-Message-State: AOAM532/D4lVg9vwbSlI4LaHVGuxezz0B0eDosL1zGiPtvPMi/b8qVgP
        cz5U8V9c8qIIIBwnlyOy2zjkfnwrfO9L1YpLWRq2WQ==
X-Google-Smtp-Source: ABdhPJwSjQ5oQZjfEtoR4Ve6sp8VlABql5PGdoO9Q/flDYRac285+1HDvAlszXmV6KA6EFPeME165019ThdE01YY4Ts=
X-Received: by 2002:a05:6512:3b07:b0:448:27ab:4a0f with SMTP id
 f7-20020a0565123b0700b0044827ab4a0fmr16658811lfv.373.1647346998734; Tue, 15
 Mar 2022 05:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220303164522.129583-1-ulf.hansson@linaro.org>
 <CAPDyKFod3LdfRRgVfdASqgSBAXqJnGkdKMM9qKnAYcfUQptF_g@mail.gmail.com> <ece53010-b7ed-6b12-1baa-08505537854d@gmail.com>
In-Reply-To: <ece53010-b7ed-6b12-1baa-08505537854d@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Mar 2022 13:22:42 +0100
Message-ID: <CAPDyKFosSVMOXtin149h=YaLeMEUq3Q0-xwYcg0ZgcfWRbawvA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Improve fallback to speed modes if eMMC HS200 fails
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yann Gautier <yann.gautier@foss.st.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 14 Mar 2022 at 23:02, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 14.03.2022 11:54, Ulf Hansson wrote:
> > On Thu, 3 Mar 2022 at 17:45, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>
> >> In the error path of mmc_select_hs200() we are trying our best to restore
> >> the card/host into a valid state. This makes sense, especially if we
> >> encounter a simple switch error (-EBADMSG). However, rather than then
> >> continue with using the legacy speed mode, let's try the other better speed
> >> modes first. Additionally, let's update the card->mmc_avail_type to avoid
> >> us from trying a broken HS200 mode again.
> >>
> >> In an Amlogic S905W based TV box where the switch to HS200 mode fails for
> >> the eMMC, this allows us to use the eMMC in DDR mode in favor of the legacy
> >> mode, which greatly improves the performance.
> >>
> >> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Heiner, does this solve your problems? Can you perhaps run some tests
> > at your side to see how it works for you?
> >
>
> Tested-by: Heiner Kallweit <hkallweit1@gmail.com>

Thanks! Patch applied for next.

[...]

Kind regards
Uffe
