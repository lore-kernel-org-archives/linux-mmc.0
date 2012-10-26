From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH v6] powerpc/esdhc: disable CMD23 for some Freescale SoCs
Date: Fri, 26 Oct 2012 02:04:27 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C1DEAE5@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1351144039-30588-1-git-send-email-r66093@freescale.com>
	<20121025080120.GA23807@lizard> <87ehkmenp3.fsf@octavius.laptop.org>
 <87sj92d88e.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:17258
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751059Ab2JZCEf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 25 Oct 2012 22:04:35 -0400
In-Reply-To: <87sj92d88e.fsf@octavius.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Anton Vorontsov <cbouatmailru@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Xie Shaohui-B21989 <B21989@freescale.com>

No problem, thanks a lot, Chris.

Best Regards
Jerry Huang


> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Thursday, October 25, 2012 8:53 PM
> To: Anton Vorontsov
> Cc: Huang Changming-R66093; linux-mmc@vger.kernel.org; Huang Changming-
> R66093; Xie Shaohui-B21989
> Subject: Re: [PATCH v6] powerpc/esdhc: disable CMD23 for some Freescale
> SoCs
> 
> Hi,
> 
> On Thu, Oct 25 2012, Chris Ball wrote:
> > Hi,
> >
> > On Thu, Oct 25 2012, Anton Vorontsov wrote:
> >> On Thu, Oct 25, 2012 at 01:47:19PM +0800, r66093@freescale.com wrote:
> >>> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >>>
> >>> CMD23 causes lots of errors in kernel on some freescale SoCs (P1020,
> >>> P1021, P1022, P1024, P1025 and P4080) when MMC card used, which is
> >>> because these controllers does not support CMD23, even on the SoCs
> >>> which declares CMD23 is supported.
> >>> Therefore, we'll not use CMD23.
> >>>
> >>> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >>> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> >>> CC: Chris Ball <cjb@laptop.org>
> >>> ---
> >>
> >> Looks perfect, thanks a lot!
> >>
> >> Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
> >
> > Thanks, pushed to mmc-next for 3.7.
> >
> > - Chris.
> 
> In the version I merged, I've changed the callback name from
> platform_caps() to platform_init() (as Anton had suggested) so that it
> has a chance of being useful to other platforms too.
> 
> Thanks,
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child


