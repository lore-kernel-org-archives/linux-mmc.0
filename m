From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH RESEND v5 0/4] atmel-mci device tree support
Date: Tue, 07 Aug 2012 23:14:23 -0400
Message-ID: <87hasexegg.fsf@octavius.laptop.org>
References: <1343136606-8874-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36502 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755426Ab2HHDO2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Aug 2012 23:14:28 -0400
In-Reply-To: <1343136606-8874-1-git-send-email-ludovic.desroches@atmel.com>
	(ludovic desroches's message of "Tue, 24 Jul 2012 15:30:02 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com

Hi,

On Tue, Jul 24 2012, ludovic.desroches@atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Hello,
>
> I resend this set of patches because patches 2, 3 and 4 were acked by
> Jean-Christophe. Patch 1 was also acked by Jean-Christophe excepted for
> cd-inverted property since it was redundant with gpio bindings.

In future, it's helpful for me if you can add the Acked-by lines you
receive into the patches when you resend them.  Thanks!

> I thought we were agree to go ahead since it was a common binding already
> documented and it will concern all drivers.

Agreed.  It's a documented core MMC binding, it's fine to use it.

> Chris are you agree to take patch 1/4? Others patches may go to at91 tree,
> isn't it?

Yes, let's do that.  I've applied patch 1/4 to mmc-next for 3.7, and you
can send the others via the at91 tree with the ACK that Arnd gave.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
