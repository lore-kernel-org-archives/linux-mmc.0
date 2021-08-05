Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34794C432BE
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Aug 2021 12:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1973060EE8
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Aug 2021 12:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241528AbhHEM71 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Aug 2021 08:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241476AbhHEM70 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Aug 2021 08:59:26 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F41FC061765;
        Thu,  5 Aug 2021 05:59:10 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id p145so8806653ybg.6;
        Thu, 05 Aug 2021 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gr9Gh5+vW9OZGr0SdSE84N+LH4Roo172IAFuTaYSsHc=;
        b=UMF1LkczVhYv53Rkxvd68wjp6e1keFmFZHkecWPux656gXCsVPnbJmQrwxeHMrGaVD
         U2JK6ZQL35+kYws5pOSCD3+CwEahggY2W7ThYoOrLs1i/cSyUOy1lOOtKNavUmAf5bNv
         d2vMfAFOsx79YomW3JjfUvc5riwP3QXNui+VQyIhZlfmQWiK6hLfmNXvthfnUqjzzt8E
         F1qg06+TUxyaMP/UEYgxXypYGl6NRGFKNGKoVsftBCz4NHyt1xBVbBASkvFnhwgJ3Wos
         NEtiymokeRoVNOQsoRvIfeIQKtxYOuelB5482263D9uulsVostxXkvw/fNeVU+XfaQvY
         MNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gr9Gh5+vW9OZGr0SdSE84N+LH4Roo172IAFuTaYSsHc=;
        b=Tx3+Gb0dwI7yyVLqiESeIUb4YjY9UJgdXrpJYaGMx/L7+ieoKWotauUmvBH8FAr0B1
         9kx6gpyrsmwKdwPYHyelrU92AIrdPGHnMCRBsKiBXRZLz44w6CmfBJQ57MGgsm/sbgL2
         d+XEiK3f1c9Dv4fEzipvUepjNhYeB3v93phWBSuov4kFDC4HnAHA+QMQU9kgRAHGjb1b
         gQ76LvY1o1Ns40wgjPhD4j3eg34NX0H5jeUsj8Hqj9ANfZLHULIpIPQwsgTKav+fsfXq
         GGVsJM1T/Ma00iN0O1Q3LPPvKbmiAf/KR5z4a7qSm/qUZXGbxaHzQ1twd3uybN7w3Rmy
         AEAQ==
X-Gm-Message-State: AOAM533jIL49qoyK4YddaxXM4UmPfWHlOKykENDGrqdt6d+pDCqyMtc3
        B/HdNq+TSj4rrsYg4TCK1JtOLZANPbx2V4I30kY=
X-Google-Smtp-Source: ABdhPJzTFyojU4VvqWJeaPQvyuMEUhC/vsMMTaMSuA/VzNXwGQQ5ZzAWDGxr9U51I0oKJSPwO2T+SqlWDl7cNfFxIeg=
X-Received: by 2002:a25:2cf:: with SMTP id 198mr5906026ybc.259.1628168349741;
 Thu, 05 Aug 2021 05:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210804143357epcas1p1c67eca591d8bb557c11b8175baaa8550@epcas1p1.samsung.com>
 <CAMdYzYrx8pgeyK7u=kcopZ+Wae+fQdr_uM4AuVjqWKfZYikgcA@mail.gmail.com>
 <a9aa636e-326f-a848-dd69-41df87c013af@samsung.com> <CAMdYzYr9PX-9=kkCAfGe8Q0-D+gRo_qCwse8SiGVsmod7fffiA@mail.gmail.com>
 <20210805124650.GM26252@sirena.org.uk>
In-Reply-To: <20210805124650.GM26252@sirena.org.uk>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 5 Aug 2021 08:58:58 -0400
Message-ID: <CAMdYzYpR6br7s1RD2ze92WzJjtEDZwy9qS6YhghgXy7F91keFg@mail.gmail.com>
Subject: Re: [BUG] mmc_regulator_set_ocr can't cope with regulator-fixed
To:     Mark Brown <broonie@kernel.org>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Aug 5, 2021 at 8:47 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Aug 05, 2021 at 07:38:06AM -0400, Peter Geis wrote:
>
> > Also, I've got a possible fix to the dw-mmc issue, the following patch
> > changes the behavior to only enable a fixed regulator, not try to set
> > the voltage. It's a split between the behavior when vmmc isn't defined
> > at all and when its a variable regulator:
>
> One thing to watch out for with this approach is if there's things that
> really need a specific voltage to be set then you'll have to stop those
> things happening if you've got a voltage regulator that can't deliver a
> voltage in the required range.  I don't know if this affects MMC or not,
> if it's just a case of being less efficient it's not such an issue.

Yeah, but if this is a fixed regulator and it's a problem, then the
hardware is screwed anyways.

>
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index d333130d1531..b30102980261 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -1446,11 +1446,13 @@ static void dw_mci_set_ios(struct mmc_host
> > *mmc, struct mmc_ios *ios)
> >   switch (ios->power_mode) {
> >   case MMC_POWER_UP:
> >   if (!IS_ERR(mmc->supply.vmmc)) {
> > - ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
>
> This patch is very whitespace damaged FWIW.

Unfortunately gmail doesn't let you reply with patch sets without
mangling them, so it's only useful as an example.
If it seems sane I'll send it as a proper patch.
