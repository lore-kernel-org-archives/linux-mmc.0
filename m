From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Mon, 8 Nov 2010 01:45:56 -0800
Message-ID: <1E1A2021-E51B-40F8-B0D3-DB3B2D5562CC@marvell.com>
References: <43E4817426ED174AA81263BCECB4351D131D9D41BC@sc-vexch3.marvell.com>
 <AANLkTi=6FeuxhEL1ht4thc6PQ05wLFo7d2NA-XUYwHxy@mail.gmail.com>
 <041757E8-9FCD-4FA8-8079-7A3FC07E4038@marvell.com>
 <alpine.LFD.2.00.1011062139370.18581@xanadu.home>
 <AD7183BC-A6C0-4283-BC89-0CC5111437D7@marvell.com>
 <4CD7C586.6020809@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:43064 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752702Ab0KHJv2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 8 Nov 2010 04:51:28 -0500
In-Reply-To: <4CD7C586.6020809@stericsson.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Ohad Ben-Cohen <ohad@wizery.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


On Nov 8, 2010, at 1:40 AM, Linus Walleij wrote:

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

I want h/w clock gating for SD/eMMC/MMC cards and NOT sdio.

If h/w is doing clock gating do not know what why I can to turn off  clock since h/w is already doing this.  Need a way to distinguish.

> 
> Yours,
> Linus Walleij
> 

