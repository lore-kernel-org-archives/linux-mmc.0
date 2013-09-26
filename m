From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: atmel-mci: abort transfer on timeout error
Date: Wed, 25 Sep 2013 21:46:53 -0400
Message-ID: <87a9j04anm.fsf@octavius.laptop.org>
References: <1378740596-25026-1-git-send-email-ludovic.desroches@atmel.com>
	<522ED03F.5070404@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49599 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753449Ab3IZBrF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 Sep 2013 21:47:05 -0400
In-Reply-To: <522ED03F.5070404@atmel.com> (Nicolas Ferre's message of "Tue, 10
	Sep 2013 09:54:39 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, etesial@gmail.com

Hi,

On Tue, Sep 10 2013, Nicolas Ferre wrote:
> On 09/09/2013 17:29, ludovic.desroches@atmel.com :
>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>>
>> When a software timeout occurs, the transfer is not stopped. In DMA case, it
>> causes DMA channel to be stuck because the transfer is still active causing
>> following transfers to be queued but not computed.
>>
>> Cc: <stable@vger.kernel.org> #3.9+
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>> Reported-by: Alexander Morozov <etesial@gmail.com>
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
