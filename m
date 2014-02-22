From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] mmc: mxcmmc: Convert to SIMPLE_DEV_PM_OPS
Date: Sat, 22 Feb 2014 16:42:38 +0100
Message-ID: <1498408.4o9IO9pcnR@wuerfel>
References: <1393080372-6760-1-git-send-email-shc_work@mail.ru> <1393081369.457413293@f421.i.mail.ru> <CAOMZO5DF5DOBMoD7G3237ecPW6YRmEx-KH0pQu4GiSoS+4f5eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51230 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbaBVPms (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Feb 2014 10:42:48 -0500
In-Reply-To: <CAOMZO5DF5DOBMoD7G3237ecPW6YRmEx-KH0pQu4GiSoS+4f5eg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Alexander Shiyan <shc_work@mail.ru>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>

On Saturday 22 February 2014 12:05:43 Fabio Estevam wrote:
> On Sat, Feb 22, 2014 at 12:02 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
> 
> >> but then you would get a warning saying that "mxcmci_suspend/resume"
> >> are defined by not used" when CONFIG_PM_SLEEP=n
> >
> > Please see the patch first,
> > this warnings is avoided by "__maybe_unused" attributes.
> 
> Ok, I see it now 
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
> 

Unfortunately, everyone else uses the #ifdef here, and a lot of people
don't understand how to use __maybe_unused for this. IMHO all
drivers should do it the way that Alexander does it here, or
we should change the SIMPLE_DEV_PM_OPS() definition in a way that
doesn't need the #ifdef.

I have in the past tried to come up with a way to handle this more
naturally, but couldn't figure out how to migrate to it. If
SIMPLE_DEV_PM_OPS() defines an unused variable pointing to the
operations, we need neither the #ifdef nor the __maybe_unused
marker, but then it fails to build when there is an #ifdef.

	Arnd
