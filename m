From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 2.6.33-rc8-rt1 on Beagle
Date: Mon, 1 Mar 2010 17:14:54 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1003011713210.4245@localhost.localdomain>
References: <alpine.LFD.2.00.0910141115020.9428@localhost.localdomain> <alpine.LFD.2.00.0911061743210.12138@localhost.localdomain> <alpine.LFD.2.00.0911101326280.2725@localhost.localdomain> <alpine.LFD.2.00.1001212102220.2906@localhost.localdomain>
 <alpine.LFD.2.00.1002181748460.2811@localhost.localdomain> <alpine.LFD.2.00.1002212322450.2811@localhost.localdomain> <20100222132927.GC5416@bicker> <4B84D20B.9080600@osadl.org> <2A3DCF3DA181AD40BDE86A3150B27B6B030CDCBE65@dbde02.ent.ti.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B030CDCC2FD@dbde02.ent.ti.com> <20100301150657.GG16049@pengutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-963598006-1267460096=:4245"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:55983 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844Ab0CAQPD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 1 Mar 2010 11:15:03 -0500
In-Reply-To: <20100301150657.GG16049@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "Chatterjee, Amit" <amit.chatterjee@ti.com>, LKML <linux-kernel@vger.kernel.org>, rt-users <linux-rt-users@vger.kernel.org>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-963598006-1267460096=:4245
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Mon, 1 Mar 2010, Uwe Kleine-König wrote:
> You might want to report that to the author(s) of
> drivers/mmc/host/omap_hsmmc.c.

FYI, thats fixed in 33-rt3 and the fix is going mainline as well.

Thanks,

	tglx
--8323328-963598006-1267460096=:4245--
