From: Zang Roy-R61911 <r61911@freescale.com>
Subject: RE: [PATCH 3/4 V2] mmc: esdhc: Correct host version of T4240-R1.0
Date: Thu, 18 Jul 2013 02:30:45 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB0020B27D1E9@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
	<1374055891-20703-2-git-send-email-Haijun.Zhang@freescale.com>
 <1374081074.8183.360@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:13863
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756655Ab3GRCbJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Jul 2013 22:31:09 -0400
In-Reply-To: <1374081074.8183.360@snotra>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wood Scott-B07421 <B07421@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, Fleming Andy-AFLEMING <afleming@freescale.com>, Zhang Haijun-B42677 <B42677@freescale.com>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Scott Wood
> 
> On 07/17/2013 05:11:30 AM, Haijun Zhang wrote:
> > Vender version and sdhc spec version of T4240-R1.0 is incorrect.
> > The right value should be VVN=0x13, SVN = 0x1. The wrong version
> > number will break down the ADMA data transfer.
> > This defect only exist in T4240-R1.0. Will be fixed in T4240-R2.0.
> > Also share vvn and svr for public use.
> >
> > Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> 
> We're not supporting T4240 rev 1.0 in upstream Linux, as it's not
> production silicon.
As discussed, production silicon Rev 2.0 will also suffer this issue. So need to address it beyond T4240-R2.0.
thanks.
Roy

