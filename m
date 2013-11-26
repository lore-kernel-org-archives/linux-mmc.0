From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: atmel-mci: fix timeout errors in SDIO mode when using DMA
Date: Tue, 26 Nov 2013 17:24:45 -0500
Message-ID: <87zjoqer82.fsf@octavius.laptop.org>
References: <1384959671-5646-1-git-send-email-ludovic.desroches@atmel.com>
	<528E29D0.9080507@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59301 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753636Ab3KZWY4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Nov 2013 17:24:56 -0500
In-Reply-To: <528E29D0.9080507@atmel.com> (Nicolas Ferre's message of "Thu, 21
	Nov 2013 16:42:08 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: ludovic.desroches@atmel.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hi,

On Thu, Nov 21 2013, Nicolas Ferre wrote:
> On 20/11/2013 16:01, ludovic.desroches@atmel.com :
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>
>> With some SDIO devices, timeout errors can happen when reading data. To solve
>> this issue the DMA transfer has to be activated before sending the command to
>> the device. This order is incorrect in PDC mode. So we have to take care if we
>> are using DMA or PDC to know when to send the MMC command.
>>
>> Cc: <stable@vger.kernel.org> #3.2+
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, pushed to mmc-next for 3.14.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
