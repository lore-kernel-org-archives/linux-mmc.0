From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc_rescan: reduce verbosity
Date: Mon, 11 Oct 2010 23:00:30 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010112257570.2764@xanadu.home>
References: <1286833731-30567-1-git-send-email-eric@eukrea.com>
 <alpine.LFD.2.00.1010112007250.2764@xanadu.home>
 <20101012021236.GA8179@void.printf.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_HExJT2eOPDf/GGGczVp8Eg)"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:36192 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755470Ab0JLDAb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Oct 2010 23:00:31 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LA500CI2PONPW80@vl-mh-mrz21.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Mon, 11 Oct 2010 23:00:23 -0400 (EDT)
In-reply-to: <20101012021236.GA8179@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: =?ISO-8859-15?Q?Eric_B=E9nard?= <eric@eukrea.com>, linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_HExJT2eOPDf/GGGczVp8Eg)
Content-type: TEXT/PLAIN; charset=iso-8859-1
Content-transfer-encoding: 8BIT

On Tue, 12 Oct 2010, Chris Ball wrote:

> Hi,
> 
> On Mon, Oct 11, 2010 at 09:50:46PM -0400, Nicolas Pitre wrote:
> > On Mon, 11 Oct 2010, Eric Bénard wrote:
> > > since commit 820f2bcfdc32cd90061224c930cf670f961e12d1 mmc_rescan
> > > includes a pr_info which prints 4 lines each second for hosts configured
> > > with MMC_CAP_NEEDS_POLL. Tested on i.MX51's sdhci-esdhc.
> > > This patch increase log level to debug (but maybe the right solution
> > > would be to remove this log).
> > 
> > Indeed.  Flooding the log with debug messages is not much better.
> 
> Other options include:
> 
> (a) Turn the message into a DBG().  (CONFIG_MMC_DEBUG=y)
> (b) Turn the message into a DBG(), predicated on !MMC_CAP_NEEDS_POLL.
> (c) Remove the message.
> 
> Any thoughts?  I'll go with (c) unless we agree on a better idea.

My preference would be (a).  You don't lose the intended debugging aid 
but it has to be turned on explicitly.  The people who might care 
most probably have CONFIG_MMC_DEBUG=y already.


Nicolas

--Boundary_(ID_HExJT2eOPDf/GGGczVp8Eg)--
