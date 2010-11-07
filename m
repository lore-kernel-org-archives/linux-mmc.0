From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Sun, 7 Nov 2010 10:18:38 -0800
Message-ID: <AD7183BC-A6C0-4283-BC89-0CC5111437D7@marvell.com>
References: <43E4817426ED174AA81263BCECB4351D131D9D41BC@sc-vexch3.marvell.com>
 <AANLkTi=6FeuxhEL1ht4thc6PQ05wLFo7d2NA-XUYwHxy@mail.gmail.com>
 <041757E8-9FCD-4FA8-8079-7A3FC07E4038@marvell.com>
 <alpine.LFD.2.00.1011062139370.18581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:53637 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751753Ab0KGSUn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 7 Nov 2010 13:20:43 -0500
In-Reply-To: <alpine.LFD.2.00.1011062139370.18581@xanadu.home>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, "linus.Walleij@stericsson.com" <linus.Walleij@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


On Nov 6, 2010, at 6:44 PM, Nicolas Pitre wrote:

> On Sat, 6 Nov 2010, Philip Rakity wrote:
> 
>> 
>> We need a way to specify
>> 
>> a) Hardware can support clock gating setting the clock to 0 in the 
>> call to set_ios (with hardware clock gating enabled) becomes a no-op 
>> so some care is needed which is why I suggested another field in the 
>> ios structure.
> 
> Why should the core code care?
> 
> What difference is there with the core telling the controller driver to 
> set the clock to a frequency of 0 ?
> 
> 
> Nicolas


When h/w clock gating is enabled then sd clocks are disabled/enabled by the sd controller; there is nothing for the core/ layer to do.

I am concerned that having the core/ layer ask for clocks off and on is

a) not needed when h/w clock gating is enabled
b) may invoke bad behavior in the controller
c) is not optimal since the h/w is already handling this. 