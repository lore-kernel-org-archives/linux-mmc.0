From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH V2 2/10] omap: Rename mmc-twl4030 files to hsmmc
Date: Thu, 21 Jan 2010 11:23:58 -0600
Message-ID: <004701ca9abe$84341530$544ff780@am.dhcp.ti.com>
References: <20100117013250.17308.17861.sendpatchset@ahunter-work.research.nokia.com> <20100117013306.17308.2282.sendpatchset@ahunter-work.research.nokia.com> <017601ca9a2a$1d1e7640$544ff780@am.dhcp.ti.com> <017701ca9a2b$07ceb920$544ff780@am.dhcp.ti.com> <4B581965.3090403@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4B581965.3090403@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: 'Adrian Hunter' <adrian.hunter@nokia.com>
Cc: 'Tony Lindgren' <tony@atomide.com>, 'Paul Walmsley' <paul@pwsan.com>, 'linux-omap Mailing List' <linux-omap@vger.kernel.org>, 'linux-mmc Mailing List' <linux-mmc@vger.kernel.org>, 'Andrew Morton' <akpm@linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org


<snip>

> >>
> >
> > My bad, please ignore. The 3rd patch in the series seems to take care of
> > renaming these bits.
> >
> > Regards,
> > Madhu
> >
> 
> Will you be Ack'ing these patches?

Sure. I will do that. The changes to hsmmc look okay to me. Having the
controller driver call the mmc core regulator fns is good.

Regards,
Madhu

