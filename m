Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC1CC432BE
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 17:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2CCF6054E
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 17:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhHRR4k (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Aug 2021 13:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhHRR4j (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 18 Aug 2021 13:56:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB7E860BD3;
        Wed, 18 Aug 2021 17:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629309364;
        bh=ns87ZPMySq8WJH44cZI5SX1ALtCXNHOELDCw7jSyjZ4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PCg1bptqI2Ma+CkzoivGb5Z2S97z2uMV1ZU8bm+5DOHVoAMsi2TraehFbG05hAe0K
         kOuSh+NH49M+0T+J4J4kKSG2e9IR2qyqXagUpy6asQotA8dZ5AfcMGeekhxkGnXVED
         Eghnx692f0QVe12V1jThlDNB9VOwj8mUTphqVY7p+sqyi4BONNJEdVGz2/auf3055v
         yDp75/zHKw4Jt4vbTwRSgJ48rx1mOXU9+nMjEQoDgU9q9AMgu3SqpykUziO8i5w7Ok
         ZUp/R/Y5qUsFwBnPLWKOA/9sWwCqwV5BZWYc6iJj4SWaaEKDJhQF5rvBY4RfZFTMio
         u+YiT+/rbo4Cg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9A8DE5C04B1; Wed, 18 Aug 2021 10:56:04 -0700 (PDT)
Date:   Wed, 18 Aug 2021 10:56:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Vasut <marex@denx.de>, qais.yousef@arm.com,
        frederic@kernel.org, tglx@linutronix.de
Subject: Re: NOHZ tick-stop error with ath10k SDIO
Message-ID: <20210818175604.GX4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAOMZO5AAvZic-NFbYYSVfOxY-27QukXMX68f9eDmhbqAkBRKRw@mail.gmail.com>
 <20210818154358.GS4126399@paulmck-ThinkPad-P17-Gen-1>
 <CAOMZO5A7drx9yXWXKTh4VfV4QHNGCPbH_vxeb=NGDghAm98CXA@mail.gmail.com>
 <CAOMZO5BY7JeFQJkU--KGRfNLTUnUVjnfar+37SvReXyBt9QJfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5BY7JeFQJkU--KGRfNLTUnUVjnfar+37SvReXyBt9QJfA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Aug 18, 2021 at 02:02:17PM -0300, Fabio Estevam wrote:
> Hi Paul,
> 
> On Wed, Aug 18, 2021 at 1:29 PM Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Paul,
> >
> > On Wed, Aug 18, 2021 at 12:43 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > > I believe that you need this commit (and possibly some prerequsites):
> > >
> > > 47c218dcae65 ("tick/sched: Prevent false positive softirq pending warnings on RT")
> > >
> > > Adding Qais on CC for his thoughts.
> >
> > Thanks for the suggestion, but I am running 5.13.11, which already
> > contains this commit.
> >
> > Any extra logs I should capture to help us understand the problem?
> 
> In case it helps, I followed your suggestion from:
> https://lkml.org/lkml/2020/12/10/676
> 
> With the debug patch and suggested command line, I get the following log:
> https://pastebin.com/raw/X96zKw7i

And it turns out that I am also seeing it in v5.14-rc2, just a lot less
frequently than earlier.  I have seen three instances of handler #02
(NET_TX_SOFTIRQ?) over the past month or so while you are seeing handler
#08 (BLOCK_SOFTIRQ?), in case that makes a difference.

Adding Frederic and Thomas on CC, though I believe Frederic is off
the grid at the moment.

							Thanx, Paul
