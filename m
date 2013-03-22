From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] ARM: at91/avr32/atmel-mci: fix DMA-channel leak on module unload
Date: Fri, 22 Mar 2013 12:58:35 -0400
Message-ID: <87ehf7mkw4.fsf@octavius.laptop.org>
References: <1363191119-4948-1-git-send-email-jhovold@gmail.com>
	<46568.1708221838$1363345027@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43702 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1160998Ab3CVQ6l (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 12:58:41 -0400
In-Reply-To: <46568.1708221838$1363345027@news.gmane.org> (Ludovic Desroches's
	message of "Fri, 15 Mar 2013 11:56:06 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: Johan Hovold <jhovold@gmail.com>, linux-mmc@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, linux-arm-kernel@lists.infradead.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>

Hi,

On Fri, Mar 15 2013, Ludovic Desroches wrote:
> On Wed, Mar 13, 2013 at 05:11:59PM +0100, Johan Hovold wrote:
>> Fix regression introduced by commit 796211b7953 ("mmc: atmel-mci: add
>> pdc support and runtime capabilities detection") which removed the need
>> for CONFIG_MMC_ATMELMCI_DMA but kept the Kconfig-entry as well as the
>> compile guards around dma_release_channel() in remove(). Consequently,
>> DMA is always enabled (if supported), but the DMA-channel is not
>> released on module unload unless the DMA-config option is selected.
>> 
>> Remove the no longer used CONFIG_MMC_ATMELMCI_DMA option completely.
>> 
>> Cc: stable <stable@vger.kernel.org>
>> Signed-off-by: Johan Hovold <jhovold@gmail.com>
>
> Hi Johan,
>
> Good point so
>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks, I'll merge this via the MMC tree if no-one objects.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
