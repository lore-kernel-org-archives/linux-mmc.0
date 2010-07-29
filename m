From: Andreas Feuersinger <andreas.feuersinger@spintower.eu>
Subject: MX27 libertas_sdio SDIO Interrupts vs available bitrate
Date: Thu, 29 Jul 2010 12:46:04 +0200
Message-ID: <20100729124604.79f88553@speedy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fep13.mx.upcmail.net ([62.179.121.33]:47065 "EHLO
	fep13.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab0G2KqG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jul 2010 06:46:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: libertas-dev@lists.infradead.org, linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org


Hi,

I'm trying to improve throughput of the Marvell 8686 sdio wlan module.
Unfortunately I have to stick with kernel 2.6.22.

Everything works except for very bad datarate. So far the mxc_mmc
driver does not handle any SDIO interrupts. Could that be the reason
for the bad performance? 


I figured, it does not make any difference wheter I use DMA for data
transfer or not (odd?)

I get only up to 90K/s.


thanks!

Andreas
