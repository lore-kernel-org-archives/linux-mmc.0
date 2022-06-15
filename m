Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31621C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jun 2022 08:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242212AbiFOIIB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jun 2022 04:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbiFOIIA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2022 04:08:00 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75B8A1758D;
        Wed, 15 Jun 2022 01:08:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9408E80FE;
        Wed, 15 Jun 2022 08:03:14 +0000 (UTC)
Date:   Wed, 15 Jun 2022 11:07:58 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Yegor Yefremov <yegorslists@googlemail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: Linux 5.18.x: sdhci issue
Message-ID: <YqmTXqXLala7Li/+@atomide.com>
References: <CAGm1_ktMOwwhhgVWj3DpCib-WpRzhkjE4d4DN74mz6kdwJk6BA@mail.gmail.com>
 <YnNagtAtSudCum75@atomide.com>
 <CAGm1_ktACExigtZUYFWria8=cxhy6x6vDGpLcaZAvnE9G3Bz_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGm1_ktACExigtZUYFWria8=cxhy6x6vDGpLcaZAvnE9G3Bz_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

* Yegor Yefremov <yegorslists@googlemail.com> [220615 09:40]:
> Hi Tony, Ulf,
> 
> On Thu, May 5, 2022 at 7:03 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > Hi,
> >
> > * Yegor Yefremov <yegorslists@googlemail.com> [220504 09:12]:
> > > Hi Tony, all,
> > >
> > > During the kernel boot I see the following error. The device is still
> > > working afterwards. 5.17.5 shows the same behavior. Is this a known
> > > issue?
> >
> > Thanks for reporting it, I was not aware of this one. Might be worth
> > bisecting. Adding linux-mmc and Ulf.
> 
> This is my bisect result:
> 
> f433e8aac6b94218394c6e7b80bb89e4e79c9549 is the first bad commit
> commit f433e8aac6b94218394c6e7b80bb89e4e79c9549
> Author: Tony Lindgren <tony@atomide.com>
> Date:   Fri Oct 15 13:47:18 2021 +0300
> 
>     mmc: sdhci-omap: Implement PM runtime functions
> 
>     Implement PM runtime functions and enable autosuspend.
> 
>     Note that we save context in probe to avoid restoring invalid context
>     on the first resume. For system suspend, we have the new PM runtime
>     functions do most of the work.
> 
>     Signed-off-by: Tony Lindgren <tony@atomide.com>
>     Link: https://lore.kernel.org/r/20211015104720.52240-5-tony@atomide.com
>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

OK thanks this makes sense based on what Arnd replied a few days ago.

Regards,

Tony
