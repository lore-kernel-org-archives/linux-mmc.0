From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mmc: tmio-mmc: fix bad pointer math
Date: Tue, 11 Jul 2017 19:55:44 +0200
Message-ID: <CAMuHMdX=Y5cpNiSd1wwXV_SOCpBs64+VpHnE_Svgd2E6P8Gm6w@mail.gmail.com>
References: <20170711162911.39114-1-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:34090 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755934AbdGKRzq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jul 2017 13:55:46 -0400
In-Reply-To: <20170711162911.39114-1-chris.brandt@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Dan Carpenter <dan.carpenter@oracle.com>, Simon Horman <horms+renesas@verge.net.au>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Chris,

On Tue, Jul 11, 2017 at 6:29 PM, Chris Brandt <chris.brandt@renesas.com> wrote:
> The existing code gives an incorrect value.
> The buffer pointer 'buf' was of type unsigned short *, and 'count' was a
> number in bytes, so the pointer should have been cast before doing any
> pointer arithmetic.
>
> Since we know the code before it is doing as many 4-byte transfers as
> possible, we just need a pointer to where it left off in the buffer, hence
> zeroing out the bottom 2 bits of count for out math.

s/out/our/

> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: 8185e51f358a: ("mmc: tmio-mmc: add support for 32bit data port")
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
>  drivers/mmc/host/tmio_mmc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 77e7b56a9099..5dfc556ccedf 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -428,7 +428,7 @@ static void tmio_mmc_transfer_data(struct tmio_mmc_host *host,
>                 if (!(count & 0x3))
>                         return;
>
> -               buf8 = (u8 *)(buf + (count >> 2));
> +               buf8 = (u8 *)buf + (count & ~3);
>                 count %= 4;

While correct, this is IMHO still difficult to understand for the casual reader.

Given the code before casts to "u32 *", and uses "count >>2", and the code
after also casts to "u32 *", what about getting rid of all casts like:

        u32 data = 0;
        u32 *buf32 = buf;

        if (is_read)
                sd_ctrl_read32_rep(host, CTL_SD_DATA_PORT, buf32,
                                   count >> 2);
        else
                sd_ctrl_write32_rep(host, CTL_SD_DATA_PORT, buf32,
                                    count >> 2);

        /* if count was multiple of 4 */
        if (!(count & 0x3))
                return;

        buf32 += count >> 2;
        count %= 4;

        if (is_read) {
                sd_ctrl_read32_rep(host, CTL_SD_DATA_PORT, &data, 1);
                memcpy(buf32, &data, count);
        } else {
                memcpy(&data, buf32, count);
                sd_ctrl_write32_rep(host, CTL_SD_DATA_PORT, &data, 1);
        }

                return;
        }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
