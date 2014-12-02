From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 0/4] mmc: atmel-mci: cleanup and probe deferring
Date: Tue, 2 Dec 2014 11:10:53 +0100
Message-ID: <CAPDyKFpuDOfw9BtYJhG0Fz6PsqUQP=gBg+4mWt9MRy_S6Yga5w@mail.gmail.com>
References: <1417444509-15501-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:54512 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbaLBKKy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Dec 2014 05:10:54 -0500
Received: by mail-qc0-f176.google.com with SMTP id i17so9209962qcy.35
        for <linux-mmc@vger.kernel.org>; Tue, 02 Dec 2014 02:10:53 -0800 (PST)
In-Reply-To: <1417444509-15501-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Arnd Bergmann <arnd@arndb.de>

On 1 December 2014 at 15:35, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> Hi Ulf,
>
> Same as previous series, based on your next branch, and no errors with
> checkpatch so let me know if you still have troubles to apply my patches.
>
> Changes from v3:
> - keep __init/__exit attributes for atmci_init/exit
> - remove useless variable in atmci_configure_dma function
>
> Ludovic Desroches (4):
>   mmc: atmel-mci: remove useless DMA stuff for non-dt devices
>   mmc: atmel-mci: remove __init/__exit attributes
>   mmc: atmel-mci: stop using specific initcall
>   mmc: atmel-mci: use probe deferring if dma controller is not ready yet
>
>  drivers/mmc/host/atmel-mci.c | 76 ++++++++++++++++----------------------------
>  1 file changed, 28 insertions(+), 48 deletions(-)

Thanks! Applied for next.

Patch 4, did have a minor checkpatch warning. I fixed it.

Kind regards
Uffe
