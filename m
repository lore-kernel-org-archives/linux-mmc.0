From: Julien Boibessot <julien.boibessot@free.fr>
Subject: Re: MX27 libertas_sdio SDIO Interrupts vs available bitrate
Date: Thu, 29 Jul 2010 14:51:43 +0200
Message-ID: <4C51795F.8000800@free.fr>
References: <20100729124604.79f88553@speedy>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1-g21.free.fr ([212.27.42.1]:60903 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753165Ab0G2Mvy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 29 Jul 2010 08:51:54 -0400
In-Reply-To: <20100729124604.79f88553@speedy>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andreas Feuersinger <andreas.feuersinger@spintower.eu>
Cc: libertas-dev@lists.infradead.org, linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org

Hi Andreas,

Andreas Feuersinger a =E9crit :
> I'm trying to improve throughput of the Marvell 8686 sdio wlan module=
=2E
> Unfortunately I have to stick with kernel 2.6.22.
>
> Everything works except for very bad datarate. So far the mxc_mmc
> driver does not handle any SDIO interrupts. Could that be the reason
> for the bad performance?=20
>  =20
Definitly !
(I had the same "problem" on my i.MX27 platform before using SDIO
interrupts)

Regards,
Julien
http://www.armadeus.com
