From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] mmc: mxs: fix build regression from mismerge
Date: Tue, 9 Oct 2012 19:10:45 +0200
Message-ID: <201210091910.45992.marex@denx.de>
References: <201210091537.23659.arnd@arndb.de> <877gqzabjy.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:55195 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab2JIRKw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Oct 2012 13:10:52 -0400
In-Reply-To: <877gqzabjy.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Attila Kinali <attila@kinali.ch>, Lauri Hintsala <lauri.hintsala@bluegiga.com>, Shawn Guo <shawn.guo@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Dear Chris Ball,

> Hi,
> 
> On Tue, Oct 09 2012, Arnd Bergmann wrote:
> > From all I can tell, the patches
> > 
> > fc108d24 "mmc: mxs-mmc: fix deadlock caused by recursion loop"
> > 829c1bf4 "mmc: spi: Pull out parts shared between MMC and SPI"
> > 
> > came in through separate branches and cause this build error when
> > combined.
[...]

> 
> I'll send Marek's change to Linus once the main MMC merge has been pulled.
> Thanks,
> 
> - Chris.

Thanks! Sorry from my previous reply from Android phone, I just saw what 
horrible email it generated :-(

Best regards,
Marek Vasut
