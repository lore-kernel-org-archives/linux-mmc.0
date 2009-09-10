From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: MMC retry mechanism
Date: Thu, 10 Sep 2009 16:20:26 -0500
Message-ID: <009a01ca325c$843e83f0$544ff780@am.dhcp.ti.com>
References: <011c01ca2dac$2de779d0$544ff780@am.dhcp.ti.com> <4AA4B38C.6060202@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50115 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753884AbZIJVUa (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Sep 2009 17:20:30 -0400
In-Reply-To: <4AA4B38C.6060202@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Adrian Hunter' <adrian.hunter@nokia.com>
Cc: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@nokia.com]
> Sent: Monday, September 07, 2009 2:18 AM
> To: Madhusudhan
> Cc: linux-mmc@vger.kernel.org
> Subject: Re: MMC retry mechanism
> 
> Madhusudhan wrote:
> > Hi Adrian,
> >
> > With respect to the below commit, It looks like currently the retry
> > mechanism only handles the READ path.
> >
> > I wonder could a similar retry logic feasible for the WRITE path?
> >
> > Regards,
> > Madhu
> 
> From my point of view, writes should never fail.  In theory, the MMC
> should have enough reserved blocks to cover bad blocks for the
> expected lifetime of the device.  It should then be just copying
> and remapping to avoid having to return write errors.
> 
> Of course, a lot of cards probably don't do that right.  However,
> I think maybe the block layer already retries failed writes.
> 
What if there is a DATA CRC error during a write and the low level driver
reports the data.error as -EILSEQ. Will the block layer retry? I thought it
is supported only for the read through your patch.

Regards,
Madhu

> >
> >
> >
> > commit 6a79e391df295bd7c2aa1309ea5031f361c197fd
> > Author: Adrian Hunter <ext-adrian.hunter@nokia.com>
> > Date:   Wed Dec 31 18:21:17 2008 +0100
> >
> >
> >
> >     mmc_block: ensure all sectors that do not have errors are read
> >
> >     If a card encounters an ECC error while reading a sector it will
> >
> >     timeout.  Instead of reporting the entire I/O request as having
> >
> >     an error, redo the I/O one sector at a time so that all readable
> >
> >     sectors are provided to the upper layers.
> >
> >
> >
> >     Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
> >
> >     Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> >
> >
> 


