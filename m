From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v7 0/6] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Wed, 14 Sep 2016 10:54:56 +0200
Message-ID: <20160914085456.GD10233@verge.net.au>
References: <1473764175-24580-1-git-send-email-horms+renesas@verge.net.au>
 <CAPDyKFoUQ0Xr0qVJoEjw6n_eL3VDoUfZHpu183pM1Yt7-pAnzQ@mail.gmail.com>
 <20160913125825.GA3510@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54091 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760929AbcINIzC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Sep 2016 04:55:02 -0400
Content-Disposition: inline
In-Reply-To: <20160913125825.GA3510@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Tue, Sep 13, 2016 at 02:58:25PM +0200, Wolfram Sang wrote:
> On Tue, Sep 13, 2016 at 02:48:26PM +0200, Ulf Hansson wrote:
> > On 13 September 2016 at 12:56, Simon Horman <horms+renesas@verge.net.au> wrote:
> > >
> > > Hi,
> > >
> > > this series is based on work by Ai Kyuse to add UHS-I SDR-104 support for
> > > sh_mobile_sdhi. It builds on work by Shinobu Uehara, Rob Taylor, William
> > > Towle and Ian Molton, Ben Hutchings, Wolfram Sang and others to add UHS-I
> > > SDR-50 support to the same driver.
> > >
> > > It is based on a merge of the next branches of the mmc tree.
> > >
> > > To aid review the following git branch is provided:
> > > * https:://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/sdr104-driver-v7
> > >
> > > Overview of changes since v6:
> > > * Address review by Ulf
> > >   - Detailed in per-patch changelogs
> > > * Move integration (arm/arm64 dt) patches to separate patchset
> > >
> > > Please see http://elinux.org/Tests:SD-SDHI-SDR104 for indicative tests
> > > results.
> > >
> > >
> > > Ai Kyuse (3):
> > >   mmc: tmio: enhance illegal sequence handling
> > >   mmc: tmio: Add hw reset support
> > >   mmc: tmio: Add tuning support
> > >
> > > Simon Horman (3):
> > >   mmc: core: Add helper to see if a host can be retuned
> > >   mmc: tmio: document mandatory and optional callbacks
> > >   mmc: sh_mobile_sdhi: Add tuning support
> > >
> > >  drivers/mmc/host/sh_mobile_sdhi.c | 265 +++++++++++++++++++++++++++++++++++++-
> > >  drivers/mmc/host/tmio_mmc.h       |  18 ++-
> > >  drivers/mmc/host/tmio_mmc_pio.c   |  87 ++++++++++++-
> > >  include/linux/mmc/host.h          |   5 +
> > >  4 files changed, 367 insertions(+), 8 deletions(-)
> > >
> > > --
> > > 2.7.0.rc3.207.g0ac5344
> > >
> > 
> > This looks good to me, although I would like to get an ack from
> > Wolfram before I queue this up.
> 
> I'll test today or tomorrow. Same for the r7s72100 patches.

Thanks!

I found a logic error in the last patch of the series,
I proposed a fix in a sub-thread for that patch.

If you could use my proposed one-line fix when testing that would be great.

