From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] MMC: OMAP: fix the maximum timeout setting
Date: Tue, 5 Feb 2019 13:48:23 +0100
Message-ID: <CAPDyKFqKkT9sfpzCsGiuXu6+6tWFmJUOQkoVv6dW+TZx+qgYoA@mail.gmail.com>
References: <20190202221433.24717-1-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190202221433.24717-1-aaro.koskinen@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On Sat, 2 Feb 2019 at 23:15, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> When running OMAP1 kernel on QEMU, MMC access is annoyingly noisy:
>
>         MMC: CTO of 0xff and 0xfe cannot be used!
>         MMC: CTO of 0xff and 0xfe cannot be used!
>         MMC: CTO of 0xff and 0xfe cannot be used!
>         [ad inf.]
>
> Emulator warnings appear to be valid. The TI document SPRU680 [1]
> ("OMAP5910 Dual-Core Processor MultiMedia Card/Secure Data Memory Card
> (MMC/SD) Reference Guide") page 36 states that the maximum timeout
> is 253 cycles and "0xff and 0xfe cannot be used".
>
> Fix by using 0xfd as the maximum timeout.
>
> Tested using QEMU 2.5 (Siemens SX1 machine, OMAP310), and also checked
> on real hardware using Palm TE (OMAP310), Nokia 770 (OMAP1710)
> and Nokia N810 (OMAP2420) that MMC works as before.
>
> [1] http://www.ti.com/lit/ug/spru680/spru680.pdf
>
> Fixes: 730c9b7e6630f ("[MMC] Add OMAP MMC host driver")
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/omap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index c60a7625b1fa..b2873a2432b6 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -920,7 +920,7 @@ static inline void set_cmd_timeout(struct mmc_omap_host *host, struct mmc_reques
>         reg &= ~(1 << 5);
>         OMAP_MMC_WRITE(host, SDIO, reg);
>         /* Set maximum timeout */
> -       OMAP_MMC_WRITE(host, CTO, 0xff);
> +       OMAP_MMC_WRITE(host, CTO, 0xfd);
>  }
>
>  static inline void set_data_timeout(struct mmc_omap_host *host, struct mmc_request *req)
> --
> 2.17.0
>
