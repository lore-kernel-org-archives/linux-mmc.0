From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
Date: Wed, 12 Sep 2012 06:18:01 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C17701A@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
	<1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com>
	<20120911075429.GA27028@lizard> <20120911080457.GA28235@lizard>
	<110EED8CC96DFC488B7E717A2027A27C176170@039-SN1MPN1-002.039d.mgd.msft.net>
	<6D8C87BA-CA06-4215-94F5-63EBF5162B0A@kernel.crashing.org>
	<2A6FCAE3-288F-4972-90C0-15105932F13E@kernel.crashing.org>
	<87k3w0y5yn.fsf@octavius.laptop.org>
	<FC22FA36-B2CF-49C2-A0B1-8A0EA614B9CB@kernel.crashing.org>
 <87liggwa1w.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:39761
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755011Ab2ILGSH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 12 Sep 2012 02:18:07 -0400
In-Reply-To: <87liggwa1w.fsf@octavius.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Kumar Gala <galak@kernel.crashing.org>
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Anton Vorontsov <cbouatmailru@gmail.com>



Best Regards
Jerry Huang


> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Wednesday, September 12, 2012 4:59 AM
> To: Kumar Gala
> Cc: Huang Changming-R66093; linuxppc-dev@lists.ozlabs.org list; linux-
> mmc@vger.kernel.org; Anton Vorontsov
> Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
> 
> Hi,
> 
> On Tue, Sep 11 2012, Kumar Gala wrote:
> > thanks for the info.  Do you know what's required on controller side
> > to handle cards that support CMD23?
> >
> > I'm trying to figure out if older controller's on FSL SoCs are missing
> > some feature to allow CMD23 to work (vs Auto-CMD23).
> 
> It seems plausible that it's just not implemented on these controllers.
> It's a little strange, since the command's been specified for so long and
> we haven't seen any other controllers with problems.  The patch would be
> correct if this is true.
> 

I didn't find any description about it, but after testing on FSL silicones, I got this result:
Some silicones support this command, and some silicones don't support it, which will cause I/O error.

