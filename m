From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] mmc: host: tmio: sdio irq improvements
Date: Tue, 24 Jan 2017 10:56:20 +0100
Message-ID: <CAPDyKFr_5kDLSOe-m6xCTLgcMebTjDNkiTYpuEjsBahcfJ6ZNQ@mail.gmail.com>
References: <20170119200718.8115-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36899 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdAXJ4W (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2017 04:56:22 -0500
Received: by mail-wm0-f41.google.com with SMTP id c206so200026782wme.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jan 2017 01:56:22 -0800 (PST)
In-Reply-To: <20170119200718.8115-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>

On 19 January 2017 at 21:07, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Here is a small series with two minor improvements (patches 1+2) and one bigger
> change (patch 3) for SDIO handling with TMIO/SDHI. Since RFC, I addressed all
> comments (Thanks Simon!) and since it is needed for the WLAN cards, I think it
> should go in now.
>
>
> Wolfram Sang (3):
>   mmc: host: tmio: refactor calls to sdio irq
>   mmc: host: tmio: SDIO_STATUS_QUIRK is rather SDIO_STATUS_SETBITS
>   mmc: tmio: discard obsolete SDIO irqs before enabling irqs
>
>  drivers/mmc/host/sh_mobile_sdhi.c |  6 ++----
>  drivers/mmc/host/tmio_mmc.h       |  2 ++
>  drivers/mmc/host/tmio_mmc_pio.c   | 20 ++++++++++++++------
>  include/linux/mfd/tmio.h          |  6 ++----
>  4 files changed, 20 insertions(+), 14 deletions(-)
>
> --
> 2.11.0
>

Thanks, applied for next!

Kind regards
Uffe
