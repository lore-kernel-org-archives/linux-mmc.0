From: Zhang Haijun-B42677 <B42677@freescale.com>
Subject: RE: [PATCH 1/4 V2] powerpc/85xx: Add support for 85xx cpu type
 detection
Date: Thu, 11 Jul 2013 09:02:10 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E139F499@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1373441941-32650-1-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Wed Jul 10 02:39:01 2013)
 <1373492893.8183.236@snotra>
 <AE90C24D6B3A694183C094C60CF0A2F6026B72DE@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe006.messaging.microsoft.com ([216.32.180.189]:33842
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755618Ab3GKJAD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Jul 2013 05:00:03 -0400
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B72DE@saturn3.aculab.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>, Wood Scott-B07421 <B07421@freescale.com>
Cc: Zhao Chenhui-B35336 <B35336@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wrobel Heinz-R39252 <r39252@freescale.com>, Fleming Andy-AFLEMING <afleming@freescale.com>, "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Xie Xiaobo-R63061 <r63061@freescale.com>



Thanks.

Regards
Haijun.


> -----Original Message-----
> From: David Laight [mailto:David.Laight@ACULAB.COM]
> Sent: Thursday, July 11, 2013 4:44 PM
> To: Wood Scott-B07421; Zhang Haijun-B42677
> Cc: Zhao Chenhui-B35336; linux-mmc@vger.kernel.org; Wrobel Heinz-R39252;
> Fleming Andy-AFLEMING; Zhang Haijun-B42677; cbouatmailru@gmail.com;
> cjb@laptop.org; linuxppc-dev@lists.ozlabs.org; Xie Xiaobo-R63061
> Subject: RE: [PATCH 1/4 V2] powerpc/85xx: Add support for 85xx cpu type
> detection
> 
> > > +#define IS_SVR_REV(svr, maj, min) \
> > > +	((SVR_MAJ(svr) == (maj)) && (SVR_MIN(svr) == (min)))
> >
> > I don't think IS_SVR_REV is needed.  Callers can just do "if
> > (SVR_REV(svr) == 0x30)" or whatever, especially since we're relying on
> > them to do this for greater/less than comparisons.
> 
> Not only that, I'd guess that 'maj' and 'min' are likely to be constants
> - so you'd want to combine them and compare against 'svr'
> rather than have two conditionals.
[Haijun Wrote:] yes, e.g: 1.0, 1.1 or 2.0. 'Major revision field' + '.' + 'Minor revision field '
I had resent the patch(V2). I'm not so clear about what you want to express.^_^  
> 
> 	David
> 
> 
> 


