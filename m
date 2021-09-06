Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC33C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Sep 2021 17:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7296A6101C
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Sep 2021 17:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbhIFRLK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Sep 2021 13:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbhIFRLK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2021 13:11:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E5FC06175F
        for <linux-mmc@vger.kernel.org>; Mon,  6 Sep 2021 10:10:05 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l18so12268361lji.12
        for <linux-mmc@vger.kernel.org>; Mon, 06 Sep 2021 10:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=fCleQtbuJdHg+Nr280Yxdci6j06NCu83yvvFVNDw9ZY=;
        b=Af5MutCHbc6t6izDBTNWd27dgXM0dmNvp9qAzoeuRik8AJL1e7gXuaA/h/a9VU3hq6
         O9ssRGj4t8zgx5v9J6WuO2+/zca5Z9HwGRSfSTy4ygvdAiAFyFIex2bzo/Sw1GMhwd3P
         Z4gMjuPopj7hqESwMhAXK90+0aKlboxEoAIVOGuQyLHdsGYpXkUxdQVYDaWWr9nrwTg6
         d9/Ge4p/wdwSKFZ1WXfszzuIw2tdcjyW+ygW45HB9LvK4UyJZ4nbYAfFy8Of34GRzlGU
         K6dGaZ/5b1Nx3sWnRKx6wl5tBM66lfCMS6UMY9+bZWfYKkvqdo0pH6VB0fLXCYS9RNJr
         AuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fCleQtbuJdHg+Nr280Yxdci6j06NCu83yvvFVNDw9ZY=;
        b=TsdQk0iPPEBDGLkHD9nmG8gwz4WWeG3pSnR98+ju4A93S2bJn41h+KmsxUuM2hfrJQ
         wX0hAK/7Pz4DrqdTmfow7OSPHt+qCD/CJocZtCDCP+l3acO7Ve3uWtPMrUqXtJ/RPV9z
         YzWaL2vo8qSqbDBBAx/ejRU7aiHlteJ9NAPj0UvH1x49VnPxJ/JI+SvJ8o7gqlc/GMEb
         aKOE3hmxCD7aAITGwir7rjOEmd3MVy5ndR91lakhULbQwDncdbDYdGNzF6jbTLWQ2Un1
         R7jEQCSXGgd8bSa8aX2fDGKbc2tvdZXHTiD8letkTdhzjSUORtYmUpgYwPhclcUrB5u9
         BfEA==
X-Gm-Message-State: AOAM532dLC4SpVAbjxW62imStrgN8nOo/MYZrA2l/jTjyCksNZQcvQaG
        vrcgrfVR9gRwWfR0p00ka7EfJ46zfhMt2qRpTjm1uA==
X-Google-Smtp-Source: ABdhPJw1iMzSoMUPz/R39/6CtfKDhCXT4P1PDrScVpBH4hduR2Z71WsCF3Cwcm9417fdkuQ9J9wI2gHSUjZPeDyxiSk=
X-Received: by 2002:a2e:9b0b:: with SMTP id u11mr11407330lji.463.1630948203483;
 Mon, 06 Sep 2021 10:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210826082107.47299-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdUXc0oSCXJ-5QmPJz0VkX1Aib+ZAv8K2LN_fT1+5mocqw@mail.gmail.com> <YSelsjPyswWCr7Nu@shikoro>
In-Reply-To: <YSelsjPyswWCr7Nu@shikoro>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Sep 2021 19:09:26 +0200
Message-ID: <CAPDyKFp2Ut4UJoRXPD4t+k1+ZfmT-CQZ3obNA_iPF6OA-t+T7g@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: fix regression with hard reset on old SDHIs
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 26 Aug 2021 at 16:31, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks a ton for testing, Geert!
>
> Ulf, any chance to get this into 5.14?

Apologize for the delay!

I have applied it for fixes (v5.15) and added a stable tag, hope that's okay.

Thanks and kind regards
Uffe
