From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: atmel-mci: fix bad variable type for clkdiv
Date: Mon, 11 May 2015 12:30:28 +0200
Message-ID: <CAPDyKFr5iYt47KsMuJ+KSusV6aRwhFLxYYb27=fZ003pejY3XA@mail.gmail.com>
References: <1430918206-19911-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:33922 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbbEKKa2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 May 2015 06:30:28 -0400
Received: by qcyk17 with SMTP id k17so66446686qcy.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2015 03:30:28 -0700 (PDT)
In-Reply-To: <1430918206-19911-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, stable@vger.kernel.org

On 6 May 2015 at 15:16, Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
> clkdiv is declared as an u32 but it can be set to a negative value
> causing a huge divisor value. Change its type to int to avoid this case.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: <stable@vger.kernel.org> # 3.4 and later

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/atmel-mci.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 03d7c75..9a39e0b 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1304,7 +1304,7 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>         if (ios->clock) {
>                 unsigned int clock_min = ~0U;
> -               u32 clkdiv;
> +               int clkdiv;
>
>                 spin_lock_bh(&host->lock);
>                 if (!host->mode_reg) {
> @@ -1328,7 +1328,12 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 /* Calculate clock divider */
>                 if (host->caps.has_odd_clk_div) {
>                         clkdiv = DIV_ROUND_UP(host->bus_hz, clock_min) - 2;
> -                       if (clkdiv > 511) {
> +                       if (clkdiv < 0) {
> +                               dev_warn(&mmc->class_dev,
> +                                        "clock %u too fast; using %lu\n",
> +                                        clock_min, host->bus_hz / 2);
> +                               clkdiv = 0;
> +                       } else if (clkdiv > 511) {
>                                 dev_warn(&mmc->class_dev,
>                                          "clock %u too slow; using %lu\n",
>                                          clock_min, host->bus_hz / (511 + 2));
> --
> 2.2.0
>
