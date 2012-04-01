From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/3] mmc: atmel-mci: add support for odd clock dividers
Date: Sat, 31 Mar 2012 23:44:41 -0400
Message-ID: <87mx6wm7yu.fsf@laptop.org>
References: <1332344483-3915-1-git-send-email-ludovic.desroches@atmel.com>
	<1332344483-3915-4-git-send-email-ludovic.desroches@atmel.com>
	<4F6B3BD0.4060702@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48713 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754388Ab2DADod (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 31 Mar 2012 23:44:33 -0400
In-Reply-To: <4F6B3BD0.4060702@atmel.com> (Nicolas Ferre's message of "Thu, 22
	Mar 2012 15:48:48 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, plagnioj@jcrosoft.com

Hi,

On Thu, Mar 22 2012, Nicolas Ferre wrote:
> On 03/21/2012 04:41 PM, ludovic.desroches@atmel.com :
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>> 
>> Add an odd clock divider capability available from v5xx. It also involves
>> changing the clock divider calculation.
>
> Also tell here that you have changed the way that the switch/case
> directive has been implemented.
>
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Otherwise:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, pushed to mmc-next for 3.4 with a rewording:

    Add an odd clock divider capability available from v5xx. It also involves
    changing the clock divider calculation, and changing the switch-case
    statement to use top-down fallthrough.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
