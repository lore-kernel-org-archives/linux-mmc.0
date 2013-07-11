From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/4 V2] powerpc/85xx: Add support for 85xx cpu type
 detection
Date: Thu, 11 Jul 2013 09:15:17 -0500
Message-ID: <1373552117.8183.243@snotra>
References: <1373441941-32650-1-git-send-email-Haijun.Zhang@freescale.com>
	<1373492893.8183.236@snotra>
	<AE90C24D6B3A694183C094C60CF0A2F6026B72DE@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0249.outbound.messaging.microsoft.com ([213.199.154.249]:38528
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932071Ab3GKOPa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Jul 2013 10:15:30 -0400
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B72DE@saturn3.aculab.com>
	(from David.Laight@ACULAB.COM on Thu Jul 11 03:43:35 2013)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, Zhao Chenhui <chenhui.zhao@freescale.com>, linux-mmc@vger.kernel.org, r39252@freescale.com, AFLEMING@freescale.comHaijun Zhang <Haijun.Zhang@freescale.com>, cbouatmailru@gmail.com, cjb@laptop.org, linuxppc-dev@lists.ozlabs.org, X.Xie@freescale.com

On 07/11/2013 03:43:35 AM, David Laight wrote:
> > > +#define IS_SVR_REV(svr, maj, min) \
> > > +	((SVR_MAJ(svr) == (maj)) && (SVR_MIN(svr) == (min)))
> >
> > I don't think IS_SVR_REV is needed.  Callers can just do "if
> > (SVR_REV(svr) == 0x30)" or whatever, especially since we're relying  
> on
> > them to do this for greater/less than comparisons.
> 
> Not only that, I'd guess that 'maj' and 'min' are likely to be
> constants - so you'd want to combine them and compare against 'svr'
> rather than have two conditionals.

Yes, that's what I meant -- 0x30 would represent revision 3.0.

-Scott
