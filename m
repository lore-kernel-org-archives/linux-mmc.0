From: Lin Tony-B19295 <B19295@freescale.com>
Subject: RE: [PATCH v2 1/1] ARM: mxc: fix card interrupt losing issue on
 freescale eSDHC
Date: Wed, 3 Aug 2011 02:06:04 +0000
Message-ID: <97D3A72708D04647A5AC84A04996E5B5169802@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1311837360-16179-1-git-send-email-tony.lin@freescale.com>
	<1311837360-16179-2-git-send-email-tony.lin@freescale.com>
 <m2ty9z73j6.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:44473 "EHLO
	TX2EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564Ab1HCCGH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Aug 2011 22:06:07 -0400
In-Reply-To: <m2ty9z73j6.fsf@bob.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Thanks, Chris!

BR
Tony

> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Wednesday, August 03, 2011 8:16 AM
> To: Lin Tony-B19295
> Cc: linux-mmc@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v2 1/1] ARM: mxc: fix card interrupt losing issue on
> freescale eSDHC
> 
> Hi Tony,
> 
> On Thu, Jul 28 2011, Tony Lin wrote:
> > apply workaround for imx eSDHC controller to avoid missing the card
> > interrupt so that SDIO function is workable
> >
> > Signed-off-by: Tony Lin <tony.lin@freescale.com>
> 
> Thanks, pushed to mmc-next for 3.1.
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child


