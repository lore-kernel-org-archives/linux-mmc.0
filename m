Return-Path: <SRS0=ySr4=3G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C23C33CB1
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jan 2020 16:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645952072E
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Jan 2020 16:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="NQB/Y04L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAQQO1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:14:27 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:14541 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbgAQQO1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 17 Jan 2020 11:14:27 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47zmNJ5xwVzJv;
        Fri, 17 Jan 2020 17:14:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1579277664; bh=ftJBWCYEwkPQyHNpwkWvXU/BQm+kqTZFwefLuQQlqwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQB/Y04LIGN2kKOJeMq1qO6oh4T2EbROfjtVwr3tOtTy1cMfjTXI9gL9jDNn4KlHt
         ijDLc7xdYuM1Yd1LCgJXTqrq6ZdAnSAPVitzrL6FDqjlTMZkVUIyBemBrGu+R/WCvN
         5wUPcL3MFVrWwrv/k8mAKCYMAuRxcS6rgw35TZA57JuamX+8yIq3Hw7uWQUyFMIvyQ
         kgnk5Rl+IV+lVzKs5Im6XwNqGCRCMCxkgYMKUCM317mIGcgiZg+LIpBn5lCo+lzwsA
         fUf/0fBKdMJsXaw9Ms3FkldFGi1qLPSkuMgdhHSEuS681H2OZuEpFwajexwcmgWZg8
         5V33/UMV05DhQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Fri, 17 Jan 2020 17:14:22 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: core: limit probe clock frequency to configured
 f_max
Message-ID: <20200117161422.GA11081@qmqm.qmqm.pl>
References: <f471bceaf237d582d746bd289c4c4f3639cb7b45.1577962382.git.mirq-linux@rere.qmqm.pl>
 <CAPDyKFpZWnkK7UmCZ8M4UnM05wR3MQsPrpEjOJuwkKcN2gePSg@mail.gmail.com>
 <20200117140511.GC26135@qmqm.qmqm.pl>
 <CAPDyKFpkhwnzi5PAr_0bAriYteeBUVM5Qr1byiXtJkgYd=dKfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFpkhwnzi5PAr_0bAriYteeBUVM5Qr1byiXtJkgYd=dKfw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jan 17, 2020 at 04:26:30PM +0100, Ulf Hansson wrote:
> On Fri, 17 Jan 2020 at 15:05, Micha³ Miros³aw <mirq-linux@rere.qmqm.pl> wrote:
> >
> > On Thu, Jan 16, 2020 at 03:07:22PM +0100, Ulf Hansson wrote:
> > > On Thu, 2 Jan 2020 at 11:54, Micha³ Miros³aw <mirq-linux@rere.qmqm.pl> wrote:
> > > >
> > > > Currently MMC core disregards host->f_max during card initialization
> > > > phase. Obey upper boundary for the clock frequency and skip faster
> > > > speeds when they are above the limit.
> > >
> > > Is this a hypothetical problem or a real problem?
> >
> > This is a problem on noisy or broken boards or cards - so needed for
> > debugging such a combination. I wouldn't expect this is required for
> > normal devices.
> 
> Alright.
> 
> >
> > > > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> > > > ---
> > > >  drivers/mmc/core/core.c | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > > index abf8f5eb0a1c..aa54d359dab7 100644
> > > > --- a/drivers/mmc/core/core.c
> > > > +++ b/drivers/mmc/core/core.c
> > > > @@ -2330,7 +2330,13 @@ void mmc_rescan(struct work_struct *work)
> > > >         }
> > > >
> > > >         for (i = 0; i < ARRAY_SIZE(freqs); i++) {
> > > > -               if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min)))
> > > > +               unsigned int freq = freqs[i];
> > > > +               if (freq > host->f_max) {
> > > > +                       if (i + 1 < ARRAY_SIZE(freqs))
> > > > +                               continue;
> > > > +                       freq = host->f_max;
> > >
> > > This looks wrong to me. For example, what if f_max = 250KHz and f_min = 50 KHz.
> > >
> > > Then we should try with 250KHz, then 200KHz and then 100KHz. This
> > > isn't what the above code does, I think.
> > >
> > > Instead it will try with 200KHz and then 100KHz, thus skip 250KHz.
> > >
> > > Maybe we should figure out what index of freqs[] to start the loop for
> > > (before actually starting the loop), depending on the value of f_max -
> > > rather than always start at 0.
> >
> > Yes, it will skip higher frequencies. I didn't view it a problem,
> > because the new code guarantees at least one frequency will be tried.
> > The eMMC standard specifies only max init frequency (400kHz), so all we
> > should try is something less whatever works.
> >
> > SD spec specifies minimal frequency (100kHz), but I wouldn't expect
> > this to be enforced nor required to be anywhere.
> 
> Well, my point isn't so much about the specs, rather about providing a
> consistent behaviour.
> 
> We deal with f_min constraints like I described above, then I think we
> should make f_max behave the similar way.

Okay, this would be a second fix as trying the same freq multiple times
is not what this code is supposed to do.

Best Regards,
Micha³ Miros³aw
