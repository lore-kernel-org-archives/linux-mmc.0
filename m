Return-Path: <SRS0=Vjr6=5R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C643DC43331
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Apr 2020 08:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99170207FF
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Apr 2020 08:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZOGrrh+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbgDAIU6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:20:58 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41194 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgDAIU5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Apr 2020 04:20:57 -0400
Received: by mail-ua1-f68.google.com with SMTP id f9so8747274uaq.8
        for <linux-mmc@vger.kernel.org>; Wed, 01 Apr 2020 01:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YPnquYCxA0mlKyKmemCORNREdcXlUy+Jk8L71JyTre8=;
        b=ZOGrrh+/dSBOmxgMPTqkfs+NChFy3OA1n00jxm/EH49SwmuTqtihuvPdDSkYgaBmlj
         08JSzufH9hLY7tNEQbWtBWLoQE4IdFHMgJKUtBr3Tkxlej55aUhXN2bqDeGBCm8W+NMu
         N4Sf9TX8naCuEtsWIkB6Yv+qDfP/rYJteb4rVpXGWDjuIM2YeXdC9gLo1nPBXFSzmA8t
         ES9Ggfe9nma7n6xuUyIjnnkCqc12cBcu1unFDsCTs+VanH8fFJQfCpDc+FVuxwJObRQm
         2vE5x1Jx22fCnwIkyxEasuJHLBjq6qrHHU/+/DNH3qeQURpwWcU3yeQ1wEbaVGEcyuOX
         rAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPnquYCxA0mlKyKmemCORNREdcXlUy+Jk8L71JyTre8=;
        b=r+05WEAaY/B8py0pFcoyIPy6taHq5rTbr5dOGRgtoEUgRPSt7Iqpr63gSUoIor7H1V
         Zqmt+0vPLO+UQf4pbo2CizgWGlfoxt7IaFO+ysrlDN3KIC+2pFeFX5tvTFP429wvQEAF
         fHRYIueS7wqYCWGdJdEVmoU7ec7VEN3XfpiJ+BmQIqnxLnRJXC/XnAEIKmb5A6YxN+Xw
         4BkPtK5c2jtPz8/ab20smkyXtZdM73i1fca9Amob2pGydvNENpCiQol9RJVCRtzdzRR6
         ip+zUFZATVXoMFmtq0pEdkags5BgnPoy2e2xKtWpxwBhYWLc9+GeniM5QGKZ9CkZJfsR
         3k6Q==
X-Gm-Message-State: AGi0PuZmguLc+Ueqa+8Dbvs7aQoe4wGoXUJet+5g/CxBSxypPS/Bun9e
        lPVlFZCOGU0fx8vJAVbpXB+jaWtn8jwasU7zcG9krdo4
X-Google-Smtp-Source: APiQypIEzOSxyTIiYPEQyc07Z4mde/nZwEi/5CgUgnzGxtJ9KUFCeSXxm0+2TglSNJULHWyxABvMUvCVdOZ0tBPtUtQ=
X-Received: by 2002:ab0:7556:: with SMTP id k22mr15152808uaq.104.1585729256549;
 Wed, 01 Apr 2020 01:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200213221332.2228810-1-patrick.oppenlander@gmail.com>
 <MN2PR04MB69915A49A1F17BD2DBBD5C29FC170@MN2PR04MB6991.namprd04.prod.outlook.com>
 <CAEg67GnUcAeM=XZteE7YjrchnUjNkZofXZ8oAeekEGxZFdgHsw@mail.gmail.com>
In-Reply-To: <CAEg67GnUcAeM=XZteE7YjrchnUjNkZofXZ8oAeekEGxZFdgHsw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Apr 2020 10:20:20 +0200
Message-ID: <CAPDyKFrW6tXMVa_P=iAPk4FurH9+MGOvJiT7m8B72kz7p0-BnQ@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Fix scaling of cache size
To:     Patrick Oppenlander <patrick.oppenlander@gmail.com>,
        Chris Ball <chris@printf.net>
Cc:     Avri Altman <Avri.Altman@wdc.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Chris

On Tue, 31 Mar 2020 at 23:11, Patrick Oppenlander
<patrick.oppenlander@gmail.com> wrote:
>
> On Sun, Feb 16, 2020 at 6:18 PM Avri Altman <Avri.Altman@wdc.com> wrote:
> >
> > > From: Patrick Oppenlander <patrick.oppenlander@gmail.com>
> > >
> > > JESD84-B51 7.4.30 CACHE_SIZE [252:249] states that "the size is
> > > indicated as multiple of kilobits". This is also supported by Table 39,
> > > "e.MMC internal sizes and related Units / Granularities" which lists
> > > "32Kb (=4KB)" as the cache size granularity for 4KiB native devices.
> > >
> > > Signed-off-by: Patrick Oppenlander <patrick.oppenlander@gmail.com>
> > Reviewed-by: Avri Altman <avri.altman@wdc.com>
> >
>
> Does anything else need to happen to get this applied?

Chris Ball maintains mmc-utils. I have added him to the loop, but
perhaps you should resend this to make sure he gets the patch.

Kind regards
Uffe
