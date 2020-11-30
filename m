Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A1EC64E8A
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 14:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB9CD2084C
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Nov 2020 14:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xet7tFpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgK3OYi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 09:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgK3OYi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Nov 2020 09:24:38 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDD9C0613CF
        for <linux-mmc@vger.kernel.org>; Mon, 30 Nov 2020 06:23:57 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id d8so22004054lfa.1
        for <linux-mmc@vger.kernel.org>; Mon, 30 Nov 2020 06:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hhbQM/sbr2CHe5EHv+ujytFkENJF0h8W5fBJewPsOfw=;
        b=Xet7tFpX/IQuXTxXpFwm99lWbqgFGmcbZE9SxK231CTPvJCKt926rYMUd5MbD2E8tT
         mlsOxvp+ChtAxwAL34cBir6cmxDuDT5j2G6JIuufF/IRfYsBY/RYYYRdw0Hfy0zYO/IE
         bkao1Jd8rkIbLjsIJL0VLdX+e08eWGbZR5PgcJ5H/VakOmx64xBAf+p8mXXwWVymH+3h
         ownaLB7atIzrP0Po0cVtIbRzylM4hESJ+u2M9s+BYvwuZGU6X6Vc1CLHm+EjMkYvJcS1
         o+tbq6zmEKYeWZD9qdvMfhb/CZyhQMPkDx5won9rB3ivzq+pCeVVDy3spA1i1+zXLWv5
         OL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hhbQM/sbr2CHe5EHv+ujytFkENJF0h8W5fBJewPsOfw=;
        b=FTvSP8wSjpdy0QstNyl571nXDSA1FVl+VMMOCWMFqj8tP6zvfoamxPwYob5onA/6YP
         /0htSG0dm4J//aPND5Moo8MxwIEpQwVOHY4BT8g9vJXZ4n5SynhmFZKLXtWJ1KknVKiN
         80zB3+35MVeKDOkEhqMWC5iz7864oFP3C5ZET/Vz5kXFrEbkFU5AazzxPDh71rCo08UV
         nTAomwtzdAxzJ3JguWwgxVGq1nwfxso+QZE2ri94fEJ0nb9n2v9GoeVKMepMaCWGnk5B
         fWz1v69q50IRReja0pjTfY/avZwmJ4a++uKsm92dFvmdTZlLfLb8o0qvJ53t9KMn1+nA
         uNCQ==
X-Gm-Message-State: AOAM532PGJcTQiRqpEgGl0e1cMLcjMjRc9lD2XURctnXS5qg9mtIQh0c
        dnOwwCA06yu6InFmx8Clwr5russ8LfCTaJ2vIoftPh3SKOsfag==
X-Google-Smtp-Source: ABdhPJxvJG7WPutxaLEoJfdGYySNAbfRXcrrg9htj/qC/ffqjGYKVoL/FZ/ySGF70IKMZt325BUu0HA7MDH4cumlPA4=
X-Received: by 2002:ac2:51b4:: with SMTP id f20mr8924349lfk.338.1606746235490;
 Mon, 30 Nov 2020 06:23:55 -0800 (PST)
MIME-Version: 1.0
References: <CAD56B7cpMcuu_+9bxQ0zCsr489J9Te268aOeQTC32rOeF1hG+A@mail.gmail.com>
 <9e5da13d-cb0d-3190-11d1-556d05178966@xilinx.com>
In-Reply-To: <9e5da13d-cb0d-3190-11d1-556d05178966@xilinx.com>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Mon, 30 Nov 2020 09:23:43 -0500
Message-ID: <CAD56B7ePLTSAbcc8RkMt3WxOEezRN_cTv9Cq1_YCRTDQ0VLtDQ@mail.gmail.com>
Subject: Re: mmc: sdhci-of-arasan: Issue DLL reset explicitly
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, git <git@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Nov 27, 2020 at 2:12 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> Hi Paul, +Manish
>
> On 27. 11. 20 4:49, Paul Thomas wrote:
> > Hi Everyone,
> >
> > The recent commit d06d60d5 'mmc: sdhci-of-arasan: Issue DLL reset
> > explicitly' seems to break the eMMC on our zynqmp boards, we get
> > messages like this:
> > mmc0: error -110 whilst initialising MMC card
> > We're using the XCZU2EG-1SFVC784I parts [1]. I see that this is moving
> > the DLL reset out of ATF. So part of the issue might be that we're
> > using the 2019.1 ATF version.
> >
> > thanks,
> > Paul
> >
> > [1] Enclustra modules:
> > https://www.enclustra.com/en/products/system-on-chip-modules/mercury-xu5/
> >
>
> Can you please try any latest version if that fix your problem?
>
> Manish: Please take look at this issue and try to replicate it.
>
> Thanks,
> Michal

Manish pointed me at the firmware patch here:
https://lore.kernel.org/patchwork/patch/1338926/

This fixed the issue for me. Thanks everyone.

-Paul
