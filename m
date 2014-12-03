From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v4 0/4] mmc: atmel-mci: cleanup and probe deferring
Date: Wed, 3 Dec 2014 09:22:05 +0100
Message-ID: <20141203082205.GW2714@ldesroches-Latitude-E6320>
References: <1417444509-15501-1-git-send-email-ludovic.desroches@atmel.com>
 <CAPDyKFpuDOfw9BtYJhG0Fz6PsqUQP=gBg+4mWt9MRy_S6Yga5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:7841 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbaLCIVj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Dec 2014 03:21:39 -0500
Content-Disposition: inline
In-Reply-To: <CAPDyKFpuDOfw9BtYJhG0Fz6PsqUQP=gBg+4mWt9MRy_S6Yga5w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Arnd Bergmann <arnd@arndb.de>

On Tue, Dec 02, 2014 at 11:10:53AM +0100, Ulf Hansson wrote:
> On 1 December 2014 at 15:35, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
> > Hi Ulf,
> >
> > Same as previous series, based on your next branch, and no errors with
> > checkpatch so let me know if you still have troubles to apply my patches.
> >
> > Changes from v3:
> > - keep __init/__exit attributes for atmci_init/exit
> > - remove useless variable in atmci_configure_dma function
> >
> > Ludovic Desroches (4):
> >   mmc: atmel-mci: remove useless DMA stuff for non-dt devices
> >   mmc: atmel-mci: remove __init/__exit attributes
> >   mmc: atmel-mci: stop using specific initcall
> >   mmc: atmel-mci: use probe deferring if dma controller is not ready yet
> >
> >  drivers/mmc/host/atmel-mci.c | 76 ++++++++++++++++----------------------------
> >  1 file changed, 28 insertions(+), 48 deletions(-)
> 
> Thanks! Applied for next.
> 
> Patch 4, did have a minor checkpatch warning. I fixed it.

Thanks, yes I see it but I feel it is a bit too constraining when you already
have a function name doing 32 characters :p

> 
> Kind regards
> Uffe
