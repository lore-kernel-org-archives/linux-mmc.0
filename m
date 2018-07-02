From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mmc: dw_mmc should depend on COMMON_CLK
Date: Mon, 2 Jul 2018 15:32:34 +0200
Message-ID: <CAMuHMdU709R3woOAvw7EH4=zGiBtezg0YeEer-4wG7pqo2SZBg@mail.gmail.com>
References: <1528310612-10158-1-git-send-email-clabbe@baylibre.com> <CAPDyKFoRUhwHk6=j0-scQa4W+nbnS_qXZbPUn0eTFm_3kqdwPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoRUhwHk6=j0-scQa4W+nbnS_qXZbPUn0eTFm_3kqdwPQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Corentin Labbe <clabbe@baylibre.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On Mon, Jul 2, 2018 at 3:18 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 6 June 2018 at 20:43, Corentin Labbe <clabbe@baylibre.com> wrote:
> > This patch fix the following build failure on m68k:
> > ERROR: "clk_set_rate" [drivers/mmc/host/dw_mmc.ko] undefined!
> >
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
>
> Thanks, applied for next!

Please drop this patch, I posted proper fixes for this general issue in series
"[PATCH 0/3] Legacy clock drivers: Normalize clk API"
(https://lkml.org/lkml/2018/6/11/122).

All fixes above are already in next-20180702.
Thanks!

> > ---
> >  drivers/mmc/host/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 0581c199c996..77d6ba090436 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -666,7 +666,7 @@ config MMC_CAVIUM_THUNDERX
> >
> >  config MMC_DW
> >         tristate "Synopsys DesignWare Memory Card Interface"
> > -       depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
> > +       depends on COMMON_CLK && (ARC || ARM || ARM64 || MIPS || COMPILE_TEST)
> >         help
> >           This selects support for the Synopsys DesignWare Mobile Storage IP
> >           block, this provides host support for SD and MMC interfaces, in both

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
