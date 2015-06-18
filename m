From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH/RFC] mmc: tmio: Fix suspend process
Date: Thu, 18 Jun 2015 15:33:45 +0200
Message-ID: <CAPDyKFrF9UK6LRGX4Jc5aZxikx4+4=Pya+x4QZC=GyRbi33U7Q@mail.gmail.com>
References: <1434302565-30996-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:35521 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755901AbbFRNdq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Jun 2015 09:33:46 -0400
Received: by qcsf5 with SMTP id f5so23472747qcs.2
        for <linux-mmc@vger.kernel.org>; Thu, 18 Jun 2015 06:33:45 -0700 (PDT)
In-Reply-To: <1434302565-30996-1-git-send-email-ykaneko0929@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ian Molton <ian.molton@codethink.co.uk>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>

On 14 June 2015 at 19:22, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:
> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>
> The clock should be enable when SDHI registers are accessed.
>
> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
>
> This patch is based on mmc-next branch of Ulf Hansson's mmc tree.
>
> * Perhaps this relates to the need to enhance clock management
>
>  drivers/mmc/host/tmio_mmc_pio.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index e3dcf31..ec10bcd 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1240,7 +1240,9 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct tmio_mmc_host *host = mmc_priv(mmc);
>
> +       pm_runtime_get_sync(dev);

I don't recommend doing a pm_runtime_get_sync() from your
->runtime_suspend() callback. There a often cases where this can
deadlock.

Anyway, isn't the clock already enabled here?

>         tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
> +       pm_runtime_put(dev);
>
>         if (host->clk_cache)
>                 tmio_mmc_clk_stop(host);
> --
> 1.9.1
>

Kind regards
Uffe
