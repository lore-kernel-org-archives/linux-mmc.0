From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/2] mmc: atmel-mci: DMA can be used with other controller
Date: Wed, 19 Sep 2012 01:15:48 -0400
Message-ID: <m3haquk2yj.fsf@pullcord.laptop.org>
References: <503F961E.5010905@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51702 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055Ab2ISFPc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Sep 2012 01:15:32 -0400
In-Reply-To: <503F961E.5010905@yahoo.es> (Hein Tibosch's message of "Fri, 31
	Aug 2012 00:34:38 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hein Tibosch <hein_tibosch@yahoo.es>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, "ludovic.desroches" <ludovic.desroches@atmel.com>, Havard Skinnemoen <havard@skinnemoen.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>

Hi Hein,

On Thu, Aug 30 2012, Hein Tibosch wrote:
> After the latest changes to atmel-mci, it could not be used with
> DMA on the AVR32 platform. This patch will allow to use DMA again
> and it will avoid access to MCI register ATMCI_DMA.
>
> v2:
> Even if the IP version is lower than v3xx and doesn't have the DMA
> configuration register, DMA transfers can be used with a different
> controller than the Atmel AHB DMA one. For instance, some AVR chips use 
> the Synopsys DesignWare AHB DMA controller.
>
> v2: in atmci_configure_dma: check both pdata and pdata->dma_slave
>
>
> Signed-off-by: Hein Tibosch <hein_tibosch@yahoo.es>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/mmc/host/atmel-mci.c |   26 +++++++++++++-------------
>  1 files changed, 13 insertions(+), 13 deletions(-)

Thanks, pushed to mmc-next for 3.7.

(For the future, please put the patch changelog below the "---" instead
of above it; that way it doesn't go into the git commit history.)

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
