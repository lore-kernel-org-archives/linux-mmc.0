Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E075C433DB
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 15:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7787C64F53
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 15:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhCDPAg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 10:00:36 -0500
Received: from smtp2.axis.com ([195.60.68.18]:24134 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232829AbhCDPA2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 4 Mar 2021 10:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1614870028;
  x=1646406028;
  h=date:to:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:from;
  bh=9pXiRpTQmDAuSYK4U3zjhuk/8rvFph0sfXnEkDckSxY=;
  b=ShektRLmbqpjClGgTzDX/IlIBGjacpDTdCnaGNndVH9Igk5FCtWhytAt
   PaTlCMi+InyuL8Sy+EmGZj6uN3MFLuVPVvVAnIhsFAq9Lq0/rYw37ilct
   ShVeANoeSVfxVGAsFhW+jcL1KI3FEWhC+5CNAzdfABe44fulJlB7vxnP3
   ifjdHDridP1uyjPZoph0ANxsju0wCvucEwPasHARc9oH5gw/phwovY6AY
   5kfmcVXqbtAePWk7ew+Zig5z9nLA0C62jwu/abgha2zK0XhriULOS7HT2
   qJOhL1jpcJKTMvbp7xLEE1LFvDXaARI1Rcp+OQAjD82AokZt0XSABSkqd
   A==;
Date:   Thu, 4 Mar 2021 15:59:46 +0100
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     =?iso-8859-1?Q?M=E5rten?= Lindahl <Marten.Lindahl@axis.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        kernel <kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: Try power cycling card if command request times out
Message-ID: <20210304145946.tnbbd4qq6nvc2mcb@axis.com>
References: <20210216224252.22187-1-marten.lindahl@axis.com>
 <CAPDyKFoASx=U8b1Oqtuo6ikiM=gXfL2x1Gsz=rfAn9zxP0y_iA@mail.gmail.com>
 <20210301215923.6jfg6mg5ntorttan@axis.com>
 <CAPDyKFoaKfuwweaEMf1Pz+ECAPU3P9-gmCJcpq+MADH5gH1c=Q@mail.gmail.com>
 <20210304134836.xlw7wbbvkc5bqzmm@axis.com>
 <CAPDyKFous2oDwcUgPkZV8bZzpd+yA8m9LwC3+yk0uxqWcrJx1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFous2oDwcUgPkZV8bZzpd+yA8m9LwC3+yk0uxqWcrJx1w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
From:   Marten Lindahl <martenli@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Mar 04, 2021 at 03:06:54PM +0100, Ulf Hansson wrote:
> On Thu, 4 Mar 2021 at 14:48, Marten Lindahl <martenli@axis.com> wrote:
> >
> > Hi Ulf! My apologies for the delay.
> >
> > On Tue, Mar 02, 2021 at 09:45:02AM +0100, Ulf Hansson wrote:
> > > On Mon, 1 Mar 2021 at 22:59, Marten Lindahl <martenli@axis.com> wrote:
> > > >
> > > > Hi Ulf!
> > > >
> > > > Thank you for your comments!
> > > >
> > > > On Mon, Mar 01, 2021 at 09:50:56AM +0100, Ulf Hansson wrote:
> > > > > + Adrian
> > > > >
> > > > > On Tue, 16 Feb 2021 at 23:43, Mårten Lindahl <marten.lindahl@axis.com> wrote:
> > > > > >
> > > > > > Sometimes SD cards that has been run for a long time enters a state
> > > > > > where it cannot by itself be recovered, but needs a power cycle to be
> > > > > > operational again. Card status analysis has indicated that the card can
> > > > > > end up in a state where all external commands are ignored by the card
> > > > > > since it is halted by data timeouts.
> > > > > >
> > > > > > If the card has been heavily used for a long time it can be weared out,
> > > > > > and should typically be replaced. But on some tests, it shows that the
> > > > > > card can still be functional after a power cycle, but as it requires an
> > > > > > operator to do it, the card can remain in a non-operational state for a
> > > > > > long time until the problem has been observed by the operator.
> > > > > >
> > > > > > This patch adds function to power cycle the card in case it does not
> > > > > > respond to a command, and then resend the command if the power cycle
> > > > > > was successful. This procedure will be tested 1 time before giving up,
> > > > > > and resuming host operation as normal.
> > > > >
> > > > > I assume the context above is all about the ioctl interface?
> > > > >
> > > >
> > > > Yes, that's correct. The problem we have seen is triggered by ioctls.
> > > >
> > > > > So, when the card enters this non functional state, have you tried
> > > > > just reading a block through the regular I/O interface. Does it
> > > > > trigger a power cycle of the card - and then makes it functional
> > > > > again?
> > > > >
> > > >
> > > > Yes, we have tried that, and it does trigger a power cycle, making the card
> > > > operational again. But as it requires an operator to trigger it, I thought
> > > > it might be something that could be automated here. At least once.
> > >
> > > Not sure what you mean by operator here? In the end it's a userspace
> > > program running and I assume it can deal with error paths. :-)
> > >
> > > In any case, I understand your point.
> > >
> >
> > Yes, we have a userspace program. So if the userspace program will try to
> > restore the card in a situation such as the one we are trying to solve
> > here, how shall it perform it? Is it expected that a ioctl CMD0 request
> > should be enough, or is there any other support for a userspace program to
> > reset the card?
> 
> Correct, there is no way for userspace to reset cards through an ioctl.
> 
> >
> > If it falls on a ioctl command to reset the card, how do we handle the case
> > where the ioctl times out anyway? Or is the only way for a userspace program
> > to restore the card, to make a block transfer that fails?
> 
> Yes, that is what I was thinking. According to the use case you have
> described, this should be possible for you to implement as a part of
> your userspace program, no?

Ok, I will discuss that with the people maintaining the userspace program :)

But would it be of interest to review a patch introducing a more clean card
reset request, without block transfers?

Kind regards
Mårten

> 
> [...]
> 
> Kind regards
> Uffe
