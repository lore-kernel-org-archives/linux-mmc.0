From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: host: omap_hsmmc: use generic_cmd6_time to
 program timeout value for CMD6
Date: Tue, 31 Jan 2017 11:12:33 +0100
Message-ID: <CAPDyKFpW0fVpThS0EQhCh5kEiG96kNSGGhmnYnLKa_A06RBaFA@mail.gmail.com>
References: <1485771118-13748-1-git-send-email-rk@ti.com> <1485771118-13748-3-git-send-email-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36213 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750933AbdAaKOZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Jan 2017 05:14:25 -0500
Received: by mail-wm0-f42.google.com with SMTP id c85so253663281wmi.1
        for <linux-mmc@vger.kernel.org>; Tue, 31 Jan 2017 02:12:35 -0800 (PST)
In-Reply-To: <1485771118-13748-3-git-send-email-rk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ravikumar Kattekola <rk@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Andreas Fenkart <afenkart@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kishon <kishon@ti.com>

On 30 January 2017 at 11:11, Ravikumar Kattekola <rk@ti.com> wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
>
> commit e2bf08d643a244ccb ("omap_hsmmc: set a large data timeout for
> commands with busy signal") sets an arbitrary timeout value (100ms) for
> commands like CMD6 (MMC SWITCH). However extended CSD register defined
> in the eMMC standard has a field for GENERIC_CMD6_TIME which indicates
> the default maximum timeout for a SWITCH command.
> Use busy_timeout of cmd structure (populated with GENERIC_CMD6_TIME
> in the case of SWITCH command) to program the data timeout value in
> omap_hsmmc driver.
> SWITCH command to turn the cache on took more than 100ms to complete
> with MICRON eMMC card present in AM572x IDK REV 1.3A resulting in
> timeout and failed enumeration. It is fixed here by programming the
> timeout with the value advertised in GENERIC_CMD6_TIME.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Ravikumar Kattekola <rk@ti.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 0ee5650..51ca3d7 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1527,16 +1527,24 @@ static void omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host)
>  omap_hsmmc_prepare_data(struct omap_hsmmc_host *host, struct mmc_request *req)
>  {
>         int ret;
> +       unsigned int timeout;
> +
>         host->data = req->data;
>
>         if (req->data == NULL) {
>                 OMAP_HSMMC_WRITE(host->base, BLK, 0);
> -               /*
> -                * Set an arbitrary 100ms data timeout for commands with
> -                * busy signal.
> -                */
> -               if (req->cmd->flags & MMC_RSP_BUSY)
> -                       set_data_timeout(host, 100000000U, 0);
> +               if (req->cmd->flags & MMC_RSP_BUSY) {
> +                       timeout = req->cmd->busy_timeout * NSEC_PER_MSEC;
> +
> +                       /*
> +                        * Set an arbitrary 100ms data timeout for commands with
> +                        * busy signal and no indication of busy_timeout.
> +                        */
> +                       if (!timeout)

This is a bug in the mmc core if this ever happen.

Therefore I am particularly interested to find out if this is really
needed or it's just playing safe?

> +                               timeout = 100000000U;
> +
> +                       set_data_timeout(host, timeout, 0);
> +               }
>                 return 0;
>         }
>
> --
> 1.9.1
>

Kind regards
Uffe
