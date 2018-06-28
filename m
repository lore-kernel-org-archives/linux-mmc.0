From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] mmc: renesas_sdhi_internal_dmac: Cannot clear the
 RX_IN_USE in abort
Date: Thu, 28 Jun 2018 14:53:30 +0200
Message-ID: <CAMuHMdWF098-zyWoezDA-5umOuWET=1OtTr+2e7UVQdkf87V+Q@mail.gmail.com>
References: <1530181745-10519-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1530181745-10519-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1530181745-10519-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: stable-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jun 28, 2018 at 1:53 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch is fixes an issue that the SDHI_INTERNAL_DMAC_RX_IN_USE
> flag cannot be cleared because tmio_mmc_core sets the host->data
> to NULL before the tmio_mmc_core calls tmio_mmc_abort_dma().
>
> So, this patch clears the SDHI_INTERNAL_DMAC_RX_IN_USE in
> the renesas_sdhi_internal_dmac_abort_dma() anyway. This doesn't
> cause any side effects.
>
> Fixes: 0cbc94daa554 ("mmc: renesas_sdhi_internal_dmac: limit DMA RX for old SoCs")
> Cc: <stable@vger.kernel.org> # v4.17+
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
