From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V3] MMC: PM: add suspend/resume in atmel-mci
Date: Sat, 09 Jul 2011 16:58:48 -0400
Message-ID: <m2iprbkw6v.fsf@bob.laptop.org>
References: <1309530754.4373.3.camel@hcegtvedt.norway.atmel.com>
	<1309779505-25509-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59830 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754459Ab1GIU7H (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 9 Jul 2011 16:59:07 -0400
In-Reply-To: <1309779505-25509-1-git-send-email-nicolas.ferre@atmel.com>
	(Nicolas Ferre's message of "Mon, 4 Jul 2011 13:38:25 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-mmc@vger.kernel.org, hans-christian.egtvedt@atmel.com, kernel@avr32linux.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de

Hi,

On Mon, Jul 04 2011, Nicolas Ferre wrote:
> Take care of slots while going to suspend state.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> V3: take care of each slot SUSPENDED state
>     (adding a status bit in the slot "flags")
> V2: move to pm_ops

Thanks, I've merged v3 of this patch for mmc-next/3.1 with Felipe's
Reviewed-by, and your [2/2] kconfig change.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
