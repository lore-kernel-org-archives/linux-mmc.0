From: Andreas Feuersinger <andreas.feuersinger@spintower.eu>
Subject: Re: MX27 libertas_sdio SDIO Interrupts vs available bitrate
Date: Mon, 2 Aug 2010 15:46:05 +0200
Message-ID: <20100802154605.33a34d59@speedy>
References: <20100729124604.79f88553@speedy>
 <4C51795F.8000800@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fep12.mx.upcmail.net ([62.179.121.32]:47392 "EHLO
	fep12.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844Ab0HBNpm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Aug 2010 09:45:42 -0400
In-Reply-To: <4C51795F.8000800@free.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Julien Boibessot <julien.boibessot@free.fr>
Cc: libertas-dev@lists.infradead.org, linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org


Hi Julien!

Julien Boibessot <julien.boibessot@free.fr> wrote:
> Andreas Feuersinger a =C3=A9crit :
> > Everything works except for very bad datarate. So far the mxc_mmc
> > driver does not handle any SDIO interrupts. Could that be the reaso=
n
> > for the bad performance?=20
> >  =20
> Definitly !
> (I had the same "problem" on my i.MX27 platform before using SDIO
> interrupts)

thank you! At least I know where to go ;)

While trying to enable SDIO handling I look at the mainline kernel
patch for SDIO interrupts in mxcmmc.c.

But in order to apply that I have to port that driver, introduced in
2.6.29 to my 2.6.22 kernel version.=20

In the first step I try to get it run without sdio support.
The driver seems to load helper firmware successfully and also real
firmware. After that it stops where the libertas driver says:
"waiting for firmware to boot."

Register status is as follows:
mxcmci_irq:status: <6>BUF_WRITE_RDY |<6>END_CMD_RESP |<6>BUF_UND_RUN
|<6>XBUF_EMPTY |<6>YBUF_EMPTY |<6>

Looks like stopped clock? Is the firmware supposed to start some cmd?


I have a different question:
Does anybody know if it is possible to boot freescale development board
mx27pdk  using kernel versions greater 2.6.30 ?

thanks

Andreas


