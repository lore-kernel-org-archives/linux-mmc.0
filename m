From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 0/10] omap_hsmmc changes V2
Date: Fri, 22 Jan 2010 09:14:27 -0800
Message-ID: <20100122171427.GQ23467@atomide.com>
References: <1264149200.1920.11.camel@Nokia-N900-51-1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62279 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755188Ab0AVROT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jan 2010 12:14:19 -0500
Content-Disposition: inline
In-Reply-To: <1264149200.1920.11.camel@Nokia-N900-51-1>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@nokia.com
Cc: madhu.cr@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, akpm@linux-foundation.org

* adrian.hunter@nokia.com <adrian.hunter@nokia.com> [100122 00:31]:
> Madhu wrote
> >
> >
> > > -----Original Message-----
> > > From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
> > > Sent: Saturday, January 16, 2010 7:33 PM
> > > To: Tony Lindgren
> > > Cc: Adrian Hunter; Madhusudhan Chikkature; Paul Walmsley; linux-omap
> > > Mailing List; linux-mmc Mailing List; Andrew Morton
> > > Subject: [PATCH V2 0/10] omap_hsmmc changes V2
> > >
> > > Hi
> > >
> > > Here are some changes we need for omap_hsmmc.  They are dependent on
> > OMAP
> > > board files so it would be simplest if the patches all went via the
> > OMAP
> > > tree.
> > >
> > > This is version 2 of this patch set.  Thank you Tony, Paul and Madhu
> > for
> > > your comments.
> > >
> > > Changes from version 1:
> > >              - amended patch 'omap_hsmmc: Move gpio and regulator control
> > from
> > >              board file' so that system control functions remain in the
> > board
> > >              file
> > >              - for clarity, split patch 'omap: Rename mmc-twl4030 to hsmmc'
> > into
> > >              'omap: Rename mmc-twl4030 files to hsmmc' and
> > >              'omap: Rename hsmmc symbols to reflect independence from
> > twl4030'
> > >              - removed patch 'omap_hsmmc: set DVFS/PM constraints'
> > >              - added patch 'omap: Add functions for dynamic remuxing of
> > pins'
> > >              - renamed and reworked patch 'omap: RX51: Remux to pull eMMC
> > lines
> > >              down when powering off' (was 'omap_hsmmc: RX51: set padconfs to
> > pull
> > >              down when powering off eMMC')
> > >              - added patch 'omap_hsmmc: Ensure regulator enable / disable
> > are
> > >              paired'
> > >              - fixed mistakes in patch 'omap_hsmmc: Allow for a shared VccQ'
> > >
> > Reviewed the omap_hsmmc changes and did a sanity test on Zoom2.
> > Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com<mailto:madhu.cr@ti.com>>
> >
> > Regards,
> > Madhu
> 
> Thanks Madhu. Tony, are you ok taking these patches into your tree?

Looks good to me, will queue them into omap for-next.

Regards,

Tony
