From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: MMC retry mechanism
Date: Sun, 6 Sep 2009 12:58:54 -0500
Message-ID: <004b01ca2f1b$b2ebc9e0$544ff780@am.dhcp.ti.com>
References: <011c01ca2dac$2de779d0$544ff780@am.dhcp.ti.com> <20090906162041.1f4d939d@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55758 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758081AbZIFR7E (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 6 Sep 2009 13:59:04 -0400
In-Reply-To: <20090906162041.1f4d939d@mjolnir.ossman.eu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Pierre Ossman' <pierre-list@ossman.eu>
Cc: 'Adrian Hunter' <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Pierre Ossman [mailto:pierre-list@ossman.eu]
> Sent: Sunday, September 06, 2009 9:21 AM
> To: Madhusudhan
> Cc: 'Adrian Hunter'; linux-mmc@vger.kernel.org
> Subject: Re: MMC retry mechanism
> 
> On Fri, 4 Sep 2009 17:08:05 -0500
> "Madhusudhan" <madhu.cr@ti.com> wrote:
> 
> > Hi Adrian,
> >
> > With respect to the below commit, It looks like currently the retry
> > mechanism only handles the READ path.
> >
> > I wonder could a similar retry logic feasible for the WRITE path?
> >
> 
> The claim is that doing so can break some filesystem drivers (notably
> the journaling ones). There has been several threads and patches about
> this in the past.
> 
Okay. Thanks for the info. I would like to read those discussions and the
patches, any reference? Or where do I look for them and any good way to
search such threads in general?

Regards,
Madhu

> Rgds
> --
>      -- Pierre Ossman
> 
>   WARNING: This correspondence is being monitored by the
>   Swedish government. Make sure your server uses encryption
>   for SMTP traffic and consider using PGP for end-to-end
>   encryption.

