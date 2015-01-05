From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/9] mmc: tmio: add tmio_mmc_host_alloc/free()
Date: Mon, 5 Jan 2015 09:35:53 +0100
Message-ID: <CAMuHMdWdZDVeUmM2DatvFh5ghxk-EeEq96=nh63vPpRoKaCnfg@mail.gmail.com>
References: <87zj9xogln.wl%kuninori.morimoto.gx@renesas.com>
	<87y4phogk8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87y4phogk8.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Morimoto-san,

On Mon, Jan 5, 2015 at 8:02 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1054,12 +1054,35 @@ static void tmio_mmc_of_parse(struct platform_device *pdev,
>                 pdata->flags |= TMIO_MMC_WRPROTECT_DISABLE;
>  }
>
> -int tmio_mmc_host_probe(struct tmio_mmc_host **host,
> -                                 struct platform_device *pdev,
> -                                 struct tmio_mmc_data *pdata)
> +struct tmio_mmc_host*
> +tmio_mmc_host_alloc(struct platform_device *pdev)

I think it would be better to match the naming in the mmc core layer, i.e.
tmio_mmc_alloc_host().

>  {
> -       struct tmio_mmc_host *_host;
> +       struct tmio_mmc_host *host;
>         struct mmc_host *mmc;
> +
> +       mmc = mmc_alloc_host(sizeof(struct tmio_mmc_host), &pdev->dev);
> +       if (!mmc)
> +               return NULL;
> +
> +       host = mmc_priv(mmc);
> +       host->mmc = mmc;
> +       host->pdev = pdev;
> +
> +       return host;
> +}
> +
> +void tmio_mmc_host_free(struct tmio_mmc_host *host)

tmio_mmc_free_host

> +{
> +       mmc_free_host(host->mmc);
> +
> +       host->mmc = NULL;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
