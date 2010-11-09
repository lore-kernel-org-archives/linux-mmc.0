From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Tue, 09 Nov 2010 19:29:01 +0900
Message-ID: <4CD9226D.2050307@samsung.com>
References: <43E4817426ED174AA81263BCECB4351D131D9D41BC@sc-vexch3.marvell.com>
 <AANLkTi=6FeuxhEL1ht4thc6PQ05wLFo7d2NA-XUYwHxy@mail.gmail.com>
 <041757E8-9FCD-4FA8-8079-7A3FC07E4038@marvell.com>
 <alpine.LFD.2.00.1011062139370.18581@xanadu.home>
 <AD7183BC-A6C0-4283-BC89-0CC5111437D7@marvell.com>
 <4CD7C586.6020809@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:14591 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab0KIK3h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2010 05:29:37 -0500
Received: from epmmp1 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0LBM00LPV53OFU70@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 09 Nov 2010 19:28:37 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LBM008J153OTK@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 09 Nov 2010 19:28:36 +0900 (KST)
In-reply-to: <4CD7C586.6020809@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Philip Rakity <prakity@marvell.com>, Nicolas Pitre <nico@fluxnic.net>, Ohad Ben-Cohen <ohad@wizery.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Linus..

i tested the clocking framework v8...at samsung SOC
just this patch worked S/W enable/disable..not H/W clock..

So i agreed the philip's opinion..
i also think that need some approach about H/W clock gating.. 

Linus Walleij wrote:
> Philip Rakity wrote:
> 
>> I am concerned that having the core/ layer ask for clocks off and on is
>>
>> a) not needed when h/w clock gating is enabled
>> b) may invoke bad behavior in the controller
>> c) is not optimal since the h/w is already handling this. 
> 
> So do not CONFIG_MMC_CLKGATE for this platform?
> 
> I don't quite get it I think...
> 
> Yours,
> Linus Walleij
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Thanks,
Jaehoon Chung
