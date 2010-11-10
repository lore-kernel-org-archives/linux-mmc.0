From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] mmc, sh: Move constants to sh_mmcif.h
Date: Wed, 10 Nov 2010 19:21:09 +0900
Message-ID: <20101110102109.GA12194@verge.net.au>
References: <20101109092952.01349C223F@yukiko.kent.sydney.vergenet.net>
 <20101110093223.GA369@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:47165 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755406Ab0KJKVP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2010 05:21:15 -0500
Content-Disposition: inline
In-Reply-To: <20101110093223.GA369@linux-sh.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>

On Wed, Nov 10, 2010 at 06:32:23PM +0900, Paul Mundt wrote:
> On Tue, Nov 09, 2010 at 05:47:02PM +0900, Simon Horman wrote:
> > This moves some constants from sh_mmcif.c to sh_mmcif.h
> > so that they can be used in sh_mmcif_boot_init().
> > 
> > It also alters the definition of SOFT_RST_OFF from (0 << 31) to
> > ~SOFT_RST_ON (= ~(1 << 31)). The former seems bogus.  The latter is
> > consistent with the code in sh_mmcif_boot_init().
> > 
> > Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > ---
> >  drivers/mmc/host/sh_mmcif.c  |   23 -----------------------
> >  include/linux/mmc/sh_mmcif.h |   39 ++++++++++++++++++++++++++++++++++-----
> >  2 files changed, 34 insertions(+), 28 deletions(-)
> > 
> As this doesn't appear to introduce any bugfixes or functionality changes
> I've queued it with the .38 changes. Its on its own topic branch for now,
> but let me know if you have a dependency on this in future patches aimed
> at the merge window and I'll make sure it ends up merged wherever its
> needed.
> 

Thanks, at this stage I don't expect any such dependencies.
I'll let you know if that situation changes.

