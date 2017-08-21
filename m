From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhi: use maximum width for the sdbuf register
Date: Mon, 21 Aug 2017 14:33:37 +0200
Message-ID: <CAPDyKFp7Csi0Sf7aeqOvEevsJzm=tCRvqHvigDFy9Hc_isJ5SQ@mail.gmail.com>
References: <20170809182926.669-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:38022 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753141AbdHUMdi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Aug 2017 08:33:38 -0400
Received: by mail-qt0-f175.google.com with SMTP id 57so4392912qtu.5
        for <linux-mmc@vger.kernel.org>; Mon, 21 Aug 2017 05:33:38 -0700 (PDT)
In-Reply-To: <20170809182926.669-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Biju Das <biju.das@bp.renesas.com>, Simon Horman <horms@verge.net.au>

On 9 August 2017 at 20:29, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Make use of the 64 bit sdbuf width on Renesas R-Car Gen3. If the
> registers are 8 byte apart, the width is also 64 bit. For all others,
> the width is 32 bit, even if the registers are only 16 bit apart.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> Change since v1:
> * width calculation is now fully backwards compatible. If it is not 8 byte
>   apart (which is only on Gen3), we will always default to 32 as before.
>   Thanks to Biju Das and Simon Horman for the error reports!
>
> Tested on a M3-W Salvator-X and H2 Lager (with both SDHI instances). On
> the Lager, I could reproduce the problem with the old patch. It is gone now!
>
>  drivers/mmc/host/renesas_sdhi_core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index dd215723fa4312..a252145097d6a5 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -459,10 +459,11 @@ static int renesas_sdhi_multi_io_quirk(struct mmc_card *card,
>
>  static void renesas_sdhi_enable_dma(struct tmio_mmc_host *host, bool enable)
>  {
> -       sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? DMA_ENABLE_DMASDRW : 0);
> +       /* Iff regs are 8 byte apart, sdbuf is 64 bit. Otherwise always 32. */
> +       int width = (host->bus_shift == 2) ? 64 : 32;
>
> -       /* enable 32bit access if DMA mode if possibile */
> -       renesas_sdhi_sdbuf_width(host, enable ? 32 : 16);
> +       sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? DMA_ENABLE_DMASDRW : 0);
> +       renesas_sdhi_sdbuf_width(host, enable ? width : 16);
>  }
>
>  int renesas_sdhi_probe(struct platform_device *pdev,
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
