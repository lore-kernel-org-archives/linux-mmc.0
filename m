From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] randconfig fixes for mmc
Date: Thu, 12 Jun 2014 11:00:46 +0200
Message-ID: <CAPDyKFozMSButjeUg4TrE87hhd2=ZhJoEYasiK9nL5gFKsGoXg@mail.gmail.com>
References: <1402002881-1986640-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:41175 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932868AbaFLJAs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jun 2014 05:00:48 -0400
Received: by mail-qa0-f48.google.com with SMTP id x12so1242150qac.7
        for <linux-mmc@vger.kernel.org>; Thu, 12 Jun 2014 02:00:47 -0700 (PDT)
In-Reply-To: <1402002881-1986640-1-git-send-email-arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, Nicolas Pitre <nico@fluxnic.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, linux-omap <linux-omap@vger.kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>

On 5 June 2014 23:14, Arnd Bergmann <arnd@arndb.de> wrote:
> Hi Chris, Ulf,
>
> These are small fixes from my randconfig testing, almost all for
> older bugs, please apply to a tree you see appropriate.

Thanks Arnd!

Applied for fixes.

Kind regards
Uffe

>
>         Arnd
>
> Arnd Bergmann (4):
>   mmc: atmel-mci: incude asm/cacheclush.h
>   mmc: mvsdio: avoid compiler warning
>   mmc: omap: don't select TPS65010
>   mmc: simplify SDHCI Kconfig dependencies
>
>  drivers/mmc/host/Kconfig     | 10 ++++------
>  drivers/mmc/host/atmel-mci.c |  1 +
>  drivers/mmc/host/mvsdio.c    |  2 +-
>  3 files changed, 6 insertions(+), 7 deletions(-)
>
> --
> 1.8.3.2
>
> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Chris Ball <chris@printf.net>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
