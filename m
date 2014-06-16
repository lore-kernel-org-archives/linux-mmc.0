From: Will Deacon <will.deacon@arm.com>
Subject: Re: how to creat watchpoint  in kernel for data access debug
Date: Mon, 16 Jun 2014 13:55:06 +0100
Message-ID: <20140616125506.GD16758@arm.com>
References: <35FD53F367049845BC99AC72306C23D1029A276569F3@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1029A276569F4@CNBJMBX05.corpusers.net>
 <20140523134550.GB21319@arm.com>
 <35FD53F367049845BC99AC72306C23D1029A276569FC@CNBJMBX05.corpusers.net>
 <20140603164512.GT23149@arm.com>
 <35FD53F367049845BC99AC72306C23D1029A27656A2F@CNBJMBX05.corpusers.net>
 <20140604180139.GD27881@arm.com>
 <35FD53F367049845BC99AC72306C23D1029A27656A34@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:50482 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751127AbaFPMzP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 08:55:15 -0400
Content-Disposition: inline
In-Reply-To: <35FD53F367049845BC99AC72306C23D1029A27656A34@CNBJMBX05.corpusers.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>, "'linux-arch-owner@vger.kernel.org'" <linux-arch-owner@vger.kernel.org>

On Thu, Jun 05, 2014 at 04:40:02AM +0100, Wang, Yalin wrote:
> Hi  Will,
> 
> Thanks for your point out very much ,
> I see your meaning ,
> And I do a try ,
> But Seems it can just work when you register a 
> Perf event with a NULL callback function,
> 
> https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/tree/arch/arm/kernel/hw_breakpoint.c#n758
> 
> i don't know why it design like this?

That's so that ptrace users can deal with the stepping themselves, which is
expected by programs such as GDB. Also, not all ARM CPUs have mismatch
breakpoints (e.g. ARMv6), so software emulation is required there.

Will
