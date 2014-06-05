From: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Subject: RE: how to creat watchpoint  in kernel for data access debug
Date: Thu, 5 Jun 2014 11:40:02 +0800
Message-ID: <35FD53F367049845BC99AC72306C23D1029A27656A34@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D1029A276569F3@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1029A276569F4@CNBJMBX05.corpusers.net>
 <20140523134550.GB21319@arm.com>
 <35FD53F367049845BC99AC72306C23D1029A276569FC@CNBJMBX05.corpusers.net>
 <20140603164512.GT23149@arm.com>
 <35FD53F367049845BC99AC72306C23D1029A27656A2F@CNBJMBX05.corpusers.net>
 <20140604180139.GD27881@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cnbjrel02.sonyericsson.com ([219.141.167.166]:12968 "EHLO
	cnbjrel02.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750944AbaFEDkG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 Jun 2014 23:40:06 -0400
In-Reply-To: <20140604180139.GD27881@arm.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Will Deacon' <will.deacon@arm.com>
Cc: "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>, "'linux-arch-owner@vger.kernel.org'" <linux-arch-owner@vger.kernel.org>

Hi  Will,

Thanks for your point out very much ,
I see your meaning ,
And I do a try ,
But Seems it can just work when you register a 
Perf event with a NULL callback function,

https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/arch/arm/kernel/hw_breakpoint.c#n758

i don't know why it design like this?
If it can always step the watchpoint,
Will be suitable for my use.

Thanks 

-----Original Message-----
From: Will Deacon [mailto:will.deacon@arm.com] 
Sent: Thursday, June 05, 2014 2:02 AM
To: Wang, Yalin
Cc: 'linux-mmc@vger.kernel.org'; 'linux-arch-owner@vger.kernel.org'
Subject: Re: how to creat watchpoint in kernel for data access debug

On Wed, Jun 04, 2014 at 04:05:03AM +0100, Wang, Yalin wrote:
> Hi  Will,
> 
> Thanks for your proposal,
> The patch google made is just like
> The one I tried before ,
> Then the problems come :
> After register the perf_event callback, In the callback function , In 
> google's patch , it is  function crbug_345917_handler( ), It just call 
> panic( ) , But My callback function will do some check , Sometimes, I 
> want to bypass this time's breakpoint, Problems is that I don't know 
> how to bypass it, If I return directly in the callback function , The 
> breakpoint will trap again and again endless ..

Take a look at enable_single_step, which uses mismatch breakpoints to try and do the step.

Will
