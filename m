From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: at91-mci: remove driver
Date: Mon, 29 Oct 2012 10:45:37 -0400
Message-ID: <87625txrou.fsf@octavius.laptop.org>
References: <1351520875-31891-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45756 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942Ab2J2Opo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Oct 2012 10:45:44 -0400
In-Reply-To: <1351520875-31891-1-git-send-email-ludovic.desroches@atmel.com>
	(ludovic desroches's message of "Mon, 29 Oct 2012 15:27:55 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, plagnioj@jcrosoft.com, nicolas.ferre@atmel.com

Hi,

On Mon, Oct 29 2012, ludovic.desroches@atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> The at91-mci driver is no more needed since atmel-mci driver supports
> all Atmel devices.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks!  Pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
