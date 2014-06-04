From: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Subject: RE: how to creat watchpoint  in kernel for data access debug
Date: Wed, 4 Jun 2014 11:05:03 +0800
Message-ID: <35FD53F367049845BC99AC72306C23D1029A27656A2F@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D1029A276569F3@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1029A276569F4@CNBJMBX05.corpusers.net>
 <20140523134550.GB21319@arm.com>
 <35FD53F367049845BC99AC72306C23D1029A276569FC@CNBJMBX05.corpusers.net>
 <20140603164512.GT23149@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cnbjrel01.sonyericsson.com ([219.141.167.165]:7765 "EHLO
	cnbjrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753413AbaFDDFI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Jun 2014 23:05:08 -0400
In-Reply-To: <20140603164512.GT23149@arm.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Will Deacon' <will.deacon@arm.com>
Cc: "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>, "'linux-arch-owner@vger.kernel.org'" <linux-arch-owner@vger.kernel.org>

Hi  Will,

Thanks for your proposal,
The patch google made is just like
The one I tried before ,
Then the problems come :
After register the perf_event callback,
In the callback function ,
In google's patch , it is  function crbug_345917_handler( ),
It just call panic( ) ,
But My callback function will do some check ,
Sometimes, I want to bypass this time's breakpoint,
Problems is that I don't know how to bypass it,
If I return directly in the callback function ,
The breakpoint will trap again and again endless ..

Thank you very much .


-----Original Message-----
From: Will Deacon [mailto:will.deacon@arm.com] 
Sent: Wednesday, June 04, 2014 12:45 AM
To: Wang, Yalin
Cc: 'linux-mmc@vger.kernel.org'; 'linux-arch-owner@vger.kernel.org'
Subject: Re: how to creat watchpoint in kernel for data access debug

On Sat, May 24, 2014 at 04:48:20AM +0100, Wang, Yalin wrote:
> Hi  Will,

Hello,

Sorry for the delayed reply, it took me a while to work out what your issue is.

> Thanks for your suggestion,
> The scenario that I encounter is a little special :
> I found our kernel memory will be corrupt in stability test , Seems 
> that someone write a memory that doesn't belong to it .
> But I can't find who does it , the bug is hard to reproduce , So I 
> want make a debug SW in kernel , which can monitor some data access, 
> When someone access it , the callback function can check if it's right .
> If it's wrong, then crash the kernel do get a ram dump .
> 
> 
> So kgdb or perf seems not suitable in this condition , We need users 
> to use devices, not just test the device in Lab .

I think Google did something similar to this with ChromeOS on the Exynos5-based chromebooks:

  https://chromium-review.googlesource.com/#/c/188479/3/arch/arm/kernel/hw_breakpoint.c

I don't think that has a place in the mainline kernel, but you could certainly adapt it for your debugging purposes.

Will
