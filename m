From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: atmel-mci: save and restore sdioirq when soft reset is performed
Date: Sat, 11 Feb 2012 16:26:59 -0500
Message-ID: <m2ipjdkqn0.fsf@bob.laptop.org>
References: <1328721759-10124-1-git-send-email-ludovic.desroches@atmel.com>
	<1328784929-24174-1-git-send-email-ludovic.desroches@atmel.com>
	<4F338C6F.9030802@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39009 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753415Ab2BKV1S (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 11 Feb 2012 16:27:18 -0500
In-Reply-To: <4F338C6F.9030802@atmel.com> (Nicolas Ferre's message of "Thu, 09
	Feb 2012 10:05:51 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Thu, Feb 09 2012, Nicolas Ferre wrote:
> On 02/09/2012 11:55 AM, ludovic.desroches@atmel.com :
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>> 
>> Sometimes a software reset is needed. Then some registers are saved and
>> restored but the interrupt mask register is missing. It causes issues
>> with sdio devices whose interrupts are masked after reset.
>> 
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> Chris, can you please queue this patch in a "fixes" branch?

Thanks, pushed to mmc-next for 3.3.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
