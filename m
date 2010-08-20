From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: [PATCH] tmio_mmc: Make ack_mmc_irqs() write-only
Date: Fri, 20 Aug 2010 17:12:53 +0200
Message-ID: <4C6E9B75.8030004@arndnet.de>
References: <4C455597.2020200@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:39981 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752692Ab0HTPM4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 Aug 2010 11:12:56 -0400
In-Reply-To: <4C455597.2020200@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yusuke Goda <yusuke.goda.sx@renesas.com>
Cc: ian@mnementh.co.uk, damm@opensource.se, sameo@linux.intel.com, Paul Mundt <lethal@linux-sh.org>, g.liakhovetski@gmx.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Am 20.07.2010 09:51, schrieb Yusuke Goda:
> This patch updates ack_mmc_irqs() to acknowledge using write instead
> of read-modify-write. Without this fix the old read-modify-write
> implementation may acknowledge interrupt sources by mistake. The
> driver may if so lock-up waiting forever for an interrupt that will
> never come. Observed with the TMIO_STAT_RXRDY bit together with
> CMD53 on AR6002 and BCM4318 SDIO cards in polled mode.
>
> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>

Tested on AP4EVB (sh7372) with SDHC and MMC cards - no regression.

Tested-by: Arnd Hannemann <arnd@arndnet.de>
