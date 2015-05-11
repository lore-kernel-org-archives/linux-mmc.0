From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/4] mmc: Add support for disabling write-protect detection
Date: Mon, 11 May 2015 12:30:36 +0200
Message-ID: <CAPDyKFpNRgmO3exNA_56qxaOR+GjPqMCbiQFs+Q-mKucT_E_wg@mail.gmail.com>
References: <1430937082-27149-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35726 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbbEKKah (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 May 2015 06:30:37 -0400
Received: by qkhg7 with SMTP id g7so83386002qkh.2
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2015 03:30:37 -0700 (PDT)
In-Reply-To: <1430937082-27149-1-git-send-email-lars@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Thomas Abraham <thomas.abraham@linaro.org>, Mike Looijmans <mike.looijmans@topic.nl>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 6 May 2015 at 20:31, Lars-Peter Clausen <lars@metafoo.de> wrote:
> It is not uncommon to see systems where there is no physical write-protect
> signal (e.g. when using eMMC or microSD card slots). For some controllers,
> which have a dedicated write-protection detection logic (like SDHCI
> controllers), the get_ro() callback can return bogus data in such a case.
>
> Instead of handling this on a per controller basis this patch adds a new
> capability flag to the MMC core that can be set to specify that the result
> of get_ro() is invalid. When the flag is set the core will not call
> get_ro() and assume that the card is always read-write.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks, applied!

Kind regards
Uffe

> ---
>  drivers/mmc/core/sd.c    | 30 +++++++++++++++++++++++-------
>  include/linux/mmc/host.h |  1 +
>  2 files changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 31a9ef2..8f6864a 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -804,6 +804,28 @@ int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card)
>         return 0;
>  }
>
> +static int mmc_sd_get_ro(struct mmc_host *host)
> +{
> +       int ro;
> +
> +       /*
> +        * Some systems don't feature a write-protect pin and don't need one.
> +        * E.g. because they only have micro-SD card slot. For those systems
> +        * assume that the SD card is always read-write.
> +        */
> +       if (host->caps2 & MMC_CAP2_NO_WRITE_PROTECT)
> +               return 0;
> +
> +       if (!host->ops->get_ro)
> +               return -1;
> +
> +       mmc_host_clk_hold(host);
> +       ro = host->ops->get_ro(host);
> +       mmc_host_clk_release(host);
> +
> +       return ro;
> +}
> +
>  int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>         bool reinit)
>  {
> @@ -855,13 +877,7 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>          * Check if read-only switch is active.
>          */
>         if (!reinit) {
> -               int ro = -1;
> -
> -               if (host->ops->get_ro) {
> -                       mmc_host_clk_hold(card->host);
> -                       ro = host->ops->get_ro(host);
> -                       mmc_host_clk_release(card->host);
> -               }
> +               int ro = mmc_sd_get_ro(host);
>
>                 if (ro < 0) {
>                         pr_warn("%s: host does not support reading read-only switch, assuming write-enable\n",
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index b5bedae..3b92fd4 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -285,6 +285,7 @@ struct mmc_host {
>                                  MMC_CAP2_HS400_1_2V)
>  #define MMC_CAP2_HSX00_1_2V    (MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_HS400_1_2V)
>  #define MMC_CAP2_SDIO_IRQ_NOTHREAD (1 << 17)
> +#define MMC_CAP2_NO_WRITE_PROTECT (1 << 18)    /* No physical write protect pin, assume that card is always read-write */
>
>         mmc_pm_flag_t           pm_caps;        /* supported pm features */
>
> --
> 1.8.0
>
