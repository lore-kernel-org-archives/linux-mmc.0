From: Zhang Haijun-B42677 <B42677@freescale.com>
Subject: RE: [PATCH V5] Powerpc eSDHC Recover from the ADMA error
Date: Tue, 4 Dec 2012 03:02:52 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E117C690@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1354241680-13903-1-git-send-email-Haijun.Zhang@freescale.com>
 <87obiah6ss.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:14897
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751393Ab2LDDDA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Dec 2012 22:03:00 -0500
In-Reply-To: <87obiah6ss.fsf@octavius.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Huang Changming-R66093 <r66093@freescale.com>

New patch had sent. Pls Review.

Thanks Chris.

Regards
Haijun.


> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Tuesday, December 04, 2012 10:48 AM
> To: Zhang Haijun-B42677
> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093
> Subject: Re: [PATCH V5] Powerpc eSDHC Recover from the ADMA error
> 
> Hi,
> 
> On Thu, Nov 29 2012, Haijun Zhang wrote:
> > A-003500: False ADMA Error might be reported when ADMA is used for
> > multiple block read command with Stop at Block Gap. If PROCTL[SABGREQ]
> > is set when the particular block's data is received by the System side
> > logic before entire block(with CRC) data is received by the SD side
> > logic, and also if ADMA descriptor line is fetched at the same time,
> > then DMA engine might report false ADMA error. eSDHC might not be able
> > to Continue(PROCTL[CREQ]=1)after Stop at Block Gap.
> > This issue will impact the eSDHC IP VVN2.3.
> >
> > Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
> > CC: Chris Ball <cjb@laptop.org>
> 
> This doesn't apply to mmc-next; please fix and resend.
> 
> Thanks,
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child


