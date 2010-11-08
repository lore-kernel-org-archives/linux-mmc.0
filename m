From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Mon, 8 Nov 2010 10:40:22 +0100
Message-ID: <4CD7C586.6020809@stericsson.com>
References: <43E4817426ED174AA81263BCECB4351D131D9D41BC@sc-vexch3.marvell.com> <AANLkTi=6FeuxhEL1ht4thc6PQ05wLFo7d2NA-XUYwHxy@mail.gmail.com> <041757E8-9FCD-4FA8-8079-7A3FC07E4038@marvell.com> <alpine.LFD.2.00.1011062139370.18581@xanadu.home> <AD7183BC-A6C0-4283-BC89-0CC5111437D7@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog108.obsmtp.com ([207.126.144.125]:37795 "EHLO
	eu1sys200aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751169Ab0KHJkp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2010 04:40:45 -0500
In-Reply-To: <AD7183BC-A6C0-4283-BC89-0CC5111437D7@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Ohad Ben-Cohen <ohad@wizery.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Philip Rakity wrote:

> I am concerned that having the core/ layer ask for clocks off and on is
> 
> a) not needed when h/w clock gating is enabled
> b) may invoke bad behavior in the controller
> c) is not optimal since the h/w is already handling this. 

So do not CONFIG_MMC_CLKGATE for this platform?

I don't quite get it I think...

Yours,
Linus Walleij

