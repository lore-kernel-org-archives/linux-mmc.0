From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4 V2] mmc: esdhc: Correct host version of T4240-R1.0
Date: Thu, 18 Jul 2013 10:24:12 -0500
Message-ID: <1374161052.5357.0@snotra>
References: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
	<1374055891-20703-2-git-send-email-Haijun.Zhang@freescale.com>
	<1374081074.8183.360@snotra>
	<3E027F8168735B46AC006B1D0C7BB0020B27D1E9@039-SN2MPN1-012.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:46437
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756756Ab3GRPYU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Jul 2013 11:24:20 -0400
In-Reply-To: <3E027F8168735B46AC006B1D0C7BB0020B27D1E9@039-SN2MPN1-012.039d.mgd.msft.net>
	(from r61911@freescale.com on Wed Jul 17 21:30:45 2013)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zang Roy-R61911 <r61911@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>, Zhang Haijun-B42677 <B42677@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, Fleming Andy-AFLEMING <afleming@freescale.com>Zhang Haijun-B42677 <B42677@freescale.com>

On 07/17/2013 09:30:45 PM, Zang Roy-R61911 wrote:
> 
> 
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of Scott Wood
> >
> > On 07/17/2013 05:11:30 AM, Haijun Zhang wrote:
> > > Vender version and sdhc spec version of T4240-R1.0 is incorrect.
> > > The right value should be VVN=0x13, SVN = 0x1. The wrong version
> > > number will break down the ADMA data transfer.
> > > This defect only exist in T4240-R1.0. Will be fixed in T4240-R2.0.
> > > Also share vvn and svr for public use.
> > >
> > > Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> >
> > We're not supporting T4240 rev 1.0 in upstream Linux, as it's not
> > production silicon.
> As discussed, production silicon Rev 2.0 will also suffer this issue.  
> So need to address it beyond T4240-R2.0.

OK -- please update the commit message.

-Scott
