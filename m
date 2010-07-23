From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] tmio_mmc: Make ack_mmc_irqs() write-only
Date: Fri, 23 Jul 2010 20:10:09 +0900
Message-ID: <AANLkTimSk_YOs7shfthCKgAVHcHyyJLh+P5qHkw_i7pH@mail.gmail.com>
References: <4C455597.2020200@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:35716 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427Ab0GWLKK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Jul 2010 07:10:10 -0400
In-Reply-To: <4C455597.2020200@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yusuke Goda <yusuke.goda.sx@renesas.com>
Cc: ian@mnementh.co.uk, damm@opensource.se, sameo@linux.intel.com, Paul Mundt <lethal@linux-sh.org>, g.liakhovetski@gmx.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

2010/7/20 Yusuke Goda <yusuke.goda.sx@renesas.com>:
> This patch updates ack_mmc_irqs() to acknowledge using write instead
> of read-modify-write. Without this fix the old read-modify-write
> implementation may acknowledge interrupt sources by mistake. The
> driver may if so lock-up waiting forever for an interrupt that will
> never come. Observed with the TMIO_STAT_RXRDY bit together with CMD53
> on AR6002 and BCM4318 SDIO cards in polled mode.
>
> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>

Simple testing with a BCM4318 card and a MMC card on sh7372 and SDHI
shows no problems.

Acked-by: Magnus Damm <damm@opensource.se>
