From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2] mmc: tmio-mmc: fix bad pointer math
Date: Wed, 12 Jul 2017 17:24:33 +0200
Message-ID: <CAMuHMdVPRjno3h=PVWMAnte5-_13Ha93CAno26=wwswgDt+smw@mail.gmail.com>
References: <20170712132701.69983-1-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35629 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752879AbdGLPYg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jul 2017 11:24:36 -0400
In-Reply-To: <20170712132701.69983-1-chris.brandt@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Dan Carpenter <dan.carpenter@oracle.com>, Simon Horman <horms+renesas@verge.net.au>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Wed, Jul 12, 2017 at 3:27 PM, Chris Brandt <chris.brandt@renesas.com> wrote:
> The existing code gives an incorrect pointer value.
> The buffer pointer 'buf' was of type unsigned short *, and 'count' was a
> number in bytes. A cast of buf should have been used.
>
> However,instead of casting, just change the code to use u32 pointers.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: 8185e51f358a: ("mmc: tmio-mmc: add support for 32bit data port")
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c

>                 if (is_read) {
>                         sd_ctrl_read32_rep(host, CTL_SD_DATA_PORT,
> -                                          (u32 *)data, 1);
> +                                          &data, 1);

I would use the opportunity to merge the two above lines, now they fit
on a single line.

> +                       memcpy(buf32, &data, count);
>                 } else {
> -                       memcpy(data, buf8, count);
> +                       memcpy(&data, buf32, count);
>                         sd_ctrl_write32_rep(host, CTL_SD_DATA_PORT,
> -                                           (u32 *)data, 1);
> +                                           &data, 1);

Likewise.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
