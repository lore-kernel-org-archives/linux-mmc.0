From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH V2] mmc: renesas_sdhi_core: on R-Car 2+, make use of CBSY bit
Date: Wed, 28 Jun 2017 19:01:42 +0200
Message-ID: <CAMuHMdXb2a30NjE9td8mNcDdsSpBdSX0_xup3NUWJs4_Q4msxg@mail.gmail.com>
References: <20170628152156.18881-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170628152156.18881-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

On Wed, Jun 28, 2017 at 5:21 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Most registers need to wait until the command is completed, not
> necessarily until the bus is free. At least, R-Car 2+ SoCs can signal
> that via the CBSY bit, so let's use it there instead of SCLKDIVEN to
> save a little bit of delay.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Tested on H2 and M3-W.
>
> Change since V1:
>
> Rebased on top of mmc/next with Simon's Gen3 DMA patches.
>
>  drivers/mmc/host/renesas_sdhi_core.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 569bcdd5e6537a..be806d3e9afeec 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -398,12 +398,14 @@ static void renesas_sdhi_hw_reset(struct tmio_mmc_host *host)
>                        sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_RVSCNTL));
>  }
>
> -static int renesas_sdhi_wait_idle(struct tmio_mmc_host *host)
> +static int renesas_sdhi_wait_idle(struct tmio_mmc_host *host, u32 bit)
>  {
>         int timeout = 1000;
> +       /* CBSY is set when busy, SCLKDIVEN is cleared when busy */
> +       u32 wait_state = (bit == TMIO_STAT_CMD_BUSY ? TMIO_STAT_CMD_BUSY : 0);
>
> -       while (--timeout && !(sd_ctrl_read16_and_16_as_32(host, CTL_STATUS)
> -                             & TMIO_STAT_SCLKDIVEN))
> +       while (--timeout && (sd_ctrl_read16_and_16_as_32(host, CTL_STATUS)
> +                             & bit) == wait_state)

Do you have any figures on the number of loops saved?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
