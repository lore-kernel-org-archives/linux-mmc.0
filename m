From: Will Deacon <will.deacon@arm.com>
Subject: Re: how to creat watchpoint  in kernel for data access debug
Date: Tue, 3 Jun 2014 17:45:12 +0100
Message-ID: <20140603164512.GT23149@arm.com>
References: <35FD53F367049845BC99AC72306C23D1029A276569F3@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1029A276569F4@CNBJMBX05.corpusers.net>
 <20140523134550.GB21319@arm.com>
 <35FD53F367049845BC99AC72306C23D1029A276569FC@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:37537 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965053AbaFCQpH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jun 2014 12:45:07 -0400
Content-Disposition: inline
In-Reply-To: <35FD53F367049845BC99AC72306C23D1029A276569FC@CNBJMBX05.corpusers.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>, "'linux-arch-owner@vger.kernel.org'" <linux-arch-owner@vger.kernel.org>

On Sat, May 24, 2014 at 04:48:20AM +0100, Wang, Yalin wrote:
> Hi  Will,

Hello,

Sorry for the delayed reply, it took me a while to work out what your issue
is.

> Thanks for your suggestion,
> The scenario that I encounter is a little special :
> I found our kernel memory will be corrupt in stability test ,
> Seems that someone write a memory that doesn't belong to it .
> But I can't find who does it , the bug is hard to reproduce ,
> So I want make a debug SW in kernel , which can monitor some data access,
> When someone access it , the callback function can check if it's right .
> If it's wrong, then crash the kernel do get a ram dump .
> 
> 
> So kgdb or perf seems not suitable in this condition ,
> We need users to use devices, not just test the device in Lab .

I think Google did something similar to this with ChromeOS on the
Exynos5-based chromebooks:

  https://chromium-review.googlesource.com/#/c/188479/3/arch/arm/kernel/hw_breakpoint.c

I don't think that has a place in the mainline kernel, but you could
certainly adapt it for your debugging purposes.

Will
