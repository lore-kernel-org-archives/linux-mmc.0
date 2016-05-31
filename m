From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 3/4] mmc: sh_mobile_sdhi: Add tuning support
Date: Tue, 31 May 2016 12:39:58 +0200
Message-ID: <CAMuHMdWs2cFgy8PtAUaYdfqnm+LU5cB9sn5WNnKsqRqza=nW6w@mail.gmail.com>
References: <1464057797-29951-1-git-send-email-horms+renesas@verge.net.au>
	<1464057797-29951-4-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1464057797-29951-4-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Simon,

On Tue, May 24, 2016 at 4:43 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c

> @@ -403,6 +580,30 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>         if (ret < 0)
>                 goto efree;
>
> +       if (host->mmc->caps & MMC_CAP_UHS_SDR104)
> +               host->mmc->caps |= MMC_CAP_HW_RESET;
> +
> +       if (of_id && of_id->data) {
> +               const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
> +               const struct sh_mobile_sdhi_scc *taps = of_data->taps;
> +               bool hit = false;
> +
> +               for (i = 0; i < of_data->taps_num; i++) {
> +                       if (taps[i].clk_rate == 0 ||
> +                           taps[i].clk_rate == host->mmc->f_max) {
> +                               host->scc_tappos = taps->tap;
> +                               hit = true;
> +                               break;
> +                       }
> +               }
> +
> +               if (!hit)
> +                       dev_warn(&host->pdev->dev, "Unknown clock rate for SDR104 and HS200\n");

This warning triggers on sh7a0/kzm9g, r8a73a4/ape6evm, and
r8a7740/armadillo.

Perhaps the tap code should check if MMC_CAP_UHS_SDR104 is
enabled?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
