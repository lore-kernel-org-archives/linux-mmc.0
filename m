From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v3 2/5] OMAP4 HSMMC: Adding hsmmc support to board file
Date: Sat, 15 May 2010 11:41:22 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C558B36B@dbde02.ent.ti.com>
References: <12490.10.24.255.17.1273781497.squirrel@dbdmail.itg.ti.com>
 <20100514215651.GI3428@atomide.com>
 <20100514220508.GC7185@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34895 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751328Ab0EOGLl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 May 2010 02:11:41 -0400
In-Reply-To: <20100514220508.GC7185@flint.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "jarkko.lavinen@nokia.com" <jarkko.lavinen@nokia.com>, "paul@pwsan.com" <paul@pwsan.com>, "adrian.hunter@nokia.com" <adrian.hunter@nokia.com>, Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>

Kishore,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Russell
> King
> Sent: Saturday, May 15, 2010 3:35 AM
> To: Tony Lindgren
> Cc: Kadiyala, Kishore; linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; Chikkature Rajashekar,
> Madhusudhan; jarkko.lavinen@nokia.com; paul@pwsan.com; adrian.hunter@nokia.com
> Subject: Re: [PATCH v3 2/5] OMAP4 HSMMC: Adding hsmmc support to board file
> 
> On Fri, May 14, 2010 at 02:56:51PM -0700, Tony Lindgren wrote:
> > * kishore kadiyala <kishore.kadiyala@ti.com> [100513 13:06]:
> > > Support for MMC1 & MMC2 controllers is added to the board file.
> > > Also includes configuration of MMC1 Card detect initially.
> >
> > This patch does not seem to apply, I don't know where you're getting
> > the sdp4430_vmmc_supply in this patch?
> >
> > I suggest you forget about the card detect patches for now and
> > first produce a minimal set of patches to get the MMC working
> > for board-4430sdp.c. The card detect patches should be applied
> > only after board-4430sdp.c works for MMC. And we're running out
> > of time for this merge window.
> 
> Absolutely - we _really_ _really_ _really_ need to get MMC usable
> on the 4430SDP for this merge window - don't care about the card
> detection provided the system can find a MMC card which is left
> plugged in.
> 
> To do this makes the overall 4430SDP more usable than it currently
> is with mainline kernels.
> 
Why is it taking so much time to get 4-5 patches in shape for mainline??
What is expected is just basic MMC support and no advance features yet.

Regards,
Santosh
