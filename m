Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6B8C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Mar 2022 08:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242362AbiCYIMx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Mar 2022 04:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353780AbiCYIMw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Mar 2022 04:12:52 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363D0CC51D
        for <linux-mmc@vger.kernel.org>; Fri, 25 Mar 2022 01:11:18 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2e68c95e0f9so75301817b3.0
        for <linux-mmc@vger.kernel.org>; Fri, 25 Mar 2022 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pSTUw1isDTQu4uKtmzMCDZQ9+KLkZLeGuSkORU++Lcg=;
        b=V1GySvVYzzix/JtoKqKBvhUXKlD7KInX6IvRLIXr/GHMsGmX+LyieOoofqnoUaRAN9
         xVh4gkN5MUGugQAvm3NVjy4NlFbDFW+J91IOeW0SlmWUMf+R9bdKMJfcaVtt863bO1RG
         b5lsWjVvFNb2lFHK5jCzzcHIdcBY1wmr2YR5gkWNr4NFzsJTI6vWXkr31jsKxqQoHzuQ
         3dOufsVNbKp7S78Y3bnNXsTExCuk/qwS0oAhJV5Jf8zOX5J+8XIKzlN4/eg8IPM1siXZ
         fMv7qb/gXw91Dqh6RS07Idl3VY7uP9uTsGmVyqfzB9VQEDH85GRZEhgntvSd1V4hERII
         mBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pSTUw1isDTQu4uKtmzMCDZQ9+KLkZLeGuSkORU++Lcg=;
        b=Vqg9RUm2cEeI6ylkMDm+4FwCieYMSuTm/4keMrhL4ArCweLpbASxOAhrnJallheibz
         soBuS0ki3WbFOnIU7op2xdfjlMpl3ODl1P1qUShFw7Ov5BEPrMyTXYTL4Rp3Mcy5D8k7
         8cVFvEukZCMg8VRfGrrgUPI0WkOKEkuE1yL0Cl/NZJ6stkovNDV3hk0+PI2YkzkW9vXC
         CvOLWVgMqVcbGRbRZnShKm/r1VYcrfG/eL794jbKpbwhrPUI0j3UQCEev/+y9vqWzSSq
         KC3zAWs+pZtpbMx3/XNjtkrvl+S4KZy4UJvrovT5sQFRKdIzL1JWq6OoxdaRt03O5Aqa
         VkNQ==
X-Gm-Message-State: AOAM530JKarfitlCZ2rQoY/fpJEnACDHdT9itkRc4uzm+EaZQyKYbRsy
        iDFsx9XutsgpFIUUQE/Ft9JXXLxsyY2mVSyRZxhkDw==
X-Google-Smtp-Source: ABdhPJzUMpnFAfasxH2efivhxekUuia7PrCumtriBF97AGOsxOz5XVrwherILvkayLPL/Zsu4MPulD1loVFxYbQ7e/Q=
X-Received: by 2002:a0d:d84f:0:b0:2e5:f8f1:7272 with SMTP id
 a76-20020a0dd84f000000b002e5f8f17272mr9213364ywe.376.1648195877410; Fri, 25
 Mar 2022 01:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220222033931.237638-1-jasonlai.genesyslogic@gmail.com>
 <20220222033931.237638-7-jasonlai.genesyslogic@gmail.com> <CAPDyKFoDkxg1b0k4s_+F+eS8EUVM9ZabiwNc4VVQuCexLWNpsw@mail.gmail.com>
 <20220324012929.GA6955@laputa> <CAPDyKFrJx2ZUR-_+6j0nL4U6P_NvH7b-21Tpz9xN1LPuhr+VSw@mail.gmail.com>
 <20220324105007.GB13268@laputa> <CAG0XXUEWUPXtc6b_5t3cL37gjccm9XMPFzrkPnTH1iUexayTDQ@mail.gmail.com>
In-Reply-To: <CAG0XXUEWUPXtc6b_5t3cL37gjccm9XMPFzrkPnTH1iUexayTDQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 25 Mar 2022 09:10:40 +0100
Message-ID: <CAPDyKFoiTAcXmk6TgZ96Kz5No-EcETYOoLdg+uyjA9+SUU+wtA@mail.gmail.com>
Subject: Re: [PATCH V3 6/7] mmc: Implement content of UHS-II card
 initialization functions
To:     Lai Jason <jasonlai.genesyslogic@gmail.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>, dlunev@chromium.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>,
        Jason Lai <Jason.Lai@genesyslogic.com.tw>,
        otis.wu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 25 Mar 2022 at 04:54, Lai Jason <jasonlai.genesyslogic@gmail.com> wrote:
>
> On Thu, Mar 24, 2022 at 6:50 PM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > On Thu, Mar 24, 2022 at 11:22:16AM +0100, Ulf Hansson wrote:
> > > On Thu, 24 Mar 2022 at 02:29, AKASHI Takahiro
> > > <takahiro.akashi@linaro.org> wrote:
> > > >
> > > > On Wed, Mar 23, 2022 at 05:15:59PM +0100, Ulf Hansson wrote:
> > > > > On Tue, 22 Feb 2022 at 04:40, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
> > > > > >
> > > > > > From: Jason Lai <jason.lai@genesyslogic.com.tw>
> > > > > >
> > > > > > UHS-II card initialization flow is divided into 2 categories: PHY & Card.
> > > > > > Part 1 - PHY Initialization:
> > > > > >          Every host controller may need their own private operation to
> > > > > >          establish LINK between controller and card. So we add a new member
> > > > > >          function(uhs2_detect_init) in struct mmc_host_ops for host
> > > > > >          controller use.
> > > > > > Part 2 - Card Initialization:
> > > > > >          This part can be divided into 6 substeps.
> > > > > >          1. Send UHS-II CCMD DEVICE_INIT to card.
> > > > > >          2. Send UHS-II CCMD ENUMERATE to card.
> > > > > >          3. Send UHS-II Native Read CCMD to obtain capabilities in CFG_REG
> > > > > >             of card.
> > > > > >          4. Host compares capabilities of host controller and card, then
> > > > > >             write the negotiated values to Setting field in CFG_REG of card
> > > > > >             through UHS-II Native Write CCMD.
> > > > > >          5. Switch host controller's clock to Range B if it is supported by
> > > > > >             both host controller and card.
> > > > > >          6. Execute legacy SD initialization flow.
> > > > > > Part 3 - Provide a function to transform legacy SD command packet into
> > > > > >          UHS-II SD-TRAN DCMD packet.
> > > > > >
> > > > > > Most of the code added above came from Intel's original patch[3].
> > > > > >
> > > > > > [3]
> > > > > > https://patchwork.kernel.org/project/linux-mmc/patch/1419672479-30852-2-
> > > > > > git-send-email-yi.y.sun@intel.com/
> > > >
> > > > To honor the original work, we should add Intel's copyright notice here
> > > > as I did before.
> > >
> > > I think Jason already did, at least for some of the files in this series.
> > >
> > > Note also that, the initial code that was posted, is very far from
> > > what code that is going to be merged. Simply because the quality was
> > > very poor and not acceptable for the upstream kernel.
> >
> > I don't think so.
> > I don't see much difference from my modified version[1] which is also
> > based on Intel's original work.
> >
> > [1] https://www.spinics.net/lists/linux-mmc/msg57321.html
> >
>
> I agree with most of what Takahiro said. The data structure and command
> packet for UHS-II followed Intel's original work. But Intel's original work
> cannot actually work. UHS-II SD card was supported successfully after Ben
> and Takahiro's hard working on patch set [RFC V3.1] Add support UHS-II for
> GL9755: https://patchwork.kernel.org/project/linux-mmc/list/?series=378627&archive=both
>
> In my opinion, keeping Intel's copyright information at head of sd_uhs2.c and
> sd_uhs2.h like listed below is a good idea. What do you think?

I have no problem with that.

However, I have to admit that I still think we have some more work to
do with the patches, before I am ready to queue them. In other words,
the decision is probably best taken a bit further down the road.

Note also that we have other ways of giving companies/people credit,
without using the copyright thing. Like the co-developed by tag and
mentioning companies/people in file-headers and commit messages, for
example.

>
> // SPDX-License-Identifier: GPL-2.0-or-later
> /*
>  *  linux/drivers/mmc/core/uhs2.c - UHS-II driver
>  *
>  *  Copyright (C) 2020 Linaro Limited
>  *  Author: Ulf Hansson <ulf.hansson@linaro.org>
>  *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
>  *  Copyright (C) 2020 Genesys Logic, Inc.
>  *  Authors: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>  *  Authors: Jason Lai <jason.lai@genesyslogic.com.tw>
>  *  Copyright (C) 2020 Linaro Limited
>  *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
>  */
>
> kind regards,
> Jason Lai

[...]

Kind regards
Uffe
