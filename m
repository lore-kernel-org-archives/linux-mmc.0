From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: Check if clk_set_rate() succeeds
Date: Tue, 4 Nov 2014 17:04:23 +0100
Message-ID: <CAPDyKFpo0sMMuBNdzsOw8-6jxXH3S4mS1S3gcGMAc-m9evpKVQ@mail.gmail.com>
References: <1415104002-1580-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:36030 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034AbaKDQEZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Nov 2014 11:04:25 -0500
Received: by mail-qa0-f48.google.com with SMTP id x12so9868887qac.7
        for <linux-mmc@vger.kernel.org>; Tue, 04 Nov 2014 08:04:23 -0800 (PST)
In-Reply-To: <1415104002-1580-1-git-send-email-broonie@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Ben Dooks <ben-linux@fluff.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Mark Brown <broonie@linaro.org>

On 4 November 2014 13:26, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> It is possible that we may fail to set the clock rate, if we do so then
> log the failure and don't bother reprogramming the IP.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-s3c.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 0ce6eb17deaf..4f7a63213b33 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -300,6 +300,7 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
>         struct device *dev = &ourhost->pdev->dev;
>         unsigned long timeout;
>         u16 clk = 0;
> +       int ret;
>
>         host->mmc->actual_clock = 0;
>
> @@ -311,7 +312,12 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
>
>         sdhci_s3c_set_clock(host, clock);
>
> -       clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
> +       ret = clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
> +       if (ret != 0) {
> +               dev_err(dev, "%s: failed to set clock rate %uHz\n",
> +                       mmc_hostname(host->mmc), clock);
> +               return;
> +       }
>
>         clk = SDHCI_CLOCK_INT_EN;
>         sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> --
> 2.1.1
>
