From: Will Deacon <will.deacon@arm.com>
Subject: Re: how to creat watchpoint  in kernel for data access debug
Date: Wed, 4 Jun 2014 19:01:39 +0100
Message-ID: <20140604180139.GD27881@arm.com>
References: <35FD53F367049845BC99AC72306C23D1029A276569F3@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1029A276569F4@CNBJMBX05.corpusers.net>
 <20140523134550.GB21319@arm.com>
 <35FD53F367049845BC99AC72306C23D1029A276569FC@CNBJMBX05.corpusers.net>
 <20140603164512.GT23149@arm.com>
 <35FD53F367049845BC99AC72306C23D1029A27656A2F@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:53744 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750717AbaFDSBg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 14:01:36 -0400
Content-Disposition: inline
In-Reply-To: <35FD53F367049845BC99AC72306C23D1029A27656A2F@CNBJMBX05.corpusers.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>, "'linux-arch-owner@vger.kernel.org'" <linux-arch-owner@vger.kernel.org>

On Wed, Jun 04, 2014 at 04:05:03AM +0100, Wang, Yalin wrote:
> Hi  Will,
> 
> Thanks for your proposal,
> The patch google made is just like
> The one I tried before ,
> Then the problems come :
> After register the perf_event callback,
> In the callback function ,
> In google's patch , it is  function crbug_345917_handler( ),
> It just call panic( ) ,
> But My callback function will do some check ,
> Sometimes, I want to bypass this time's breakpoint,
> Problems is that I don't know how to bypass it,
> If I return directly in the callback function ,
> The breakpoint will trap again and again endless ..

Take a look at enable_single_step, which uses mismatch breakpoints to try
and do the step.

Will
