From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] mmc: renesas_sdhi_internal_dmac: Fix missing unmap in
 error patch
Date: Thu, 28 Jun 2018 14:50:00 +0200
Message-ID: <CAMuHMdWRKPoP6rxgeWC5tWyxdvZ0kJH9UmxPY3H4hxWMKmq=iw@mail.gmail.com>
References: <1530181745-10519-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1530181745-10519-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1530181745-10519-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: stable-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Shimoda-san,

On Thu, Jun 28, 2018 at 1:53 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch fixes an issue that lacks the dma_unmap_sg() calling in
> the error patch of renesas_sdhi_internal_dmac_start_dma().

Nice catch!
Thanks for your patch!

> Fixes: 0cbc94daa554 ("mmc: renesas_sdhi_internal_dmac: limit DMA RX for old SoCs")
> Cc: <stable@vger.kernel.org> # v4.17+
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -173,8 +173,11 @@
>         if (data->flags & MMC_DATA_READ) {
>                 dtran_mode |= DTRAN_MODE_CH_NUM_CH1;
>                 if (test_bit(SDHI_INTERNAL_DMAC_ONE_RX_ONLY, &global_flags) &&
> -                   test_and_set_bit(SDHI_INTERNAL_DMAC_RX_IN_USE, &global_flags))
> +                   test_and_set_bit(SDHI_INTERNAL_DMAC_RX_IN_USE, &global_flags)) {
> +                       dma_unmap_sg(&host->pdev->dev, sg, host->sg_len,
> +                                    mmc_get_dma_dir(data));

Given there is already a call to dma_unmap_sg() a few lines earlier , you
may want to introduce a new label before force_pio, and move the call to
dma_unmap_sg() there.

>                         goto force_pio;
> +               }
>         } else {
>                 dtran_mode |= DTRAN_MODE_CH_NUM_CH0;
>         }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
