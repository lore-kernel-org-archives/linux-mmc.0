From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
Date: Fri, 14 Sep 2012 02:02:56 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C179C7E@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1347347565-17474-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1347347565-17474-2-git-send-email-Chang-Ming.Huang@freescale.com>
 <20120911075429.GA27028@lizard> <20120911080457.GA28235@lizard>
 <110EED8CC96DFC488B7E717A2027A27C176170@039-SN1MPN1-002.039d.mgd.msft.net>
 <6D8C87BA-CA06-4215-94F5-63EBF5162B0A@kernel.crashing.org>
 <2A6FCAE3-288F-4972-90C0-15105932F13E@kernel.crashing.org>
 <87k3w0y5yn.fsf@octavius.laptop.org>
 <FC22FA36-B2CF-49C2-A0B1-8A0EA614B9CB@kernel.crashing.org> <87liggwa1w
 <8B1F0805-759E-417A-B787-40DF197896F3@kernel.crashing.org>
 <110EED8CC96DFC488B7E717A2027A27C1785D0@039-SN1MPN1-002.039d.mgd.msft.net>
 <4E15F856-D385-40C4-A5FD-5F298C70F402@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:59177
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751558Ab2INCDB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 13 Sep 2012 22:03:01 -0400
In-Reply-To: <4E15F856-D385-40C4-A5FD-5F298C70F402@kernel.crashing.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Chris Ball <cjb@laptop.org>, "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Anton Vorontsov <cbouatmailru@gmail.com>



Best Regards
Jerry Huang


> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Thursday, September 13, 2012 8:48 PM
> To: Huang Changming-R66093
> Cc: Chris Ball; linuxppc-dev@lists.ozlabs.org list; linux-
> mmc@vger.kernel.org; Anton Vorontsov
> Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the CMD23
> 
> 
> On Sep 12, 2012, at 9:02 PM, Huang Changming-R66093 wrote:
> 
> >>>
> >>>> -----Original Message-----
> >>>> From: Chris Ball [mailto:cjb@laptop.org]
> >>>> Sent: Wednesday, September 12, 2012 4:59 AM
> >>>> To: Kumar Gala
> >>>> Cc: Huang Changming-R66093; linuxppc-dev@lists.ozlabs.org list;
> >>>> linux- mmc@vger.kernel.org; Anton Vorontsov
> >>>> Subject: Re: [PATCH 2/3] powerpc/esdhc: add property to disable the
> >>>> CMD23
> >>>>
> >>>> Hi,
> >>>>
> >>>> On Tue, Sep 11 2012, Kumar Gala wrote:
> >>>>> thanks for the info.  Do you know what's required on controller
> >>>>> side to handle cards that support CMD23?
> >>>>>
> >>>>> I'm trying to figure out if older controller's on FSL SoCs are
> >>>>> missing some feature to allow CMD23 to work (vs Auto-CMD23).
> >>>>
> >>>> It seems plausible that it's just not implemented on these
> controllers.
> >>>> It's a little strange, since the command's been specified for so
> >>>> long and we haven't seen any other controllers with problems.  The
> >>>> patch would be correct if this is true.
> >>>>
> >>>
> >>> I didn't find any description about it, but after testing on FSL
> >> silicones, I got this result:
> >>> Some silicones support this command, and some silicones don't
> >>> support
> >> it, which will cause I/O error.
> >>
> >> Can you list out which SoCs support it and which don't.  Having this
> >> list will be useful in understanding which controller versions
> supported it.
> >>
> > P1020, p1021, p1022, p1024, p1015 and p4080 can't support it.
> > Mpc8536, p2020, and the other current DPAA silicon (e.g. p5020, p3041)
> support it.
> 
> Based on this, why don't we use the HOSTVER register to detect instead of
> device tree:
> 
> 
> #define FSL_SDHC_VER_1_0	0x00
> #define FSL_SDHC_VER_1_1	0x01
> #define FSL_SDHC_VER_2_0	0x10
> #define FSL_SDHC_VER_2_1	0x11
> #define FSL_SDHC_VER_2_2	0x12
> #define FSL_SDHC_VER_2_3	0x13
> 
> unsigned int vendor_version;
> 
> vendor_version = sdhci_readw(host, SDHCI_HOST_VERSION); vendor_version =
> (vendor_version & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
> 
> if ((vendor_version == FSL_SDHC_VER_1_1) || (vendor_version ==
> FSL_SDHC_VER_2_2))
> 	host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> 

I once thought about it, but if the future silicon does not support this feature,
then we continue to modify these codes for new silicon?

