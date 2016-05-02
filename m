From: "Winkler, Tomas" <tomas.winkler@intel.com>
Subject: RE: [PATCH RFC 0/3] mmc: block: Fix tuning (by avoiding it) for RPMB
Date: Mon, 2 May 2016 21:19:10 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B54256819@hasmsx108.ger.corp.intel.com>
References: <1461245314-6282-1-git-send-email-adrian.hunter@intel.com>
 <5721B9F7.509@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30946 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755025AbcEBVTj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 May 2016 17:19:39 -0400
In-Reply-To: <5721B9F7.509@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Hunter, Adrian" <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Roman Pen <r.peniaev@gmail.com>, Ben Gardiner <bengardiner@nanometrics.ca>


> 
> cc a couple more people
> 
> On 21/04/16 16:28, Adrian Hunter wrote:
> > Hi
> >
> > The RPMB partition only allows certain commands.  In particular, the
> > tuning command (CMD21) is not allowed -  refer JEDEC eMMC standard
> > v5.1 section 6.2.2 Command restrictions.
> >
> > That means commands will begin failing if re-tuning is needed while
> > switched to the RPMB partition.
> >
> > Here are 4 options to fix the problem:
> >
> >
> > 1. The approach taken by this patch set:
> >
> > To avoid tuning for RPMB, switch to High Speed mode from HS200 or
> > HS400 mode if re-tuning has been enabled.  And switch back when
> > leaving RPMB.
> >
> > Advantages: Directly does what needs to be done.
> >
> > Disadvantages: Assumes the mode switching will work.
> >
> >
> > 2. Same as 1 but disable the tuning modes by removing them from
> > card->mmc_avail_type and doing a full mmc_reset().
> >
> > Advantages: Simpler to program
> >
> > Disadvantages: Doing a full reset is slower.  Doing a full reset is
> > not an expected consequence of accessing RPMB.
> >
> >
> > 3. Simply disable re-tuning and attempt to recover from any errors.
> >
> > Disadvantages: Due to the interdependent nature of RPMB reads/writes
> > it might not be possible to recover without returning an error to the
> > RPMB user.  Also it would be difficult to test if the recovery
> > actually worked in all cases.
> >
> >
> > 4. Do a partiton switch as part of re-tuning.
> >
> > Disadvantages: Makes re-tuning more complicated.  Would require moving
> > the control of partition switching into the core.  CRC errors arising
> > from the need to re-tune might break the interdependent nature of RPMB
> > operations.
> >
> >
> > As a final note, if a solution is found then we might be able to
> > revert commit 4e93b9a6abc0 ("mmc: card: Don't access RPMB partitions
> > for normal read/write").
> >
This still doesn't bring us to that point, mostly for writing as each transaction has to have  a valid MAC computed. 
There is another layer required I hope matching the RPMB sybsystem as we suggested. 
I would prefer it won't be attached to block layer as is, yet we already have legacy SW stack so I see it painfull. 

Thanks
Tomas 

