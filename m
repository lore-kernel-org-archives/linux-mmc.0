Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B27C63777
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 10:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44B032075A
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 10:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d32flcIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgKYK4F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Nov 2020 05:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgKYK4E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2020 05:56:04 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6AEC0613D4;
        Wed, 25 Nov 2020 02:56:04 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id b144so3512474qkc.13;
        Wed, 25 Nov 2020 02:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZUhSViKlrS32eRO6QaltTNHwNv4ukAnMlkVxhlaISUE=;
        b=d32flcIto9seFSM+1Dcn2JN1g+Re5k5tTBcEYSygiwVNxMP8UGbw0fdYUc5bYliGmj
         Aa8uALs7u+ilR2uWlA5Q0w5l71qGVHLUCDZUZXWoA53kyhkFdgbIQa/EM3HnumVRUxm6
         u16LZdcDbhbgB/KPN7GfdH4lXrkdlwLbxXML+2+ZBVQQbhpE+wg50/Du48IjliQCFGdF
         xDGvvieIeN8Qz3d4FqZztjoxlRC/liteSf6j6YKn0hd2r/44s1CHYn8ztZ+xHzPXYq+y
         i6xp/3vSPSrapk9h9cKsfXcisWR8R+1o1uH9XjCTqLC7rG/A3Em0L882BywDpoReadDn
         HD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUhSViKlrS32eRO6QaltTNHwNv4ukAnMlkVxhlaISUE=;
        b=IlrSibUUFWUDLCNyEzLvEmB7dZbJH5PrRY6itxfbc0PC+1M9wN5598c5frpGiKVLfA
         /cBCkVL4d+pxqFbyDLap3Vm79M9K2bYaraIp/CotQngdj69lfqCeTvER+cysIXlRskVI
         X0Frg2BxXcsQ9vZeGsZhIp2uhx7S7HVaAgMzix8fyNj++bhFkYyfrTR1e8B0Fbzo7Y8C
         c9LveYway5UhRG8BBWagB6iyi/NwpHoFUWOoUFRoqLWaw0loSL+PTwmSr0h9KwoBQEWS
         DwpOdJyAnMrpDejmTYS2WgajHSf14xmioevE1ka1pdm9oIBk41cEg1Ur19psKQy5mfw0
         QVHw==
X-Gm-Message-State: AOAM531mRFRxo2yiYLBUuH6Fj2w3Zr7lqm21exn+7Z0npppJ7FHyKzo5
        rEaV9r3LJJZvudsomnZggDz6aT6UX+vWJF52eCM=
X-Google-Smtp-Source: ABdhPJzeJHvtr4DndqVnbtPYEEKZD7HEwW06DISDj+k+M0Dhu20GlTFvTk0+RsBdaYrNrgeDMABf4s+UiCu+gcJwTJs=
X-Received: by 2002:a5b:cd1:: with SMTP id e17mr3316511ybr.177.1606301763947;
 Wed, 25 Nov 2020 02:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20201125100004.1288-1-benchuanggli@gmail.com> <CAPDyKFp_3Vpq6ZRm5Qm1Zningz9tDqQLS_E78a8ChYHVbofB9g@mail.gmail.com>
 <CACT4zj_rrV+MFXwsnXpLD=CNjApUKozMWJMnhS6z2q5d6-dY-g@mail.gmail.com> <CAPDyKFq=r8Fwt1j7S1F5fCsMjGp6mxfWWPjppA0CVjx17MVRVQ@mail.gmail.com>
In-Reply-To: <CAPDyKFq=r8Fwt1j7S1F5fCsMjGp6mxfWWPjppA0CVjx17MVRVQ@mail.gmail.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Wed, 25 Nov 2020 18:55:53 +0800
Message-ID: <CACT4zj9qLmwZn14OV3yfs1kXS1b_7hCbtezejEVRTcW83CsZzQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Disable slow mode in HS400 mode for GL9763E
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Wed, Nov 25, 2020 at 6:49 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 25 Nov 2020 at 11:43, Ben Chuang <benchuanggli@gmail.com> wrote:
> >
> > Hi Ulf,
> >
> > On Wed, Nov 25, 2020 at 6:04 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Wed, 25 Nov 2020 at 10:59, Ben Chuang <benchuanggli@gmail.com> wrote:
> > > >
> > > > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > > >
> > > > The GL9763E uses 150Mhz (slow mode) by default in HS400 mode. In order
> > > > to make HS400 mode run at 200Mhz, the slow mode needs to be turned off.
> > > >
> > > > Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")
> > >
> > > Why a fixes tag? This patch looks like an improvement and not a fix, right?
> > >
> >
> > Since the specification defines that the HS400 mode must run at 200Mhz,
> > this patch fixes the HS400 mode to 200Mhz.
>
> The spec states that in HS400 mode the clock can be *up to 200MHz* -
> not that it must run at 200MHz. At least at those places I have looked
> at in the spec.
>

You are right. I will resend v2.

Best regards,
Ben

> [...]
>
> Kind regards
> Uffe
