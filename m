From: Zang Roy-R61911 <r61911@freescale.com>
Subject: RE: [PATCH] eSDHC: Access Freescale eSDHC registers by 32-bit
Date: Tue, 13 Sep 2011 04:10:05 +0000
Message-ID: <2239AC579C7D3646A720227A37E026811A3C67@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1315569946-21386-1-git-send-email-tie-fei.zang@freescale.com>
 <20110909114004.GP1912@pengutronix.de>
 <2239AC579C7D3646A720227A37E026811A22BD@039-SN1MPN1-005.039d.mgd.msft.net>
 <20110909123324.GQ1912@pengutronix.de>
 <2239AC579C7D3646A720227A37E026811A2311@039-SN1MPN1-005.039d.mgd.msft.net>
 <20110909130855.GR1912@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:43570
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750714Ab1IMEKI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 13 Sep 2011 00:10:08 -0400
In-Reply-To: <20110909130855.GR1912@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, Xu Lei-B33228 <B33228@freescale.com>, Kumar Gala <galak@kernel.crashing.org>



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org]
> On Behalf Of Wolfram Sang
> Sent: Friday, September 09, 2011 21:09 PM
> To: Zang Roy-R61911
> Cc: cjb@laptop.org; linux-mmc@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> akpm@linux-foundation.org; cbouatmailru@gmail.com; Xu Lei-B33228; Kumar Gala
> Subject: Re: [PATCH] eSDHC: Access Freescale eSDHC registers by 32-bit
> 
> 
> > Previously, I sent this patch together  with another one. But
> > technically they are separated patches.  I got some comments from
> > Anton about the patch. I will try to address the comment. but for this
> > one, it is a stand along patch. I'd like to push it first.
> 
> Okay.
Good.
> 
> > I do not see any comment about byte swapping about this patch.
> > you may have mis-understanding here.
> 
> I was misguided, yes, sorry. BE/LE issues with additional byteswapping
> are a mind twister :/ Having a second look, it looks okay to me. One
> could think about putting this into sdhci_platform as well, but this can
> be done later if needed. Sadly, I currently don't have hardware to test
> it.
I tested on 8536 and P4080/P5020/P3041 platform.
Anyone can help to pull it in?
Thanks.
Roy

