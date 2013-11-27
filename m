From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] mmc: atmel-mci: fix timeout errors in SDIO mode when
 using DMA
Date: Wed, 27 Nov 2013 10:41:42 +0100
Message-ID: <5295BE56.3060609@atmel.com>
References: <1384959671-5646-1-git-send-email-ludovic.desroches@atmel.com>	<528E29D0.9080507@atmel.com> <87zjoqer82.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:56058 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab3K0Jlu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Nov 2013 04:41:50 -0500
In-Reply-To: <87zjoqer82.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: ludovic.desroches@atmel.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

On 26/11/2013 23:24, Chris Ball :
> Hi,
>
> On Thu, Nov 21 2013, Nicolas Ferre wrote:
>> On 20/11/2013 16:01, ludovic.desroches@atmel.com :
>>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>>
>>> With some SDIO devices, timeout errors can happen when reading data. To solve
>>> this issue the DMA transfer has to be activated before sending the command to
>>> the device. This order is incorrect in PDC mode. So we have to take care if we
>>> are using DMA or PDC to know when to send the MMC command.
>>>
>>> Cc: <stable@vger.kernel.org> #3.2+
>>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> Thanks, pushed to mmc-next for 3.14.

Nice, thank you Chris, but what about considering its inclusion in 3.13?

I know that it will anyway hit the 3.13.y stable update but I do think 
that it would be nice to have this fix sooner in official 3.13...

Bye,
-- 
Nicolas Ferre
