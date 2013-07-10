From: Scott Wood <scottwood@freescale.com>
Subject: Re: =?UTF-8?b?562U5aSNOg==?= [PATCH] Powerpc/t4240: change the
 compatible flags for t4240qds board
Date: Wed, 10 Jul 2013 15:30:05 -0500
Message-ID: <1373488205.8183.228@snotra>
References: <99E897753B6F7048BD8CCDB4661D02E1396F57@039-SN2MPN1-021.039d.mgd.msft.net>
	<1373400262.8183.201@snotra>
	<99E897753B6F7048BD8CCDB4661D02E139CE27@039-SN2MPN1-021.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:39329
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754520Ab3GJUaM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 10 Jul 2013 16:30:12 -0400
In-Reply-To: <99E897753B6F7048BD8CCDB4661D02E139CE27@039-SN2MPN1-021.039d.mgd.msft.net>
	(from B42677@freescale.com on Tue Jul  9 22:41:22 2013)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhang Haijun-B42677 <B42677@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, Fleming Andy-AFLEMING <afleming@freescale.com>, Wrobel Heinz-R39252 <r39252@freescale.com>

On 07/09/2013 10:41:22 PM, Zhang Haijun-B42677 wrote:
> > No.  It's still supposed to be describing the sdhc block itself,  
> not the
> > board -- and any workarounds that key off of this will still fail  
> to work
> > with existing device trees.
> [Haijun Wrote:] So, leave dts unchanged and to check compitable for  
> board in sdhci-pltfm.c
> e.g.:
> 	unsigned long root = of_get_flat_dt_root();
> 
> 	if (of_flat_dt_is_compatible(root, "fsl,T4240QDS"))
> 		host->quirks |= XXX;

Why are you looking at the flat tree at this point?  Use the normal OF  
accessors.  The flat stuff is only for early boot.

Also make sure that you only do this for quirks that are actually  
board-specific.  In your last patch you had two quirks keyed off of the  
board, one of which is keyed off of the SoC for other chips.

-SCott
