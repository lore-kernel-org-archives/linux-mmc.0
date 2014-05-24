From: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Subject: RE: how to creat watchpoint  in kernel for data access debug
Date: Sat, 24 May 2014 11:48:20 +0800
Message-ID: <35FD53F367049845BC99AC72306C23D1029A276569FC@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D1029A276569F3@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1029A276569F4@CNBJMBX05.corpusers.net>
 <20140523134550.GB21319@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cnbjrel02.sonyericsson.com ([219.141.167.166]:11098 "EHLO
	cnbjrel02.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751151AbaEXDsY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 23 May 2014 23:48:24 -0400
In-Reply-To: <20140523134550.GB21319@arm.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Will Deacon' <will.deacon@arm.com>
Cc: "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>, "'linux-arch-owner@vger.kernel.org'" <linux-arch-owner@vger.kernel.org>

Hi  Will,

Thanks for your suggestion,
The scenario that I encounter is a little special :
I found our kernel memory will be corrupt in stability test ,
Seems that someone write a memory that doesn't belong to it .
But I can't find who does it , the bug is hard to reproduce ,
So I want make a debug SW in kernel , which can monitor some data access,
When someone access it , the callback function can check if it's right .
If it's wrong, then crash the kernel do get a ram dump .


So kgdb or perf seems not suitable in this condition ,
We need users to use devices, not just test the device in Lab .

For watchpoint breakpoint, can it be implement by software on ARM arch?
I think It's impossible ,  instruction breakpoint can be implemented by
Software through undefined instruction in kernel , but data access watchpoint 
Seems can't be done by this method, at least on ARM arch ,  am I right ?

Is there some modules have implement watchpoint probe function  just like kporbe in kernel ?
Appreciate for your point out and help .

Thanks 





-----Original Message-----
From: Will Deacon [mailto:will.deacon@arm.com] 
Sent: Friday, May 23, 2014 9:46 PM
To: Wang, Yalin
Cc: 'linux-mmc@vger.kernel.org'; 'linux-arch-owner@vger.kernel.org'
Subject: Re: how to creat watchpoint in kernel for data access debug

On Fri, May 23, 2014 at 03:51:17AM +0100, Wang, Yalin wrote:
> I have a problems that I want create a watchpoint to monitor a data 
> for Debug in kernel , but I don't know how to do it , I try the 
> kprobes , but seems it only support create .text section probe , Can't 
> monitor data access ,  then  I try  perf_event_create to create a 
> hardware Data watchpoint , it can work , but has a problem: When the 
> data access hit , I don't know how to bypass this time's watchpoint , 
> This need simulate the data access  or step the break instructions in 
> data abort Exception handler ,  seems kernel don't provide these for perf_event ..
> 
> I test this on ARM arch ,
> My question is that how to create data watchpoint in kernel ?

It depends on why you want the watchpoint. If it's for counting accesses to that data, then you can use the perf tool and the perf code will try to deal with the single-stepping for you. Otherwise, you can investigate KGDB, but I've never tried it myself (and I don't think it uses hardware watchpoint for ARM)..

Will
