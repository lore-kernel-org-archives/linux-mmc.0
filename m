From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: tmio: don't wait on R-Car2+ when handling the clock
Date: Tue, 11 Jul 2017 16:43:41 +0200
Message-ID: <CAPDyKFpKPcC_tq5=rrArL20+-Z6faquE4RjB4Ap=TTfe1d3YBA@mail.gmail.com>
References: <20170628152311.18935-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34252 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933119AbdGKOnm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jul 2017 10:43:42 -0400
Received: by mail-qk0-f180.google.com with SMTP id d78so2713055qkb.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jul 2017 07:43:42 -0700 (PDT)
In-Reply-To: <20170628152311.18935-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On 28 June 2017 at 17:23, Wolfram Sang <wsa+renesas@sang-engineering.com> wrote:
> Our hardware engineers confirmed that it is unnecessary to wait when
> turning the clock on/off. The documentation was a tad vague, so we
> used to play safe.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> Tested on H2 and M3-W. Based on top of mmc/next with Simon's Gen3 DMA patches.
>
>  drivers/mmc/host/tmio_mmc_core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 77e7b56a909933..1851c883bfc82a 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -207,7 +207,10 @@ static void tmio_mmc_clk_start(struct tmio_mmc_host *host)
>  {
>         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, CLK_CTL_SCLKEN |
>                 sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
> -       msleep(host->pdata->flags & TMIO_MMC_MIN_RCAR2 ? 1 : 10);
> +
> +       /* HW engineers overrode docs: no sleep needed on R-Car2+ */
> +       if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
> +               msleep(10);
>
>         if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG) {
>                 sd_ctrl_write16(host, CTL_CLK_AND_WAIT_CTL, 0x0100);
> @@ -224,7 +227,10 @@ static void tmio_mmc_clk_stop(struct tmio_mmc_host *host)
>
>         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
>                 sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
> -       msleep(host->pdata->flags & TMIO_MMC_MIN_RCAR2 ? 5 : 10);
> +
> +       /* HW engineers overrode docs: no sleep needed on R-Car2+ */
> +       if (!(host->pdata->flags & TMIO_MMC_MIN_RCAR2))
> +               msleep(10);
>  }
>
>  static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
