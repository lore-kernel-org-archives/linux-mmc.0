From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/6] mmc: sh-mmcif: use devm_ for clock management
Date: Tue, 1 Apr 2014 12:59:24 +0200
Message-ID: <CAMuHMdU4mcz1u0ghpWduuh1LzsbHGxu7ZkuXses4170rz=g3Sw@mail.gmail.com>
References: <1396347954-13740-1-git-send-email-ben.dooks@codethink.co.uk>
	<1396347954-13740-4-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1396347954-13740-4-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 1, 2014 at 12:25 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> -       host->hclk = clk_get(&pdev->dev, NULL);
> +       host->hclk = devm_clk_get(&pdev->dev, NULL);
>         if (IS_ERR(host->hclk)) {
>                 ret = PTR_ERR(host->hclk);
>                 dev_err(&pdev->dev, "cannot get clock: %d\n", ret);
> -               goto eclkget;
> +               goto err_pm;
>         }
>         ret = sh_mmcif_clk_update(host);
>         if (ret < 0)
> -               goto eclkupdate;
> +               goto err_clk;

This goto doesn't look correct to me. If sh_mmcif_clk_update() failed,
the clock was not enabled nor prepared. "goto err_pm"?

>         ret = pm_runtime_resume(&pdev->dev);
>         if (ret < 0)
> -               goto eresume;
> +               goto err_clk;
>
>         INIT_DELAYED_WORK(&host->timeout_work, mmcif_timeout_work);
>
> @@ -1486,13 +1486,11 @@ ereqirq1:
>         free_irq(irq[0], host);
>  ereqirq0:
>         pm_runtime_suspend(&pdev->dev);
> -eresume:
> +err_clk:
>         clk_disable_unprepare(host->hclk);
> -eclkupdate:
> -       clk_put(host->hclk);
> -eclkget:
> +err_pm:
>         pm_runtime_disable(&pdev->dev);
> -eofparse:
> +err_host:
>         mmc_free_host(mmc);
>         return ret;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
