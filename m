From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: add spin_unlock_irq() before calling clk_round_rate
Date: Thu, 1 Dec 2016 09:14:02 +0100
Message-ID: <CAPDyKFo8tnz8OjXSfLCJmh4_PkwC+CFMKgOyrAK6cEuEPg74XQ@mail.gmail.com>
References: <20161130060542.18225-1-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37459 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbcLAIOd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2016 03:14:33 -0500
Received: by mail-wm0-f52.google.com with SMTP id t79so239814870wmt.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2016 00:14:04 -0800 (PST)
In-Reply-To: <20161130060542.18225-1-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 30 November 2016 at 07:05, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Before calling clk_round_rate(), put the spin_unlock_irq() in
> sdhci_s3c_consider_clock() function.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-s3c.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 784c5a8..de219ca 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -121,7 +121,9 @@ static unsigned int sdhci_s3c_consider_clock(struct sdhci_s3c *ourhost,
>          * speed possible with selected clock source and skip the division.
>          */
>         if (ourhost->no_divider) {
> +               spin_unlock_irq(&ourhost->host->lock);
>                 rate = clk_round_rate(clksrc, wanted);
> +               spin_lock_irq(&ourhost->host->lock);
>                 return wanted - rate;
>         }
>
> --
> 2.10.2
>
