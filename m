From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/9] mmc: sh_mobile_sdhi: improve prerequisite for hw_reset
Date: Tue, 13 Dec 2016 11:51:54 +0100
Message-ID: <CAMuHMdWnhtQb6OyZ5Q-O3H4h+D2bWu=z2q=K2qY9oDfCZKxzeQ@mail.gmail.com>
References: <20161212195128.16633-1-wsa+renesas@sang-engineering.com> <20161212195128.16633-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36523 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752746AbcLMKv4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2016 05:51:56 -0500
In-Reply-To: <20161212195128.16633-3-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>

On Mon, Dec 12, 2016 at 8:51 PM, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> We need a SCC unit for hw_reset. Those units can only be described in
> of_data. So, of_data and a valid SCC offset are prerequisites for
> enabling the hw_reset capability. Merge the two 'if' conditions into one
> and add a check for an scc offset.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  drivers/mmc/host/sh_mobile_sdhi.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index b48e3ae4549b6b..f3ea2c8b12040c 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -656,27 +656,25 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>         if (ret < 0)
>                 goto efree;
>
> -       if (host->mmc->caps & MMC_CAP_UHS_SDR104) {
> +       if (of_data && of_data->scc_offset && host->mmc->caps & MMC_CAP_UHS_SDR104) {

For readability, you may want to add parentheses around the last check,
and break the long line before the classical punch card line limit.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
