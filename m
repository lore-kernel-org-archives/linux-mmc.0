From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 4/9] mmc: add the new linux-mmc mailing list to
 MAINTAINERS
Date: Tue, 18 Aug 2009 15:17:27 -0700
Message-ID: <20090818151727.30e958ab.akpm@linux-foundation.org>
References: <200908182111.n7ILBCSc017248@imap1.linux-foundation.org>
	<003c01ca2050$71d72c80$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51420 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750872AbZHRWSY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Aug 2009 18:18:24 -0400
In-Reply-To: <003c01ca2050$71d72c80$544ff780@am.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: torvalds@linux-foundation.org, HaraldWelte@viatech.com, JosephChan@via.com.tw, ben-linux@fluff.org, drzeus@drzeus.cx, ian@mnementh.co.uk, jarkko.lavinen@nokia.com, linux-mmc@vger.kernel.org, manuel.lauss@gmail.com, nico@cam.org, ppisa@pikron.com, saschasommer@freenet.de

On Tue, 18 Aug 2009 17:08:40 -0500
"Madhusudhan" <madhu.cr@ti.com> wrote:

> 
> 
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of akpm@linux-foundation.org
> > Sent: Tuesday, August 18, 2009 4:11 PM
> > To: torvalds@linux-foundation.org
> > Cc: akpm@linux-foundation.org; HaraldWelte@viatech.com;
> > JosephChan@via.com.tw; ben-linux@fluff.org; drzeus@drzeus.cx;
> > ian@mnementh.co.uk; jarkko.lavinen@nokia.com; linux-mmc@vger.kernel.org;
> > manuel.lauss@gmail.com; nico@cam.org; ppisa@pikron.com;
> > saschasommer@freenet.de
> > Subject: [patch 4/9] mmc: add the new linux-mmc mailing list to
> > MAINTAINERS
> > 
> > From: Andrew Morton <akpm@linux-foundation.org>
> > 
> > There are a number of individual MMC drivers listed in MAINTAINERS.  I
> > didn't modify those records.  Perhaps I should have.
> > 
> Does this mean that the individual MMC drivers list needs to be changed to
> linux-mmc@vger.kernel.org? 
> 
> For e.g. the OMAP MMC support currently listed as 
> 
> L:     linux-omap@vger.kernel.org
> 
> Should now be changed as below?
> 
> L:     linux-mmc@vger.kernel.org

I don't know - that's why I cc'ed all you guys.  If you think that
linux-mmc should be mentioned in your driver's MAINTAINERS record then
please raise a patch to make that change.



