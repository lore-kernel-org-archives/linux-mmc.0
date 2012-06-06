From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: atmel-mci: fix burst/chunk size modification
Date: Wed, 06 Jun 2012 08:52:44 -0400
Message-ID: <87vcj44n6r.fsf@octavius.laptop.org>
References: <87396869fw.fsf@octavius.laptop.org>
	<1338977984-10888-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35001 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539Ab2FFMwu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 Jun 2012 08:52:50 -0400
In-Reply-To: <1338977984-10888-1-git-send-email-ludovic.desroches@atmel.com>
	(ludovic desroches's message of "Wed, 6 Jun 2012 12:19:44 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com, linux-mmc@vger.kernel.org

Hi,

On Wed, Jun 06 2012, ludovic.desroches@atmel.com wrote:
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> The use of DMA slave config operation requires that the burst size
> (aka chunk size) is specified through this interface.
> Modify atmel-mci slave driver to use this specification on its side.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
> Hi Chris,
>
> Sorry for this trouble, this patch should apply well on 3.5-rc1.

Thanks, pushed to mmc-next for 3.5.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
