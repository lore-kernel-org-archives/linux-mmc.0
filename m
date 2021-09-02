Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD9AC433EF
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Sep 2021 22:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABF460E9B
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Sep 2021 22:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhIBWKh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Sep 2021 18:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235083AbhIBWKf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Sep 2021 18:10:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE29461054;
        Thu,  2 Sep 2021 22:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630620576;
        bh=JozAychQdkZVheZRC5cWwi/+T0d8FJXICvfkY3V5oBo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=V18ES6DFquE+5t+YhDz0yzC6zzNDXLTYF6EgHK2ATVlk+veX4/c6KdnZTZ7V2LnJQ
         3X9w24jn6s1G7nFufYQkAwX/2ptNxeFSYcydLe/4C+uAUlsSpy4rDJ45i0uHkznM91
         O0McyUB9SO2VWoGzlNH9fTdo5za96C4beesNag3wCRsdYpS1LOz9JTVMJX0QX3n5bu
         h5OYLFNT2n8N5tX4SHoGg+ObyL98YrRsGRNSQHciSWPfVZpC1evKe/LNiiMfYawTfR
         pru+bG93l9pdIqw9NVVwwweRAt+7Ea38M7Uvkg6cSLznZYzhOa9ONfGbYrKIBlDpF9
         AGgJVOkS67EdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7DD615C0E58; Thu,  2 Sep 2021 15:09:36 -0700 (PDT)
Date:   Thu, 2 Sep 2021 15:09:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Vasut <marex@denx.de>, qais.yousef@arm.com,
        frederic@kernel.org
Subject: Re: NOHZ tick-stop error with ath10k SDIO
Message-ID: <20210902220936.GP4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAOMZO5AAvZic-NFbYYSVfOxY-27QukXMX68f9eDmhbqAkBRKRw@mail.gmail.com>
 <20210818154358.GS4126399@paulmck-ThinkPad-P17-Gen-1>
 <CAOMZO5A7drx9yXWXKTh4VfV4QHNGCPbH_vxeb=NGDghAm98CXA@mail.gmail.com>
 <CAOMZO5BY7JeFQJkU--KGRfNLTUnUVjnfar+37SvReXyBt9QJfA@mail.gmail.com>
 <20210818175604.GX4126399@paulmck-ThinkPad-P17-Gen-1>
 <87czpqbq98.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czpqbq98.ffs@tglx>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Sep 02, 2021 at 11:51:15PM +0200, Thomas Gleixner wrote:
> Paul,
> 
> On Wed, Aug 18 2021 at 10:56, Paul E. McKenney wrote:
> > On Wed, Aug 18, 2021 at 02:02:17PM -0300, Fabio Estevam wrote:
> >> On Wed, Aug 18, 2021 at 1:29 PM Fabio Estevam <festevam@gmail.com> wrote:
> >> > On Wed, Aug 18, 2021 at 12:43 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >> >
> >> > > I believe that you need this commit (and possibly some prerequsites):
> >> > >
> >> > > 47c218dcae65 ("tick/sched: Prevent false positive softirq pending warnings on RT")
> >> > >
> >> > > Adding Qais on CC for his thoughts.
> >> >
> >> > Thanks for the suggestion, but I am running 5.13.11, which already
> >> > contains this commit.
> >> >
> >> > Any extra logs I should capture to help us understand the problem?
> >> 
> >> In case it helps, I followed your suggestion from:
> >> https://lkml.org/lkml/2020/12/10/676
> >> 
> >> With the debug patch and suggested command line, I get the following log:
> >> https://pastebin.com/raw/X96zKw7i
> >
> > And it turns out that I am also seeing it in v5.14-rc2, just a lot less
> > frequently than earlier.  I have seen three instances of handler #02
> > (NET_TX_SOFTIRQ?) over the past month or so while you are seeing handler
> > #08 (BLOCK_SOFTIRQ?), in case that makes a difference.
> 
> Huch? #02 is TIMER_SOFTIRQ and #08 is NET_TX_SOFTIRQ.

Idiot here was forgetting that the #02 represents bit 1 (as you say,
TIMER_SOFTIRQ) rather than numeral 2.  Ditto for the #08.  :-/

							Thanx, Paul
