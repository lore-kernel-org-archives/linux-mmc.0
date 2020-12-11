Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7EDC1B0D8
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 13:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B9623EF1
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 13:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390622AbgLKNys (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Dec 2020 08:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390535AbgLKNy1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Dec 2020 08:54:27 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF84C061793
        for <linux-mmc@vger.kernel.org>; Fri, 11 Dec 2020 05:53:47 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 143so8397537qke.10
        for <linux-mmc@vger.kernel.org>; Fri, 11 Dec 2020 05:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=am+2yk9rlqtbVhZwrF/QYG0TW4go4+v58RaDE0YJVkg=;
        b=sjiP97iCb6jEqk6pJZ3bNHdcNGmg/71IMWS9q4+NTagiACQCiHxHikgrxKMxKBHUhC
         sV6bN4wVP2WDjLSNk9zKtsoGacAjiZ0mSjtvtwpQyM9+rDgEKIpZCckS7BiQSyBfvkS8
         U9AKLvJr4jVOcuhwkZrWcZH7Rf28UJWFv4UdYT/tuvlR2qV4vDhmnnTKgX99RQrjAO9Y
         6rfoPEy1zuxvJ/YHMs0dANUbT2B2Va7pO1k18Mp8QG6jzkmDBY9r1X1YbCL93hX8ZFaU
         MnBISumAB6jg2oU/yTFzEELFnh3Uh/4qimiPRR6Dunf2OcZJsnPZ6IV3qdFQhJ0RzDHL
         O+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=am+2yk9rlqtbVhZwrF/QYG0TW4go4+v58RaDE0YJVkg=;
        b=ULkVIOSV5Oe4/saZNvaefbd/u0VJaJt7qG/IVOzAhPB5sE6YTP/u5OA2a9pIRixXdp
         tO871uFeJqrOcxfME3nbBKcNQvrwxbRgfRkgmVGmx8C/9IS2Ccdqm3f1fm4arjIB8beh
         r1iEDoRXTactHElG0RUmKLJ9P35gkj31pW6kybh3Nm7A3hUCOEpULop4qvYSOYIEu2zo
         CPaLaSKPaqRDVj3kTEwuGYwE145N0O3UvQNytfDRc8UsvbrPP68dxRkjHTFVrwncZ7QS
         z8A/Brisw30s51e/et37KGNGV91I0bX3/ceCz837S+zLyCmvDxpaThyZANe0IOKq31Ko
         Z93w==
X-Gm-Message-State: AOAM530/vw7c0JfVZ6y1PsbN3JRvUlXyv6F+StjqlE4orgdf6oSzg4TJ
        xlpNkYK9hZh9BeEhG4/8SmtRPb7E+YccYHROijMuTA==
X-Google-Smtp-Source: ABdhPJyYWBakyT3hEXmuJsjvfwnz/oJCdb47wQHHewrJcLM78CiAQFbOrOyMziUWC7me0hhSdrQwgJD2iEBZ93bw08w=
X-Received: by 2002:a37:2cc4:: with SMTP id s187mr15797755qkh.385.1607694826325;
 Fri, 11 Dec 2020 05:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20201204171626.10935-1-mw@semihalf.com> <CAPDyKFooRuitBjVr7FoMbty3rmM3eOsLKqwF5=ZQ=Aj6r29h+A@mail.gmail.com>
In-Reply-To: <CAPDyKFooRuitBjVr7FoMbty3rmM3eOsLKqwF5=ZQ=Aj6r29h+A@mail.gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 11 Dec 2020 14:53:35 +0100
Message-ID: <CAPv3WKevssDOq72xF+ciLdCGC5EZNpnSCb4Sw3PiEfnqb-ZG5Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] sdhci-xenon ACPI support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ziji Hu <huziji@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Kostya Porotchkin <kostap@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

pt., 11 gru 2020 o 14:47 Ulf Hansson <ulf.hansson@linaro.org> napisa=C5=82(=
a):
>
> On Fri, 4 Dec 2020 at 18:17, Marcin Wojtas <mw@semihalf.com> wrote:
> >
> > Hi,
> >
> > The fourth version of the sdhci-xenon ACPI support
> > addresses a comment regarding clk handling in xenon_runtime_resume.
> >
> > The MacchiatoBin firmware for testing can be obtained from:
> > https://drive.google.com/file/d/1Y8BhyaCrksQgT_GPfpqqiYHpQ41kP8Kp
> >
> > Changelog:
> > v3->v4
> >   * [3/4] Call clk_prepare_enable unconditionally in xenon_runtime_resu=
me.
> >   * Add Adrian's Acked-by to all patches.
> >
> > v2->v3
> >   * [3/4] Call clk_disable_unprepare unconditionally.
> >   * Add Adrian's Acked-by to all patches.
> >
> > v1->v2
> >   * Split single commit to 4
> >   * Use device_match_data and dedicated ACPI ID's per controller
> >     variant
> >
> > Marcin Wojtas (4):
> >   mmc: sdhci-xenon: use match data for controllers variants
> >   mmc: sdhci-xenon: switch to device_* API
> >   mmc: sdhci-xenon: use clk only with DT
> >   mmc: sdhci-xenon: introduce ACPI support
> >
> >  drivers/mmc/host/sdhci-xenon.h     | 12 ++-
> >  drivers/mmc/host/sdhci-xenon-phy.c | 40 +++++----
> >  drivers/mmc/host/sdhci-xenon.c     | 91 +++++++++++++-------
> >  3 files changed, 91 insertions(+), 52 deletions(-)
> >
>
> Applied for next, thanks!
>

Thanks a lot!

Best regards,
Marcin
